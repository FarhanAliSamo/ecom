import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLogoutConfirmation(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: isDark ? AppColors.darkScaffold : AppColors.white,
      title: Text(
        'Logout',
        style: TextStyle(
          color: isDark ? AppColors.darkHeadingText : AppColors.headingText,
        ),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          color: isDark
              ? AppColors.darkDescriptionText
              : AppColors.descriptionText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: isDark ? AppColors.secondary : AppColors.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            await _auth.signOut();
            Get.offAllNamed(AppRoutes.login);
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
