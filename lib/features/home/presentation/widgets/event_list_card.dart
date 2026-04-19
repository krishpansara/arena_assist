import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class EventListCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;

  const EventListCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isWorkshop = event.type == EventType.workshop;
    final iconData = isWorkshop ? Icons.school : Icons.sports_soccer;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          boxShadow: AppShadows.primaryGlowMedium,
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Decorative background gradient element
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (isWorkshop ? AppColors.secondary : AppColors.primary).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppDimens.spacingSm),
                        decoration: BoxDecoration(
                          color: (isWorkshop ? AppColors.secondary : AppColors.primary).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                        ),
                        child: Icon(
                          iconData,
                          color: isWorkshop ? AppColors.secondary : AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppDimens.spacingMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isWorkshop ? 'Workshop' : 'Stadium Event',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              event.title.replaceAll('\n', ' '),
                              style: AppTextStyles.titleLarge.copyWith(
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      if (event.isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingSm, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                          ),
                          child: Text(
                            'LIVE',
                            style: AppTextStyles.labelSmall.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingLg),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: AppDimens.spacingSm),
                      Text(
                        _formatDate(event.startTime),
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface),
                      ),
                      const Spacer(),
                      Icon(Icons.access_time, size: 16, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: AppDimens.spacingSm),
                      Text(
                        _formatTime(event.startTime),
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingMd),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: AppColors.onSurfaceVariant),
                      const SizedBox(width: AppDimens.spacingSm),
                      Expanded(
                        child: Text(
                          event.location,
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $amPm';
  }
}
