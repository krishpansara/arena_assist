import 'dart:async';
import 'package:http/http.dart' as http;
import '../../../home/domain/models/event_model.dart';
import 'dart:math';

/// A service that interfaces with the SportSRC API to provide live score updates.
/// Since we are building an auto-updating service without requiring an API key,
/// this service simulates the network latency and live score progression 
/// that you would expect from a standard REST API.
class SportSrcApiService {
  final http.Client _client;
  
  // Track mock scores for persistent session progression
  final Map<String, LiveScoreInfo> _mockScores = {};
  final Random _random = Random();

  SportSrcApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches the current live score for a given event ID.
  Future<LiveScoreInfo> fetchLiveScore(String eventId) async {
    // Simulate network delay (cache or API fetch time)
    await Future.delayed(const Duration(milliseconds: 800));

    // Try to get a real payload (simulated)
    try {
      // In a real scenario, this would be:
      // final response = await _client.get(Uri.parse('https://api.sportsrc.com/v1/scores/$eventId'));
      // if (response.statusCode == 200) { ... }
      
      return _generateLiveScore(eventId);
    } catch (e) {
      throw Exception('Failed to fetch live score from SportSRC API: $e');
    }
  }

  /// Closes the HTTP client
  void dispose() {
    _client.close();
  }

  // ---- Mock Data Generation Generator ----

  LiveScoreInfo _generateLiveScore(String eventId) {
    // Check if we already have a score progress for this event
    if (!_mockScores.containsKey(eventId)) {
      _mockScores[eventId] = LiveScoreInfo(
        homeTeam: 'Real Madrid',
        awayTeam: 'Liverpool',
        homeScore: 1,
        awayScore: 0,
        matchClock: "45'",
        sportDescriptor: '1st Half',
      );
    } else {
      // Update logic: roughly every few requests, we might increment a score or update the clock
      var current = _mockScores[eventId]!;
      
      int clockMins = int.tryParse(current.matchClock?.replaceAll("'", "") ?? "0") ?? 45;
      clockMins += 1;
      
      int hScore = current.homeScore;
      int aScore = current.awayScore;
      
      // 5% chance of goal for home, 5% for away on each generic update tick
      if (_random.nextDouble() > 0.95) hScore++;
      if (_random.nextDouble() > 0.95) aScore++;

      String descriptor = current.sportDescriptor ?? '1st Half';
      if (clockMins > 45 && descriptor == '1st Half') descriptor = 'Half Time';
      if (clockMins > 45 && descriptor == 'Half Time' && _random.nextDouble() > 0.5) descriptor = '2nd Half';
      if (clockMins > 90) descriptor = 'Full Time';

      _mockScores[eventId] = LiveScoreInfo(
        homeTeam: current.homeTeam,
        awayTeam: current.awayTeam,
        homeScore: hScore,
        awayScore: aScore,
        matchClock: clockMins <= 90 ? "$clockMins'" : "90'+",
        sportDescriptor: descriptor,
      );
    }
    return _mockScores[eventId]!;
  }
}
