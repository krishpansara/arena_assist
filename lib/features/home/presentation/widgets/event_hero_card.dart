import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class EventHeroCard extends StatelessWidget {
  final bool isStadiumMode;
  const EventHeroCard({super.key, this.isStadiumMode = true});

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
                  isStadiumMode ? 'Champions League\nFinals' : 'Advanced Flutter\nWorkshop',
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = AppColors.primaryGradient.createShader(
                        const Rect.fromLTWH(0, 0, 300, 50),
                      ),
                  ),
                ),
              ),
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
            isStadiumMode ? 'Tonight, 19:30 • Metropolis Arena' : 'Today, 10:00 • Tech Hub Room 4',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Row(
            children: [
              _buildSeatPod(isStadiumMode ? 'SECTION' : 'ROOM', isStadiumMode ? '112' : '4B'),
              const SizedBox(width: AppDimens.spacingSm),
              _buildSeatPod('ROW', isStadiumMode ? 'AA' : '3'),
              const SizedBox(width: AppDimens.spacingSm),
              _buildSeatPod('SEAT', isStadiumMode ? '14' : '12'),
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
                  isStadiumMode ? 'Starts in 45 mins' : 'Starts in 15 mins',
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
