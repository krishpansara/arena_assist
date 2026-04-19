import 'package:flutter/material.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:arena_assist/features/workshop/presentation/screens/speaker_bio_screen.dart';
import 'package:arena_assist/features/workshop/presentation/screens/speakers_list_screen.dart';

class WorkshopSpeakerBios extends StatelessWidget {
  const WorkshopSpeakerBios({super.key, required this.speakers});
  final List<SpeakerInfo> speakers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SPEAKER BIOS',
                style: AppTextStyles.labelLarge.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SpeakersListScreen(speakers: speakers),
                    ),
                  );
                },
                child: Text(
                  'VIEW ALL',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
            scrollDirection: Axis.horizontal,
            itemCount: speakers.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppDimens.spacingLg),
            itemBuilder: (context, index) => _SpeakerCard(speaker: speakers[index]),
          ),
        ),
      ],
    );
  }
}

class _SpeakerCard extends StatelessWidget {
  final SpeakerInfo speaker;
  const _SpeakerCard({required this.speaker});

  void _navigateToBio(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SpeakerBioScreen(speaker: speaker),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToBio(context),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(AppDimens.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Hero(
              tag: 'speaker_avatar_${speaker.name}',
              child: ClipOval(
                child: Image.network(
                  speaker.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: AppColors.surfaceContainerHighest,
                    child: const Icon(Icons.person, color: AppColors.onSurfaceVariant, size: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.spacingSm),
            Text(
              speaker.name,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _navigateToBio(context),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'READ MORE',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
