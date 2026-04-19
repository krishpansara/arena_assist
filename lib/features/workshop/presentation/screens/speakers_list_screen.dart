import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/core/widgets/app_header.dart';
import 'package:arena_assist/features/workshop/presentation/screens/speaker_bio_screen.dart';

class SpeakersListScreen extends StatelessWidget {
  final List<SpeakerInfo> speakers;

  const SpeakersListScreen({super.key, required this.speakers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const AppHeader(
        title: 'Speakers',
        showProfile: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        itemCount: speakers.length,
        separatorBuilder: (context, index) => const SizedBox(height: AppDimens.spacingLg),
        itemBuilder: (context, index) {
          final speaker = speakers[index];
          return _SpeakerListItem(speaker: speaker);
        },
      ),
    );
  }
}

class _SpeakerListItem extends StatelessWidget {
  final SpeakerInfo speaker;

  const _SpeakerListItem({required this.speaker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SpeakerBioScreen(speaker: speaker),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimens.spacingLg),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'speaker_avatar_${speaker.name}',
              child: ClipOval(
                child: Image.network(
                  speaker.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70,
                    height: 70,
                    color: AppColors.surfaceContainerHighest,
                    child: const Icon(Icons.person, color: AppColors.onSurfaceVariant, size: 35),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimens.spacingLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    speaker.name,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    speaker.topic.toUpperCase(),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    speaker.bio,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimens.spacingMd),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
