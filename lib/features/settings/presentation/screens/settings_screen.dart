import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_list_tile.dart';
import '../widgets/settings_section_header.dart';
import '../widgets/settings_toggle_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userDataProvider);

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
          'SETTINGS',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimens.spacingLg),
            Text(
              'Settings',
              style: AppTextStyles.displaySmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurface,
              ),
            ),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              'Fine-tune your elite stadium experience.',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // ACCOUNT SETTINGS
            const SettingsSectionHeader(
              icon: Icons.person_outline,
              title: 'ACCOUNT SETTINGS',
              iconColor: AppColors.primary,
            ),
            SettingsCard(
              children: [
                userAsync.when(
                  data: (user) => SettingsListTile(
                    icon: Icons.person_add_alt_1_outlined,
                    title: 'Edit Profile',
                    subtitle: user!.name,
                    onTap: () => context.push('/edit-profile'),
                  ),
                  loading: () => const Center(child: Padding(
                    padding: EdgeInsets.all(AppDimens.spacingLg),
                    child: CircularProgressIndicator(),
                  )),
                  error: (e, _) => SettingsListTile(
                    icon: Icons.error_outline,
                    title: 'Profile',
                    subtitle: 'Error loading profile',
                    onTap: () {},
                  ),
                ),
                Divider(color: AppColors.outlineVariant.withValues(alpha: 0.3), height: 1),
                SettingsListTile(
                  icon: Icons.lock_outline,
                  title: 'Password',
                  subtitle: 'Last changed 3 months ago',
                  onTap: () {
                    context.push('/change-password');
                  },
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            // NOTIFICATIONS
            const SettingsSectionHeader(
              icon: Icons.notifications_outlined,
              title: 'NOTIFICATIONS',
              iconColor: AppColors.secondary,
            ),
            SettingsCard(
              children: [
                const SettingsToggleTile(
                  icon: Icons.notifications_active_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Direct messages and general alerts',
                  initialValue: true,
                ),
                Divider(color: AppColors.outlineVariant.withValues(alpha: 0.3), height: 1),
                const SettingsToggleTile(
                  icon: Icons.people_outline,
                  title: 'Crowd Alerts',
                  subtitle: 'Real-time heatmaps and density reports',
                  initialValue: true,
                ),
                Divider(color: AppColors.outlineVariant.withValues(alpha: 0.3), height: 1),
                const SettingsToggleTile(
                  icon: Icons.event_note_outlined,
                  title: 'Session Reminders',
                  subtitle: 'Remind me 15m before event starts',
                  initialValue: false,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            // PRIVACY
            const SettingsSectionHeader(
              icon: Icons.shield_outlined,
              title: 'PRIVACY',
              iconColor: AppColors.tertiaryFixed,
            ),
            SettingsCard(
              children: [
                SettingsListTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location Access',
                  subtitle: 'Required for in-stadium\nnavigation',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'While Using\nApp',
                        textAlign: TextAlign.right,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.tertiaryFixed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppDimens.spacingSm),
                      const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant, size: 20),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Location permissions coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            // APP PREFERENCES
            const SettingsSectionHeader(
              icon: Icons.tune_outlined,
              title: 'APP PREFERENCES',
              iconColor: AppColors.primaryDim,
            ),
            SettingsCard(
              children: [
                SettingsListTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Theme',
                  subtitle: 'Kinetic Midnight (Dark)',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Theme selection coming soon')),
                    );
                  },
                ),
                Divider(color: AppColors.outlineVariant.withValues(alpha: 0.3), height: 1),
                SettingsListTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English (US)',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Language selection coming soon')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacing4xl),
               
            // DELETE ACCOUNT BUTTON
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.surfaceContainerHigh,
                      title: const Text('Delete Account', style: TextStyle(color: AppColors.error)),
                      content: const Text('Are you sure you want to permanently delete your account?', style: TextStyle(color: AppColors.onSurfaceVariant)),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text('Cancel', style: TextStyle(color: AppColors.onSurface)),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            context.go('/register');
                          },
                          child: const Text('Delete', style: TextStyle(color: AppColors.error)),
                        ),
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg),
                  backgroundColor: AppColors.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  ),
                ),
                icon: const Icon(Icons.cancel, color: AppColors.errorDim),
                label: Text(
                  'Delete Account',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.errorDim,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            // VERSION INFO
            Center(
              child: Text(
                'V2.4.0-STABLE BUILD #8812',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
          ],
        ),
      ),
    );
  }
}
