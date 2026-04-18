import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class AnalyzingStatusCard extends StatefulWidget {
  const AnalyzingStatusCard({super.key});

  @override
  State<AnalyzingStatusCard> createState() => _AnalyzingStatusCardState();
}

class _AnalyzingStatusCardState extends State<AnalyzingStatusCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.ghostBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingSm),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerLowest,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 1.5),
            ),
            child: const Icon(
              Icons.bolt,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimens.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Analyzing event...',
                  style: AppTextStyles.titleMedium,
                ),
                Text(
                  'Gathering crowd density and social sentiment',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
