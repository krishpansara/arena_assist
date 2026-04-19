import 'package:flutter/material.dart';
import '../../domain/models/alert_model.dart';
import '../../../../core/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class AlertCard extends StatelessWidget {
  final AlertModel alert;
  final VoidCallback? onTap;

  const AlertCard({
    super.key,
    required this.alert,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _getAlertStyle(alert.type);

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      elevation: alert.isRead ? 0 : 2,
      color: alert.isRead
          ? AppColors.surfaceContainerLowest
          : AppColors.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        side: BorderSide(
          color: alert.isRead
              ? AppColors.outlineVariant.withValues(alpha: 0.2)
              : color.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spacingMd),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.spacingSm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: AppDimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            alert.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                          ),
                        ),
                        if (!alert.isRead) ...[
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: AppDimens.spacingXs),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppDimens.spacingXs),
                    Text(
                      alert.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: AppDimens.spacingSm),
                    Text(
                      timeago.format(alert.timestamp),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  (IconData, Color) _getAlertStyle(AlertType type) {
    switch (type) {
      case AlertType.warning:
        return (Icons.warning_amber_rounded, AppColors.error);
      case AlertType.success:
        return (Icons.check_circle_outline, Colors.green);
      case AlertType.eventStarting:
        return (Icons.event_available, AppColors.primary);
      case AlertType.info:
        return (Icons.info_outline, AppColors.primary);
    }
  }
}
