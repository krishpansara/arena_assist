import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class RefuelCard extends StatelessWidget {
  const RefuelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceContainerHighest,
            AppColors.surfaceContainerLowest,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'SEC 6 • EAST CONCOURSE',
              style: AppTextStyles.labelSmall.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Text(
            'CRAVING A \nREFUEL?',
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Text(
            "Skip the lines. We've identified the closest concessions with the shortest wait times for your section.",
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimens.spacingLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6), // Purple from design
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('REORDER LAST MEAL'),
                  SizedBox(width: 8),
                  Icon(Icons.history, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
