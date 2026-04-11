import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class ReportIssueForm extends StatelessWidget {
  const ReportIssueForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report an Issue',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'Experiencing technical glitches? Let our tech team know immediately.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXl),

          // Issue Category Label
          Text(
            'ISSUE CATEGORY',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          
          // Dropdown mock
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.black, // Dark dropdown
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Technical Glitch',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface),
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.onSurfaceVariant, size: 20),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spacingLg),

          // Detailed Description Label
          Text(
            'DETAILED DESCRIPTION',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          
          // Text Area
          TextFormField(
            maxLines: 4,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Please describe exactly what happened...',
              fillColor: Colors.black,
              filled: true,
            ),
          ),
          const SizedBox(height: AppDimens.spacingLg),

          // Attach Screenshot button
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_outlined, color: AppColors.onSurfaceVariant, size: 18),
                const SizedBox(width: AppDimens.spacingSm),
                Text(
                  'Attach Screenshot (Optional)',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spacingXl),

          // Submit Report button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.onSurface,
                foregroundColor: AppColors.surface,
                padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
              child: Text(
                'Submit Report',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.surface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
