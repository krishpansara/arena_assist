import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class HeavyFlowAlert extends StatelessWidget {
  final bool isStadiumMode;
  const HeavyFlowAlert({super.key, this.isStadiumMode = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.errorDim.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.errorDim.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 24),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isStadiumMode ? 'Heavy Flow Alert' : 'Session Requirement',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimens.spacingXs),
                Text(
                  isStadiumMode 
                      ? 'Gate 2 is experiencing heavy flow. Please consider using Gate 4 for faster exit.'
                      : 'Please ensure you have Flutter 3.19+ installed before the workshop starts.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
