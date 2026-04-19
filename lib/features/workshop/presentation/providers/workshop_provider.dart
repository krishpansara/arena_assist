import 'package:arena_assist/core/network/api_providers.dart';
import 'package:arena_assist/features/event_analyzer/data/services/event_analyzer_service.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/data/services/event_firestore_service.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:arena_assist/features/workshop/data/services/workshop_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workshopStorageProvider = Provider<WorkshopStorage>((ref) => WorkshopStorage());

final analyzerServiceProvider = Provider<EventAnalyzerService>((ref) {
  final apiClient = ref.watch(pythonApiClientProvider);
  return EventAnalyzerService(apiClient);
});

final analyzedWorkshopsProvider = StreamProvider<List<EventModel>>((ref) {
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid;
  
  if (userId == null) {
    return Stream.value([]);
  }

  return ref.watch(eventFirestoreServiceProvider).getUserEvents(userId);
});


final upcomingWorkshopsProvider = Provider<List<EventModel>>((ref) {
  final workshopsAsync = ref.watch(analyzedWorkshopsProvider);
  return workshopsAsync.when(
    data: (list) => list.where((w) => !w.isCompleted).toList(),
    loading: () => [],
    error: (error, stackTrace) => [],
  );
});

final completedWorkshopsProvider = Provider<List<EventModel>>((ref) {
  final workshopsAsync = ref.watch(analyzedWorkshopsProvider);
  return workshopsAsync.when(
    data: (list) => list.where((w) => w.isCompleted).toList(),
    loading: () => [],
    error: (error, stackTrace) => [],
  );
});
