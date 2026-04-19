import 'package:arena_assist/core/network/api_constants.dart';
import 'package:arena_assist/core/network/python_api_client.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class EventAnalyzerService {
  final PythonApiClient _apiClient;

  EventAnalyzerService(this._apiClient);

  Future<EventModel> analyzeEvent(String urlOrQuery) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.analyzeEvent,
        body: {'url': urlOrQuery},
      );

      final Map<String, dynamic> data = response['data'];

      // Map backend response to EventModel
      return EventModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: data['event_type'] == 'stadium' ? EventType.stadium : EventType.workshop,
        title: data['event_name'] ?? 'Untitled Event',
        startTime: _parseDate(data['date']),
        location: data['location'] ?? 'Unknown Location',
        latitude: (data['latitude'] as num?)?.toDouble() ?? 37.7749, // Default to SF if missing
        longitude: (data['longitude'] as num?)?.toDouble() ?? -122.4194,
        section: data['event_type'] == 'stadium' ? '112' : 'Main Stage',
        row: data['event_type'] == 'stadium' ? 'AA' : '-',
        seat: data['event_type'] == 'stadium' ? '14' : '-',
        description: data['description'],
        speakers: (data['speakers'] as List?)
            ?.map(
              (s) => SpeakerInfo(
                name: s['name'] ?? '',
                topic: s['topic'] ?? '',
                bio: s['bio'] ?? '',
                imageUrl:
                    'https://ui-avatars.com/api/?name=${Uri.encodeComponent(s['name'] ?? 'anon')}&background=random',
              ),
            )
            .toList(),
        sessions: (data['sessions'] as List?)
            ?.map(
              (s) => SessionInfo(
                title: s['title'] ?? '',
                time: s['time'] ?? '',
                speaker: s['speaker'] ?? '',
              ),
            )
            .toList(),
        budget: data['budget'] != null
            ? BudgetEstimate(
                tickets: data['budget']['tickets'] ?? 'N/A',
                travel: data['budget']['travel'] ?? 'N/A',
                total: data['budget']['total_estimate'] ?? 'N/A',
              )
            : null,
        checklist: (data['checklist'] as List?)?.cast<String>(),
      );
    } catch (e) {
      print('[DEBUG] EventAnalyzerService: Error analyzing event - $e');
      throw Exception('Failed to analyze event: $e');
    }
  }

  DateTime _parseDate(String? dateStr) {
    if (dateStr == null) return DateTime.now().add(const Duration(days: 7));
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return DateTime.now().add(const Duration(days: 7));
    }
  }
}

