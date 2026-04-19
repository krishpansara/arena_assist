import 'package:arena_assist/features/workshop/presentation/providers/workshop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/core/widgets/gradient_button.dart';
import 'package:arena_assist/features/home/presentation/widgets/home_header.dart';
import 'package:arena_assist/features/home/presentation/widgets/event_hero_card.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:arena_assist/features/home/presentation/providers/event_provider.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider).valueOrNull;
    final nearestEvent = ref.watch(nearestEventProvider);
    final upcomingWorkshops = ref.watch(upcomingWorkshopsProvider);

    // Combine nearestEvent (stadium/mock) and analyzed workshops
    final List<EventModel> displayEvents = [];
    if (nearestEvent != null) displayEvents.add(nearestEvent);
    
    // Add analyzed workshops that aren't already the nearestEvent
    for (final w in upcomingWorkshops) {
      if (nearestEvent?.id != w.id && displayEvents.length < 2) {
        displayEvents.add(w);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(
                userName: user?.name ?? 'Guest',
                userAvatarUrl: '', // Fallback to icon
                onTicketPressed: () => context.push('/event-analyzer'),
              ),
              const SizedBox(height: AppDimens.spacingXxl),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayEvents.isNotEmpty ? 'Upcoming Events' : 'No Upcoming Events',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (upcomingWorkshops.isNotEmpty)
                    TextButton(
                      onPressed: () => context.push('/workshops'),
                      child: Text(
                        'VIEW ALL',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppDimens.spacingLg),

              if (displayEvents.isNotEmpty)
                ...displayEvents.map((event) => Padding(
                  padding: const EdgeInsets.only(bottom: AppDimens.spacingLg),
                  child: GestureDetector(
                    onTap: () => context.push(
                      event.type == EventType.stadium ? '/stadium' : '/workshop',
                      extra: event,
                    ),
                    child: EventHeroCard(event: event),
                  ),
                ))
              else
                _buildAddEventCTA(context),

              const SizedBox(height: AppDimens.spacingXxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddEventCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 48,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'Keep the vibe going!',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'Add your next ticket to see it highlighted here.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXl),
          GradientButton(
            text: 'Add Event',
            onPressed: () => context.push('/event-analyzer'),
          ),
        ],
      ),
    );
  }
}
