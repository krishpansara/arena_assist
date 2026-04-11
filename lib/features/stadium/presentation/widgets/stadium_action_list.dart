import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class StadiumActionList extends StatelessWidget {
  const StadiumActionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildActionCard(
          icon: Icons.fastfood,
          title: 'Order Food',
          subtitle: 'Skip the queue, pick up at Section 12',
          iconColor: AppColors.secondary,
        ),
        const SizedBox(height: AppDimens.spacingLg),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            subtitle,
            style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
