import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/arena_text_field.dart';
import '../../../../core/widgets/ghost_button.dart';
import '../../../../core/widgets/gradient_button.dart';

class AddTicketScreen extends StatelessWidget {
  const AddTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Icon(Icons.sports_score, color: AppColors.primary, size: 20),
            const SizedBox(width: AppDimens.spacingSm),
            Text(
              'STADIUM LIVE',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHigh,
            child: Icon(Icons.person, size: 20, color: AppColors.onSurface),
          ),
          const SizedBox(width: AppDimens.spacingXl),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
        child: Column(
          children: [
            const SizedBox(height: AppDimens.spacing4xl),
            // Success Checkmark Icon Custom Wrapper
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.tertiaryFixed.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.tertiaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.onTertiary,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            Text(
              'Add Your Ticket',
              style: AppTextStyles.displaySmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacingLg),
            Text(
              'Link your ticket once to unlock real-time\nnavigation and updates',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppDimens.spacing4xl),

            // Ticket Input Form
            ArenaTextField(
              label: 'TICKET ID',
              hint: 'STADIUM-XXXX-XXXX',
              prefixIcon: Icons.confirmation_number_outlined,
            ),
            const SizedBox(height: AppDimens.spacing3xl),

            GradientButton(text: 'LINK TICKET', onPressed: () {}),

            const SizedBox(height: AppDimens.spacing3xl),
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
                    'OR',
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
            const SizedBox(height: AppDimens.spacing3xl),

            GhostButton(
              text: 'SCAN QR CODE',
              onPressed: () {},
              icon: const Icon(
                Icons.qr_code_scanner,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
