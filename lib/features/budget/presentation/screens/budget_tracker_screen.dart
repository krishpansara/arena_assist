import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../../home/domain/models/event_model.dart';
import '../widgets/budget_tracker_section.dart';

import 'package:arena_assist/core/widgets/app_header.dart';

class BudgetTrackerScreen extends ConsumerWidget {
  final EventModel event;

  const BudgetTrackerScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const AppHeader(
        title: 'Budget Tracker',
        showProfile: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppDimens.spacingLg),
            BudgetTrackerSection(
              event: event,
            ),
            const SizedBox(height: AppDimens.spacingXxl),
          ],
        ),
      ),
    );
  }
}
