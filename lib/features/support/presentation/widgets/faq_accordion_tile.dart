import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class FaqAccordionTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isExpandedInitially;

  const FaqAccordionTile({
    super.key,
    required this.title,
    required this.content,
    this.isExpandedInitially = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.spacingMd),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpandedInitially,
          backgroundColor: AppColors.surfaceContainerHigh,
          collapsedBackgroundColor: AppColors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
          collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusMd)),
          tilePadding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: 4.0),
          title: Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.onSurface),
          ),
          iconColor: AppColors.onSurfaceVariant,
          collapsedIconColor: AppColors.onSurfaceVariant,
          childrenPadding: const EdgeInsets.only(
            left: AppDimens.spacingLg,
            right: AppDimens.spacingLg,
            bottom: AppDimens.spacingLg,
          ),
          children: [
            Text(
              content,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
