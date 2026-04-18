import 'package:flutter/material.dart';
import '../theme/theme.dart';

enum AppBadgeVariant { primary, secondary, tertiary, alert, outline }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeVariant variant;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.text,
    this.variant = AppBadgeVariant.primary,
    this.icon,
  });

  Color _getBackgroundColor() {
    switch (variant) {
      case AppBadgeVariant.primary:
        return AppColors.primary.withOpacity(0.15);
      case AppBadgeVariant.secondary:
        return AppColors.secondary.withOpacity(0.15);
      case AppBadgeVariant.tertiary:
        return AppColors.tertiary.withOpacity(0.15);
      case AppBadgeVariant.alert:
        return AppColors.error.withOpacity(0.15);
      case AppBadgeVariant.outline:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    switch (variant) {
      case AppBadgeVariant.primary:
        return AppColors.primary;
      case AppBadgeVariant.secondary:
        return AppColors.secondary;
      case AppBadgeVariant.tertiary:
        return AppColors.tertiary;
      case AppBadgeVariant.alert:
        return AppColors.error;
      case AppBadgeVariant.outline:
        return AppColors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        border: variant == AppBadgeVariant.outline
            ? Border.all(color: AppColors.outlineVariant)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: _getTextColor()),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: _getTextColor(),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
