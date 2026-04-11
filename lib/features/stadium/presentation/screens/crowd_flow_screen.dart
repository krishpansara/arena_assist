import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

class CrowdFlowScreen extends StatelessWidget {
  const CrowdFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Dark background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: AppDimens.spacingLg),
              _buildTitleSection(),
              const SizedBox(height: AppDimens.spacingLg),
              _buildStatsRow(),
              const SizedBox(height: AppDimens.spacingXxl),
              _buildSpatialDensity(),
              const SizedBox(height: AppDimens.spacingXxl),
              _buildPredictiveFlow(),
              const SizedBox(height: AppDimens.spacingXxl),
              _buildOptimization(),
              const SizedBox(height: AppDimens.spacingXxl),
              _buildActiveSectionMonitoring(),
              const SizedBox(height: 100), // padding
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader() {
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
                  color: const Color(0xFF8B5CF6), // Matches the purple in image
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

  Widget _buildTitleSection() {
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
                  color: Color(0xFF10b981), // Emerald green
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

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Row(
        children: [
          Expanded(
            child: _buildGradientBorderCard(
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
            child: _buildGradientBorderCard(
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

  Widget _buildGradientBorderCard({required List<Color> gradientColors, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(2), // border width
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd, horizontal: AppDimens.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest, // Dark inner color
          borderRadius: BorderRadius.circular(AppDimens.radiusLg - 2),
        ),
        child: child,
      ),
    );
  }

  Widget _buildSpatialDensity() {
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
        ] // slight inner glow simulation from border
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
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(60), // oval shape
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Dots
                  Positioned(
                    top: 20,
                    left: 20,
                    child: _buildGlowingDot(const Color(0xFFef4444), 30, 'GATE A'),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 40,
                    child: _buildGlowingDot(const Color(0xFF10b981), 20, ''),
                  ),
                  Positioned(
                    right: 20,
                    top: 30,
                    child: _buildGlowingDot(const Color(0xFF3b82f6), 40, 'CONCOURSE'),
                  ),
                  Positioned(
                    bottom: 15,
                    child: _buildGlowingDot(const Color(0xFF10b981), 20, 'FIELD'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendNode(const Color(0xFF10b981), 'LOW <\n30%'),
              _buildLegendNode(const Color(0xFF8B5CF6), 'MED 30-\n70%'),
              _buildLegendNode(const Color(0xFFef4444), 'HIGH >\n70%'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGlowingDot(Color color, double size, String label) {
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
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 6, fontWeight: FontWeight.bold)),
        ]
      ],
    );
  }

  Widget _buildLegendNode(Color color, String text) {
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

  Widget _buildPredictiveFlow() {
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

  Widget _buildOptimization() {
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
          _buildOptimizationAlert(
            text: 'Redirect fans to ',
            highlight: 'Gate D.',
            tail: ' Current wait time: ',
            tailHighlight: '2 mins.',
            highlightColor: const Color(0xFFc084fc),
            tailHighlightColor: const Color(0xFF10b981),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          _buildOptimizationAlert(
            text: 'Restock alert: ',
            highlight: 'Section 204',
            tail: ' mobile\nconcessions experiencing high demand.',
            tailHighlight: '',
            highlightColor: const Color(0xFF3b82f6),
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

  Widget _buildOptimizationAlert({
    required String text,
    required String highlight,
    required String tail,
    required String tailHighlight,
    required Color highlightColor,
    required Color tailHighlightColor,
  }) {
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

  Widget _buildActiveSectionMonitoring() {
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
          _buildSectionRow(
            indicatorColor: const Color(0xFFef4444),
            title: 'NORTH\nSTAND',
            subtitle: 'Sectors\n101-110',
            occupancy: '94%',
            badgeText: 'CRITICAL',
            badgeColor: const Color(0xFFef4444),
            trendIcon: Icons.trending_up,
            trendColor: const Color(0xFFef4444),
          ),
          const SizedBox(height: AppDimens.spacingMd),
          _buildSectionRow(
            indicatorColor: const Color(0xFF10b981),
            title: 'SOUTH\nPLAZA',
            subtitle: 'Entry Gate\nG',
            occupancy: '28%',
            badgeText: 'OPTIMAL',
            badgeColor: const Color(0xFF10b981),
            trendIcon: Icons.arrow_right_alt,
            trendColor: const Color(0xFF10b981),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionRow({
    required Color indicatorColor,
    required String title,
    required String subtitle,
    required String occupancy,
    required String badgeText,
    required Color badgeColor,
    required IconData trendIcon,
    required Color trendColor,
  }) {
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

  Widget _buildBottomNav(BuildContext context) {
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
        selectedIndex: 1, // CROWD selected
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent, // Like stadium_screen
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
          NavigationDestination(icon: Icon(Icons.fastfood_outlined, color: AppColors.onSurfaceVariant), label: 'ORDERS'),
          NavigationDestination(icon: Icon(Icons.notifications_outlined, color: AppColors.onSurfaceVariant), label: 'ALERTS'),
        ],
      ),
    );
  }
}
