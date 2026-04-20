import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../widgets/auth_app_bar.dart';

class VerifyAccessScreen extends StatelessWidget {
  const VerifyAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(
        showBackButton: true,
        showSkipButton: false,
      ),
      body: SafeArea(
        top: false, // AppBar handles the top UI
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.spacingXxl),
              // App Logo Header (Modified to be bordered based on design)
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.secondary.withValues(alpha: 0.5), width: 2),
                    boxShadow: [
                      BoxShadow(color: AppColors.secondary.withValues(alpha: 0.2), blurRadius: 20)
                    ]
                  ),
                  child: const Center(
                    child: Icon(Icons.sports_score, color: AppColors.onSurface, size: 32),
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.spacingXxl),
              Text(
                'ARENA ASSISTANT',
                textAlign: TextAlign.center,
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = AppColors.secondaryGradient.createShader(
                      const Rect.fromLTWH(0, 0, 300, 50),
                    ),
                ),
              ),
              const SizedBox(height: AppDimens.spacingSm),
              Text(
                'SYNCHRONIZING IDENTITY',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: AppDimens.spacing4xl),

              // The Glass Pod containing the verification logic
              Container(
                padding: const EdgeInsets.all(AppDimens.spacingXxl),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verify Access',
                      style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: AppDimens.spacingMd),
                    Text(
                      'Please enter the 6-digit access token\nsent to your stadium-linked device.',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
                    ),
                    const SizedBox(height: AppDimens.spacing3xl),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        bool isActive = index == 2; // Mocking the active state
                        String digit = index == 0 ? '8' : index == 1 ? '2' : '';
                        
                        return Container(
                          width: 48,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            border: Border.all(
                              color: isActive ? AppColors.primary : AppColors.outlineVariant.withValues(alpha: 0.1),
                              width: 2,
                            ),
                            boxShadow: isActive ? AppShadows.primaryGlowSmall : null,
                          ),
                          child: isActive
                            ? Container(width: 2, height: 24, color: AppColors.primary) // Cursor mock
                            : Text(
                                digit,
                                style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface),
                              ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppDimens.spacing4xl),

                    GradientButton(
                      text: 'AUTHORIZE DEVICE',
                      onPressed: () {
                         context.go('/login');
                      },
                    ),
                    const SizedBox(height: AppDimens.spacingXl),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Resend Code', style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
                        Text('00:45', style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimens.spacing4xl),
              
              // Bottom secure badge
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                    border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.tertiaryFixed,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppDimens.spacingMd),
                      Text(
                        'ENCRYPTED BIOMETRIC LINK ACTIVE',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onSurfaceVariant,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.spacingLg),
              // Trust Avatars Mock
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 24,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: CircleAvatar(radius: 12, backgroundColor: AppColors.surfaceContainerHigh, child: Icon(Icons.person, size: 16)),
                        ),
                        Positioned(
                          left: 16,
                          child: CircleAvatar(radius: 12, backgroundColor: AppColors.surfaceContainerHighest, child: Icon(Icons.person, size: 16)),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'TRUSTED BY 14.2K ACTIVE FANS',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
