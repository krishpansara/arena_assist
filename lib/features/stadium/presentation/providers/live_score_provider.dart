import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/domain/models/event_model.dart';
import '../../data/services/sportsrc_api_service.dart';

/// Provider for the SportSrcApiService. 
final sportSrcApiProvider = Provider<SportSrcApiService>((ref) {
  final service = SportSrcApiService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// A StreamProvider that fetches live scores and automatically polls every 10 seconds.
final liveScoreStreamProvider = StreamProvider.family<LiveScoreInfo, String>((ref, eventId) async* {
  final apiService = ref.watch(sportSrcApiProvider);

  // Yield the initial value
  yield await apiService.fetchLiveScore(eventId);

  // Poll loop: wait 10 seconds, then fetch again
  // Use a Stream.periodic or a while loop that respects provider cancellation.
  while (true) {
    // Wait for the polling interval
    await Future.delayed(const Duration(seconds: 10));
    
    // Check if the provider has been disposed
    // Setting up cancellation is better handled via standard Riverpod patterns,
    // but throwing an exception or cleanly breaking out if unmounted is essential.
    if (ref.state is AsyncLoading) continue; // safety check
    
    try {
      final newScore = await apiService.fetchLiveScore(eventId);
      yield newScore;
    } catch (e) {
      // Just emit current state to avoid breaking the stream or log the error
      // In a real app we might yield an error, but for live score we'll just fail silently 
      // on temp network issues and try again on the next polling tick.
    }
  }
});
