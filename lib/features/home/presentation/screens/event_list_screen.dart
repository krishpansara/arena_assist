import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/home/presentation/providers/event_provider.dart';
import 'package:arena_assist/features/home/presentation/widgets/event_list_card.dart';

class EventListScreen extends ConsumerStatefulWidget {
  const EventListScreen({super.key});

  @override
  ConsumerState<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends ConsumerState<EventListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(allEventsProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'All Events',
          style: AppTextStyles.headlineMedium.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          tabs: const [
            Tab(text: 'ONGOING'),
            Tab(text: 'UPCOMING'),
            Tab(text: 'HISTORY'),
          ],
        ),
      ),
      body: eventsAsync.when(
        data: (events) {
          final ongoing = events.where((e) => e.isLive).toList();
          // Upcoming: Not live, not completed, effectively anything starting > 30 mins from now.
          final upcoming = events.where((e) => !e.isLive && !e.isCompleted).toList();
          final history = events.where((e) => e.isCompleted).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildEventList(ongoing, "No ongoing events."),
              _buildEventList(upcoming, "No upcoming events scheduled."),
              _buildEventList(history, "No event history found."),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Failed to load events: $error',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(List<EventModel> events, String emptyMessage) {
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
            const SizedBox(height: AppDimens.spacingMd),
            Text(
              emptyMessage,
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }
    
    // Sort events: closest in time first
    events.sort((a, b) => a.startTime.compareTo(b.startTime));

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.spacingMd),
          child: EventListCard(
            event: event,
            onTap: () {
              if (event.type == EventType.stadium) {
                context.push('/stadium', extra: event);
              } else {
                context.push('/workshop', extra: event);
              }
            },
          ),
        );
      },
    );
  }
}
