import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/data/services/event_firestore_service.dart';
import 'dart:async';

class EventRepository {
  final EventFirestoreService _firestoreService;

  EventRepository({
    required EventFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // Mock list of events for Guest users
  final List<EventModel> _mockEvents = [
    // HISTORY
    EventModel.mock(
      id: 'mock_past_1',
      type: EventType.stadium,
      title: 'ICC World Cup 2023\nFinal',
      startTime: DateTime.now().subtract(const Duration(days: 30, hours: 2)),
      location: 'Narendra Modi Stadium',
      latitude: 23.0919,
      longitude: 72.5975,
    ).copyWith(userId: 'guest_user'),
    EventModel.mock(
      id: 'mock_past_2',
      type: EventType.workshop,
      title: 'Google I/O Extended\nTech Talk',
      startTime: DateTime.now().subtract(const Duration(days: 5, hours: 4)),
      location: 'Koramangala, BLR',
      latitude: 12.9352,
      longitude: 77.6245,
    ).copyWith(userId: 'guest_user'),

    // ONGOING
    EventModel.mock(
      id: 'mock_live_1',
      type: EventType.stadium,
      title: 'Premier League\nMan City vs Arsenal',
      startTime: DateTime.now().subtract(const Duration(hours: 1)), // Started 1 hour ago
      location: 'Etihad Stadium',
      latitude: 53.4831,
      longitude: -2.2004,
    ).copyWith(userId: 'guest_user'),
    EventModel.mock(
      id: 'mock_live_2',
      type: EventType.workshop,
      title: 'AI Native Development\nBootcamp',
      startTime: DateTime.now().subtract(const Duration(minutes: 15)), // Started 15 mins ago
      location: 'Tech Hub',
      latitude: 19.1334,
      longitude: 72.9133,
    ).copyWith(userId: 'guest_user'),

    // UPCOMING
    EventModel.mock(
      id: 'mock_future_1',
      type: EventType.stadium,
      title: 'Champions League\nFinals',
      startTime: DateTime.now().add(const Duration(days: 2, hours: 5)),
      location: 'Wembley Stadium',
      latitude: 51.5560,
      longitude: -0.2795,
    ).copyWith(userId: 'guest_user'),
    EventModel.mock(
      id: 'mock_future_2',
      type: EventType.workshop,
      title: 'Advanced Flutter\nMasterclass',
      startTime: DateTime.now().add(const Duration(days: 4, hours: 2)),
      location: 'IIT Bombay',
      latitude: 19.1334,
      longitude: 72.9133,
    ).copyWith(userId: 'guest_user'),
  ];

  Stream<List<EventModel>> getEvents(String? userId) {
    if (userId == null) {
      // Return mock events for guest users
      return Stream.value(_mockEvents);
    }

    // Return firestore events for authenticated users
    return _firestoreService.getUserEvents(userId);
  }
}
