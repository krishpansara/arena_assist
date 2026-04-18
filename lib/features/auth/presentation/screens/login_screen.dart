import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../widgets/auth_app_bar.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    try {
      await ref.read(authControllerProvider.notifier).signIn(
            email: email,
            password: password,
          );
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

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
              controller: _emailController,
              label: 'EMAIL ADDRESS',
              hint: 'name@arena.live',
              prefixIcon: Icons.alternate_email,
            ),
            const SizedBox(height: AppDimens.spacingLg),
            ArenaTextField(
              controller: _passwordController,
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
            authState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GradientButton(
                    text: 'Login',
                    onPressed: _handleLogin,
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
