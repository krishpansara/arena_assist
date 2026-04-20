import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:arena_assist/features/support/data/services/chat_service.dart';
import 'package:arena_assist/features/support/domain/models/chat_message.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:arena_assist/features/home/presentation/providers/event_provider.dart';
import 'package:arena_assist/core/network/api_providers.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  final apiClient = ref.watch(pythonApiClientProvider);
  return ChatService(apiClient);
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isListening;
  final String speechText;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.isListening = false,
    this.speechText = '',
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isListening,
    String? speechText,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isListening: isListening ?? this.isListening,
      speechText: speechText ?? this.speechText,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatService _chatService;
  final Ref _ref;
  final stt.SpeechToText _speech = stt.SpeechToText();

  ChatNotifier(this._chatService, this._ref) : super(ChatState(messages: []));

  Future<void> sendMessage(String text, {EventModel? event}) async {
    if (text.trim().isEmpty) return;

    final user = _ref.read(authStateChangesProvider).valueOrNull;
    if (user == null) return;

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: text,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    );

    try {
      // Get context from provided event or current events
      final resolvedEvent = event ?? _ref.read(nearestEventProvider);
      final eventId = resolvedEvent?.id ?? 'general';
      final context = resolvedEvent != null 
          ? "Event: ${resolvedEvent.title}, Location: ${resolvedEvent.location}, Time: ${resolvedEvent.startTime}"
          : "No active event data found.";

      final reply = await _chatService.sendMessage(
        userId: user.uid,
        eventId: eventId,
        message: text,
        context: context,
      );

      final assistantMessage = ChatMessage(
        id: const Uuid().v4(),
        content: reply,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Optional: add an error message to the chat
    }
  }

  Future<void> toggleListening({EventModel? event}) async {
    if (state.isListening) {
      await _speech.stop();
      state = state.copyWith(isListening: false);
      if (state.speechText.isNotEmpty) {
        sendMessage(state.speechText, event: event);
      }
    } else {
      final status = await Permission.microphone.request();
      if (!status.isGranted) return;

      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        state = state.copyWith(isListening: true, speechText: '');
        _speech.listen(
          onResult: (val) {
            state = state.copyWith(speechText: val.recognizedWords);
            if (val.finalResult) {
              state = state.copyWith(isListening: false);
              sendMessage(val.recognizedWords, event: event);
            }
          },
        );
      }
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final service = ref.watch(chatServiceProvider);
  return ChatNotifier(service, ref);
});
