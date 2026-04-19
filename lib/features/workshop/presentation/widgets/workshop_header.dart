import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class WorkshopHeader extends StatelessWidget {
  final EventModel event;
  const WorkshopHeader({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.onSurface),
              ),
              const SizedBox(width: AppDimens.spacingMd),
              const Icon(Icons.flag, color: AppColors.onSurfaceVariant, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'WORKSHOP LIVE',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.surfaceContainerHigh,
            child: Icon(Icons.person, size: 16, color: AppColors.onSurfaceVariant),
          )
        ],
      ),
    );
  }
}
