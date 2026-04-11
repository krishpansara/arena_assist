import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class FoodVendorList extends StatelessWidget {
  final bool isStadiumMode;
  const FoodVendorList({super.key, this.isStadiumMode = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isStadiumMode ? 'Nearby Food' : 'Local Coffee & Bites',
              style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'VIEW ALL',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spacingMd),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildFoodCard(
                name: isStadiumMode ? 'Arena Grill' : 'Dev Coffee',
                waitTime: isStadiumMode ? '5 mins wait' : '2 mins walk',
                isFast: true,
                imagePlaceholderColor: Colors.blueGrey.shade800,
                icon: isStadiumMode ? Icons.fastfood : Icons.coffee,
                // Replace with real image when integrated
              ),
              const SizedBox(width: AppDimens.spacingMd),
              _buildFoodCard(
                name: isStadiumMode ? 'Slice Zone' : 'Tech Bites',
                waitTime: isStadiumMode ? '12 mins wait' : '5 mins walk',
                isFast: false,
                imagePlaceholderColor: Colors.grey.shade400,
                icon: isStadiumMode ? Icons.fastfood : Icons.bakery_dining,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodCard({
    required String name,
    required String waitTime,
    required bool isFast,
    required Color imagePlaceholderColor,
    required IconData icon,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Area
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: imagePlaceholderColor,
            ),
            child: Center(child: Icon(icon, color: Colors.white24, size: 32)),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacingSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                const SizedBox(height: AppDimens.spacingXs),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: isFast ? AppColors.tertiaryFixed : AppColors.warning),
                    const SizedBox(width: 4),
                    Text(
                      waitTime,
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
