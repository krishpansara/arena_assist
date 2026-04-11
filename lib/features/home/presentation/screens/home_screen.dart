import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/home_header.dart';
import '../widgets/event_hero_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HomeHeader(
                userName: 'Alex',
                userAvatarUrl: '', // Fallback to icon
                onTicketPressed: () => context.push('/add-ticket'),
              ),
              const SizedBox(height: AppDimens.spacingXxl),
              
              Text(
                'Select Mode',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppDimens.spacingLg),
              
              GestureDetector(
                onTap: () => context.push('/stadium'),
                child: const EventHeroCard(isStadiumMode: true),
              ),
              
              const SizedBox(height: AppDimens.spacing3xl),
              
              GestureDetector(
                onTap: () => context.push('/workshop'),
                child: const EventHeroCard(isStadiumMode: false),
              ),
              
              const SizedBox(height: AppDimens.spacingXxl),
            ],
          ),
        ),
      ),
    );
  }
}
