import 'package:flutter/material.dart';

import '../theme/theme.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool showArrow;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.showArrow = true,
    this.isLoading = false,
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
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: AppDimens.buttonHeightLg,
          decoration: BoxDecoration(
            gradient: widget.onPressed == null || widget.isLoading
                ? LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.5),
                      AppColors.primaryDim.withValues(alpha: 0.5),
                    ],
                  )
                : AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
            boxShadow: _isHovered || _isPressed
                ? AppShadows.primaryHoverGlow
                : AppShadows.primaryGlowSmall,
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.onSurface,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
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
                      if (widget.showArrow) ...[
                        const SizedBox(width: AppDimens.spacingSm),
                        const Icon(Icons.arrow_forward,
                            color: AppColors.onSurface, size: 20),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
