import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/transport_service.dart';
import '../../domain/models/transport_models.dart';

// Service provider
final transportServiceProvider = Provider<TransportService>((ref) {
  return TransportService();
});

// State for the Form
class RideEstimatorState {
  final String source;
  final String destination;
  final bool isLoading;
  final String? error;
  final RideEstimationResponse? result;

  RideEstimatorState({
    this.source = 'Use Current Location',
    this.destination = '',
    this.isLoading = false,
    this.error,
    this.result,
  });

  RideEstimatorState copyWith({
    String? source,
    String? destination,
    bool? isLoading,
    String? error,
    bool clearError = false,
    RideEstimationResponse? result,
  }) {
    return RideEstimatorState(
      source: source ?? this.source,
      destination: destination ?? this.destination,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      result: result ?? this.result,
    );
  }
}

// Notifier
class RideEstimatorNotifier extends StateNotifier<RideEstimatorState> {
  final TransportService _service;

  RideEstimatorNotifier(this._service, {String defaultDestination = ''})
      : super(RideEstimatorState(destination: defaultDestination));

  void updateSource(String source) {
    state = state.copyWith(source: source, clearError: true);
  }

  void updateDestination(String destination) {
    state = state.copyWith(destination: destination, clearError: true);
  }

  Future<void> estimateFare() async {
    if (state.source.isEmpty || state.destination.isEmpty) {
      state = state.copyWith(error: 'Please enter both source and destination.');
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _service.estimateFares(
        source: state.source, 
        destination: state.destination
      );
      
      state = state.copyWith(
        isLoading: false, 
        result: response
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: 'Failed to estimate fare. Please try again.',
      );
    }
  }
}

// Provider
final rideEstimatorProvider = StateNotifierProvider.family<RideEstimatorNotifier, RideEstimatorState, String>((ref, defaultDest) {
  final service = ref.watch(transportServiceProvider);
  return RideEstimatorNotifier(service, defaultDestination: defaultDest);
});
