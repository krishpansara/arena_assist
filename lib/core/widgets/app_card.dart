import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A universal, interactive Card component standardized across the entire app.
/// Utilizing AnimatedContainer prevents harsh color snaps and provides subtle scaling on tap.
class AppCard extends StatefulWidget {
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final bool borderEnabled;
  final Color? borderColor;

  const AppCard({
    super.key,
    this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppDimens.spacingLg),
    this.backgroundColor,
    this.borderEnabled = true,
    this.borderColor,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.surfaceContainerHigh;

    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: widget.borderEnabled
            ? Border.all(color: widget.borderColor ?? AppColors.outlineVariant.withValues(alpha: 0.1))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: widget.child,
    );

    if (widget.onTap == null) {
      return cardContent;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: cardContent,
      ),
    );
  }
}
