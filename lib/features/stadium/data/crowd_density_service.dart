import 'dart:async';
import 'package:flutter/widgets.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/zone_mapper.dart';

// High-performance stream aggregating non-stale active_users zone counts
final crowdDensityProvider = StreamProvider.autoDispose<Map<StadiumZone, int>>((ref) {
  return FirebaseFirestore.instance
      .collection('active_users')
      .where('timestamp', isGreaterThan: Timestamp.fromDate(DateTime.now().subtract(const Duration(minutes: 2))))
      .snapshots()
      .map((snapshot) {
    final Map<StadiumZone, int> counts = {
      StadiumZone.northStand: 0,
      StadiumZone.southStand: 0,
      StadiumZone.eastStand: 0,
      StadiumZone.westStand: 0,
    };

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final zoneStr = data['zone_id'] as String?;
      if (zoneStr != null) {
        final zone = StadiumZone.values.firstWhere(
            (e) => ZoneMapper.zoneToString(e) == zoneStr,
            orElse: () => StadiumZone.outside);
        
        if (zone != StadiumZone.outside) {
           counts[zone] = (counts[zone] ?? 0) + 1;
        }
      }
    }
    return counts;
  });
});

// Maintains lifecycle of the LocationTracker
final locationTrackerProvider = Provider<LocationTracker>((ref) {
  final tracker = LocationTracker();
  ref.onDispose(() => tracker.dispose());
  return tracker;
});

class LocationTracker with WidgetsBindingObserver {
  StreamSubscription<Position>? _positionStream;
  Timer? _fallbackTimer;
  Position? _lastPosition;
  
  LocationTracker() {
    WidgetsBinding.instance.addObserver(this);
    _startTracking();
  }

  void _startTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    // Start location stream with battery-optimized settings.
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 20, // Only trigger if moved 20m
      ),
    ).listen((Position position) {
      _lastPosition = position;
      _updateLocationInFirebase(position);
      _resetTimer();
    });

    _resetTimer();
  }
  
  void _resetTimer() {
    _fallbackTimer?.cancel();
    _fallbackTimer = Timer.periodic(const Duration(minutes: 2), (timer) {
      if (_lastPosition != null) {
        _updateLocationInFirebase(_lastPosition!);
      }
    });
  }

  Future<void> _updateLocationInFirebase(Position position) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final zone = ZoneMapper.getZoneFromLocation(position.latitude, position.longitude);
    if (zone == StadiumZone.outside) return; // Don't track if outside

    // Privacy-focused: Store ONLY the zone and time, NO actual lat/long coords.
    await FirebaseFirestore.instance.collection('active_users').doc(user.uid).set({
      'user_id': user.uid,
      'zone_id': ZoneMapper.zoneToString(zone),
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _positionStream?.pause();
      _fallbackTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _positionStream?.resume();
      _resetTimer();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _positionStream?.cancel();
    _fallbackTimer?.cancel();
  }
}
