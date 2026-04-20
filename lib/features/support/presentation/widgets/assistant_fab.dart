import 'package:arena_assist/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/app_colors.dart';
import 'package:arena_assist/core/theme/app_dimens.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/safety/presentation/providers/sos_provider.dart';

class AssistantFab extends ConsumerWidget {
  final EventModel? event;

  const AssistantFab({super.key, this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sosState = ref.watch(sosProvider);
    final router = ref.watch(appRouterProvider);
    
    // Get current location to decide how much to lift the FAB
    final location = router.routeInformationProvider.value.uri.path;
    final hasBottomBar = ['/home', '/events', '/alerts', '/profile'].contains(location);
    
    // Lift by more if SOS is above the bottom navbar, 
    // and by less if SOS is at the absolute bottom (event screens)
    final liftAmount = hasBottomBar ? -165.0 : -95.0;

    return Transform.translate(
      offset: Offset(0, sosState.isActive ? liftAmount : 0.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => context.push('/ai-assistant', extra: event),
          backgroundColor: AppColors.primary,
          child: const Icon(
            Icons.auto_awesome,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
