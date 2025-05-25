import 'package:ecom/components/buttons/app_button.dart';
import 'package:ecom/components/modals/forgot_password_modal.dart';
import 'package:ecom/components/text_fields/app_textfield.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:ecom/core/app_images.dart';
import 'package:ecom/core/app_routes.dart';
import 'package:ecom/screens/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final isDark = Get.isDarkMode;

    final forgotPasswordColor =
        isDark ? AppColors.secondary : AppColors.primary;
    final createAccountColor = isDark ? AppColors.primary : AppColors.secondary;
    final normalTextColor =
        isDark ? AppColors.darkDescriptionText : AppColors.descriptionText;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.logo,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Welcome back! Please sign in to continue.',
                        style: TextStyle(
                          fontSize: AppConstants.medium,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? AppColors.secondary : AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
                      AppTextField(
                        controller: controller.emailController,
                        focusNode: controller.emailFocus,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(controller.passwordFocus);
                        },
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => AppTextField(
                          controller: controller.passwordController,
                          focusNode: controller.passwordFocus,
                          labelText: 'Password',
                          isPassword: !controller.isPasswordVisible.value,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => controller.login(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: controller.isPasswordVisible.value
                                  ? AppColors.primary
                                  : AppColors.iconDark,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => showForgotPasswordModal(context),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: AppConstants.medium,
                              fontWeight: FontWeight.w500,
                              color: forgotPasswordColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => AppButton(
                          title: controller.isLoading.value ? '' : 'Login',
                          onPressed: () => controller.isLoading.value
                              ? null
                              : controller.login(),
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
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: normalTextColor,
                              fontSize: AppConstants.medium,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: 'Create account',
                                style: TextStyle(
                                  color: createAccountColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppConstants.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
