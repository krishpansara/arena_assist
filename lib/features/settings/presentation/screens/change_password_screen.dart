import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: 120,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Row(
            children: [
              const SizedBox(width: AppDimens.spacingLg),
              const Icon(Icons.arrow_back, color: AppColors.onSurfaceVariant, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'BACK',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          'PASSWORD',
          style: AppTextStyles.labelLarge.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingXl,
          vertical: AppDimens.spacingLg,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppDimens.spacingXl),
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingXxl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArenaTextField(
                    label: 'CURRENT PASSWORD',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    labelTrailing: GestureDetector(
                      onTap: () {
                        context.push('/forgot-password');
                      },
                      child: Text(
                        'FORGOT PASSWORD?',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacing4xl),
                  ArenaTextField(
                    label: 'NEW PASSWORD',
                    hint: '••••••••',
                    prefixIcon: Icons.vpn_key_outlined,
                    isPassword: true,
                  ),
                  const SizedBox(height: AppDimens.spacingMd),
                  // Password strength indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PASSWORD STRENGTH',
                        style: AppTextStyles.labelSmall.copyWith(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingSm),
                  Row(
                    children: [
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(width: 4),
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(width: 4),
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(width: 4),
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.surfaceContainerLowest, borderRadius: BorderRadius.circular(2)))),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingLg),
                  ArenaTextField(
                    label: 'CONFIRM NEW PASSWORD',
                    hint: '••••••••',
                    prefixIcon: Icons.verified_user_outlined,
                    isPassword: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            GradientButton(
              text: 'UPDATE PASSWORD',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
