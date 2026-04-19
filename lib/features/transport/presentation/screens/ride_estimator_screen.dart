import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/models/transport_models.dart';
import '../providers/transport_providers.dart';

class RideEstimatorScreen extends ConsumerStatefulWidget {
  final String defaultDestination;

  const RideEstimatorScreen({
    super.key,
    this.defaultDestination = '',
  });

  @override
  ConsumerState<RideEstimatorScreen> createState() => _RideEstimatorScreenState();
}

class _RideEstimatorScreenState extends ConsumerState<RideEstimatorScreen> {
  late TextEditingController _sourceController;
  late TextEditingController _destinationController;

  @override
  void initState() {
    super.initState();
    _sourceController = TextEditingController(text: 'Use Current Location');
    _destinationController = TextEditingController(text: widget.defaultDestination);
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rideEstimatorProvider(widget.defaultDestination));
    final notifier = ref.read(rideEstimatorProvider(widget.defaultDestination).notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Ride Estimator',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: AppColors.surfaceContainerHighest,
              radius: 16,
              child: const Icon(Icons.person, size: 20, color: AppColors.onSurfaceVariant),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spacingXl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Plan Your Ride',
                style: AppTextStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppDimens.spacingXs),
              Text(
                'Compare ride prices instantly',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDimens.spacingXxl),

              // Inputs Card
              AppCard(
                padding: const EdgeInsets.all(AppDimens.spacingLg),
                backgroundColor: AppColors.surfaceContainer,
                child: Column(
                  children: [
                    _buildInputRow(
                      icon: Icons.location_on,
                      iconColor: AppColors.primary,
                      controller: _sourceController,
                      hint: 'Pickup Location',
                      onChanged: notifier.updateSource,
                    ),
                    
                    // Current Location helper
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.my_location, size: 16, color: AppColors.primary),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              _sourceController.text = 'Use Current Location';
                              notifier.updateSource('Use Current Location');
                            },
                            child: Text(
                              'Use Current Location',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Connection Line
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 19.0),
                        child: Container(
                          height: 24,
                          width: 2,
                          color: AppColors.outlineVariant.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildInputRow(
                      icon: Icons.flag,
                      iconColor: AppColors.tertiary,
                      controller: _destinationController,
                      hint: 'Drop Location',
                      onChanged: notifier.updateDestination,
                    ),
                    
                    const SizedBox(height: AppDimens.spacingXl),

                    // Estimate Button
                    GestureDetector(
                      onTap: state.isLoading ? null : () => notifier.estimateFare(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingLg),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.tertiary],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                        ),
                        child: Center(
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 20, 
                                  height: 20, 
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                                )
                              : Text(
                                  'ESTIMATE FARE',
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (state.error != null) ...[
                const SizedBox(height: AppDimens.spacingLg),
                Text(
                  state.error!,
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                ),
              ],

              if (state.result != null && !state.isLoading) ...[
                const SizedBox(height: AppDimens.spacingXxl),
                Text(
                  'Available Services',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppDimens.spacingLg),
                
                ...state.result!.rides.map((ride) => _buildRideCard(ride)),
                
                const SizedBox(height: AppDimens.spacingXxl),
                Center(
                  child: Text(
                    'PRICES ARE ESTIMATED BASED ON DISTANCE\nAND MAY VARY.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputRow({
    required IconData icon,
    required Color iconColor,
    required TextEditingController controller,
    required String hint,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.bodyLarge.copyWith(color: AppColors.onSurfaceVariant),
          prefixIcon: Icon(icon, color: iconColor),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, size: 18),
            color: AppColors.onSurfaceVariant,
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildRideCard(RideOption ride) {
    final bool isCheapest = ride.tag == 'CHEAPEST';
    final bool isFastest = ride.tag == 'FASTEST';
    final tagColor = isCheapest ? Colors.cyanAccent : (isFastest ? Colors.blueAccent : Colors.transparent);
    
    // Provide subtitle labels
    String typeLabel = '';
    if (ride.provider == 'Uber') typeLabel = 'UberGo';
    if (ride.provider == 'Ola') typeLabel = 'Mini';
    if (ride.provider == 'Rapido') typeLabel = 'Bike';

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.spacingLg),
          child: AppCard(
            backgroundColor: AppColors.surfaceContainerHigh,
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            child: Row(
              children: [
                // Mock Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      ride.provider[0],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.spacingLg),
                
                // Provider Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ride.provider,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${ride.eta} mins away',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Price Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${ride.price.round()}',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: (isCheapest) ? Colors.cyanAccent : AppColors.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      typeLabel,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Tag Badge Layout
        if (ride.tag.isNotEmpty)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppDimens.radiusXl),
                  bottomLeft: Radius.circular(AppDimens.radiusMd),
                ),
              ),
              child: Text(
                ride.tag,
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
