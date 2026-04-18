import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'search_type_toggle.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isWebsite;
  final VoidCallback onToggleType;
  final VoidCallback onAnalyze;
  final bool isLoading;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.isWebsite,
    required this.onToggleType,
    required this.onAnalyze,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTypeToggle(
          isWebsite: isWebsite,
          onChanged: (_) => onToggleType(),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            style: AppTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: isWebsite 
                ? 'Paste event website URL...' 
                : 'Enter event name or topic...',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimens.spacingXl,
                vertical: AppDimens.spacingLg,
              ),
              border: InputBorder.none,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: isLoading ? null : onAnalyze,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    disabledBackgroundColor: AppColors.surfaceContainerHighest,
                  ),
                  icon: isLoading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      )
                    : const Icon(Icons.auto_awesome, size: 20),
                ),
              ),
            ),
            onSubmitted: (_) => onAnalyze(),
          ),
        ),
      ],
    );
  }
}
