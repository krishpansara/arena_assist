import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

class WorkshopActionGrid extends StatelessWidget {
  const WorkshopActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.groups,
                  title: 'CROWD DENSITY',
                  iconColor: AppColors.primary,
                  onTap: () => context.push('/crowd_flow'),
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.groups,
                  title: 'SPEAKER BIOS',
                  iconColor: AppColors.primary,
                  onTap: () => context.push('/workshop_speaker_bios'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.folder,
                  title: 'RESOURCES',
                  iconColor: AppColors.tertiaryFixed,
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.map,
                  title: 'CAMPUS MAP',
                  iconColor: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(AppDimens.spacingLg),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingMd),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
