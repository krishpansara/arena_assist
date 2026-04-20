import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/network/api_constants.dart';
import 'package:arena_assist/features/transcript/domain/models/transcript_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transcriptRepositoryProvider = Provider((ref) => TranscriptRepository());

class TranscriptRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _transcripts => _firestore.collection('transcripts');

  /// Saves or updates a transcript record.
  /// If the record has no ID, it will create a new document and return the assigned ID.
  Future<String> saveTranscript(TranscriptRecord record) async {
    if (record.id.isEmpty) {
      final docRef = await _transcripts.add(record.toMap());
      return docRef.id;
    } else {
      await _transcripts.doc(record.id).set(record.toMap(), SetOptions(merge: true));
      return record.id;
    }
  }

  /// Retrieves a stream of transcripts for a specific event and user
  Stream<List<TranscriptRecord>> getTranscriptsForEvent(String eventId, String userId) {
    return _transcripts
        .where('event_id', isEqualTo: eventId)
        .snapshots()
        .map((snapshot) {
      final records = snapshot.docs
          .map((doc) => TranscriptRecord.fromFirestore(doc))
          .where((record) => record.userId == userId)
          .toList();
      
      // Sort locally to avoid needing a Firestore composite index
      records.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return records;
    });
  }

  /// Fetches transcript summary and insights from the backend
  Future<Map<String, dynamic>?> generateInsights(String rawTranscript) async {
    if (rawTranscript.trim().isEmpty) {
      return null;
    }

    final url = Uri.parse('${ApiConstants.pythonBaseUrl}/api/v1/transcript/insights');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'transcript': rawTranscript}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['data'] as Map<String, dynamic>;
        }
      } else {
        print('Backend error (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      print('Error calling Backend: $e');
    }
    return null;
  }
}
