import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/core/widgets/app_header.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/presentation/widgets/workshop_hero.dart';
import 'package:arena_assist/features/workshop/presentation/widgets/workshop_action_grid.dart';
import 'package:arena_assist/features/workshop/presentation/widgets/workshop_upcoming_sessions.dart';
import 'package:arena_assist/features/workshop/presentation/widgets/assistant_pulse.dart';
import 'package:arena_assist/features/workshop/presentation/widgets/workshop_speaker_bios.dart';

class WorkshopScreen extends StatelessWidget {
  final EventModel event;

  const WorkshopScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppHeader(title: event.title, showProfile: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppDimens.spacingLg),
            WorkshopHero(event: event),
            const SizedBox(height: AppDimens.spacingXl),
            WorkshopActionGrid(event: event),
            const SizedBox(height: AppDimens.spacingXl),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
            //   child: FoodVendorList(isStadiumMode: false),
            // ),
            const SizedBox(height: AppDimens.spacingXl),
            if (event.sessions != null && event.sessions!.isNotEmpty) ...[
              WorkshopUpcomingSessions(sessions: event.sessions!),
              const SizedBox(height: AppDimens.spacingXl),
            ],
            if (event.speakers != null && event.speakers!.isNotEmpty) ...[
              WorkshopSpeakerBios(speakers: event.speakers!),
              const SizedBox(height: AppDimens.spacingXl),
            ],
            const AssistantPulse(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
