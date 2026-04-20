import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/safety/presentation/widgets/sos_button.dart';

class WorkshopActionGrid extends StatelessWidget {
  final EventModel event;
  const WorkshopActionGrid({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        children: [
          if (!event.isCompleted) ...[
            SOSButton(eventId: event.id, eventTitle: event.title),
            const SizedBox(height: AppDimens.spacingXl),
          ],
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.groups,
                  title: 'CROWD DENSITY',
                  iconColor: AppColors.primary,
                  onTap: () => context.push('/crowd_flow'),
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.groups,
                  title: 'SPEAKER BIOS',
                  iconColor: AppColors.primary,
                  onTap: () => context.push('/workshop_speaker_bios', extra: event.speakers ?? []),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.folder,
                  title: 'RESOURCES',
                  iconColor: AppColors.tertiaryFixed,
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.mic,
                  title: 'TRANSCRIPTS',
                  iconColor: AppColors.error,
                  onTap: () => context.push('/transcripts_list', extra: event),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.location_on_outlined,
                  title: 'VENUE LOCATION',
                  iconColor: AppColors.secondary,
                  onTap: () => context.push('/venue_location', extra: event),
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.account_balance_wallet,
                  title: 'BUDGET TRACKER',
                  iconColor: AppColors.primary,
                  onTap: () => context.push('/budget', extra: event),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.restaurant,
                  title: 'ORDER FOOD',
                  iconColor: AppColors.tertiaryFixed,
                  onTap: () => context.push('/food_order', extra: event),
                ),
              ),
              const SizedBox(width: AppDimens.spacingLg),

              Expanded(
                child: _buildActionBtn(
                  icon: Icons.local_taxi,
                  title: 'PLAN RIDE',
                  iconColor: AppColors.tertiary,
                  onTap: () => context.push('/ride-estimator', extra: event.location),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String title,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(AppDimens.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingSm),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: AppDimens.spacingSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
