import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../home/domain/models/event_model.dart';

class StadiumLiveScore extends StatelessWidget {
  final LiveScoreInfo score;

  const StadiumLiveScore({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam(score.homeTeam, true),
              _buildScoreCenter(),
              _buildTeam(score.awayTeam, false),
            ],
          ),
          if (score.sportDescriptor != null || score.matchClock != null) ...[
            const SizedBox(height: AppDimens.spacingMd),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${score.sportDescriptor ?? ''} ${score.matchClock ?? ''}'.trim(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTeam(String name, bool isHome) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Text(
                name.substring(0, 1).toUpperCase(),
                style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCenter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${score.homeScore}',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  ':',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
              ),
              Text(
                '${score.awayScore}',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
