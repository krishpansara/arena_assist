import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_header.dart';
import '../widgets/crowd_flow_widgets.dart';

class CrowdFlowScreen extends StatelessWidget {
  const CrowdFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Dark background
      appBar: const AppHeader(
        title: 'Crowd Flow',
        showProfile: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SizedBox(height: AppDimens.spacingLg),
            CrowdFlowTitle(),
            SizedBox(height: AppDimens.spacingLg),
            CrowdFlowStats(),
            SizedBox(height: AppDimens.spacingXxl),
            SpatialDensityCard(),
            SizedBox(height: AppDimens.spacingXxl),
            PredictiveFlowCard(),
            SizedBox(height: AppDimens.spacingXxl),
            // OptimizationCard(),
            // SizedBox(height: AppDimens.spacingXxl),
            ActiveSectionMonitoring(),
            SizedBox(height: 100), // padding
          ],
        ),
      ),
      // bottomNavigationBar: const CrowdFlowBottomNav(),
    );
  }
}
