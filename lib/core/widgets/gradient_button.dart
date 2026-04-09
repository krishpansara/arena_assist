import 'package:flutter/material.dart';

import '../theme/theme.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: AppDimens.buttonHeightLg,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
            boxShadow: _isHovered || _isPressed
                ? AppShadows.primaryHoverGlow
                : AppShadows.primaryGlowSmall,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  widget.icon!,
                  const SizedBox(width: AppDimens.spacingSm),
                ],
                Text(
                  widget.text,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(width: AppDimens.spacingSm),
                const Icon(Icons.arrow_forward, color: AppColors.onSurface, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
