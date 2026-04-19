import 'package:cloud_firestore/cloud_firestore.dart';

enum AlertType { info, warning, success, eventStarting }

class AlertModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final AlertType type;
  final bool isRead;
  final String? eventId; // Optional: If the alert is specific to an event

  AlertModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.type = AlertType.info,
    this.isRead = false,
    this.eventId,
  });

  factory AlertModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AlertModel(
      id: doc.id,
      title: data['title'] ?? 'Alert',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      type: _parseAlertType(data['type']),
      isRead: data['isRead'] ?? false,
      eventId: data['eventId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
      'type': type.name,
      'isRead': isRead,
      'eventId': eventId,
    };
  }

  static AlertType _parseAlertType(String? typeStr) {
    if (typeStr == null) return AlertType.info;
    return AlertType.values.firstWhere(
      (e) => e.name == typeStr,
      orElse: () => AlertType.info,
    );
  }

  AlertModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    AlertType? type,
    bool? isRead,
    String? eventId,
  }) {
    return AlertModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      eventId: eventId ?? this.eventId,
    );
  }
}
