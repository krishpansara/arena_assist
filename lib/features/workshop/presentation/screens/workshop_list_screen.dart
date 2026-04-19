import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/workshop/presentation/providers/workshop_provider.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class WorkshopListScreen extends ConsumerWidget {
  const WorkshopListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingWorkshops = ref.watch(upcomingWorkshopsProvider);
    final completedWorkshops = ref.watch(completedWorkshopsProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: Text(
            'My Workshops',
            style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelStyle: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelColor: AppColors.onSurfaceVariant,
            tabs: const [
              Tab(text: 'UPCOMING'),
              Tab(text: 'COMPLETED'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _WorkshopListView(workshops: upcomingWorkshops),
            _WorkshopListView(workshops: completedWorkshops),
          ],
        ),
      ),
    );
  }
}

class _WorkshopListView extends StatelessWidget {
  final List<EventModel> workshops;
  const _WorkshopListView({required this.workshops});

  @override
  Widget build(BuildContext context) {
    if (workshops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_note_outlined,
              size: 64,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppDimens.spacingLg),
            Text(
              'No workshops found',
              style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.spacingXl),
      itemCount: workshops.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppDimens.spacingLg),
      itemBuilder: (context, index) {
        final workshop = workshops[index];
        return _WorkshopCard(workshop: workshop);
      },
    );
  }
}

class _WorkshopCard extends StatelessWidget {
  final EventModel workshop;
  const _WorkshopCard({required this.workshop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/workshop', extra: workshop),
      borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingLg),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingSm, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    workshop.startTime.year.toString(),
                    style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              workshop.title,
              style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimens.spacingSm),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: AppColors.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  workshop.location,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
