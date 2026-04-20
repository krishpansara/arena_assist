import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/theme/theme.dart';
import '../../../home/domain/models/event_model.dart';
import '../providers/transcript_list_provider.dart';

class TranscriptListScreen extends ConsumerWidget {
  final EventModel event;

  const TranscriptListScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transcriptsAsync = ref.watch(userEventTranscriptsProvider(event.id));

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('My Transcripts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: transcriptsAsync.when(
        data: (transcripts) {
          if (transcripts.isEmpty) {
            return _buildEmptyState(context);
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            itemCount: transcripts.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppDimens.spacingMd),
            itemBuilder: (context, index) {
              final record = transcripts[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  border: Border.all(
                    color: AppColors.outlineVariant.withValues(alpha: 0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.mic, color: AppColors.primary, size: 20),
                          Text(
                            timeago.format(record.updatedAt),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.spacingSm),
                      Text(
                        record.text.isNotEmpty ? record.text : 'No audio recorded',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurface,
                        ),
                      ),
                      if (record.summary != null && record.summary!.isNotEmpty) ...[
                        const SizedBox(height: AppDimens.spacingMd),
                        Container(
                          padding: const EdgeInsets.all(AppDimens.spacingSm),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.auto_awesome, color: AppColors.primary, size: 16),
                              const SizedBox(width: AppDimens.spacingSm),
                              Expanded(
                                child: Text(
                                  record.summary!,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading transcripts:\n$error',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/live_transcript', extra: event),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add),
        label: const Text('Add New'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic_none, size: 64, color: AppColors.onSurfaceVariant),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'No Transcripts Yet',
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Text(
            'Record notes or transribe the event live.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
