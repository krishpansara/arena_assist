import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showProfile;
  final IconData? contextIcon;
  final VoidCallback? onBackTap;

  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.showBackButton = true,
    this.showProfile = false,
    this.contextIcon = Icons.flag,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      titleSpacing: AppDimens.spacingXl,
      title: Row(
        children: [
          if (showBackButton) ...[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onBackTap ?? () => context.pop(),
              child: const Padding(
                padding: EdgeInsets.only(right: AppDimens.spacingMd),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ],
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppDimens.spacingSm),
          ],
          if (contextIcon != null && leading == null) ...[
            Icon(contextIcon, color: AppColors.primary, size: 20),
            const SizedBox(width: AppDimens.spacingSm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'header_title_$title',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      title.toUpperCase(),
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
        if (showProfile) ...[
          const SizedBox(width: AppDimens.spacingMd),
          const CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=krish'),
          ),
        ],
        const SizedBox(width: AppDimens.spacingXl),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
