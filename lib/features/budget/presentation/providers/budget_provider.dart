import 'package:arena_assist/features/budget/data/services/budget_firestore_service.dart';
import 'package:arena_assist/features/budget/domain/models/expense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final budgetServiceProvider = Provider<BudgetFirestoreService>((ref) {
  return BudgetFirestoreService();
});

// Stream of expenses for a specific event
final expensesProvider = StreamProvider.family<List<ExpenseModel>, String>((ref, eventId) {
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid;
  
  if (userId == null) return Stream.value([]);
  
  return ref.watch(budgetServiceProvider).getExpenses(userId, eventId);
});

// Summary state for the budget
class BudgetSummary {
  final double spent;
  final double budget;
  final Map<ExpenseCategory, double> categoryBreakdown;

  BudgetSummary({
    required this.spent,
    required this.budget,
    required this.categoryBreakdown,
  });

  double get remaining => budget - spent;
  double get percentage => budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0.0;
}

// Provider for the budget summary
final budgetSummaryProvider = Provider.family<BudgetSummary, (String eventId, double eventBudget)>((ref, arg) {
  final eventId = arg.$1;
  final eventBudget = arg.$2;
  final expenses = ref.watch(expensesProvider(eventId)).valueOrNull ?? [];
  
  double totalSpent = 0;
  Map<ExpenseCategory, double> breakdown = {
    for (var cat in ExpenseCategory.values) cat: 0.0,
  };
  
  for (final expense in expenses) {
    totalSpent += expense.amount;
    breakdown[expense.category] = (breakdown[expense.category] ?? 0) + expense.amount;
  }
  
  return BudgetSummary(
    spent: totalSpent,
    budget: eventBudget,
    categoryBreakdown: breakdown,
  );
});

// Provider for actions
final budgetActionsProvider = Provider((ref) {
  final service = ref.watch(budgetServiceProvider);
  return BudgetActions(service);
});

class BudgetActions {
  final BudgetFirestoreService _service;
  BudgetActions(this._service);

  Future<void> addExpense(ExpenseModel expense) => _service.addExpense(expense);
  Future<void> deleteExpense(String id) => _service.deleteExpense(id);
  Future<void> updateExpense(ExpenseModel expense) => _service.updateExpense(expense);
}
