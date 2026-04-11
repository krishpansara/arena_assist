import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/app_header.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Standard theme dark background
      appBar: AppHeader(
        title: 'EVENT DETAILS',
        showBackButton: true,
        actions: [
          const Icon(Icons.favorite, color: AppColors.primary),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMainCard(),
            const SizedBox(height: AppDimens.spacingLg),
            _buildStartsInBanner(),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildVenueDetails(),
            const SizedBox(height: AppDimens.spacingMd),
            _buildEntryUpdate(),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildAboutSection(),
            const SizedBox(height: AppDimens.spacingXxl),
            _buildFooterActions(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildMainCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBadge(
            text: 'CHAMPIONS LEAGUE FINALS',
            variant: AppBadgeVariant.primary,
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'Real Madrid vs\nLiverpool',
            style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
              const SizedBox(width: AppDimens.spacingSm),
              Text('Sat, June 10 • 21:00', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildInfoItem('VENUE', 'Stade de France')),
              Expanded(child: _buildInfoItem('TICKET ID', 'REF: SL-992-KNT')),
            ],
          ),
          const SizedBox(height: AppDimens.spacingXxl),
          // Simplified Seat indicator
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
      onTap: () {}, // Adds smooth animated scaling and inkwell feedback!
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

  Widget _buildVenueDetails() {
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
        // Extremely simplified map placeholder
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
                onPressed: () {},
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

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About the Finals', style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: AppDimens.spacingSm),
        Text(
          'Experience the pinnacle of European football as two giants, Real Madrid and Liverpool, collide at the Stade de France.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('READ MORE', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildFooterActions() {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
          ),
          onPressed: () {},
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
                onPressed: () {},
                icon: const Icon(Icons.restaurant, color: AppColors.tertiaryFixed),
                label: const Text('ORDER FOOD'),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: 1, // TICKETS selected
      backgroundColor: AppColors.surfaceContainerLowest,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
        NavigationDestination(icon: Icon(Icons.confirmation_number), label: 'TICKETS'),
        NavigationDestination(icon: Icon(Icons.explore), label: 'MAP'),
        NavigationDestination(icon: Icon(Icons.person), label: 'PROFILE'),
      ],
    );
  }
}
