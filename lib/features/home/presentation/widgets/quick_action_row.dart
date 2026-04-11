import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class QuickActionRow extends StatelessWidget {
  final bool isStadiumMode;
  const QuickActionRow({super.key, this.isStadiumMode = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimens.spacingMd),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: isStadiumMode ? [
            _buildActionCard(
              title: 'Live\nMap',
              icon: Icons.map_outlined,
              isPrimary: true,
            ),
            const SizedBox(width: AppDimens.spacingMd),
            _buildActionCard(
              title: 'Find\nFood',
              icon: Icons.fastfood_outlined,
              isPrimary: false,
            ),
            const SizedBox(width: AppDimens.spacingMd),
            _buildActionCard(
              title: 'Entry\nGate',
              icon: Icons.door_front_door_outlined,
              isPrimary: false,
            ),
          ] : [
            _buildActionCard(
              title: 'Live\nMap',
              icon: Icons.map_outlined,
              isPrimary: true,
            ),
            const SizedBox(width: AppDimens.spacingMd),
            _buildActionCard(
              title: 'Agenda\n& Info',
              icon: Icons.event_note_outlined,
              isPrimary: false,
            ),
            const SizedBox(width: AppDimens.spacingMd),
            _buildActionCard(
              title: 'Ask\nQ&A',
              icon: Icons.question_answer_outlined,
              isPrimary: false,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildActionCard({required String title, required IconData icon, required bool isPrimary}) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(AppDimens.spacingMd),
        decoration: BoxDecoration(
          gradient: isPrimary ? AppColors.secondaryGradient : null,
          color: isPrimary ? null : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          boxShadow: isPrimary ? AppShadows.secondaryGlowSmall : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingSm),
              decoration: BoxDecoration(
                color: isPrimary ? AppColors.surfaceContainerLowest.withValues(alpha: 0.2) : AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
              child: Icon(icon, color: AppColors.onSurface, size: 20),
            ),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
