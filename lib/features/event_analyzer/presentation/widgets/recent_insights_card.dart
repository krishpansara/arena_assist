import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class RecentInsightsCard extends StatelessWidget {
  const RecentInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: AppColors.ghostBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spacingMd, vertical: AppDimens.spacingXs),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: Text(
                  'RECENT INSIGHTS',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.tertiaryFixed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'Global Tech Summit',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'San Francisco • Nov 24, 2024',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          _buildBarChart(),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PULSE RATE',
                style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant),
              ),
              Text(
                '94.2% ACTIVE',
                style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBar(height: 30, color: AppColors.outline),
          const SizedBox(width: AppDimens.spacingSm),
          _buildBar(height: 50, color: AppColors.outline),
          const SizedBox(width: AppDimens.spacingSm),
          _buildBar(height: 80, color: AppColors.primary, isHighlighted: true),
          const SizedBox(width: AppDimens.spacingSm),
          _buildBar(height: 45, color: AppColors.outline),
          const SizedBox(width: AppDimens.spacingSm),
          _buildBar(height: 20, color: AppColors.outline),
        ],
      ),
    );
  }

  Widget _buildBar({required double height, required Color color, bool isHighlighted = false}) {
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimens.radiusSm), bottom: Radius.circular(AppDimens.radiusSm)),
          boxShadow: isHighlighted ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 10, spreadRadius: 2)] : null,
        ),
      ),
    );
  }
}
