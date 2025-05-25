import 'package:ecom/core/app_colors.dart';
import 'package:ecom/screens/product/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showClearCartDialog(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final controller = Get.find<CartController>();

  Get.dialog(
    Dialog(
      backgroundColor: isDark ? AppColors.darkScaffold : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_rounded,
              size: 48,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 16),
            Text(
              'Clear Your Cart?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.darkHeadingText : AppColors.headingText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'This will remove all items from your shopping cart.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkDescriptionText
                    : AppColors.descriptionText,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isDark ? Colors.white70 : Colors.black54,
                      side: BorderSide(
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      controller.clearCart();
                      Get.back();
                      Get.snackbar(
                        'Cart Cleared',
                        'All items have been removed',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor:
                            isDark ? AppColors.darkScaffold : Colors.white,
                        colorText: isDark ? Colors.white : Colors.black,
                      );
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
