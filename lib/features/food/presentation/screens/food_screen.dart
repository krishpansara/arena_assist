import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../widgets/food_header.dart';
import '../widgets/refuel_card.dart';
import '../widgets/wait_time_card.dart';
import '../widgets/food_category_chips.dart';
import '../widgets/food_menu_list.dart';
import '../widgets/food_checkout_bar.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Ensure dark background
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  FoodHeader(),
                  SizedBox(height: AppDimens.spacingLg),
                  RefuelCard(),
                  SizedBox(height: AppDimens.spacingXl),
                  WaitTimeCard(),
                  SizedBox(height: AppDimens.spacingXl),
                  FoodCategoryChips(),
                  SizedBox(height: AppDimens.spacingXl),
                  FoodMenuList(),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: FoodCheckoutBar(),
            ),
          ],
        ),
      ),
    );
  }
}
