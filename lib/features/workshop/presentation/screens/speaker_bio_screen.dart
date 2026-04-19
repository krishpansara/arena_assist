import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';

class SpeakerBioScreen extends StatelessWidget {
  final SpeakerInfo speaker;

  const SpeakerBioScreen({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('SPEAKER BIO'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'speaker_avatar_${speaker.name}',
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      speaker.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 120,
                        height: 120,
                        color: AppColors.surfaceContainerHighest,
                        child: const Icon(Icons.person, color: AppColors.onSurfaceVariant, size: 60),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacingXxl),
            Text(
              speaker.name,
              style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimens.spacingXs),
            Text(
              speaker.topic.toUpperCase(),
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spacingXl),
            Container(
              padding: const EdgeInsets.all(AppDimens.spacingLg),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingSm),
                  Text(
                    speaker.bio,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.onSurface,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
