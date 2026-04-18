import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class SearchTypeToggle extends StatelessWidget {
  final bool isWebsite;
  final ValueChanged<bool> onChanged;

  const SearchTypeToggle({
    super.key,
    required this.isWebsite,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
                decoration: BoxDecoration(
                  gradient: isWebsite ? AppColors.primaryGradient : null,
                  borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                ),
                child: Center(
                  child: Text(
                    'Website URL',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: isWebsite ? AppColors.onSurface : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
                decoration: BoxDecoration(
                  gradient: !isWebsite ? AppColors.primaryGradient : null,
                  borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                ),
                child: Center(
                  child: Text(
                    'Event Name',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: !isWebsite ? AppColors.onSurface : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
