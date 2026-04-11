import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class StadiumHero extends StatelessWidget {
  const StadiumHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceContainerHigh,
            AppColors.primary.withValues(alpha: 0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppDimens.spacingXs),
              Text(
                'LIVE NOW',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.tertiaryFixed,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Text(
            'Summer Beats\nFestival',
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Text(
            'Main Stage • DJ KINETIC • 21:40 -\n23:00',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingXl),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              boxShadow: AppShadows.primaryGlowSmall,
            ),
            child: Text(
              'JOIN THE VIBE',
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
