import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Simulate loading configuration, establishing connections, etc.
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            const AppLogo(size: 100, showText: true),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              'EXPERIENCE EVENTS\nSMARTER',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 4,
                height: 1.6,
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            Container(
              width: 100,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacingXl),
            Text(
              'INITIALIZING CORE SYSTEMS',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.primary,
                letterSpacing: 2,
              ),
            ),
            const Spacer(flex: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                    indent: AppDimens.spacing4xl,
                    endIndent: AppDimens.spacingMd,
                  ),
                ),
                Text(
                  'POWERED BY STADIUM LIVE',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.5,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.outlineVariant.withValues(alpha: 0.5),
                    indent: AppDimens.spacingMd,
                    endIndent: AppDimens.spacing4xl,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacingXxl),
          ],
        ),
      ),
    );
  }
}
