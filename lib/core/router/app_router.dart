import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arena_assist/core/widgets/app_shell.dart';
import 'package:arena_assist/features/auth/presentation/screens/splash_screen.dart';
import 'package:arena_assist/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:arena_assist/features/auth/presentation/screens/login_screen.dart';
import 'package:arena_assist/features/auth/presentation/screens/register_screen.dart';
import 'package:arena_assist/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:arena_assist/features/auth/presentation/screens/verify_access_screen.dart';
import 'package:arena_assist/features/home/presentation/screens/home_screen.dart';
import 'package:arena_assist/features/profile/presentation/screens/profile_screen.dart';
import 'package:arena_assist/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:arena_assist/features/settings/presentation/screens/settings_screen.dart';
import 'package:arena_assist/features/settings/presentation/screens/change_password_screen.dart';
import 'package:arena_assist/features/support/presentation/screens/support_screen.dart';
import 'package:arena_assist/features/event_analyzer/presentation/screens/event_analyzer_screen.dart';
import 'package:arena_assist/features/workshop/presentation/screens/workshop_screen.dart';
import 'package:arena_assist/features/workshop/presentation/screens/workshop_list_screen.dart';
import 'package:arena_assist/features/stadium/presentation/screens/stadium_map_detail_screen.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/home/presentation/screens/event_list_screen.dart';
import 'package:arena_assist/features/venue_map/presentation/screens/venue_location_screen.dart';
import 'package:arena_assist/features/workshop/presentation/screens/speakers_list_screen.dart';
import 'package:arena_assist/features/stadium/presentation/screens/event_details_screen.dart';
import 'package:arena_assist/features/budget/presentation/screens/budget_tracker_screen.dart';
import 'package:arena_assist/features/stadium/presentation/screens/crowd_flow_screen.dart';
import 'package:arena_assist/features/food/presentation/screens/food_screen.dart';
import 'package:arena_assist/features/stadium/presentation/screens/live_score_screen.dart';
import 'package:arena_assist/features/transport/presentation/screens/ride_estimator_screen.dart';
import 'package:arena_assist/features/transcript/presentation/screens/live_transcript_screen.dart';
import 'package:arena_assist/features/transcript/presentation/screens/transcript_list_screen.dart';
import 'package:arena_assist/features/alerts/presentation/screens/alerts_screen.dart';
import 'package:arena_assist/features/safety/presentation/screens/emergency_dashboard_screen.dart';

EventModel? _parseEvent(Object? extra) {
  if (extra is EventModel) return extra;
  if (extra is Map<String, dynamic>) return EventModel.fromJson(extra);
  if (extra is Map) return EventModel.fromJson(Map<String, dynamic>.from(extra));
  return null;
}

List<SpeakerInfo>? _parseSpeakers(Object? extra) {
  if (extra is List<SpeakerInfo>) return extra;
  if (extra is List) {
    try {
      return extra.map((e) => SpeakerInfo.fromJson(Map<String, dynamic>.from(e))).toList();
    } catch (_) {
      return null;
    }
  }
  return null;
}

// Dummy screen for unbuilt tabs
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text(title)));
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authStateChangesProvider);
      
      if (authState.isLoading) return null;

      final isAuthenticated = authState.valueOrNull != null;
      final location = state.matchedLocation;

      // Routes that are strictly for authentication (redirect to home if logged in)
      final isAuthRoute = location == '/login' ||
          location == '/register' ||
          location == '/' || 
          location == '/onboarding';

      // Routes related to authentication but accessible to both
      final isForgotPassRoute = location == '/forgot-password' || 
          location == '/verify';

      // Feature routes that are accessible by Guests
      final isPublicRoute = isAuthRoute ||
          isForgotPassRoute ||
          location == '/home' ||
          location == '/stadium' ||
          location == '/workshops' ||
          location == '/workshop' ||
          location == '/food' ||
          location == '/food_order' ||
          location == '/venue_location';

      // If user is not logged in and tries to access a private route, redirect to login
      if (!isAuthenticated && !isPublicRoute) {
        return '/login';
      }

      // If user is logged in and tries to access auth routes, redirect to home
      if (isAuthenticated && isAuthRoute) {
        return '/home';
      }

      return null;
    },
    routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => const VerifyAccessScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportScreen(),
    ),
    GoRoute(
      path: '/event-analyzer',
      builder: (context, state) => const EventAnalyzerScreen(),
    ),
    GoRoute(
      path: '/workshop',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return WorkshopScreen(event: event);
      },
    ),
    GoRoute(
      path: '/workshops',
      builder: (context, state) => const WorkshopListScreen(),
    ),
    GoRoute(
      path: '/stadium',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        return EventDetailsScreen(event: event);
      },
    ),
    GoRoute(
      path: '/stadium_map',
      builder: (context, state) => const StadiumMapDetailScreen(),
    ),
    GoRoute(
      path: '/live-score',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return LiveScoreScreen(event: event);
      },
    ),
    GoRoute(
      path: '/ride-estimator',
      builder: (context, state) {
        final dest = state.extra as String? ?? '';
        return RideEstimatorScreen(defaultDestination: dest);
      },
    ),
    GoRoute(
      path: '/crowd_flow',
      builder: (context, state) => const CrowdFlowScreen(),
    ),
    GoRoute(
      path: '/budget',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return BudgetTrackerScreen(event: event);
      },
    ),
    GoRoute(
      path: '/venue_location',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return VenueLocationScreen(event: event);
      },
    ),
    GoRoute(
      path: '/workshop_speaker_bios',
      builder: (context, state) {
        final speakers = _parseSpeakers(state.extra) ?? [];
        return SpeakersListScreen(speakers: speakers);
      },
    ),
    GoRoute(
      path: '/food_order',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        return FoodScreen(event: event);
      },
    ),
    GoRoute(
      path: '/live_transcript',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return LiveTranscriptScreen(event: event);
      },
    ),
    GoRoute(
      path: '/transcripts_list',
      builder: (context, state) {
        final event = _parseEvent(state.extra);
        if (event == null) return const PlaceholderScreen('Invalid Event Data');
        return TranscriptListScreen(event: event);
      },
    ),
    GoRoute(
      path: '/emergency-dashboard',
      builder: (context, state) => const EmergencyDashboardScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/events',
              builder: (context, state) => const EventListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/alerts',
              builder: (context, state) => const AlertsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

  ref.listen(authStateChangesProvider, (_, __) {
    router.refresh();
  });

  return router;
});
