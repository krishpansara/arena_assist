import 'package:arena_assist/features/home/data/repositories/event_repository.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/data/services/event_firestore_service.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final firestoreService = ref.watch(eventFirestoreServiceProvider);
  return EventRepository(firestoreService: firestoreService);
});

final allEventsProvider = StreamProvider<List<EventModel>>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid;
  
  return ref.watch(eventRepositoryProvider).getEvents(userId);
});

final nearestEventProvider = Provider<EventModel?>((ref) {
  final eventsAsync = ref.watch(allEventsProvider);
  
  return eventsAsync.when(
    data: (events) {
      if (events.isEmpty) return null;
      
      final now = DateTime.now();
      
      // Filter for upcoming events (including those that started recently)
      final upcomingEvents = events.where((e) {
        // Show if it starts in the future or started within the last 3 hours (ongoing)
        return e.startTime.add(const Duration(hours: 3)).isAfter(now);
      }).toList();

      if (upcomingEvents.isEmpty) return null;

      // Sort by start time to find the nearest
      upcomingEvents.sort((a, b) => a.startTime.compareTo(b.startTime));
      
      return upcomingEvents.first;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
