import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/domain/models/event_model.dart';

final eventFirestoreServiceProvider = Provider<EventFirestoreService>((ref) {
  return EventFirestoreService();
});

class EventFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'events';

  Future<void> saveEvent(EventModel event) async {
    if (event.userId == null) {
      throw Exception('UserId is required to save an event to Firestore.');
    }
    
    await _firestore
        .collection(_collectionName)
        .doc(event.id)
        .set(event.toJson());

    // Auto-seed an expense document if it's a paid event.
    // The entryFee and !isFree checks determine if the event is a paid event.
    if (!event.isFree && event.entryFee != null && event.entryFee! > 0) {
      final expenseRef = _firestore.collection('expenses').doc();
      final expensePayload = {
        'userId': event.userId,
        'eventId': event.id,
        'title': 'Event Ticket - ${event.title}',
        'amount': event.entryFee,
        'category': 'tickets', // Matches ExpenseCategory.tickets.name
        'date': Timestamp.now(),
        'metadata': {'source': 'auto-seed', 'isEventEntryFee': true},
      };

      await expenseRef.set(expensePayload);
    }
  }

  Stream<List<EventModel>> getUserEvents(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data()))
          .toList();
    });
  }

  Future<void> deleteEvent(String eventId) async {
    await _firestore.collection(_collectionName).doc(eventId).delete();
  }
}
