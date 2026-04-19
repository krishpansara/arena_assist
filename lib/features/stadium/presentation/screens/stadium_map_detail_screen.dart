import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../data/crowd_density_service.dart';
import '../../utils/zone_mapper.dart';

class StadiumMapDetailScreen extends ConsumerWidget {
  const StadiumMapDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final densityData = ref.watch(crowdDensityProvider);

    return Scaffold(
      backgroundColor: AppColors.surface, // Dark background
      body: Stack(
        children: [
          // Background blur and color
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.surfaceContainerHigh,
                  AppColors.surfaceContainerLowest,
                ],
                radius: 1.5,
              ),
            ),
          ),

          // Image layer
          InteractiveViewer(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spacingLg),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Base Image which implicitly defines the exact dimensions of this Stack
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        AppColors.surfaceContainerLowest.withValues(alpha: 0.3),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        'assets/images/maps/wankhede_stadium_blueprint.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Fills the intrinsic size determined by the Image above
                    Positioned.fill(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final w = constraints.maxWidth;
                          final h = constraints.maxHeight;

                          return densityData.when(
                            data: (counts) {
                              return Stack(
                                children: [
                                  _DensityZoneShape(
                                    maxWidth: w,
                                    maxHeight: h,
                                    zone: StadiumZone.northStand,
                                    count: counts[StadiumZone.northStand] ?? 0,
                                    topPercent: 0.05,
                                    leftPercent: 0.25,
                                    widthPercent: 0.50,
                                    heightPercent: 0.20,
                                    label: 'NORTH STAND',
                                  ),
                                  _DensityZoneShape(
                                    maxWidth: w,
                                    maxHeight: h,
                                    zone: StadiumZone.southStand,
                                    count: counts[StadiumZone.southStand] ?? 0,
                                    topPercent: 0.75,
                                    leftPercent: 0.25,
                                    widthPercent: 0.50,
                                    heightPercent: 0.20,
                                    label: 'SOUTH STAND',
                                  ),
                                  _DensityZoneShape(
                                    maxWidth: w,
                                    maxHeight: h,
                                    zone: StadiumZone.eastStand,
                                    count: counts[StadiumZone.eastStand] ?? 0,
                                    topPercent: 0.25,
                                    leftPercent: 0.75,
                                    widthPercent: 0.20,
                                    heightPercent: 0.50,
                                    label: 'EAST STAND',
                                  ),
                                  _DensityZoneShape(
                                    maxWidth: w,
                                    maxHeight: h,
                                    zone: StadiumZone.westStand,
                                    count: counts[StadiumZone.westStand] ?? 0,
                                    topPercent: 0.25,
                                    leftPercent: 0.05,
                                    widthPercent: 0.20,
                                    heightPercent: 0.50,
                                    label: 'WEST STAND',
                                  ),
                                ],
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                            error: (err, stack) => Center(
                              child: Text(
                                'Error loading density',
                                style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Top Bar Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.spacingLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerHigh
                          .withValues(alpha: 0.8),
                      padding: const EdgeInsets.all(AppDimens.spacingMd),
                    ),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.spacingLg,
                      vertical: AppDimens.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh.withValues(
                        alpha: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                      border: Border.all(
                        color: AppColors.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10b981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppDimens.spacingSm),
                        Text(
                          'LIVE ZONES',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
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
}

class _DensityZoneShape extends StatelessWidget {
  final StadiumZone zone;
  final int count;
  final double topPercent;
  final double leftPercent;
  final double widthPercent;
  final double heightPercent;
  final String label;
  final double maxWidth;
  final double maxHeight;

  const _DensityZoneShape({
    required this.zone,
    required this.count,
    required this.topPercent,
    required this.leftPercent,
    required this.widthPercent,
    required this.heightPercent,
    required this.label,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    Color getDensityColor() {
      // Density Logic Implementation
      if (count < 5) return const Color(0xFF10b981); // Low (Green)
      if (count <= 20) return const Color(0xFFeab308); // Medium (Yellow)
      return const Color(0xFFef4444); // High (Red)
    }

    final color = getDensityColor();

    return Positioned(
      top: MediaQuery.of(context).size.height * topPercent,
      left: MediaQuery.of(context).size.width * leftPercent,
      width: MediaQuery.of(context).size.width * widthPercent,
      height: MediaQuery.of(context).size.height * heightPercent,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          border: Border.all(color: color.withValues(alpha: 0.8), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Text(
              '$label\n$count',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
