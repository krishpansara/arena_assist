import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../widgets/auth_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create Account',
              textAlign: TextAlign.center,
              style: AppTextStyles.displaySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            ArenaTextField(
              label: 'FULL NAME',
              hint: 'John Doe',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: AppDimens.spacingLg),
            ArenaTextField(
              label: 'EMAIL ADDRESS',
              hint: 'name@stadium.com',
              prefixIcon: Icons.alternate_email,
            ),
            const SizedBox(height: AppDimens.spacingLg),
            ArenaTextField(
              label: 'CREATE PASSWORD',
              hint: '••••••••',
              prefixIcon: Icons.lock_outline,
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
                Text(
                  'OPTIMAL',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.tertiaryFixed,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacingSm),
            Row(
              children: [
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.primaryDim, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.primaryDim, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.secondaryDim, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.surfaceContainerHigh, borderRadius: BorderRadius.circular(2)))),
              ],
            ),
            const SizedBox(height: AppDimens.spacingLg),
            ArenaTextField(
              label: 'CONFIRM PASSWORD',
              hint: '••••••••',
              prefixIcon: Icons.verified_user_outlined,
              isPassword: true,
            ),
            const SizedBox(height: AppDimens.spacingSm),
            Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.tertiaryFixed, size: 16),
                const SizedBox(width: AppDimens.spacingXs),
                Text(
                  'Passwords match successfully',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.tertiaryFixed, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            GradientButton(
              text: 'Create Account',
              onPressed: () {
                context.go('/home');
              },
            ),
            const SizedBox(height: AppDimens.spacingXl),
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.outlineVariant.withValues(alpha: 0.5))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                  child: Text(
                    'OR CONTINUE WITH',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.outlineVariant.withValues(alpha: 0.5))),
              ],
            ),
            const SizedBox(height: AppDimens.spacingXl),
            GhostButton(
              text: 'Continue with Google',
              onPressed: () {},
              icon: const Text('G', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)), // Placeholder
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/login');
                  },
                  child: Text(
                    'Login',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('PRIVACY', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 2)),
                const SizedBox(width: AppDimens.spacingXxl),
                Text('TERMS', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 2)),
                const SizedBox(width: AppDimens.spacingXxl),
                Text('SUPPORT', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 2)),
              ],
            ),
            const SizedBox(height: AppDimens.spacingMd),
          ],
        ),
      ),
    );
  }
}
