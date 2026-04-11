import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class SmartSuggestionsList extends StatelessWidget {
  final bool isStadiumMode;
  const SmartSuggestionsList({super.key, this.isStadiumMode = true});

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
          icon: isStadiumMode ? Icons.speed : Icons.person_add_alt_1_outlined,
          iconColor: AppColors.tertiaryFixed,
          text: isStadiumMode ? 'Use Gate G for 8m faster entry' : 'Network with attendees before it starts',
        ),
        const SizedBox(height: AppDimens.spacingSm),
        _buildSuggestionCard(
          icon: isStadiumMode ? Icons.local_cafe : Icons.wifi,
          iconColor: AppColors.primary,
          text: isStadiumMode ? 'Concourse B has lowest wait times' : 'Connect to TechHub_Guest WiFi',
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
