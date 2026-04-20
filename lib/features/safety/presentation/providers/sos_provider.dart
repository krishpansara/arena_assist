import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/models/emergency_model.dart';
import '../../data/repositories/emergency_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final sosProvider = StateNotifierProvider<SOSNotifier, SOSState>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final user = authState.valueOrNull;
  
  return SOSNotifier(
    ref.read(emergencyRepositoryProvider),
    user?.uid,
    user?.displayName,
  );
});

class SOSState {
  final bool isActive;
  final String? activeEmergencyId;
  final String? eventId;
  final String? eventTitle;
  
  SOSState({
    required this.isActive,
    this.activeEmergencyId,
    this.eventId,
    this.eventTitle,
  });

  SOSState copyWith({
    bool? isActive,
    String? activeEmergencyId,
    String? eventId,
    String? eventTitle,
  }) {
    return SOSState(
      isActive: isActive ?? this.isActive,
      activeEmergencyId: activeEmergencyId,
      eventId: eventId,
      eventTitle: eventTitle,
    );
  }
}

class SOSNotifier extends StateNotifier<SOSState> {
  final EmergencyRepository _repository;
  final String? _userId;
  final String? _userName;
  StreamSubscription<Position>? _positionSubscription;

  SOSNotifier(this._repository, this._userId, this._userName) 
      : super(SOSState(isActive: false));

  Future<void> triggerSOS(String eventId, String eventTitle) async {
    if (state.isActive) return;
    
    if (_userId == null) {
      throw StateError('You must be logged in to trigger an SOS alert.');
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw StateError('Location services are disabled. Please enable them to continue.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();

    final emergency = EmergencyModel(
      id: '',
      userId: _userId,
      userName: _userName ?? 'Unknown User',
      eventId: eventId,
      eventTitle: eventTitle,
      status: EmergencyStatus.active,
      latitude: position.latitude,
      longitude: position.longitude,
      timestamp: DateTime.now(),
    );

    final emergencyId = await _repository.triggerSOS(emergency);
    state = SOSState(
      isActive: true, 
      activeEmergencyId: emergencyId,
      eventId: eventId,
      eventTitle: eventTitle,
    );
    _startTrackingLocation();
  }

  void _startTrackingLocation() {
    _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // updates every 10 meters
      ),
    ).listen((Position position) {
      if (state.activeEmergencyId != null) {
        _repository.updateLocation(state.activeEmergencyId!, position.latitude, position.longitude);
      }
    });
  }

  Future<void> resolveSOS() async {
    if (!state.isActive || state.activeEmergencyId == null) return;

    await _repository.resolveEmergency(state.activeEmergencyId!);
    _positionSubscription?.cancel();
    state = SOSState(isActive: false);
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    super.dispose();
  }
}

// Stream provider for the dashboard
final activeEmergenciesProvider = StreamProvider<List<EmergencyModel>>((ref) {
  return ref.watch(emergencyRepositoryProvider).getActiveEmergencies();
});
