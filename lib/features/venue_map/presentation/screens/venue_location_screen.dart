import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

import 'package:arena_assist/core/widgets/app_header.dart';

class VenueLocationScreen extends StatefulWidget {
  final EventModel event;

  const VenueLocationScreen({
    super.key,
    required this.event,
  });

  @override
  State<VenueLocationScreen> createState() => _VenueLocationScreenState();
}

class _VenueLocationScreenState extends State<VenueLocationScreen> {
  final MapController _mapController = MapController();
  Position? _currentPosition;
  String _distance = 'Calculating...';
  String _travelTime = 'Calculating...';
  bool _hasVenueCoords = false;
  bool _isGeocoding = false;
  String? _statusMessage;
  bool _mapReady = false;

  double? _venueLat;
  double? _venueLng;

  @override
  void dispose() {
    // Do NOT call _mapController.dispose() — flutter_map manages its own
    // controller lifecycle. Calling dispose() here causes a ChangeNotifier
    // "used after dispose" exception that spams the debugger log.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Default to false. We will try to geocode by name first because
    // the user mentioned database coordinates might be wrong.
    _hasVenueCoords = false;
    _determinePosition();
  }

  Future<void> _geocodeVenue() async {
    final searchQueries = [
      widget.event.location,
      widget.event.title,
      '${widget.event.title} ${widget.event.location}',
    ].where((q) => q.trim().isNotEmpty).toList();

    if (searchQueries.isEmpty) return;

    if (mounted) {
      setState(() {
        _isGeocoding = true;
        _statusMessage = 'Searching for venue by name...';
      });
    }

    // 1. Geocode via Nominatim
    for (final queryStr in searchQueries) {
      try {
        final query = Uri.encodeComponent(queryStr);
        final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1');
        
        final Map<String, String> headers = {
          'Accept': 'application/json',
        };
        
        if (!kIsWeb) {
          headers['User-Agent'] = 'ArenaAssist/1.0 (Contact: web-support@arenaassist.com)';
        }

        final response = await http.get(url, headers: headers).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final dynamic decoded = json.decode(response.body);
          if (decoded is List && decoded.isNotEmpty) {
            final data = decoded[0];
            final lat = double.tryParse(data['lat']?.toString() ?? '');
            final lon = double.tryParse(data['lon']?.toString() ?? '');
            
            if (lat != null && lon != null && mounted) {
              setState(() {
                _venueLat = lat;
                _venueLng = lon;
                _hasVenueCoords = true;
                _isGeocoding = false;
                _statusMessage = 'Found venue: ${data['display_name']}';
              });
              _calculateDistance();
              _moveCameraToVenue();
              return; 
            }
          } else {
            debugPrint('Nominatim: No results for "$queryStr"');
          }
        } else {
          debugPrint('Nominatim HTTP Error: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        debugPrint('Nominatim error geocoding venue with "$queryStr": $e');
        if (mounted && queryStr == widget.event.location) {
          setState(() => _statusMessage = 'Geocoding connection error. Using fallbacks...');
        }
      }
    }

    // 3. Last Result: Fallback to Database coordinates if geocoding failed
    if (!_hasVenueCoords && widget.event.latitude != null && widget.event.longitude != null) {
        if (mounted) {
          setState(() {
            _venueLat = widget.event.latitude;
            _venueLng = widget.event.longitude;
            _hasVenueCoords = (_venueLat != null && _venueLng != null);
            _isGeocoding = false;
            _statusMessage = _hasVenueCoords ? 'Using database coordinates' : null;
          });
        }
        if (_hasVenueCoords && mounted) {
          _calculateDistance();
          _moveCameraToVenue();
        }
    }

    if (mounted) {
      setState(() {
        _isGeocoding = false;
        _statusMessage = _hasVenueCoords ? null : 'Could not find venue location.';
      });
    }
  }

  void _moveCameraToVenue() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_hasVenueCoords || !_mapReady) return;
      if (_currentPosition == null) {
        _mapController.move(LatLng(_venueLat ?? 0.0, _venueLng ?? 0.0), 14.0);
      } else {
        _fitMapToBounds();
      }
    });
  }

  void _fitMapToBounds() {
    if (!_hasVenueCoords || _currentPosition == null || !_mapReady) return;
    
    final bounds = LatLngBounds.fromPoints([
      LatLng(_venueLat ?? 0.0, _venueLng ?? 0.0),
      LatLng(_currentPosition?.latitude ?? 0.0, _currentPosition?.longitude ?? 0.0),
    ]);
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(80)),
    );
  }

  Future<void> _determinePosition() async {
    try {
      if (!_hasVenueCoords) {
        await _geocodeVenue();
      }

      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled or not supported.');
        await _handleLocationFailure('GPS turned off.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          await _handleLocationFailure('Permissions denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied.');
        await _handleLocationFailure('Perms denied forever.');
        return;
      }

      if (mounted) {
        setState(() => _statusMessage = 'Fetching accurate GPS location...');
      }



      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.best,
            distanceFilter: 10,
            timeLimit: Duration(seconds: 15),
          ),
        );
      } catch (e) {
        debugPrint('getCurrentPosition error: $e');
        await _handleLocationFailure('GPS timed out.');
        return;
      }
      
      _handleSuccessfulPosition(position);
    } catch (e) {
      debugPrint('Error determining location: $e');
      await _handleLocationFailure('Failed: $e');
    }
  }

  Future<void> _handleLocationFailure(String reason) async {
    debugPrint('Location failure reason: $reason');
    if (mounted) {
      setState(() {
        // Removed inaccurate geojs IP fallback 
        _statusMessage = 'Could not get accurate device GPS.';
      });
      _moveCameraToVenue();
    }
  }

    void _handleSuccessfulPosition(Position position, {String? status}) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
          if (status != null) {
            _statusMessage = status;
          } else if (_statusMessage == 'Fetching your location...') {
            _statusMessage = null; // Clear the fetching message
          }
          
          // Calculate distance updates fields which we then reflect in this same setState
          _calculateDistance();
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (_hasVenueCoords) {
            _fitMapToBounds();
          } else {
            _mapController.move(
              LatLng(position.latitude, position.longitude),
              13.0,
            );
          }
        });
      }
    }

    void _calculateDistance() {
      if (_currentPosition == null || !_hasVenueCoords) return;

      final distanceInMeters = Geolocator.distanceBetween(
        _currentPosition?.latitude ?? 0.0,
        _currentPosition?.longitude ?? 0.0,
        _venueLat ?? 0.0,
        _venueLng ?? 0.0,
      );

      final km = distanceInMeters / 1000;
      final timeInMins = (km / 40) * 60;

      // Update fields. Caller is responsible for wrapping in setState.
      _distance = '${km.toStringAsFixed(1)} KM';
      _travelTime = '${timeInMins.round()} MINS';
    }

  Future<void> _launchNavigation() async {
    if (!_hasVenueCoords) return;
    
    // Redirect user directly to the Google Maps app showing the venue location
    final lat = _venueLat ?? 0.0;
    final lng = _venueLng ?? 0.0;
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppHeader(
        title: 'Venue Location',
        showProfile: true,
      ),
      body: Stack(
        children: [
          // 1. Map Layer
          Positioned.fill(
            child: Container(
              color: const Color(0xFF1A1B2E),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _hasVenueCoords 
                      ? LatLng(_venueLat ?? 23.0919, _venueLng ?? 72.5975) 
                      : const LatLng(23.0919, 72.5975), // Fallback to Ahmedabad
                  initialZoom: 14.0,
                  onMapReady: () {
                    if (mounted) setState(() => _mapReady = true);
                    // Now safe to move the camera
                    _moveCameraToVenue();
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'arena_assist_app',
                  ),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      // Venue marker
                      if (_hasVenueCoords)
                        Marker(
                          point: LatLng(_venueLat ?? 0.0, _venueLng ?? 0.0),
                          width: 48,
                          height: 48,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      // User location marker
                      if (_currentPosition != null)
                        Marker(
                          point: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          width: 40,
                          height: 40,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 2. Status Banner (New)
          if (_statusMessage != null || _isGeocoding)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black87.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isGeocoding)
                      const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                      ),
                    if (_isGeocoding) const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        _statusMessage ?? 'Searching...',
                        style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 3. Top Stats Overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 130, // Pushed down for banner
            left: 20,
            right: 20,
            child: _buildGlassCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.spacingLg,
                  horizontal: AppDimens.spacingXl,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCol(Icons.directions_car, _distance, 'DISTANCE'),
                    Container(width: 1, height: 40, color: Colors.white10),
                    _buildStatCol(Icons.access_time, _travelTime, 'ARRIVAL'),
                  ],
                ),
              ),
            ),
          ),

          // 4. Locate Me Button (New)
          Positioned(
            right: 20,
            bottom: 250,
            child: FloatingActionButton.small(
              onPressed: _determinePosition,
              backgroundColor: AppColors.surfaceContainerHigh,
              foregroundColor: AppColors.primary,
              child: const Icon(Icons.my_location),
            ),
          ),

          // 5. Bottom Venue Details
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildGlassCard(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spacingXl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.event.title,
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.event.type == EventType.stadium
                                ? 'GATE 42'
                                : 'FLOOR 3',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.spacingSm),
                    Text(
                      widget.event.location,
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: AppDimens.spacingXl),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _launchNavigation,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'START NAVIGATION',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimens.spacingMd),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.share_outlined,
                                color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Location shared!')),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10, width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildStatCol(IconData icon, String val, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(val,
            style: AppTextStyles.titleMedium
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: Colors.white54, letterSpacing: 1.1)),
      ],
    );
  }
}

