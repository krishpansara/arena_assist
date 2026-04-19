import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../providers/alerts_provider.dart';
import '../widgets/alert_card.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsyncValue = ref.watch(alertsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Alerts'),
        backgroundColor: AppColors.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
            onPressed: () {
              final user = ref.read(authStateChangesProvider).valueOrNull;
              if (user != null) {
                ref.read(alertsRepositoryProvider).markAllAsRead(user.uid);
              }
            },
          ),
        ],
      ),
      body: alertsAsyncValue.when(
        data: (alerts) {
          if (alerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: AppDimens.spacingMd),
                  Text(
                    'No alerts yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: AppDimens.spacingSm),
                  Text(
                    'You\'re all caught up!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppDimens.spacingMd),
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return AlertCard(
                alert: alert,
                onTap: () {
                  if (!alert.isRead) {
                    final user = ref.read(authStateChangesProvider).valueOrNull;
                    if (user != null) {
                      ref.read(alertsRepositoryProvider).markAsRead(user.uid, alert.id);
                    }
                  }
                  // Optionally navigate based on alert.eventId or type
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            child: Text(
              'Error loading alerts: $error',
              style: TextStyle(color: AppColors.error),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
