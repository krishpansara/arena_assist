import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class SettingsSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;

  const SettingsSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      child: Row(
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: AppDimens.spacingSm),
          Text(
            title.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: iconColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
