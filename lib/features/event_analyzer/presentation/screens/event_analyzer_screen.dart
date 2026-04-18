import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:arena_assist/core/theme/theme.dart';
import 'package:arena_assist/features/workshop/presentation/providers/workshop_provider.dart';
import 'package:arena_assist/features/auth/presentation/providers/auth_provider.dart';
import 'package:arena_assist/features/workshop/data/services/event_firestore_service.dart';
import 'package:arena_assist/features/home/presentation/providers/event_provider.dart';
import '../widgets/analyzing_status_card.dart';
import '../widgets/gradient_text.dart';
import '../widgets/recent_insights_card.dart';
import '../widgets/trending_events_section.dart';
import '../widgets/search_input_field.dart';

class EventAnalyzerScreen extends ConsumerStatefulWidget {
  const EventAnalyzerScreen({super.key});

  @override
  ConsumerState<EventAnalyzerScreen> createState() => _EventAnalyzerScreenState();
}

class _EventAnalyzerScreenState extends ConsumerState<EventAnalyzerScreen> {
  bool _isWebsiteType = true;
  bool _isAnalyzing = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _analyzeEvent() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
    });

    try {
      final analyzer = ref.read(analyzerServiceProvider);
      final firestoreService = ref.read(eventFirestoreServiceProvider);
      final userId = ref.read(authStateChangesProvider).valueOrNull?.uid;

      // Perform analysis
      var analyzedEvent = await analyzer.analyzeEvent(input);
      
      if (userId != null) {
        analyzedEvent = analyzedEvent.copyWith(userId: userId);
        // Save to Firestore for personalized access
        await firestoreService.saveEvent(analyzedEvent);
      } else {
        // Fallback for Guest (though routing should ideally prevent this)
        final storage = ref.read(workshopStorageProvider);
        await storage.saveWorkshop(analyzedEvent);
      }
      
      // Refresh providers
      ref.invalidate(analyzedWorkshopsProvider);
      ref.invalidate(allEventsProvider);

      if (mounted) {
        context.pushReplacement('/workshop', extra: analyzedEvent);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: Ensure local AI server is running.$e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.spacingXl),
              _buildAppBar(context),
              const SizedBox(height: AppDimens.spacingXxl),
              GradientText(
                'Unlock the\nEvent Narratives',
                gradient: AppColors.primaryGradient,
                style: AppTextStyles.headlineLarge,
              ),
              const SizedBox(height: AppDimens.spacingMd),
              Text(
                'Let AI dissect your technical schedules, speaker bios, and logistical details.',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppDimens.spacingXxl),
              SearchInputField(
                controller: _controller,
                isWebsite: _isWebsiteType,
                onToggleType: () => setState(() => _isWebsiteType = !_isWebsiteType),
                onAnalyze: _analyzeEvent,
                isLoading: _isAnalyzing,
              ),
              const SizedBox(height: AppDimens.spacingXxl),
              if (_isAnalyzing)
                const AnalyzingStatusCard()
              else ...[
                const RecentInsightsCard(),
                const SizedBox(height: AppDimens.spacingXxl),
                const TrendingEventsSection(),
              ],
              const SizedBox(height: AppDimens.spacingXxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          color: AppColors.onSurface,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'AI Engine Active',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
