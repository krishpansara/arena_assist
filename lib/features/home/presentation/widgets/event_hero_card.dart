import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class EventHeroCard extends StatelessWidget {
  final EventModel event;
  const EventHeroCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = AppColors.primaryGradient.createShader(
                        const Rect.fromLTWH(0, 0, 300, 50),
                      ),
                  ),
                ),
              ),
              if (event.isLive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: AppDimens.spacingXs),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    'LIVE',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onSurface,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Text(
            '${event.location} • ${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')}',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Row(
            children: [
              _buildSeatPod(event.type == EventType.stadium ? 'SECTION' : 'ROOM', event.section),
              const SizedBox(width: AppDimens.spacingSm),
              _buildSeatPod('ROW', event.row),
              const SizedBox(width: AppDimens.spacingSm),
              _buildSeatPod('SEAT', event.seat),
            ],
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
              border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timer_outlined, color: AppColors.secondary, size: 20),
                const SizedBox(width: AppDimens.spacingSm),
                Text(
                  event.timeStatus,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSeatPod(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingSm),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(label, style: AppTextStyles.labelSmall.copyWith(fontSize: 9, color: AppColors.onSurfaceVariant, letterSpacing: 1.0)),
            const SizedBox(height: AppDimens.spacingXs),
            Text(value, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
