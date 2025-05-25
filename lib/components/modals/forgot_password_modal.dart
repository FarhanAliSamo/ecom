import 'package:ecom/components/buttons/app_button.dart';
import 'package:ecom/components/text_fields/app_textfield.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/screens/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showForgotPasswordModal(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final controller = Get.find<LoginController>();

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
              Icons.lock_reset_rounded,
              size: 48,
              color: isDark ? AppColors.secondary : AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.darkHeadingText : AppColors.headingText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter your email to receive a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? AppColors.darkDescriptionText
                    : AppColors.descriptionText,
              ),
            ),
            const SizedBox(height: 24),
            AppTextField(
              controller: controller.resetEmailController,
              focusNode: controller.emailFocus,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => controller.forgotPassword(),
            ),
            const SizedBox(height: 24),
            Obx(
              () => AppButton(
                title: controller.isLoading.value ? '' : 'Send Reset Link',
                onPressed: () => controller.isLoading.value
                    ? null
                    : controller.forgotPassword(),
                suffixIcon: controller.isLoading.value
                    ? const SizedBox(
                        width: 50,
                        height: 12,
                        child: Center(
                          child: SizedBox(
                            height: 20,
                            width: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDark ? AppColors.secondary : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
