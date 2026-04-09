import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class SmartSuggestionsList extends StatelessWidget {
  const SmartSuggestionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.auto_awesome, color: AppColors.secondary, size: 20),
            const SizedBox(width: AppDimens.spacingSm),
            Text(
              'Smart Suggestions',
              style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spacingMd),
        _buildSuggestionCard(
          icon: Icons.speed,
          iconColor: AppColors.tertiaryFixed,
          text: 'Use Gate G for 8m faster entry',
        ),
        const SizedBox(height: AppDimens.spacingSm),
        _buildSuggestionCard(
          icon: Icons.local_cafe,
          iconColor: AppColors.primary,
          text: 'Concourse B has lowest wait times',
        ),
      ],
    );
  }

  Widget _buildSuggestionCard({required IconData icon, required Color iconColor, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: AppDimens.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border(
          left: BorderSide(color: iconColor, width: 3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingSm),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
