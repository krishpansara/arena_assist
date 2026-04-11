import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class UpcomingHighlightCard extends StatelessWidget {
  const UpcomingHighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Upcoming\nHighlights',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'VIEW FULL\nSEASON',
                  textAlign: TextAlign.right,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.surfaceContainerHighest,
                      AppColors.secondary.withValues(alpha: 0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      bottom: AppDimens.spacingMd,
                      right: AppDimens.spacingMd,
                      child: Icon(Icons.sports_basketball, size: 80, color: Colors.white12),
                    ),
                    Positioned(
                      top: AppDimens.spacingMd,
                      left: AppDimens.spacingMd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingSm, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                        ),
                        child: Text(
                          'JULY 24',
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppDimens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Urban Hoops Final',
                      style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimens.spacingXs),
                    Text(
                      'Championship Series Game 7',
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
