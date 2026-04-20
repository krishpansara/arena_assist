import 'package:cloud_firestore/cloud_firestore.dart';

enum EmergencyStatus { active, resolved }

class EmergencyModel {
  final String id;
  final String userId;
  final String userName;
  final String eventId;
  final String eventTitle;
  final EmergencyStatus status;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final DateTime? resolvedAt;
  final String? helperId;

  EmergencyModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.eventId,
    required this.eventTitle,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.resolvedAt,
    this.helperId,
  });

  factory EmergencyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EmergencyModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? 'Unknown',
      eventId: data['eventId'] ?? '',
      eventTitle: data['eventTitle'] ?? 'Unknown Event',
      status: _parseStatus(data['status']),
      latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      resolvedAt: (data['resolvedAt'] as Timestamp?)?.toDate(),
      helperId: data['helperId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'eventId': eventId,
      'eventTitle': eventTitle,
      'status': status.name,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': Timestamp.fromDate(timestamp),
      'resolvedAt': resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
      'helperId': helperId,
    };
  }

  static EmergencyStatus _parseStatus(String? statusStr) {
    if (statusStr == null) return EmergencyStatus.active;
    return EmergencyStatus.values.firstWhere(
      (e) => e.name == statusStr,
      orElse: () => EmergencyStatus.active,
    );
  }

  EmergencyModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? eventId,
    String? eventTitle,
    EmergencyStatus? status,
    double? latitude,
    double? longitude,
    DateTime? timestamp,
    DateTime? resolvedAt,
    String? helperId,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      eventId: eventId ?? this.eventId,
      eventTitle: eventTitle ?? this.eventTitle,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      helperId: helperId ?? this.helperId,
    );
  }
}
