import 'package:arena_assist/features/home/domain/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/models/food_models.dart';
import '../providers/cart_provider.dart';
import '../../data/repositories/food_order_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class FoodCheckoutScreen extends ConsumerWidget {
  final EventModel? event;

  const FoodCheckoutScreen({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalAmount = ref.watch(cartTotalAmountProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.radiusXl),
          topRight: Radius.circular(AppDimens.radiusXl),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: AppDimens.spacingMd),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppDimens.spacingLg),
            child: Row(
              children: [
                Text(
                  'YOUR ORDER',
                  style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          if (event != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg),
              child: Row(
                children: [
                   const Icon(Icons.location_on, size: 14, color: Color(0xFF8B5CF6)),
                   const SizedBox(width: 4),
                   Text(
                     event!.title,
                     style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
                   ),
                ],
              ),
            ),

          const Divider(height: AppDimens.spacingXl),

          // Cart Items List
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_basket_outlined, size: 64, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                        const SizedBox(height: AppDimens.spacingMd),
                        Text('Your cart is empty', style: AppTextStyles.bodyLarge),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return _buildCartItemTile(ref, cartItem);
                    },
                  ),
          ),

          // Summary and Place Order
          if (cartItems.isNotEmpty) _buildOrderSummary(context, ref, totalAmount),
        ],
      ),
    );
  }

  Widget _buildCartItemTile(WidgetRef ref, CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.spacingLg, vertical: AppDimens.spacingMd),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: const Icon(Icons.fastfood_outlined),
          ),
          const SizedBox(width: AppDimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.item.title,
                  style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '₹${cartItem.item.price.toStringAsFixed(2)}',
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).updateQuantity(cartItem.item.id, cartItem.quantity - 1);
                },
                icon: const Icon(Icons.remove_circle_outline, size: 20),
              ),
              Text(
                '${cartItem.quantity}',
                style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).updateQuantity(cartItem.item.id, cartItem.quantity + 1);
                },
                icon: const Icon(Icons.add_circle_outline, size: 20, color: Color(0xFF8B5CF6)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, WidgetRef ref, double totalAmount) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        border: Border(top: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.2))),
      ),
      child: SafeArea(
        child: Column(
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Subtotal', style: AppTextStyles.bodyMedium),
                   Text('₹${totalAmount.toStringAsFixed(2)}', style: AppTextStyles.bodyMedium),
                ],
             ),
             const SizedBox(height: AppDimens.spacingXs),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('Tax', style: AppTextStyles.bodyMedium),
                   Text('₹${(totalAmount * 0.05).toStringAsFixed(2)}', style: AppTextStyles.bodyMedium),
                ],
             ),
             const SizedBox(height: AppDimens.spacingMd),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text('TOTAL', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w900)),
                   Text('₹${(totalAmount * 1.05).toStringAsFixed(2)}', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w900, color: const Color(0xFF8B5CF6))),
                ],
             ),
             const SizedBox(height: AppDimens.spacingLg),
             SizedBox(
               width: double.infinity,
               height: 54,
               child: ElevatedButton(
                 onPressed: () => _placeOrder(context, ref),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF8B5CF6),
                   foregroundColor: Colors.white,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusLg)),
                 ),
                 child: Text(
                   'PLACE ORDER',
                   style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }

  Future<void> _placeOrder(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(userDataProvider);
    final user = authState.value;
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to place an order')),
      );
      return;
    }

    final cartItems = ref.read(cartProvider);
    final totalAmount = ref.read(cartTotalAmountProvider) * 1.05;

    final order = OrderModel(
      id: const Uuid().v4(),
      userId: user.id,
      eventId: event?.id,
      items: List.from(cartItems),
      totalAmount: totalAmount,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await ref.read(foodOrderRepositoryProvider).placeOrder(order);
      
      // Close loading
      if (context.mounted) Navigator.pop(context);
      
      // Close checkout sheet
      if (context.mounted) Navigator.pop(context);

      // Show success
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.surfaceContainerHigh,
            title: const Icon(Icons.check_circle, color: Colors.green, size: 64),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Order Placed!', style: AppTextStyles.titleLarge),
                const SizedBox(height: AppDimens.spacingMd),
                Text(
                  'Your order #${order.id.substring(0, 8).toUpperCase()} has been sent to the kitchen.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }

      // Clear cart
      ref.read(cartProvider.notifier).clearCart();
    } catch (e) {
      // Close loading
      if (context.mounted) Navigator.pop(context);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order: $e')),
        );
      }
    }
  }
}
