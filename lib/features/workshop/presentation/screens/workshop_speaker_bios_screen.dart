import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';

// ─────────────────────────────────────────────
// Data models
// ─────────────────────────────────────────────
class _Session {
  final String title;
  final String time;
  final String location;
  final String tag;
  const _Session({
    required this.title,
    required this.time,
    required this.location,
    required this.tag,
  });
}

class _Publication {
  final String title;
  final String date;
  final Color accentColor;
  const _Publication({
    required this.title,
    required this.date,
    required this.accentColor,
  });
}

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────
class WorkshopSpeakerBiosScreen extends StatelessWidget {
  const WorkshopSpeakerBiosScreen({super.key});

  // Mock data
  static const List<_Session> _sessions = [
    _Session(
      title: 'Architecting LLM Reasoning in Competitive Environments',
      time: 'Today · 2PM',
      location: 'Audi A',
      tag: 'MAIN STAGE',
    ),
    _Session(
      title: 'The Future of Sports Analytics & Neural Research',
      time: 'Tomorrow',
      location: 'Prof D',
      tag: 'WORKSHOP',
    ),
  ];

  static const List<String> _techStack = [
    'PyTorch',
    'JAX',
    'TensorFlow',
    'CLIP',
    'Kubernetes',
    'Deep Learning',
  ];

  static const List<_Publication> _publications = [
    _Publication(
      title: 'Hyper-Parameter Secret in Massive Parallel Agents',
      date: 'Sep 11, 2024',
      accentColor: AppColors.primary,
    ),
    _Publication(
      title: 'Sparse Attention Inheritance in Vision Transformers',
      date: 'Mar 22, 2024',
      accentColor: AppColors.secondary,
    ),
    _Publication(
      title: 'Vector Databases for Real-Time Arena Simulations',
      date: 'Nov 7, 2023',
      accentColor: AppColors.tertiaryFixed,
    ),
    _Publication(
      title: 'Emergent Collaborative Behaviors in Arena Bots',
      date: 'Aug 3, 2023',
      accentColor: AppColors.warning,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          _SpeakerSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimens.spacingXxl),
                  _buildBio(),
                  const SizedBox(height: AppDimens.spacingXxl),
                  _buildActionButtons(context),
                  const SizedBox(height: AppDimens.spacingXxl),
                  _buildSectionTitle('Upcoming Sessions'),
                  const SizedBox(height: AppDimens.spacingMd),
                  ..._sessions.map(_buildSessionCard),
                  const SizedBox(height: AppDimens.spacingXxl),
                  _buildSectionTitle('Technical Stack'),
                  const SizedBox(height: AppDimens.spacingMd),
                  _buildTechStack(),
                  const SizedBox(height: AppDimens.spacingLg),
                  _buildAvailabilityBadge(),
                  const SizedBox(height: AppDimens.spacingXxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionTitle('Selected Publications'),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppDimens.spacingMd),
                  ..._publications.map(_buildPublicationCard),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Bio ──────────────────────────────────────
  Widget _buildBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dr. Sarah Chen',
          style: AppTextStyles.displaySmall.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Lead AI Researcher at Google Deep Mind',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: AppDimens.spacingMd),
        Text(
          'Sarah Chen is a pioneering researcher focusing on multi-agent reinforcement learning and large language model architectures. At DeepMind, she leads the Arena AI Project, exploring the intersection of cognitive signaling models and generative few-shot networks.\n\nHer work has been featured in Nature, Research, and ICML. This pioneering work is applicable to the next generation of engineers and data scientists.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.7,
          ),
        ),
      ],
    );
  }

  // ── CTA Buttons ──────────────────────────────
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined, size: 18),
            label: const Text(
              'Book Session',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spacingMd),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: AppColors.outlineVariant),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.code, size: 18, color: AppColors.onSurfaceVariant),
            label: Text(
              'Github Profile',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ),
        ),
      ],
    );
  }

  // ── Section Title ─────────────────────────────
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: AppTextStyles.titleMedium.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ── Session Card ──────────────────────────────
  Widget _buildSessionCard(_Session session) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.spacingMd,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                ),
                child: Text(
                  session.tag,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: AppDimens.spacingMd),
          Text(
            session.title,
            style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: AppDimens.spacingSm),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(session.time, style: AppTextStyles.bodySmall),
              const SizedBox(width: AppDimens.spacingLg),
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(session.location, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  // ── Tech Stack ────────────────────────────────
  Widget _buildTechStack() {
    return Wrap(
      spacing: AppDimens.spacingSm,
      runSpacing: AppDimens.spacingSm,
      children: _techStack.map((tech) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacingMd,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.15)),
          ),
          child: Text(
            tech,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Availability Badge ─────────────────────────
  Widget _buildAvailabilityBadge() {
    return Row(
      children: [
        Text(
          'AVAILABILITY',
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(width: AppDimens.spacingMd),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingMd, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.tertiaryFixed.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'ACTIVE IN TALKS',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.tertiaryFixed,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Publication Card ──────────────────────────
  Widget _buildPublicationCard(_Publication pub) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: 42,
            decoration: BoxDecoration(
              color: pub.accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pub.title,
                  style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(pub.date, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Sliver App Bar with Speaker Photo
// ─────────────────────────────────────────────
class _SpeakerSliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.surfaceContainerHigh,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A1B2E),
                    Color(0xFF0A0B10),
                  ],
                ),
              ),
            ),
            // Ambient glow
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Speaker info
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.spacingXl),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Avatar with glowing border
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.surfaceContainerHighest,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: AppColors.surfaceContainerHighest,
                          child: Icon(
                            Icons.person,
                            size: 44,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.spacingLg),
                    // Badges
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeaderBadge('GOOGLE SPEAKER', AppColors.primary),
                        const SizedBox(height: 6),
                        _buildHeaderBadge('AI EXPERT', AppColors.secondary),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
