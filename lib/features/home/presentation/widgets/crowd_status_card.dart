import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class CrowdStatusCard extends StatelessWidget {
  final bool isStadiumMode;
  const CrowdStatusCard({super.key, this.isStadiumMode = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, // Match the design proportion
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
      ),
      child: Stack(
        children: [
          // Simulated Heatmap Background Gradient
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, 0.8),
                    radius: 1.5,
                    colors: [
                      AppColors.warning.withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.warning,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: AppColors.warning.withValues(alpha: 0.4), blurRadius: 10),
                            ],
                          ),
                          child: Center(
                            child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          ),
                        ),
                        const SizedBox(width: AppDimens.spacingSm),
                        Text(
                          isStadiumMode ? 'Crowd Status' : 'Room Capacity',
                          style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      isStadiumMode ? 'Moderate Density' : 'Filling up fast',
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.warning, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.spacingSm),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
                        children: isStadiumMode ? [
                          const TextSpan(text: 'Moderate crowd near '),
                          TextSpan(text: 'Gate G', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ] : [
                          const TextSpan(text: 'Seats are filling up in '),
                          TextSpan(text: 'Room 4', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
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
