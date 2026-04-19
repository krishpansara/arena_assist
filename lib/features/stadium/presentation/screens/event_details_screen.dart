import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../home/domain/models/event_model.dart';

class EventDetailsScreen extends ConsumerStatefulWidget {
  final EventModel? event;

  const EventDetailsScreen({
    super.key,
    this.event,
  });

  @override
  ConsumerState<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends ConsumerState<EventDetailsScreen> {
  bool _showLiveScore = false;

  @override
  Widget build(BuildContext context) {
    // Fallback data if event is null (for development/mocking)
    final displayEvent = widget.event ?? 
      EventModel(
        id: 'mock-123',
        title: 'Real Madrid vs Liverpool',
        type: EventType.stadium,
        startTime: DateTime.now().add(const Duration(hours: 45)),
        location: 'Stade de France',
        section: '112',
        row: 'AA',
        seat: '14',
        liveScore: LiveScoreInfo(
          homeTeam: 'Real Madrid',
          awayTeam: 'Liverpool',
          homeScore: 1,
          awayScore: 0,
          matchClock: "35'",
          sportDescriptor: "1st Half",
        ),
      );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppHeader(
        title: 'Event Details',
        showProfile: true,
        actions: const [
          Icon(Icons.favorite_outline, color: AppColors.primary, size: 24),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMainCard(displayEvent),
            if (displayEvent.type == EventType.stadium) ...[
              const SizedBox(height: AppDimens.spacingLg),
              _buildLiveScoreButton(context, displayEvent),
            ],
            const SizedBox(height: AppDimens.spacingLg),
            _buildStartsInBanner(),
            const SizedBox(height: AppDimens.spacingLg),
            _buildRideEstimatorButton(context, displayEvent),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildBudgetCard(context, displayEvent),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildVenueDetails(context, displayEvent),
            const SizedBox(height: AppDimens.spacingMd),
            _buildEntryUpdate(),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildAboutSection(displayEvent),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildFooterActions(context, displayEvent),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveScoreButton(BuildContext context, EventModel event) {
    return AppCard(
      onTap: () => context.push('/live-score', extra: event),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
      borderEnabled: true,
      borderColor: AppColors.primary.withValues(alpha: 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const SizedBox(
              width: 4,
              height: 4,
            ),
          ),
          const SizedBox(width: AppDimens.spacingMd),
          Text(
            'TRACK LIVE SCORE',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context, EventModel event) {
    return AppCard(
      onTap: () => context.push('/budget', extra: event),
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingLg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingMd),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_wallet_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDimens.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ESTIMATED BUDGET',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        event.budget?.total ?? '0',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: AppDimens.spacingSm),
                      Text(
                        'AI PREDICTION',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard(EventModel event) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBadge(
            text: event.title.toUpperCase(),
            variant: AppBadgeVariant.primary,
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            event.title.contains('vs') 
              ? event.title.replaceFirst(' vs ', ' vs\n')
              : event.title,
            style: AppTextStyles.headlineMedium.copyWith(
              fontWeight: FontWeight.bold, 
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                '${_formatDate(event.startTime)} • ${_formatTime(event.startTime)}', 
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildInfoItem('VENUE', event.location)),
              Expanded(child: _buildInfoItem('TICKET ID', 'REF: ${event.id.toUpperCase().substring(0, 8)}')),
            ],
          ),
          const SizedBox(height: AppDimens.spacingXxl),
          Container(
            padding: const EdgeInsets.all(AppDimens.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: AppColors.tertiaryFixed,
                child: Icon(Icons.accessible, color: Colors.black, size: 20),
              ),
              title: Text('YOUR SEAT', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
              subtitle: Text('Sec 112, Row AA', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              trailing: Text('14', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.tertiaryFixed, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildStartsInBanner() {
    return AppCard(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      onTap: () {},
      borderEnabled: true,
      backgroundColor: AppColors.surfaceContainerHigh,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.timer, color: AppColors.primary),
              const SizedBox(width: AppDimens.spacingMd),
              Text('STARTS IN 45 MINS', style: AppTextStyles.labelLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildRideEstimatorButton(BuildContext context, EventModel event) {
    return AppCard(
      onTap: () => context.push('/ride-estimator', extra: event.location),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
      backgroundColor: AppColors.tertiary.withValues(alpha: 0.1),
      borderEnabled: true,
      borderColor: AppColors.tertiary.withValues(alpha: 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_taxi, color: AppColors.tertiary),
          const SizedBox(width: AppDimens.spacingMd),
          Text(
            'PLAN YOUR RIDE',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.tertiary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVenueDetails(BuildContext context, EventModel event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Venue Details', style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            Text('GATE G RECOMMENDED', style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: AppDimens.spacingMd),
        AppCard(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.surfaceContainerHighest,
          child: SizedBox(
            height: 120,
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => context.push('/venue_location', extra: event),
                icon: const Icon(Icons.pin_drop, color: AppColors.primary),
                label: const Text('VIEW ON MAP'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEntryUpdate() {
    return AppCard(
      backgroundColor: AppColors.surfaceContainerHigh,
      borderEnabled: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.speed, color: AppColors.secondary),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ENTRY UPDATE', style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Gate G is experiencing low wait times. Optimal entry now.', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(EventModel event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About the Event', style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: AppDimens.spacingSm),
        Text(
          event.description != null && event.description!.isNotEmpty 
            ? event.description! 
            : 'Experience the pinnacle of ${event.type == EventType.stadium ? 'stadium events' : 'workshops'} at ${event.location}. Join us for an unforgettable atmosphere.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('READ MORE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildFooterActions(BuildContext context, EventModel displayEvent) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
          ),
          onPressed: () => context.push('/stadium_map'), 
          icon: const Icon(Icons.map),
          label: const Text('VIEW LIVE MAP', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: AppDimens.spacingMd),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHighest,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.near_me, color: AppColors.primary),
                label: const Text('FIND SEAT'),
              ),
            ),
            const SizedBox(width: AppDimens.spacingMd),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHighest,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
                ),
                onPressed: () => context.push('/food_order', extra: displayEvent),
                icon: const Icon(Icons.restaurant, color: AppColors.tertiaryFixed),
                label: const Text('ORDER FOOD'),
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget _buildBottomNav() {
  //   return NavigationBar(
  //     selectedIndex: 1, // TICKETS selected
  //     backgroundColor: AppColors.surfaceContainerLowest,
  //     destinations: const [
  //       NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
  //       NavigationDestination(icon: Icon(Icons.confirmation_number), label: 'TICKETS'),
  //       NavigationDestination(icon: Icon(Icons.explore), label: 'MAP'),
  //       NavigationDestination(icon: Icon(Icons.person), label: 'PROFILE'),
  //     ],
  //   );
  // }

  String _formatDate(DateTime dt) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return '${days[dt.weekday % 7]}, ${months[dt.month - 1]} ${dt.day}';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
