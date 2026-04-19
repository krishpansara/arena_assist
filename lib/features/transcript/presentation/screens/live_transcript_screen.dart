import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../home/domain/models/event_model.dart';
import '../../domain/models/transcript_model.dart';
import '../providers/transcript_provider.dart';

class LiveTranscriptScreen extends ConsumerStatefulWidget {
  final EventModel event;

  const LiveTranscriptScreen({super.key, required this.event});

  @override
  ConsumerState<LiveTranscriptScreen> createState() => _LiveTranscriptScreenState();
}

class _LiveTranscriptScreenState extends ConsumerState<LiveTranscriptScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(transcriptProvider(widget.event.id));
    final notifier = ref.read(transcriptProvider(widget.event.id).notifier);

    // Auto-scroll to bottom when new text arrives
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppHeader(
        title: 'LIVE TRANSCRIPT',
        showBackButton: true,
        showProfile: false,
      ),
      body: Column(
        children: [
          // Sub-header with recording indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border(bottom: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.1))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.event.title,
                    style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (state.isListening)
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppDimens.spacingSm),
                      Text(
                        'RECORDING',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          if (state.error != null)
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingMd),
              color: AppColors.error.withValues(alpha: 0.1),
              width: double.infinity,
              child: Text(
                state.error!,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
              ),
            ),

          // Main Transcript Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(AppDimens.spacingXl),
              padding: const EdgeInsets.all(AppDimens.spacingLg),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
              ),
              child: state.finalText.isEmpty && state.partialText.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.mic_none, size: 48, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                          const SizedBox(height: AppDimens.spacingMd),
                          Text(
                            state.isListening ? 'Listening...' : 'Tap the microphone to start transcribing.',
                            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant.withValues(alpha: 0.7)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (state.finalText.isNotEmpty)
                          Text(
                            state.finalText,
                            style: AppTextStyles.bodyLarge.copyWith(
                              height: 1.6,
                              color: AppColors.onSurface,
                            ),
                          ),
                        if (state.partialText.isNotEmpty) ...[
                          if (state.finalText.isNotEmpty) const SizedBox(height: AppDimens.spacingSm),
                          Text(
                            state.partialText,
                            style: AppTextStyles.bodyLarge.copyWith(
                              height: 1.6,
                              color: AppColors.primary, // Highlight live text
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ]
                      ],
                    ),
            ),
          ),

          // Action Area & Insights
          Container(
            padding: const EdgeInsets.only(
              left: AppDimens.spacingXl,
              right: AppDimens.spacingXl,
              bottom: AppDimens.spacingXxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // AI Action Panel (only visible when not listening and we have text)
                if (!state.isListening && state.finalText.isNotEmpty) ...[
                  if (state.insightsLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (state.record?.summary == null)
                    ElevatedButton.icon(
                      onPressed: notifier.generateInsights,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tertiary,
                        foregroundColor: AppColors.onTertiary,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                      ),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('GENERATE AI INSIGHTS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    )
                  else
                    _buildInsightsPanel(state.record!),
                  
                  const SizedBox(height: AppDimens.spacingLg),
                ],

                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.large(
                      heroTag: 'mic',
                      onPressed: state.isInitializing
                          ? null
                          : () {
                              if (state.isListening) {
                                notifier.stopListening();
                              } else {
                                notifier.startListening();
                              }
                            },
                      backgroundColor: state.isListening ? AppColors.surfaceContainerHighest : AppColors.primary,
                      foregroundColor: state.isListening ? AppColors.error : AppColors.onPrimary,
                      elevation: state.isListening ? 0 : 4,
                      child: state.isInitializing
                          ? const CircularProgressIndicator(color: AppColors.onPrimary)
                          : Icon(state.isListening ? Icons.stop : Icons.mic, size: 36),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsPanel(TranscriptRecord record) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.tertiary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.tertiary, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'AI SUMMARY',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Text(
            record.summary ?? '',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          if (record.keyPoints != null && record.keyPoints!.isNotEmpty) ...[
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              'KEY POINTS:',
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: AppDimens.spacingSm),
            ...record.keyPoints!.map((kp) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.tertiary, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(kp, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant))),
                ],
              ),
            )),
          ],
          if (record.keywords != null && record.keywords!.isNotEmpty) ...[
            const SizedBox(height: AppDimens.spacingMd),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: record.keywords!.map((kw) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  kw.toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.tertiary, fontWeight: FontWeight.bold),
                ),
              )).toList(),
            ),
          ]
        ],
      ),
    );
  }
}
