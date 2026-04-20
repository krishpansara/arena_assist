import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/theme.dart';
import '../providers/sos_provider.dart';

class EmergencyDashboardScreen extends ConsumerStatefulWidget {
  const EmergencyDashboardScreen({super.key});

  @override
  ConsumerState<EmergencyDashboardScreen> createState() => _EmergencyDashboardScreenState();
}

class _EmergencyDashboardScreenState extends ConsumerState<EmergencyDashboardScreen> {
  final MapController _mapController = MapController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    setState(() => _currentPosition = position);
    _mapController.move(LatLng(position.latitude, position.longitude), 15);
  }

  @override
  Widget build(BuildContext context) {
    final emergenciesAsync = ref.watch(activeEmergenciesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Command Center'),
        backgroundColor: AppColors.errorContainer,
        foregroundColor: AppColors.onErrorContainer,
      ),
      body: emergenciesAsync.when(
        data: (emergencies) {
          if (emergencies.isEmpty) {
            return _buildEmptyState();
          }

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition != null
                      ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                      : const LatLng(0, 0),
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.arena_assist.app',
                  ),
                  if (_currentPosition != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                          width: 40,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.person, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  MarkerLayer(
                    markers: emergencies.map((e) => Marker(
                      point: LatLng(e.latitude, e.longitude),
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          _showEmergencyDetails(context, e);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.warning, color: Colors.white, size: 24),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.radiusXl)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppDimens.spacingMd),
                        child: Text(
                          'Active Emergencies (${emergencies.length})',
                          style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                          itemCount: emergencies.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final emergency = emergencies[index];
                            final timeStr = DateFormat('h:mm a').format(emergency.timestamp);
                            
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.errorContainer,
                                child: Icon(Icons.warning_amber, color: AppColors.error),
                              ),
                              title: Text(emergency.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${emergency.eventTitle} • Triggered at $timeStr'),
                              trailing: Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                              onTap: () {
                                _mapController.move(LatLng(emergency.latitude, emergency.longitude), 18);
                                _showEmergencyDetails(context, emergency);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error loading emergencies: $err')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.health_and_safety, size: 80, color: AppColors.primary.withValues(alpha: 0.5)),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'All Clear',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Text(
            'No active emergencies at this time.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  void _showEmergencyDetails(BuildContext context, emergency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.radiusXxl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Emergency Details', style: AppTextStyles.titleLarge),
            const SizedBox(height: AppDimens.spacingMd),
            _detailRow(Icons.person, 'User', emergency.userName),
            _detailRow(Icons.event, 'Event', emergency.eventTitle),
            _detailRow(Icons.location_on, 'Coordinates', '${emergency.latitude.toStringAsFixed(4)}, ${emergency.longitude.toStringAsFixed(4)}'),
            _detailRow(Icons.access_time, 'Time', DateFormat('MMM d, h:mm a').format(emergency.timestamp)),
            const SizedBox(height: AppDimens.spacingXxl),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () {
                  // In a real app, assigning to a helper
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('DISPATCH HELPER', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      child: Row(
        children: [
          Icon(icon, color: AppColors.onSurfaceVariant, size: 20),
          const SizedBox(width: AppDimens.spacingMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
              Text(value, style: AppTextStyles.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}
