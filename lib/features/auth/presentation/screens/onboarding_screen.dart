import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/gradient_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  void _onSkip() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Icon(Icons.sports_score, color: AppColors.primary, size: 20),
            const SizedBox(width: AppDimens.spacingSm),
            Text(
              'STADIUM LIVE',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _onSkip,
            child: Text(
              'SKIP',
              style: AppTextStyles.labelMedium.copyWith(
                letterSpacing: 1.2,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppDimens.spacingMd),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildPageContent(
                    title: 'Know the Crowd.',
                    subtitle: 'Live updates on stadium occupancy and flow. Avoid the bottleneck and find the shortest lines for food and exits.',
                    graphics: _buildStep1(),
                  ),
                  _buildPageContent(
                    title: 'Never Miss a Moment.',
                    subtitle: 'Order food straight to your seat, get live replay updates, and stay connected to the game.',
                    graphics: _buildStep2(),
                  ),
                  _buildPageContent(
                    title: 'Find Your Way.',
                    subtitle: 'Navigate the stadium with ease. Get turn-by-turn directions to your seat and facilities.',
                    graphics: _buildStep3(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.spacing3xl),
            // Pagination dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = _currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingSm / 2),
                  width: isActive ? 32 : 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                    boxShadow: isActive ? AppShadows.primaryGlowSmall : [],
                  ),
                );
              }),
            ),
            const SizedBox(height: AppDimens.spacing4xl),
            if (_currentIndex == 2) ...[
              GradientButton(
                text: 'CREATE ACCOUNT',
                onPressed: () => context.push('/register'),
              ),
              const SizedBox(height: AppDimens.spacingMd),
              OutlinedButton(
                onPressed: () => context.push('/login'),
                child: const Text('LOG IN'),
              ),
            ] else ...[
              GradientButton(
                text: 'NEXT',
                onPressed: _onNext,
              ),
            ],
            const SizedBox(height: AppDimens.spacingXl),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({
    required String title,
    required String subtitle,
    required Widget graphics,
  }) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: graphics,
          ),
        ),
        const SizedBox(height: AppDimens.spacingXxl),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.displaySmall.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spacingLg),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background cards imitation
          Transform.rotate(
            angle: -0.1,
            child: _buildMockCard(
              width: 160,
              height: 180,
              alignment: const Alignment(-0.6, -0.4),
              color: const Color(0xFF32242B),
              title: '94%',
              subtitle: 'GATE B FLOW',
              icon: Icons.wifi,
              iconColor: AppColors.error,
            ),
          ),
          Transform.rotate(
            angle: 0.1,
            child: _buildMockCard(
              width: 140,
              height: 100,
              alignment: const Alignment(0.6, -0.2),
              color: AppColors.surfaceContainerHigh,
              title: 'Optimal',
              subtitle: 'CONCOURSE A',
              icon: Icons.map,
              iconColor: AppColors.onSurfaceVariant,
            ),
          ),
          Transform.rotate(
            angle: -0.05,
            child: _buildMockCard(
              width: 200,
              height: 100,
              alignment: const Alignment(0.0, 0.4),
              color: AppColors.surfaceContainer,
              title: 'LIVE DENSITY',
              subtitle: '8:45 PM UPDATE',
              icon: Icons.bar_chart,
              iconColor: AppColors.tertiaryFixed,
              isBottom: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: 0.05,
            child: _buildMockCard(
              width: 180,
              height: 160,
              alignment: const Alignment(0.3, -0.3),
              color: AppColors.surfaceContainerHigh,
              title: 'Ready',
              subtitle: 'YOUR ORDER',
              icon: Icons.fastfood,
              iconColor: AppColors.primary,
            ),
          ),
          Transform.rotate(
            angle: -0.08,
            child: _buildMockCard(
              width: 160,
              height: 120,
              alignment: const Alignment(-0.4, 0.4),
              color: const Color(0xFF2A2B32),
              title: 'Replay',
              subtitle: 'CAM 3 - GOAL',
              icon: Icons.play_circle_fill,
              iconColor: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: -0.05,
            child: _buildMockCard(
              width: 220,
              height: 150,
              alignment: const Alignment(0.0, 0.0),
              color: AppColors.surfaceContainer,
              title: 'Section 124',
              subtitle: 'TURN RIGHT IN 50FT',
              icon: Icons.directions_walk,
              iconColor: AppColors.tertiaryFixed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockCard({
    required double width,
    required double height,
    required Alignment alignment,
    required Color color,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    bool isBottom = false,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(AppDimens.spacingMd),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isBottom ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isBottom) Icon(icon, color: iconColor, size: 20),
            if (!isBottom) const Spacer(),
            Text(title, style: AppTextStyles.headlineSmall.copyWith(fontWeight: FontWeight.bold)),
            Text(subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
