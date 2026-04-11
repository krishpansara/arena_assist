import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class FoodCategoryChips extends StatefulWidget {
  const FoodCategoryChips({super.key});

  @override
  State<FoodCategoryChips> createState() => _FoodCategoryChipsState();
}

class _FoodCategoryChipsState extends State<FoodCategoryChips> {
  int _selectedIndex = 0;
  final List<String> _categories = ['ALL', 'MEALS', 'SNACKS', 'DRINKS', 'DESSERTS'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingXl),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: AppDimens.spacingSm),
            child: ChoiceChip(
              label: Text(_categories[index]),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              },
              backgroundColor: AppColors.surfaceContainerHigh,
              selectedColor: const Color(0xFF8B5CF6).withOpacity(0.2), // Purple tint
              labelStyle: AppTextStyles.labelMedium.copyWith(
                color: isSelected ? const Color(0xFF8B5CF6) : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF8B5CF6).withOpacity(0.5) : AppColors.outlineVariant.withOpacity(0.1),
                ),
              ),
              showCheckmark: false,
            ),
          );
        }),
      ),
    );
  }
}
