import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/models/food_models.dart';
import '../providers/cart_provider.dart';

class FoodMenuList extends ConsumerWidget {
  const FoodMenuList({super.key});

  static final List<FoodItem> _menuItems = [
    FoodItem(
      id: 'burger_1',
      title: 'THE BLITZ DOUBLE BURGER',
      price: 18.00,
      description: 'Double wagyu beef, aged cheddar, caramelized onions, and secret blitz sauce on a toasted brioche bun.',
      badge: '25 MIN WAIT',
    ),
    FoodItem(
      id: 'nachos_1',
      title: 'SUPREME NACHO PILE',
      price: 14.50,
      description: 'Crispy chips, beer cheese, pico de gallo, and fresh jalapeños.',
    ),
    FoodItem(
      id: 'hotdog_1',
      title: 'ARENA CLASSIC DOG',
      price: 9.50,
      description: 'All-beef frank, stadium mustard, kraut on a steamed bun.',
    ),
    FoodItem(
      id: 'ipa_1',
      title: 'HOME TURF IPA',
      price: 12.50,
      description: 'Local craft brew, with citrus notes and a crisp finish.',
    ),
    FoodItem(
      id: 'soda_1',
      title: 'FOUNTAIN SODA',
      price: 6.50,
      description: 'Unlimited self-serve bites. Refillable at any station.',
    ),
    FoodItem(
      id: 'popcorn_1',
      title: 'STADIUM POPCORN',
      price: 8.50,
      description: 'Large tub of buttery, salty movie-style popcorn.',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ..._menuItems.map((item) => _buildItemCard(context, ref, item)),
        _buildRefillBanner(),
        const SizedBox(height: 100), // Padding for the bottom checkout bar
      ],
    );
  }

  Widget _buildItemCard(BuildContext context, WidgetRef ref, FoodItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image Placeholder Area
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Icon(Icons.fastfood_outlined, size: 48, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                  if (item.badge != null)
                    Positioned(
                      top: AppDimens.spacingMd,
                      left: AppDimens.spacingMd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.badge!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: AppDimens.spacingMd,
                    right: AppDimens.spacingMd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '₹${item.price.toStringAsFixed(2)}',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content Area
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppDimens.spacingXs),
                Text(
                  item.description,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: AppDimens.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addItem(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.title} added to order'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: item.badge != null ? const Color(0xFF8B5CF6) : AppColors.surfaceContainerHighest,
                      foregroundColor: item.badge != null ? Colors.white : AppColors.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.badge != null ? Icons.shopping_cart : Icons.add,
                          size: 16,
                          color: item.badge != null ? Colors.white : AppColors.onSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(item.badge != null ? 'ADD TO ORDER' : 'ADD ITEM'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefillBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl, vertical: AppDimens.spacingMd),
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B2E), // Dark purple tint
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'UPGRADE YOUR DRINK',
                style: AppTextStyles.labelSmall.copyWith(
                  color: const Color(0xFF8B5CF6),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'UNLIMITED REFILLS',
            style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppDimens.spacingXs),
          Text(
            'Upgrade any drink to a Souvenir Cup for just ₹4.50 extra.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: AppDimens.spacingLg),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF8B5CF6)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
              child: Text(
                'UPGRADE NOW',
                style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
