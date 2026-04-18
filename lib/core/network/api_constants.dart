import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConstants {
  // If you are using a REAL Android device, replace this with your machine's local IP
  // You can find it by running 'ipconfig' (Windows) or 'ifconfig' (Mac/Linux)
  // Example: '192.168.1.5'
  static const String _machineIp = '10.0.2.2'; // Default to emulator alias
  
  // Base URL for the Python backend
  static String get pythonBaseUrl {
    // If running on Web, use localhost
    if (kIsWeb) {
      return 'http://localhost:8000';
    }
    
    // For Mobile (Android/iOS)
    if (Platform.isAndroid) {
      // 10.0.2.2 only works for the Android Emulator.
      // For a REAL device, you must use your machine's local network IP.
      return 'http://$_machineIp:8000';
    }
    
    // Default for iOS / Desktop / others
    return 'http://localhost:8000';
  }

  
  // API Versioning
  static const String apiV1 = '/api/v1';
  
  // Endpoints
  static const String analyzeEvent = '$apiV1/analyze';
  
  // Helper to get full URL
  static String fullUrl(String endpoint) => '$pythonBaseUrl$endpoint';
}

