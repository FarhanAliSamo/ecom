import 'package:ecom/components/cards/product_card.dart';
import 'package:ecom/components/modals/confirmation_modal.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:ecom/core/app_routes.dart';
import 'package:ecom/screens/product/controller/cart_controller.dart';
import 'package:ecom/screens/product/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => showLogoutConfirmation(context),
            ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value && controller.products.isEmpty) {
            // Show loading on first load
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          }

          if (controller.products.isEmpty) {
            // No products found
            return const Center(child: Text('No products found.'));
          }

          return RefreshIndicator(
            onRefresh: () => controller.getProducts(reset: true),
            color: AppColors.primary,
            child: ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: controller.products.length +
                  (controller.isPageEnd.value ? 0 : 1),
              itemBuilder: (context, index) {
                if (index < controller.products.length) {
                  final product = controller.products[index];
                  return ProductCard(
                    price: product.price,
                    imageUrl: product.imageUrl,
                    title: product.title,
                    description: product.description,
                    onAddToCart: () {
                      cartController.addToCart(product);
                      Get.toNamed(AppRoutes.cart, parameters: {
                        AppConstants.argProductID: product.id,
                      });
                    },
                  );
                } else {
                  return !controller.isPageEnd.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ))
                      : const SizedBox.shrink();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
