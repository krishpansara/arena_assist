import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/theme.dart';
import 'core/router/app_router.dart';
import 'features/stadium/data/crowd_density_service.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize continuous location tracking service
    ref.watch(locationTrackerProvider);
    
    final goRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Arena Assist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: goRouter,
    );
  }
}
