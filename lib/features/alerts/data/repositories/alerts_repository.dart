import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/alert_model.dart';

class AlertsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get a real-time stream of alerts for a specific user.
  /// We assume a collection path like `users/{userId}/alerts`
  Stream<List<AlertModel>> getUserAlerts(String userId) {
    if (userId.isEmpty) return Stream.value([]);
    
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('alerts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => AlertModel.fromFirestore(doc)).toList();
    });
  }

  /// Mark an alert as read
  Future<void> markAsRead(String userId, String alertId) async {
    if (userId.isEmpty) return;
    
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('alerts')
        .doc(alertId)
        .update({'isRead': true});
  }

  /// Mark all alerts as read
  Future<void> markAllAsRead(String userId) async {
    if (userId.isEmpty) return;
    
    final unreadAlerts = await _firestore
        .collection('users')
        .doc(userId)
        .collection('alerts')
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (var doc in unreadAlerts.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    
    await batch.commit();
  }
}
