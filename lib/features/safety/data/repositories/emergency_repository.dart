import 'package:arena_assist/features/safety/domain/models/emergency_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emergencyRepositoryProvider = Provider<EmergencyRepository>((ref) {
  return EmergencyRepositoryImpl(FirebaseFirestore.instance);
});

abstract class EmergencyRepository {
  Future<String> triggerSOS(EmergencyModel emergency);
  Future<void> updateLocation(String emergencyId, double lat, double lng);
  Future<void> resolveEmergency(String emergencyId, {String? helperId});
  Stream<List<EmergencyModel>> getActiveEmergencies();
}

class EmergencyRepositoryImpl implements EmergencyRepository {
  final FirebaseFirestore _firestore;

  EmergencyRepositoryImpl(this._firestore);

  @override
  Future<String> triggerSOS(EmergencyModel emergency) async {
    final docRef = await _firestore.collection('emergencies').add(emergency.toMap());
    return docRef.id;
  }

  @override
  Future<void> updateLocation(String emergencyId, double lat, double lng) async {
    await _firestore.collection('emergencies').doc(emergencyId).update({
      'latitude': lat,
      'longitude': lng,
    });
  }

  @override
  Future<void> resolveEmergency(String emergencyId, {String? helperId}) async {
    await _firestore.collection('emergencies').doc(emergencyId).update({
      'status': EmergencyStatus.resolved.name,
      'resolvedAt': FieldValue.serverTimestamp(),
      if (helperId != null) 'helperId': helperId,
    });
  }

  @override
  Stream<List<EmergencyModel>> getActiveEmergencies() {
    return _firestore
        .collection('emergencies')
        .where('status', isEqualTo: EmergencyStatus.active.name)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => EmergencyModel.fromFirestore(doc)).toList());
  }
}
