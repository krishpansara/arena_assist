import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class WaitTimeCard extends StatelessWidget {
  const WaitTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURRENT WAIT',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '~8',
                style: AppTextStyles.displayMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: AppDimens.spacingXs),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'MINUTES',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'SEC 6 • EAST CONCOURSE',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Row(
              children: [
                const Icon(Icons.storefront, size: 20, color: Color(0xFF8B5CF6)), // Purple color for icon
                const SizedBox(width: AppDimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'FOOD POINT',
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                          Text(
                            'VIEW MENU',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.spacingXs),
                      Text(
                        'Gridiron Grill Express',
                        style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
