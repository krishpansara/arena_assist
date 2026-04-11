import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/workshop_header.dart';
import '../widgets/workshop_hero.dart';
import '../widgets/workshop_action_grid.dart';
import '../widgets/workshop_upcoming_sessions.dart';
import '../widgets/assistant_pulse.dart';
import '../widgets/workshop_speaker_bios.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Ensure dark background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              WorkshopHeader(),
              SizedBox(height: AppDimens.spacingXxl),
              WorkshopHero(),
              SizedBox(height: AppDimens.spacingXxl),
              WorkshopActionGrid(),
              SizedBox(height: AppDimens.spacingXxl),
              WorkshopUpcomingSessions(),
              SizedBox(height: AppDimens.spacingXxl),
              WorkshopSpeakerBios(),
              SizedBox(height: AppDimens.spacingXxl),
              AssistantPulse(),
              SizedBox(height: 100), // padding for floating action button
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildWorkshopBottomNav(),
    );
  }

  Widget _buildWorkshopBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: 0,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_filled, color: AppColors.primary), label: 'HOME'),
          const NavigationDestination(icon: Icon(Icons.map_outlined, color: AppColors.onSurfaceVariant), label: 'MAP'),
          const NavigationDestination(icon: Icon(Icons.calendar_view_day_outlined, color: AppColors.onSurfaceVariant), label: 'SCHEDULE'),
          NavigationDestination(
            icon: Badge(
              backgroundColor: AppColors.error,
              smallSize: 8,
              child: const Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant),
            ),
            label: 'ALERTS',
          ),
          const NavigationDestination(icon: Icon(Icons.person_outline, color: AppColors.onSurfaceVariant), label: 'PROFILE'),
        ],
      ),
    );
  }
}

