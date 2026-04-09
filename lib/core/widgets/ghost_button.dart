import 'package:flutter/material.dart';

import '../theme/theme.dart';

class GhostButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;

  const GhostButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: AppDimens.buttonHeightLg,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.20),
            width: AppDimens.ghostBorderWidth,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: AppDimens.spacingSm),
            ],
            Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
