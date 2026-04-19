import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String userAvatarUrl;
  final VoidCallback onTicketPressed;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
    required this.onTicketPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.surfaceContainerHigh,
          backgroundImage: userAvatarUrl.isNotEmpty ? NetworkImage(userAvatarUrl) : null,
          onBackgroundImageError: userAvatarUrl.isNotEmpty 
              ? (exception, stackTrace) => debugPrint('Avatar image error: $exception')
              : null,
          child: userAvatarUrl.isEmpty 
              ? const Icon(Icons.person, color: AppColors.onSurface) 
              : null,
        ),
        const SizedBox(width: AppDimens.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $userName 👋',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
              ),
              Text(
                'Arena Assistant',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = AppColors.secondaryGradient.createShader(
                      const Rect.fromLTWH(0, 0, 150, 20),
                    ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTicketPressed,
          child: Container(
            padding: const EdgeInsets.all(AppDimens.spacingSm),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: const Icon(Icons.local_activity, color: AppColors.primary, size: 24),
          ),
        ),
      ],
    );
  }
}
