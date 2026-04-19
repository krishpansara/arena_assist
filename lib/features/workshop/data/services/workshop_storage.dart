import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class WorkshopStorage {
  static String _getKey(String? userId) => 'analyzed_workshops_${userId ?? 'guest'}';

  Future<void> saveWorkshop(EventModel workshop, [String? userId]) async {
    final prefs = await SharedPreferences.getInstance();
    final List<EventModel> workshops = await getWorkshops(userId);
    
    // Remove if already exists (matching by ID or title)
    workshops.removeWhere((item) => item.id == workshop.id || item.title == workshop.title);
    
    // Insert at beginning (LIFO / Recent first)
    workshops.insert(0, workshop);
    
    // Limit to 20 items to save space
    if (workshops.length > 20) {
      workshops.removeLast();
    }

    final jsonList = workshops.map((e) => e.toJson()).toList();
    await prefs.setString(_getKey(userId), jsonEncode(jsonList));
  }

  Future<List<EventModel>> getWorkshops([String? userId]) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString(_getKey(userId));
    
    if (jsonStr == null) return [];
    
    try {
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      return jsonList.map((e) => EventModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<EventModel>> getUpcomingWorkshops([String? userId]) async {
    final workshops = await getWorkshops(userId);
    return workshops.where((w) => !w.isCompleted).toList();
  }

  Future<List<EventModel>> getCompletedWorkshops([String? userId]) async {
    final workshops = await getWorkshops(userId);
    return workshops.where((w) => w.isCompleted).toList();
  }
}
