import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/stadium_header.dart';
import '../widgets/stadium_hero.dart';
import '../widgets/stadium_crowd_density.dart';
import '../widgets/stadium_action_list.dart';
import '../widgets/upcoming_highlight_card.dart';

class StadiumScreen extends StatelessWidget {
  const StadiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Ensure dark background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const StadiumHeader(),
              const SizedBox(height: AppDimens.spacingXxl),
              const StadiumHero(),
              const SizedBox(height: AppDimens.spacingXxl),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.push('/crowd_flow'),
                child: const StadiumCrowdDensity(),
              ),
              const SizedBox(height: AppDimens.spacingXxl),
              const StadiumActionList(),
              const SizedBox(height: AppDimens.spacingXxl),
              const UpcomingHighlightCard(),
              const SizedBox(height: 100), // padding for floating action button
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildStadiumBottomNav(context),
    );
  }

  Widget _buildStadiumBottomNav(BuildContext context) {
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
        onDestinationSelected: (index) {
          if (index == 1) {
            context.push('/crowd_flow');
          } else if (index == 0) {
            context.go('/stadium');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view, color: AppColors.primary), label: 'EVENT'),
          NavigationDestination(icon: Icon(Icons.map_outlined, color: AppColors.onSurfaceVariant), label: 'CROWD'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined, color: AppColors.onSurfaceVariant), label: 'WALLET'),
          NavigationDestination(icon: Icon(Icons.fastfood_outlined, color: AppColors.onSurfaceVariant), label: 'ORDERS'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant), label: 'ALERTS'),
        ],
      ),
    );
  }
}

