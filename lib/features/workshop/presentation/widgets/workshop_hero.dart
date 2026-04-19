import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class WorkshopHero extends StatelessWidget {
  final EventModel event;
  const WorkshopHero({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final firstSpeaker = event.speakers?.firstOrNull?.name ?? 'Assigned Speaker';
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: AppDimens.spacingXs),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: event.isLive ? AppColors.tertiaryFixed : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppDimens.spacingSm),
                Text(
                  event.isLive ? 'LIVE NOW' : (event.isCompleted ? 'COMPLETED' : 'UPCOMING'),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            event.title.replaceFirst(' ', '\n'),
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            children: [
              const Icon(Icons.access_time_filled, color: AppColors.primary, size: 16),
              const SizedBox(width: AppDimens.spacingMd),
              Text(
                '${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')} — ${event.startTime.add(const Duration(hours: 1, minutes: 30)).hour}:${event.startTime.add(const Duration(hours: 1, minutes: 30)).minute.toString().padLeft(2, '0')}', 
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Row(
            children: [
              const Icon(Icons.person, color: AppColors.primary, size: 16),
              const SizedBox(width: AppDimens.spacingMd),
              Text(firstSpeaker, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),

          const SizedBox(height: AppDimens.spacingXxl),
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingXl),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(Icons.qr_code_2, size: 80, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.spacingXxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'JOIN SESSION',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(width: AppDimens.spacingSm),
                    const Icon(Icons.arrow_forward, color: AppColors.primary, size: 16),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
