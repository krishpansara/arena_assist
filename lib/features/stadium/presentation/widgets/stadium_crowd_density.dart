import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class StadiumCrowdDensity extends StatelessWidget {
  const StadiumCrowdDensity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Crowd\nDensity',
                    style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppDimens.spacingXs),
                  Text(
                    'Real-time occupancy\nand flow analysis',
                    style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: AppDimens.spacingXs),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.refresh, size: 12, color: AppColors.secondary),
                    const SizedBox(width: AppDimens.spacingXs),
                    Text(
                      'UPDATING\nLIVE',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 9,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Inner Card
                Container(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg, horizontal: AppDimens.spacingXxl),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '88%',
                        style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'CONCOURSE PEAK',
                        style: AppTextStyles.labelSmall.copyWith(fontSize: 9, color: AppColors.onSurfaceVariant, letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          Row(
            children: [
              _buildLegend(AppColors.tertiaryFixed, 'LOW'),
              const SizedBox(width: AppDimens.spacingXl),
              _buildLegend(AppColors.secondary, 'MEDIUM'),
              const SizedBox(width: AppDimens.spacingXl),
              _buildLegend(AppColors.error, 'HIGH'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppDimens.spacingSm),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurface, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
        ),
      ],
    );
  }
}
