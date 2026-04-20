import 'package:arena_assist/core/network/api_constants.dart';
import 'package:arena_assist/core/network/python_api_client.dart';

class ChatService {
  final PythonApiClient _apiClient;

  ChatService(this._apiClient);

  Future<String> sendMessage({
    required String userId,
    required String eventId,
    required String message,
    String? context,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.analyzeChat,
        body: {
          'user_id': userId,
          'event_id': eventId,
          'message': message,
          'context': context ?? '',
        },
      );

      if (response['status'] == 'success') {
        return response['reply'] as String;
      } else {
        throw Exception('Assistant failed to reply: ${response['status']}');
      }
    } catch (e) {
      print('[DEBUG] ChatService: Error sending message - $e');
      rethrow;
    }
  }
}
