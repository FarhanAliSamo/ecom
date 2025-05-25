import 'package:ecom/components/buttons/app_button.dart';
import 'package:ecom/components/cards/wishlist_amount_card.dart';
import 'package:ecom/components/cards/wishlist_card.dart';
import 'package:ecom/components/modals/clear_cart.dart';
import 'package:ecom/components/snackbar/snackbar.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/cart_controller.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wishlist'),
          actions: [
            if (controller.cartItems.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => showClearCartDialog(context),
              ),
          ],
        ),
        body: Obx(() {
          if (controller.cartItems.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your WishList",
                        style: TextStyle(
                          fontSize: AppConstants.large,
                          fontFamily: AppConstants.fontPoppins,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppButton(
                        title: "Add product",
                        onPressed: () => Get.back(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ],
                  ),
                  Expanded(child: Center(child: Text('Wishlist is empty'))),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your WishList",
                      style: TextStyle(
                        fontSize: AppConstants.large,
                        fontFamily: AppConstants.fontPoppins,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppButton(
                      title: "Add product",
                      onPressed: () => Get.back(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cartItems[index];
                        return WishlistCard(
                          item: cartItem,
                          onIncrement: () =>
                              controller.increaseQuantity(cartItem.product),
                          onDecrement: () =>
                              controller.decreaseQuantity(cartItem.product),
                        );
                      },
                    ),
                  ),
                ),
                WishlistAmountCard(
                  discountAmount: controller.totalDiscount,
                  discountAmountTotal: controller.finalTotalPrice,
                  productTotalAmount: controller.totalPrice,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(
                    onPressed: () {
                      showSnackbar(
                        SnackbarMessage.success,
                        'Your cartItems items confirmed!',
                      );
                    },
                    title: 'Confirm',
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
