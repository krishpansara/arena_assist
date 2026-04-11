import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class AssistantPulse extends StatelessWidget {
  const AssistantPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Text(
            'Assistant Pulse',
            style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        _buildPulseCard(
          icon: Icons.chat_bubble,
          title: 'Session B starts in 10m - Concourse A',
          subtitle: 'Check the map for fastest route',
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: AppDimens.spacingMd),
        _buildPulseCard(
          icon: Icons.download,
          title: 'Workshop Assets Ready',
          subtitle: 'Download .zip (42MB)',
          iconColor: AppColors.tertiaryFixed,
        ),
        const SizedBox(height: AppDimens.spacingMd),
        _buildDensityPulse(),
      ],
    );
  }

  Widget _buildPulseCard({
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
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDensityPulse() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.tertiaryFixed.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CONCOURSE DENSITY',
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  letterSpacing: 1.0,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                'Low Congestion',
                style: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.tertiaryFixed,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.tertiaryFixed,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 5,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
