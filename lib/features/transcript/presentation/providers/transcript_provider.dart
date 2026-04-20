import 'dart:async';
import 'package:arena_assist/features/transcript/domain/models/transcript_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

import '../../data/repositories/transcript_repository.dart';

class TranscriptState {
  final bool isListening;
  final bool isInitializing;
  final String partialText;
  final String finalText;
  final bool insightsLoading;
  final TranscriptRecord? record;
  final String? error;

  TranscriptState({
    this.isListening = false,
    this.isInitializing = false,
    this.partialText = '',
    this.finalText = '',
    this.insightsLoading = false,
    this.record,
    this.error,
  });

  TranscriptState copyWith({
    bool? isListening,
    bool? isInitializing,
    String? partialText,
    String? finalText,
    bool? insightsLoading,
    TranscriptRecord? record,
    String? error,
    bool clearError = false,
  }) {
    return TranscriptState(
      isListening: isListening ?? this.isListening,
      isInitializing: isInitializing ?? this.isInitializing,
      partialText: partialText ?? this.partialText,
      finalText: finalText ?? this.finalText,
      insightsLoading: insightsLoading ?? this.insightsLoading,
      record: record ?? this.record,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class TranscriptNotifier extends StateNotifier<TranscriptState> {
  final TranscriptRepository _repository;
  final SpeechToText _speechToText = SpeechToText();
  final String eventId;
  final String userId;
  String _recordId = '';
  bool _userIntendsToListen = false;
  
  // Timer for auto-saving less frequently to save tokens/Firestore writes
  Timer? _autoSaveTimer;

  TranscriptNotifier(this._repository, this.eventId, this.userId)
      : super(TranscriptState()) {
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    state = state.copyWith(isInitializing: true, clearError: true);
    try {
      bool available = await _speechToText.initialize(
        onStatus: _onStatus,
        onError: _onError,
      );
      if (available) {
        state = state.copyWith(isInitializing: false);
      } else {
        state = state.copyWith(
          isInitializing: false,
          error: 'Speech recognition is not available on this device.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isInitializing: false,
        error: 'Failed to initialize microphone: $e',
      );
    }
  }

  void _onStatus(String status) {
    if (status == 'done' || status == 'notListening') {
      state = state.copyWith(isListening: false);
      
      // AUTO-RESTART LOOP:
      // If the user hasn't explicitly tapped Stop, and the OS 
      // closed the mic due to silence, restart immediately.
      if (_userIntendsToListen) {
        // Increased delay to 500ms to ensure Android audio buffers 
        // are fully flushed before the next session starts.
        Future.delayed(const Duration(milliseconds: 500), () {
          if (_userIntendsToListen) {
            startListening();
          }
        });
      }
    }
  }

  void _onError(SpeechRecognitionError error) {
    state = state.copyWith(
      isListening: false,
      error: 'Error: ${error.errorMsg}',
    );
  }

  void _commitPartialText() {
    final text = state.partialText.trim();
    if (text.isNotEmpty) {
      // De-duplication check: Don't append if it's identical to the last segment
      final currentFinal = state.finalText.trim();
      if (currentFinal.endsWith(text) || currentFinal.endsWith('$text.')) {
        state = state.copyWith(partialText: '');
        return;
      }

      final updatedFinal = '${state.finalText}${state.finalText.isNotEmpty ? ' ' : ''}$text.';
      state = state.copyWith(
        finalText: updatedFinal,
        partialText: '',
      );
      _saveToBackend();
    }
  }

  bool _isSimulating = false;
  Timer? _simulationTimer;
  final List<String> _simulatedSentences = [
    "Welcome everyone to today's workshop.",
    "We have a lot of exciting material to cover about the new system.",
    "Feel free to ask questions as we go along.",
    "The core idea is to improve performance without sacrificing user experience.",
    "Let's dive into the first slide and look at the numbers.",
  ];
  int _simIndex = 0;

  Future<void> startListening() async {
    if (!_speechToText.isAvailable) await _initSpeech();
    
    // Explicitly check for microphone permission using permission_handler
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      state = state.copyWith(error: 'Microphone permission denied.');
      return;
    }

    if (_speechToText.isAvailable && !state.isListening) {
      _userIntendsToListen = true;
      
      // Clear error before starting
      state = state.copyWith(clearError: true);
      
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: const Duration(hours: 1),
        pauseFor: const Duration(seconds: 10), // Longer pause before native done
        partialResults: true,
        cancelOnError: false, // Don't stop on transient noise errors
        listenMode: ListenMode.dictation,
      );
      
      state = state.copyWith(isListening: true);
      
      // Auto-save every 2 minutes while recording, to handle long sessions gracefully
      _autoSaveTimer?.cancel();
      _autoSaveTimer = Timer.periodic(const Duration(minutes: 2), (_) {
        _saveToBackend();
      });
    } else if (!_speechToText.isAvailable) {
      // Fallback: Simulate speech recognition for desktop testing
      state = state.copyWith(clearError: true, isListening: true);
      _isSimulating = true;
      _simIndex = 0;
      _simulateSpeech();

      _autoSaveTimer?.cancel();
      _autoSaveTimer = Timer.periodic(const Duration(minutes: 2), (_) {
        _saveToBackend();
      });
    }
  }

  void _simulateSpeech() {
    if (!_isSimulating) return;
    String currentSentence = _simulatedSentences[_simIndex % _simulatedSentences.length];
    _simIndex++;
    
    int wordCount = 0;
    final words = currentSentence.split(' ');
    
    _simulationTimer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (!_isSimulating) {
        timer.cancel();
        return;
      }
      
      if (wordCount < words.length) {
        final partial = words.sublist(0, wordCount + 1).join(' ');
        state = state.copyWith(partialText: partial);
        wordCount++;
      } else {
        timer.cancel();
        final updatedFinal = '${state.finalText}${state.finalText.isNotEmpty ? ' ' : ''}$currentSentence';
        state = state.copyWith(finalText: updatedFinal, partialText: '');
        
        // Wait a bit, then generate the next sentence
        Future.delayed(const Duration(seconds: 2), () {
          if (_isSimulating) {
            _simulateSpeech();
          }
        });
      }
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      final text = result.recognizedWords.trim();
      if (text.isEmpty) return;

      // De-duplication check: 
      // Sometimes the engine delivers the same final result twice, 
      // or the restart loop captures the end of the previous session.
      final currentFinal = state.finalText.trim();
      if (currentFinal.endsWith(text) || currentFinal.endsWith('$text.')) {
        state = state.copyWith(partialText: '');
        return;
      }

      final updatedFinal = '${state.finalText}${state.finalText.isNotEmpty ? ' ' : ''}$text.';
      state = state.copyWith(
        finalText: updatedFinal,
        partialText: '',
      );
      _saveToBackend();
    } else {
      state = state.copyWith(partialText: result.recognizedWords);
    }
  }

  Future<void> stopListening() async {
    _userIntendsToListen = false; // Disable auto-restart BEFORE stopping engine

    if (_isSimulating) {
      _isSimulating = false;
      _simulationTimer?.cancel();
      _commitPartialText();
      state = state.copyWith(isListening: false);
      await _saveToBackend();
      return;
    }

    await _speechToText.stop();
    _autoSaveTimer?.cancel();
    
    // Give the engine a moment to deliver a final result before manual commit
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.partialText.isNotEmpty) {
      _commitPartialText();
    }
    
    state = state.copyWith(isListening: false);
    await _saveToBackend();
  }

  Future<void> _saveToBackend() async {
    final fullText = '${state.finalText} ${state.partialText}'.trim();
    if (fullText.isEmpty) return;

    if (_recordId.isEmpty) {
      _recordId = const Uuid().v4();
    }

    final newRecord = TranscriptRecord(
      id: _recordId,
      eventId: eventId,
      userId: userId,
      text: fullText,
      updatedAt: DateTime.now(),
      summary: state.record?.summary,
      keyPoints: state.record?.keyPoints,
      keywords: state.record?.keywords,
    );

    try {
      final savedId = await _repository.saveTranscript(newRecord);
      _recordId = savedId;
      state = state.copyWith(record: newRecord);
    } catch (e) {
      print('Failed to save to backend: $e');
    }
  }

  /// Manually trigger AI summarization
  Future<void> generateInsights() async {
    final fullText = '${state.finalText} ${state.partialText}'.trim();
    if (fullText.isEmpty) {
      state = state.copyWith(error: 'Not enough text to generate insights.');
      return;
    }

    state = state.copyWith(insightsLoading: true, clearError: true);

    try {
      // 1. Get Insights from Backend
      final insights = await _repository.generateInsights(fullText);
      
      if (insights != null) {
        // 2. Update local state
        final updatedRecord = TranscriptRecord(
          id: _recordId,
          eventId: eventId,
          userId: userId,
          text: insights['clean_transcript'] ?? fullText,
          updatedAt: DateTime.now(),
          summary: insights['summary'],
          keyPoints: insights['key_points'] != null ? List<String>.from(insights['key_points']) : null,
          keywords: insights['keywords'] != null ? List<String>.from(insights['keywords']) : null,
        );

        // 3. Save updated record back to Firestore
        if (_recordId.isNotEmpty) {
           await _repository.saveTranscript(updatedRecord);
        }
        
        // 4. If AI provided a clean transcript, replace our final text 
        // to show the grammar-corrected version.
        if (insights['clean_transcript'] != null) {
          state = state.copyWith(
            record: updatedRecord,
            finalText: insights['clean_transcript'],
            partialText: '', 
            insightsLoading: false,
          );
        } else {
           state = state.copyWith(record: updatedRecord, insightsLoading: false);
        }
      } else {
        state = state.copyWith(
          insightsLoading: false,
          error: 'Failed to generate insights. Check API key or connection.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        insightsLoading: false,
        error: 'Failed to generate insights: $e',
      );
    }
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
    super.dispose();
  }
}

final transcriptProvider = StateNotifierProvider.family<TranscriptNotifier, TranscriptState, String>((ref, eventId) {
  final repository = ref.watch(transcriptRepositoryProvider);
  final authState = ref.watch(authStateChangesProvider);
  final userId = authState.valueOrNull?.uid ?? '';
  return TranscriptNotifier(repository, eventId, userId);
});
