import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sports_score, color: AppColors.primary, size: 20),
          const SizedBox(width: AppDimens.spacingSm),
          Text(
            'STADIUM LIVE',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
