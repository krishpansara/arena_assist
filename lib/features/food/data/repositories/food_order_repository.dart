import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/food_models.dart';

class FoodOrderRepository {
  final FirebaseFirestore _firestore;

  FoodOrderRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> placeOrder(OrderModel order) async {
    try {
      await _firestore.collection('orders').doc(order.id).set(order.toJson());
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
    });
  }
}

final foodOrderRepositoryProvider = Provider<FoodOrderRepository>((ref) {
  return FoodOrderRepository();
});
