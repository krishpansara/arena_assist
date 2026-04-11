import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class WorkshopUpcomingSessions extends StatelessWidget {
  const WorkshopUpcomingSessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Upcoming Sessions',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'SEE ALL',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        _buildSessionCard(
          time: '1:00\nPM',
          title: 'Deep Learning Architectures',
          tags: ['AI', 'ML'],
          tagColor: AppColors.primary,
        ),
        const SizedBox(height: AppDimens.spacingLg),
        _buildSessionCard(
          time: '2:45\nPM',
          title: 'Ethics in Modern Robotics',
          tags: ['POLICY', 'AI'],
          tagColor: AppColors.tertiaryFixed,
        ),
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
