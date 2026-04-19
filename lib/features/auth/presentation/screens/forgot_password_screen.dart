import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email address')),
      );
      return;
    }

    try {
      await ref.read(authControllerProvider.notifier).forgotPassword(email);
      if (mounted) {
        // Navigate to verify access as a mock flow (per original design)
        context.push('/verify');
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: 200,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimens.spacingLg),
            // Header Logo
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.secondaryGradient,
                    borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  ),
                  child: const Center(
                    child: Icon(Icons.sports_score, color: AppColors.onPrimary),
                  ),
                ),
                const SizedBox(width: AppDimens.spacingMd),
                Text(
                  'STADIUM LIVE',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            
            // Content Container
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingXxl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password?',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingMd),
                  Text(
                    'Enter the email associated with your\naccount and we\'ll send a kinetic reset link\nto your inbox.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacing3xl),
                  ArenaTextField(
                    controller: _emailController,
                    label: 'EMAIL ADDRESS',
                    hint: 'name@stadium.live',
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: AppDimens.spacing3xl),
                  authState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GradientButton(
                          text: 'SEND RESET LINK',
                          onPressed: _handleResetPassword,
                        ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the email? ",
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
                GestureDetector(
                  onTap: _handleResetPassword,
                  child: Text(
                    'Resend code',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
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
