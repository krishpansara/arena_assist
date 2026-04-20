import 'package:arena_assist/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../providers/sos_provider.dart';

class SOSActiveOverlay extends ConsumerWidget {
  final Widget child;

  const SOSActiveOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sosState = ref.watch(sosProvider);
    final router = ref.watch(appRouterProvider);

    // Get current location to decide if we should offset for bottom nav bar
    // routes in StatefulShellRoute branches usually display the nav bar
    final location = router.routeInformationProvider.value.uri.path;
    final hasBottomBar = ['/home', '/events', '/alerts', '/profile'].contains(location);

    return Stack(
      children: [
        child,
        if (sosState.isActive)
          Positioned(
            bottom: hasBottomBar ? AppDimens.bottomNavHeight + AppDimens.spacingSm : AppDimens.spacingSm,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              bottom: true,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd),
                  padding: const EdgeInsets.all(AppDimens.spacingMd),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emergency, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: AppDimens.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'SOS IS ACTIVE',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.onErrorContainer,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Text(
                              'Location tracking enabled.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.onErrorContainer.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _showResolveDialog(ref);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                          ),
                        ),
                        child: Text(
                          'RESOLVE',
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  void _showResolveDialog(WidgetRef ref) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerHigh,
        title: Text(
          'Resolve Emergency?',
          style: AppTextStyles.titleMedium,
        ),
        content: Text(
          'This will notify authorities that you are safe and stop tracking your location.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () {
              ref.read(sosProvider.notifier).resolveSOS();
              Navigator.pop(context);
            },
            child: Text('Resolve', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
