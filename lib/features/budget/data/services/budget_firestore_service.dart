import 'package:arena_assist/features/budget/domain/models/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _expensesCollection => _firestore.collection('expenses');

  // Stream of expenses for a specific user and event
  Stream<List<ExpenseModel>> getExpenses(String userId, String eventId) {
    return _expensesCollection
        .where('userId', isEqualTo: userId)
        .where('eventId', isEqualTo: eventId)
        // TODO: Restore ordering once composite index is ready
        // .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ExpenseModel.fromFirestore(doc)).toList();
    });
  }

  // Add a new expense
  Future<void> addExpense(ExpenseModel expense) async {
    await _expensesCollection.doc(expense.id).set(expense.toFirestore());
  }

  // Delete an expense
  Future<void> deleteExpense(String expenseId) async {
    await _expensesCollection.doc(expenseId).delete();
  }

  // Update an expense
  Future<void> updateExpense(ExpenseModel expense) async {
    await _expensesCollection.doc(expense.id).update(expense.toFirestore());
  }

  // Get total spent for an event
  Future<double> getTotalSpent(String userId, String eventId) async {
    final snapshot = await _expensesCollection
        .where('userId', isEqualTo: userId)
        .where('eventId', isEqualTo: eventId)
        .get();

    final docs = snapshot.docs;
    double totalSpent = 0.0;
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      totalSpent += (data['amount'] ?? 0.0).toDouble();
    }
    return totalSpent;
  }
}
