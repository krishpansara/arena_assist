import 'package:flutter/material.dart';
import 'package:arena_assist/core/widgets/app_header.dart';
import 'package:arena_assist/features/home/domain/models/event_model.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/refuel_card.dart';
import '../widgets/wait_time_card.dart';
import '../widgets/food_category_chips.dart';
import '../widgets/food_menu_list.dart';
import '../widgets/food_checkout_bar.dart';

class FoodScreen extends StatelessWidget {
  final EventModel? event;

  const FoodScreen({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Ensure dark background
      appBar: AppHeader(
        title: event?.title ?? 'STADIUM LIVE',
        showProfile: true,
        contextIcon: Icons.flag,
        showBackButton: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),

            // padding: const EdgeInsets.all(AppDimens.spacingXl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                const RefuelCard(),
                const SizedBox(height: AppDimens.spacingXl),
                const WaitTimeCard(),
                const SizedBox(height: AppDimens.spacingXl),
                const FoodCategoryChips(),
                const SizedBox(height: AppDimens.spacingXl),
                const FoodMenuList(),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FoodCheckoutBar(event: event),
          ),
        ],
      ),
    );
  }
}
