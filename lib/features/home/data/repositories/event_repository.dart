import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/data/services/event_firestore_service.dart';
import 'dart:async';

class EventRepository {
  final EventFirestoreService _firestoreService;

  EventRepository({
    required EventFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  Stream<List<EventModel>> getEvents(String? userId) {
    if (userId == null) {
      // Guest users see no events by default
      return Stream.value([]);
    }

    // Return firestore events for authenticated users
    return _firestoreService.getUserEvents(userId);
  }
}
