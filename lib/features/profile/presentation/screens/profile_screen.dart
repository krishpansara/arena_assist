import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFILE',
          style: AppTextStyles.labelLarge.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.spacingXl,
          vertical: AppDimens.spacingLg,
        ),
        child: Column(
          children: [
            ProfileHeader(
              name: user?.name ?? 'Guest',
              email: user?.email ?? 'No email available',
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            ProfileOptionTile(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                context.push('/edit-profile');
              },
            ),
            const SizedBox(height: AppDimens.spacingMd),
            ProfileOptionTile(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                context.push('/settings');
              },
            ),
            const SizedBox(height: AppDimens.spacingMd),
            ProfileOptionTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                context.push('/support');
              },
            ),
            if (user?.email.endsWith('@admin.com') == true || 
                user?.email.endsWith('@security.com') == true || 
                user?.email == 'krishpansara@gmail.com') // Including user for testing convenience
              ...[
                const SizedBox(height: AppDimens.spacingMd),
                ProfileOptionTile(
                  icon: Icons.security,
                  title: 'Security Command Center',
                  onTap: () {
                    context.push('/emergency-dashboard');
                  },
                ),
              ],
            const SizedBox(height: AppDimens.spacing4xl),
            ProfileOptionTile(
              icon: Icons.logout_outlined,
              title: 'Logout',
              isDestructive: true,
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
