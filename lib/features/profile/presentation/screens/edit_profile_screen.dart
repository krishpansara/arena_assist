import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userDataProvider).valueOrNull;
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phoneNumber ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }

    try {
      await ref.read(authControllerProvider.notifier).updateProfile(
            name: name,
            phoneNumber: phone.isEmpty ? null : phone,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
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
              padding: const EdgeInsets.all(AppDimens.spacingXl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              ),
              child: Column(
                children: [
                  // Profile Information
                  const SizedBox(height: AppDimens.spacingLg),
                  ArenaTextField(
                    label: 'Full Name',
                    hint: 'Your legal name',
                    prefixIcon: Icons.person_outline,
                    controller: _nameController,
                  ),
                  const SizedBox(height: AppDimens.spacingXl),
                  ArenaTextField(
                    label: 'Email Address',
                    hint: 'alex.sterling@elite.com',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    enabled: false,
                  ),
                  const SizedBox(height: AppDimens.spacingXl),
                  ArenaTextField(
                    label: 'Phone Number',
                    hint: '+1 (555) 000-0000',
                    prefixIcon: Icons.phone_outlined,
                    controller: _phoneController,
                  ),
                  const SizedBox(height: AppDimens.spacing4xl),

                  // SAVE BUTTON
                  GradientButton(
                    text: 'SAVE CHANGES',
                    isLoading: authState.isLoading,
                    onPressed: authState.isLoading ? null : () => _handleSave(),
                  ),
                  const SizedBox(height: AppDimens.spacing3xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
