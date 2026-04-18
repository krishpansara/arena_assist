import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class PythonApiClient {
  final http.Client _client;

  PythonApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('${ApiConstants.pythonBaseUrl}$endpoint');
    
    print('[DEBUG] PythonApiClient: Calling POST $uri');
    
    try {
      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      print('[DEBUG] PythonApiClient: Error calling $uri - $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('${ApiConstants.pythonBaseUrl}$endpoint');
    
    print('[DEBUG] PythonApiClient: Calling GET $uri');
    
    try {
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );

      return _handleResponse(response);
    } catch (e) {
      print('[DEBUG] PythonApiClient: Error calling $uri - $e');
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      return jsonDecode(response.body);
    } else {
      print('[DEBUG] PythonApiClient: Request failed with status ${response.statusCode}');
      print('[DEBUG] PythonApiClient: Error body: ${response.body}');
      throw Exception('API Request Failed: ${response.statusCode} - ${response.body}');
    }
  }

  void dispose() {
    _client.close();
  }
}
