import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'python_api_client.dart';

final pythonApiClientProvider = Provider<PythonApiClient>((ref) {
  final client = PythonApiClient();
  
  // Clean up when provider is disposed
  ref.onDispose(() {
    client.dispose();
  });
  
  return client;
});
