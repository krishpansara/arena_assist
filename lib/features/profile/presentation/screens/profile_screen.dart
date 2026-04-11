import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const ProfileHeader(
              name: 'Alex Sterling',
              email: 'alex.sterling@vibe-elite.com',
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
            const SizedBox(height: AppDimens.spacing4xl),
            ProfileOptionTile(
              icon: Icons.logout_outlined,
              title: 'Logout',
              isDestructive: true,
              onTap: () {
                context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
