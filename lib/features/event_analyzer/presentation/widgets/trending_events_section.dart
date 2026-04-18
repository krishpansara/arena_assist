import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class TrendingEventsSection extends StatelessWidget {
  const TrendingEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = [
      'DevFest Ahmedabad',
      'HackMIT 2026',
      'Tech Conference 2025',
      'Voltage Arena Live',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Trending Events', style: AppTextStyles.titleLarge),
            const Icon(Icons.trending_up, color: AppColors.secondary),
          ],
        ),
        const SizedBox(height: AppDimens.spacingLg),
        Wrap(
          spacing: AppDimens.spacingMd,
          runSpacing: AppDimens.spacingMd,
          children: tags.map((t) => _buildChip(t)).toList(),
        ),
      ],
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        border: Border.all(color: AppColors.ghostBorder),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
      ),
    );
  }
}
