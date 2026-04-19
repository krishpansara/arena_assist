import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class WorkshopUpcomingSessions extends StatelessWidget {
  final List<SessionInfo> sessions;
  const WorkshopUpcomingSessions({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Text(
            'UPCOMING SESSIONS',
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        ...sessions.map((session) => Column(
          children: [
            _buildSessionCard(
              time: session.time,
              title: session.title,
              tags: [session.speaker], // Using speaker as a tag for now
              tagColor: AppColors.primary,
            ),
            const SizedBox(height: AppDimens.spacingLg),
          ],
        )),
      ],
    );
  }

  Widget _buildSessionCard({
    required String time,
    required String title,
    required List<String> tags,
    required Color tagColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingSm),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.spacingLg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppDimens.spacingSm),
                Row(
                  children: tags.map((t) {
                    return Container(
                      margin: const EdgeInsets.only(right: AppDimens.spacingSm),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: t == 'POLICY' ? AppColors.tertiaryFixed.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        t,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: t == 'POLICY' ? AppColors.tertiaryFixed : AppColors.primary,
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          const Icon(Icons.bookmark_border, color: AppColors.onSurfaceVariant),
        ],
      ),
    );
  }
}
