import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/expense_model.dart';
import '../providers/budget_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

import '../../../home/domain/models/event_model.dart';

class BudgetTrackerSection extends ConsumerStatefulWidget {
  final EventModel event;

  const BudgetTrackerSection({
    super.key,
    required this.event,
  });

  @override
  ConsumerState<BudgetTrackerSection> createState() => _BudgetTrackerSectionState();
}

class _BudgetTrackerSectionState extends ConsumerState<BudgetTrackerSection> {
  final _uuid = const Uuid();
  final double _costPerKm = 12.0; // AI estimate constant

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesProvider(widget.event.id));
    final budgetAmount = double.tryParse(widget.event.budget?.total.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ?? 4500.0;
    final summary = ref.watch(budgetSummaryProvider((widget.event.id, budgetAmount)));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopSummary(summary, budgetAmount),
          const SizedBox(height: AppDimens.spacingLg),
          _buildAIEstimateSection(),
          const SizedBox(height: AppDimens.spacingLg),
          _buildCategoryBars(summary, budgetAmount),
          const SizedBox(height: AppDimens.spacingLg),
          _buildExpenseList(expensesAsync),
          const SizedBox(height: AppDimens.spacingXxl), // Bottom padding for FAB/Scroll
        ],
      ),
    );
  }

  Widget _buildTopSummary(BudgetSummary summary, double budgetAmount) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.surfaceContainerHigh),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Budget',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                ),
                Text(
                  '₹${budgetAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: AppDimens.spacingSm),
                Text(
                  'Remaining: ₹${summary.remaining.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: summary.percentage > 0.9 ? AppColors.error : AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: summary.percentage,
                  strokeWidth: 8,
                  backgroundColor: AppColors.surfaceContainerHigh,
                  color: summary.percentage > 0.9 ? AppColors.error : AppColors.primary,
                ),
              ),
              Text(
                '${(summary.percentage * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAIEstimateSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary.withOpacity(0.1), AppColors.secondary.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.secondary, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'AI Travel Estimate',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingSm),
          const Text(
            'Estimated travel cost based on your location and venue distance (approx. 15km).',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${(15 * _costPerKm).toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () => _addAIEstimate(15 * _costPerKm),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text('Add to Budget'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBars(BudgetSummary summary, double budgetAmount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category Breakdown',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: AppDimens.spacingMd),
        ...ExpenseCategory.values.map((cat) {
          final amount = summary.categoryBreakdown[cat] ?? 0.0;
          if (amount == 0 && cat != ExpenseCategory.misc) return const SizedBox.shrink();
          
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimens.spacingSm),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cat.label, style: const TextStyle(fontSize: 13)),
                    Text('₹${amount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: budgetAmount > 0 ? amount / budgetAmount : 0,
                    backgroundColor: AppColors.surfaceContainerHigh,
                    color: _getCategoryColor(cat),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildExpenseList(AsyncValue<List<ExpenseModel>> expensesAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Expenses',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              onPressed: _showAddExpenseModal,
              icon: const Icon(Icons.add_circle, color: AppColors.primary),
            ),
          ],
        ),
        expensesAsync.when(
          data: (expenses) {
            if (expenses.isEmpty) {
              return Container(
                height: 100,
                alignment: Alignment.center,
                child: const Text('No expenses added yet', style: TextStyle(color: Colors.white54)),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Dismissible(
                  key: Key(expense.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: AppColors.error,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(budgetActionsProvider).deleteExpense(expense.id);
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryColor(expense.category).withOpacity(0.2),
                      child: Icon(_getCategoryIcon(expense.category), color: _getCategoryColor(expense.category), size: 18),
                    ),
                    title: Text(expense.title),
                    subtitle: Text(expense.category.label, style: const TextStyle(fontSize: 12)),
                    trailing: Text(
                      '₹${expense.amount.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err'),
        ),
      ],
    );
  }

  Color _getCategoryColor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.travel: return Colors.blue;
      case ExpenseCategory.food: return Colors.orange;
      case ExpenseCategory.tickets: return Colors.purple;
      case ExpenseCategory.merch: return Colors.teal;
      case ExpenseCategory.room: return Colors.green;
      case ExpenseCategory.misc: return Colors.grey;
    }
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.travel: return Icons.directions_car;
      case ExpenseCategory.food: return Icons.restaurant;
      case ExpenseCategory.tickets: return Icons.local_activity;
      case ExpenseCategory.merch: return Icons.shopping_bag;
      case ExpenseCategory.room: return Icons.hotel;
      case ExpenseCategory.misc: return Icons.more_horiz;
    }
  }

  void _addAIEstimate(double amount) {
    final userId = ref.read(authStateChangesProvider).valueOrNull?.uid ?? 'anonymous';
    final expense = ExpenseModel(
      id: _uuid.v4(),
      userId: userId,
      eventId: widget.event.id,
      title: 'Estimated Travel',
      amount: amount,
      category: ExpenseCategory.travel,
      date: DateTime.now(),
      metadata: {'source': 'ai_estimate'},
    );
    ref.read(budgetActionsProvider).addExpense(expense);
  }

  void _showAddExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceContainerHighest,
      builder: (context) => _AddExpenseModal(
        eventId: widget.event.id,
        onAdd: (expense) {
          ref.read(budgetActionsProvider).addExpense(expense);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _AddExpenseModal extends StatefulWidget {
  final String eventId;
  final Function(ExpenseModel) onAdd;

  const _AddExpenseModal({required this.eventId, required this.onAdd});

  @override
  State<_AddExpenseModal> createState() => _AddExpenseModalState();
}

class _AddExpenseModalState extends State<_AddExpenseModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: AppDimens.spacingMd,
        right: AppDimens.spacingMd,
        top: AppDimens.spacingMd,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add Expense', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: AppDimens.spacingMd),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title', hintText: 'e.g. Uber to Stadium'),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount (₹)', hintText: '0.00'),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          DropdownButtonFormField<ExpenseCategory>(
            value: _selectedCategory,
            items: ExpenseCategory.values.map((cat) {
              return DropdownMenuItem(value: cat, child: Text(cat.label));
            }).toList(),
            onChanged: (val) => setState(() => _selectedCategory = val!),
            decoration: const InputDecoration(labelText: 'Category'),
          ),
          const SizedBox(height: AppDimens.spacingLg),
          SizedBox(
            width: double.infinity,
            child: Consumer(
              builder: (context, ref, _) {
                return ElevatedButton(
                  onPressed: () {
                    final title = _titleController.text;
                    final amount = double.tryParse(_amountController.text) ?? 0;
                    if (title.isEmpty || amount <= 0) return;
                    
                    final userId = ref.read(authStateChangesProvider).valueOrNull?.uid ?? 'anonymous';
                    
                    final expense = ExpenseModel(
                      id: _uuid.v4(),
                      userId: userId,
                      eventId: widget.eventId,
                      title: title,
                      amount: amount,
                      category: _selectedCategory,
                      date: DateTime.now(),
                    );
                    widget.onAdd(expense);
                  },
                  child: const Text('Add Expense'),
                );
              },
            ),
          ),
          const SizedBox(height: AppDimens.spacingLg),
        ],
      ),
    );
  }
}
