import 'package:cloud_firestore/cloud_firestore.dart';

class TranscriptRecord {
  final String id;
  final String eventId;
  final String userId;
  final String text;
  final DateTime updatedAt;
  final DateTime? completedAt; // If true, the session is over
  final String? summary;
  final List<String>? keyPoints;
  final List<String>? keywords;

  TranscriptRecord({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.text,
    required this.updatedAt,
    this.completedAt,
    this.summary,
    this.keyPoints,
    this.keywords,
  });

  factory TranscriptRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TranscriptRecord(
      id: doc.id,
      eventId: data['event_id'] ?? '',
      userId: data['user_id'] ?? '',
      text: data['text'] ?? '',
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      completedAt: (data['completed_at'] as Timestamp?)?.toDate(),
      summary: data['summary'],
      keyPoints: data['key_points'] != null ? List<String>.from(data['key_points']) : null,
      keywords: data['keywords'] != null ? List<String>.from(data['keywords']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'user_id': userId,
      'text': text,
      'updated_at': Timestamp.fromDate(updatedAt),
      if (completedAt != null) 'completed_at': Timestamp.fromDate(completedAt!),
      if (summary != null) 'summary': summary,
      if (keyPoints != null) 'key_points': keyPoints,
      if (keywords != null) 'keywords': keywords,
    };
  }

  TranscriptRecord copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? text,
    DateTime? updatedAt,
    DateTime? completedAt,
    String? summary,
    List<String>? keyPoints,
    List<String>? keywords,
  }) {
    return TranscriptRecord(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      text: text ?? this.text,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      summary: summary ?? this.summary,
      keyPoints: keyPoints ?? this.keyPoints,
      keywords: keywords ?? this.keywords,
    );
  }
}
