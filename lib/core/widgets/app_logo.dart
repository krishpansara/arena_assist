import 'package:flutter/material.dart';

import '../theme/theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  
  const AppLogo({
    super.key,
    this.size = 64,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 10),
                  )
                ]
              ),
              child: Center(
                child: Icon(
                  Icons.sports_score, // Checkered flag stand-in
                  color: AppColors.primary,
                  size: size * 0.5,
                ),
              ),
            ),
            // The tiny green indicator dot
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.tertiaryGlow,
                ),
              ),
            ),
          ],
        ),
        if (showText) ...[
          const SizedBox(height: AppDimens.spacingXxl),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.displaySmall,
              children: [
                const TextSpan(text: 'ARENA '),
                TextSpan(
                  text: 'ASSISTANT',
                  style: AppTextStyles.displaySmall.copyWith(
                    foreground: Paint()
                      ..shader = AppColors.secondaryGradient.createShader(
                        const Rect.fromLTWH(0, 0, 200, 50),
                      ),
                  ),
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
