import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/transcript_model.dart';
import '../../data/repositories/transcript_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

final userEventTranscriptsProvider = StreamProvider.family<List<TranscriptRecord>, String>((ref, eventId) {
  final repository = ref.watch(transcriptRepositoryProvider);
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid;

  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  return repository.getTranscriptsForEvent(eventId, userId);
});
