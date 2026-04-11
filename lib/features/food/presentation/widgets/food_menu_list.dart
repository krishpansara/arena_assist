import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class FoodMenuList extends StatelessWidget {
  const FoodMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItemCard(
          title: 'THE BLITZ DOUBLE BURGER',
          price: '\$18.00',
          description: 'Double wagyu beef, aged cheddar, caramelized onions, and secret blitz sauce on a toasted brioche bun.',
          badgeText: '25 MIN WAIT',
        ),
        _buildItemCard(
          title: 'SUPREME NACHO PILE',
          price: '\$14.50',
          description: 'Crispy chips, beer cheese, pico de gallo, and fresh jalapeños.',
        ),
        _buildItemCard(
          title: 'ARENA CLASSIC DOG',
          price: '\$9.50',
          description: 'All-beef frank, stadium mustard, kraut on a steamed bun.',
        ),
        _buildRefillBanner(),
        _buildItemCard(
          title: 'HOME TURF IPA',
          price: '\$12.50',
          description: 'Local craft brew, with citrus notes and a crisp finish.',
        ),
        _buildItemCard(
          title: 'FOUNTAIN SODA',
          price: '\$6.50',
          description: 'Unlimited self-serve bites. Refillable at any station.',
        ),
        _buildItemCard(
          title: 'STADIUM POPCORN',
          price: '\$8.50',
          description: 'Large tub of buttery, salty movie-style popcorn.',
        ),
        const SizedBox(height: 100), // Padding for the bottom checkout bar
      ],
    );
  }

  Widget _buildItemCard({
    required String title,
    required String price,
    required String description,
    String? badgeText,
  }) {
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
                  if (badgeText != null)
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
                          badgeText,
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
                        price,
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
                  title,
                  style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppDimens.spacingXs),
                Text(
                  description,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: AppDimens.spacingLg),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: badgeText != null ? const Color(0xFF8B5CF6) : AppColors.surfaceContainerHighest,
                      foregroundColor: badgeText != null ? Colors.white : AppColors.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          badgeText != null ? Icons.shopping_cart : Icons.add,
                          size: 16,
                          color: badgeText != null ? Colors.white : AppColors.onSurface,
                        ),
                        const SizedBox(width: 8),
                        Text(badgeText != null ? 'ADD TO ORDER' : 'ADD ITEM'),
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
            'Upgrade any drink to a Souvenir Cup for just \$4.50 extra.',
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
