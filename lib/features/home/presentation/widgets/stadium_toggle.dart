import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class StadiumToggle extends StatelessWidget {
  final bool isStadiumMode;
  final ValueChanged<bool> onChanged;

  const StadiumToggle({
    super.key,
    required this.isStadiumMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleOption(
            title: 'STADIUM',
            icon: Icons.sports_soccer,
            isActive: isStadiumMode,
            onTap: () => onChanged(true),
          ),
          _buildToggleOption(
            title: 'WORKSHOP',
            icon: Icons.architecture,
            isActive: !isStadiumMode,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingSm),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isActive ? AppColors.onPrimary : AppColors.onSurfaceVariant),
            const SizedBox(width: AppDimens.spacingXs),
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                color: isActive ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
