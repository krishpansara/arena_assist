import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/theme.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
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
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent, // Disable standard pill
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            _buildDestination(0, Icons.home_filled, Icons.home_outlined, 'HOME'),
            _buildDestination(1, Icons.event, Icons.event_outlined, 'EVENTS'),
            _buildDestination(2, Icons.notifications, Icons.notifications_outlined, 'ALERTS', hasBadge: true),
            _buildDestination(3, Icons.person, Icons.person_outline, 'PROFILE'),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  NavigationDestination _buildDestination(
      int index, IconData activeIcon, IconData inactiveIcon, String label, {bool hasBadge = false}) {
    final isActive = navigationShell.currentIndex == index;
    final color = isActive ? AppColors.primary : AppColors.onSurfaceVariant;

    Widget iconWidget = Icon(
      isActive ? activeIcon : inactiveIcon,
      color: color,
    );

    if (hasBadge) {
      iconWidget = Badge(
        backgroundColor: AppColors.error,
        smallSize: 8,
        child: iconWidget,
      );
    }

    return NavigationDestination(
      icon: iconWidget,
      label: label,
    );
  }
}
