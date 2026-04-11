import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class FoodHeader extends StatelessWidget {
  const FoodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: AppColors.onSurfaceVariant, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'STADIUM LIVE',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHigh,
            child: Icon(Icons.person, size: 16, color: AppColors.onSurfaceVariant),
          )
        ],
      ),
    );
  }
}
