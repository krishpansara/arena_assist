import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Base URL for the Python backend
  static String get pythonBaseUrl {
    // 1. Priority: Explicit BACKEND_URL from .env
    final explicitUrl = dotenv.maybeGet('BACKEND_URL');
    if (explicitUrl != null && explicitUrl.isNotEmpty) {
      return explicitUrl;
    }

    // 2. Priority: Web handling
    if (kIsWeb) {
      final origin = Uri.base.origin;
      if (origin.contains('localhost')) {
        return 'http://localhost:8000';
      }
      return origin;
    }
    
    // 3. Priority: Mobile handling with MACHINE_IP
    final machineIp = dotenv.get('MACHINE_IP', fallback: '10.0.2.2');
    
    if (Platform.isAndroid) {
      return 'http://$machineIp:8000';
    }
    
    // Default for iOS / Desktop / others
    return 'http://localhost:8000';
  }

  
  // API Versioning
  static const String apiV1 = '/api/v1';
  
  // Endpoints
  static const String analyzeEvent = '$apiV1/analyze';
  static const String analyzeChat = '$apiV1/chat';
  
  // Helper to get full URL
  static String fullUrl(String endpoint) => '$pythonBaseUrl$endpoint';
}

