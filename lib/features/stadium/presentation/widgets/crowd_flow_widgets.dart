import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

class CrowdFlowHeader extends StatelessWidget {
  const CrowdFlowHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: AppColors.onSurfaceVariant, size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text(
                'STADIUM LIVE',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: const Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 24),
              const SizedBox(width: AppDimens.spacingMd),
              const CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.surfaceContainerHigh,
                child: Icon(Icons.person, size: 16, color: AppColors.onSurfaceVariant),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CrowdFlowTitle extends StatelessWidget {
  const CrowdFlowTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CROWD FLOW',
            style: AppTextStyles.displayLarge.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 40,
              letterSpacing: -1.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Row(
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
              Expanded(
                child: Text(
                  'LIVE STADIUM INSIGHTS • ZONE A-G',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CrowdFlowStats extends StatelessWidget {
  const CrowdFlowStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Row(
        children: [
          Expanded(
            child: _GradientBorderCard(
              gradientColors: [const Color(0xFF8B5CF6), const Color(0xFF8B5CF6).withOpacity(0.1)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CURRENT CAPACITY', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text('84.2%', style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF8B5CF6))),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: _GradientBorderCard(
              gradientColors: [const Color(0xFF10b981), const Color(0xFF10b981).withOpacity(0.1)],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('EST. EXIT TIME', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Text('14 MIN', style: AppTextStyles.headlineMedium.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF10b981))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBorderCard extends StatelessWidget {
  final List<Color> gradientColors;
  final Widget child;

  const _GradientBorderCard({required this.gradientColors, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg - 2),
        ),
        child: child,
      ),
    );
  }
}

class SpatialDensityCard extends StatelessWidget {
  const SpatialDensityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              offset: const Offset(0, -1),
              blurRadius: 10,
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Spatial Density', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('Real-time occupancy\nby sector', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 11)),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                      ),
                      child: Text('LIVE', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: 6),
                      child: Text('REPLAY', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          GestureDetector(
            onTap: () => context.push('/stadium-map'),
            child: Container(
              height: 320,
              width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Stadium Blueprint Image with Theme Matching
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      AppColors.surfaceContainerLowest.withOpacity(0.4),
                      BlendMode.multiply,
                    ),
                    child: Image.asset(
                      'assets/images/maps/wankhede_stadium_blueprint.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  // Semi-transparent overlay to further blend with theme
                  Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.surfaceContainerLowest.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),

                  // Interactive Data Points (Dots) - Re-positioned for larger map
                  Positioned(
                    top: 60,
                    left: 90,
                    child: _GlowingDot(color: const Color(0xFFef4444), size: 18, label: 'GATE 4'),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 140,
                    child: _GlowingDot(color: const Color(0xFF10b981), size: 14, label: ''),
                  ),
                  Positioned(
                    right: 90,
                    top: 80,
                    child: _GlowingDot(color: const Color(0xFF3b82f6), size: 22, label: 'NORTH'),
                  ),
                  Positioned(
                    bottom: 60,
                    right: 180,
                    child: _GlowingDot(color: const Color(0xFF10b981), size: 16, label: 'FIELD'),
                  ),
                ],
              ),
            ),
          ),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _LegendNode(color: const Color(0xFF10b981), text: 'LOW <\n30%'),
              _LegendNode(color: const Color(0xFF8B5CF6), text: 'MED 30-\n70%'),
              _LegendNode(color: const Color(0xFFef4444), text: 'HIGH >\n70%'),
            ],
          )
        ],
      ),
    );
  }
}

class _GlowingDot extends StatelessWidget {
  final Color color;
  final double size;
  final String label;

  const _GlowingDot({required this.color, required this.size, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
        ]
      ],
    );
  }
}

class _LegendNode extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendNode({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: AppDimens.spacingSm),
        Text(
          text,
          style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10),
        ),
      ],
    );
  }
}

class PredictiveFlowCard extends StatelessWidget {
  const PredictiveFlowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.show_chart, color: Color(0xFF8B5CF6), size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text('Predictive Flow', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text('NEXT 15 MINS', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Heavy Influx @ Gate A', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              Text('+12%', style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFFef4444), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.8,
            backgroundColor: AppColors.surfaceContainerHighest,
            color: const Color(0xFFef4444),
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Text('NEXT 30 MINS', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Concourse Clearance', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
              Text('-24%', style: AppTextStyles.labelMedium.copyWith(color: const Color(0xFF10b981), fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.3,
            backgroundColor: AppColors.surfaceContainerHighest,
            color: const Color(0xFF10b981),
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}

class OptimizationCard extends StatelessWidget {
  const OptimizationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Color(0xFFc084fc), size: 20),
              const SizedBox(width: AppDimens.spacingSm),
              Text('Optimization', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          const _OptimizationAlert(
            text: 'Redirect fans to ',
            highlight: 'Gate D.',
            tail: ' Current wait time: ',
            tailHighlight: '2 mins.',
            highlightColor: Color(0xFFc084fc),
            tailHighlightColor: Color(0xFF10b981),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          const _OptimizationAlert(
            text: 'Restock alert: ',
            highlight: 'Section 204',
            tail: ' mobile\nconcessions experiencing high demand.',
            tailHighlight: '',
            highlightColor: Color(0xFF3b82f6),
            tailHighlightColor: Colors.transparent,
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFa855f7), Color(0xFF8b5cf6)],
              ),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: Center(
              child: Text(
                'SEND NOTIFICATIONS',
                style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _OptimizationAlert extends StatelessWidget {
  final String text;
  final String highlight;
  final String tail;
  final String tailHighlight;
  final Color highlightColor;
  final Color tailHighlightColor;

  const _OptimizationAlert({
    required this.text,
    required this.highlight,
    required this.tail,
    required this.tailHighlight,
    required this.highlightColor,
    required this.tailHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.1)),
      ),
      child: RichText(
        text: TextSpan(
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
          children: [
            TextSpan(text: text),
            TextSpan(text: highlight, style: TextStyle(color: highlightColor, fontWeight: FontWeight.bold)),
            TextSpan(text: tail),
            if (tailHighlight.isNotEmpty)
              TextSpan(text: tailHighlight, style: TextStyle(color: tailHighlightColor, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class ActiveSectionMonitoring extends StatelessWidget {
  const ActiveSectionMonitoring({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ACTIVE SECTION MONITORING', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const Icon(Icons.filter_list, color: AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: AppDimens.spacingLg),
          Row(
            children: [
              Expanded(flex: 3, child: Text('ZONE /\nSECTION', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10))),
              Expanded(flex: 3, child: Text('OCCUPANCY', style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10))),
              Expanded(flex: 1, child: Text('TREND', textAlign: TextAlign.right, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10))),
            ],
          ),
          const SizedBox(height: AppDimens.spacingMd),
          const _SectionRow(
            indicatorColor: Color(0xFFef4444),
            title: 'NORTH\nSTAND',
            subtitle: 'Sectors\n101-110',
            occupancy: '94%',
            badgeText: 'CRITICAL',
            badgeColor: Color(0xFFef4444),
            trendIcon: Icons.trending_up,
            trendColor: Color(0xFFef4444),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          const _SectionRow(
            indicatorColor: Color(0xFF10b981),
            title: 'SOUTH\nPLAZA',
            subtitle: 'Entry Gate\nG',
            occupancy: '28%',
            badgeText: 'OPTIMAL',
            badgeColor: Color(0xFF10b981),
            trendIcon: Icons.arrow_right_alt,
            trendColor: Color(0xFF10b981),
          ),
        ],
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  final Color indicatorColor;
  final String title;
  final String subtitle;
  final String occupancy;
  final String badgeText;
  final Color badgeColor;
  final IconData trendIcon;
  final Color trendColor;

  const _SectionRow({
    required this.indicatorColor,
    required this.title,
    required this.subtitle,
    required this.occupancy,
    required this.badgeText,
    required this.badgeColor,
    required this.trendIcon,
    required this.trendColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 36,
                  margin: const EdgeInsets.only(right: AppDimens.spacingMd),
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold, height: 1.1)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                Text(occupancy, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(badgeText, style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(trendIcon, color: trendColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class CrowdFlowBottomNav extends StatelessWidget {
  const CrowdFlowBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(
            color: AppColors.outlineVariant.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: 1,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          if (index == 0) {
            context.go('/stadium');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view, color: AppColors.onSurfaceVariant), label: 'EVENT'),
          NavigationDestination(icon: Icon(Icons.map, color: AppColors.primary), label: 'CROWD'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined, color: AppColors.onSurfaceVariant), label: 'WALLET'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant), label: 'ALERTS'),
        ],
      ),
    );
  }
}
