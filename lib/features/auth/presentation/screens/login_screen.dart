import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../widgets/auth_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimens.spacingXl),
            Text(
              'Welcome Back',
              style: AppTextStyles.displaySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              'Access your events and smart\nfeatures',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            ArenaTextField(
              label: 'EMAIL ADDRESS',
              hint: 'name@arena.live',
              prefixIcon: Icons.alternate_email,
            ),
            const SizedBox(height: AppDimens.spacingLg),
            ArenaTextField(
              label: 'PASSWORD',
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
            GradientButton(
              text: 'Login',
              onPressed: () {
                // Mocking auth success
                context.go('/home');
              },
            ),
            const SizedBox(height: AppDimens.spacingXxl),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spacingMd,
                  ),
                  child: Text(
                    'OR CONTINUE WITH',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacingXl),
            GhostButton(
              text: 'Continue with Google',
              onPressed: () {},
              icon: const Text(
                'G',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ), // Placeholder for Google Icon
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/register');
                  },
                  child: Text(
                    'Sign Up',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
