import 'package:cloud_firestore/cloud_firestore.dart';

enum ExpenseCategory {
  travel('Travel'),
  food('Food'),
  tickets('Tickets'),
  merch('Merch'),
  room('Accommodation'),
  misc('Misc');

  final String label;
  const ExpenseCategory(this.label);

  static ExpenseCategory fromString(String value) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.name == value || e.label == value,
      orElse: () => ExpenseCategory.misc,
    );
  }
}

class ExpenseModel {
  final String id;
  final String userId;
  final String eventId;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final Map<String, dynamic>? metadata;

  ExpenseModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.metadata,
  });

  factory ExpenseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ExpenseModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      eventId: data['eventId'] ?? '',
      title: data['title'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      category: ExpenseCategory.fromString(data['category'] ?? 'misc'),
      date: (data['date'] as Timestamp).toDate(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'eventId': eventId,
      'title': title,
      'amount': amount,
      'category': category.name,
      'date': Timestamp.fromDate(date),
      'metadata': metadata,
    };
  }

  ExpenseModel copyWith({
    String? id,
    String? userId,
    String? eventId,
    String? title,
    double? amount,
    ExpenseCategory? category,
    DateTime? date,
    Map<String, dynamic>? metadata,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      metadata: metadata ?? this.metadata,
    );
  }
}
