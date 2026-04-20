import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showSkipButton;

  const AuthAppBar({
    super.key,
    this.showBackButton = false,
    this.showSkipButton = true,
  });

  @override
  Widget build(BuildContext context) {
    void onSkip() {
      context.go('/home');
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              color: AppColors.onSurfaceVariant,
              onPressed: () => context.pop(),
            )
          : null,
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
      actions: [
        if (showSkipButton) ...[
          TextButton(
            onPressed: onSkip,
            child: Text(
              'SKIP',
              style: AppTextStyles.labelMedium.copyWith(
                letterSpacing: 1.2,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.spacingMd),
        ] else
          const SizedBox(width: 48), // Balance for centered title if back button is present
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
