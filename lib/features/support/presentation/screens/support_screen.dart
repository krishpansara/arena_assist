import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
// import '../../../../core/widgets/arena_text_field.dart';
import '../widgets/faq_accordion_tile.dart';
import '../widgets/report_issue_form.dart';
import '../widgets/support_category_card.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
          'SMART EVENT', // Or standard title style if preferred, matching design
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
            // Header Section
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingXl),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SUPPORT CENTER',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingLg),
                  RichText(
                    text: TextSpan(
                      style: AppTextStyles.displaySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                      children: const [
                        TextSpan(text: 'How can we '),
                        TextSpan(
                          text: 'assist\n',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                        TextSpan(text: 'your experience?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingXl),
                  // Search bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 20),
                              const SizedBox(width: AppDimens.spacingMd),
                              Expanded(
                                child: Text(
                                  'Search for linking tickets, stadium map',
                                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // Categories
            const SupportCategoryCard(
              icon: Icons.person_outline,
              iconColor: AppColors.primary,
              title: 'Account',
              description: 'Manage your profile, preferences, and elite member status settings.',
            ),
            const SupportCategoryCard(
              icon: Icons.explore_outlined,
              iconColor: AppColors.secondary,
              title: 'Navigation',
              description: 'Finding your seat, locating amenities, and crowd density heatmaps.',
            ),
            const SupportCategoryCard(
              icon: Icons.event_note_outlined,
              iconColor: AppColors.tertiaryFixed,
              title: 'Event',
              description: 'Ticket linking, entry protocols, and event-specific schedules.',
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // FAQs Header
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppDimens.spacingMd),
                Text(
                  'Frequently Asked Questions',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spacingXl),

            // FAQ Items
            const FaqAccordionTile(
              title: 'How do I link my digital tickets?',
              content: 'Navigate to the Ticket Wallet in your sidebar. Select "Add Ticket" and either scan the QR code from your confirmation email or enter the unique 12-digit transaction ID.',
              isExpandedInitially: true,
            ),
            const FaqAccordionTile(
              title: 'Can I share my stadium location with friends?',
              content: 'Yes! Open the stadium map and tap "Share Location". Your friends will receive a secure link to see your real-time position during the event.',
            ),
            const FaqAccordionTile(
              title: 'How does the navigation heatmap work?',
              content: 'The heatmap displays real-time crowd density across the stadium, helping you find less congested routes to restrooms, exits, or concessions.',
            ),
            const FaqAccordionTile(
              title: 'What if my ticket isn\'t showing up?',
              content: 'Try refreshing the wallet. If it still doesn\'t appear, ensure you are logged into the correct account or contact support immediately.',
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // Support Buttons
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                  ),
                  icon: const Icon(Icons.chat_bubble, color: AppColors.surface, size: 20),
                  label: Text(
                    'Live Chat Support',
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.surface,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacingLg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: AppColors.onSurface,
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                ),
                icon: const Icon(Icons.email, color: AppColors.onSurface, size: 20),
                label: Text(
                  'Email Assistance',
                  style: AppTextStyles.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // Report Form
            const ReportIssueForm(),
            const SizedBox(height: AppDimens.spacing4xl),
          ],
        ),
      ),
    );
  }
}
