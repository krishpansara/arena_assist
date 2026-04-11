import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          'EDIT PROFILE',
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
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.secondary, AppColors.tertiaryFixed],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceContainerHigh,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceContainerLowest,
                      ),
                      child: const Icon(Icons.person, size: 60, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, color: AppColors.onSurface, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingXxl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              ),
              child: Column(
                children: [
                  ArenaTextField(
                    label: 'FULL NAME',
                    hint: 'Alex Sterling',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: AppDimens.spacingLg),
                  ArenaTextField(
                    label: 'EMAIL ADDRESS',
                    hint: 'alex.sterling@vibe-elite.com',
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: AppDimens.spacingLg),
                  ArenaTextField(
                    label: 'PHONE NUMBER',
                    hint: '+1 (555) 123-4567',
                    prefixIcon: Icons.phone_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            GradientButton(
              text: 'SAVE CHANGES',
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
