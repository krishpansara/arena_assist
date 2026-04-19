import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../home/domain/models/event_model.dart';
import '../providers/live_score_provider.dart';
import '../widgets/stadium_live_score.dart';
import 'dart:ui';

class LiveScoreScreen extends ConsumerWidget {
  final EventModel event;

  const LiveScoreScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch our new stream provider
    final liveScoreAsync = ref.watch(liveScoreStreamProvider(event.id));

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppHeader(
        title: 'Live Tracking',
        showProfile: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.onSurface),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient to make it look premium
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.surface,
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimens.spacingXl),
                  Text(
                    event.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppDimens.spacingXxl),

                  // Riverpod async handling
                  Expanded(
                    child: liveScoreAsync.when(
                      data: (score) => _buildLiveScoreContent(score),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                      error: (err, stack) => _buildErrorState(err.toString(), ref),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveScoreContent(LiveScoreInfo score) {
    return Column(
      children: [
        // Premium large scoreboard
        Hero(
          tag: 'live_score_card',
          child: StadiumLiveScore(score: score),
        ),
        const SizedBox(height: AppDimens.spacingXxl),
        
        // Auto updating indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.withValues(alpha: 0.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'LIVE - AUTOSYNC ON',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppDimens.spacingXxl),
        
        // Extra placeholder stats
        _buildStatsRow('Possession', '45%', '55%'),
        const SizedBox(height: AppDimens.spacingLg),
        _buildStatsRow('Shots on Target', '4', '6'),
        const SizedBox(height: AppDimens.spacingLg),
        _buildStatsRow('Fouls', '2', '3'),
      ],
    );
  }

  Widget _buildStatsRow(String label, String homeValue, String awayValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            homeValue, 
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)
          ),
          Text(
            label, 
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)
          ),
          Text(
            awayValue, 
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.tertiary, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: AppDimens.spacingLg),
          Text(
            'Failed to load live score:\n$error',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
          const SizedBox(height: AppDimens.spacingXl),
          ElevatedButton(
            onPressed: () => ref.invalidate(liveScoreStreamProvider(event.id)),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
