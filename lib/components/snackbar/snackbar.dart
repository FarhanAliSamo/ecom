import 'package:ecom/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarMessage {
  missing,
  error,
  success,
  info,
}

void showSnackbar(SnackbarMessage messageType, String msg,
    {Color textColor = AppColors.white}) {
  Get.snackbar(
    messageType == SnackbarMessage.error
        ? 'Error'
        : messageType == SnackbarMessage.success
            ? 'Success'
            : messageType == SnackbarMessage.missing
                ? 'Alert!'
                : 'Info',
    msg,
    backgroundColor: messageType == SnackbarMessage.error
        ? AppColors.error
        : messageType == SnackbarMessage.success
            ? AppColors.primary
            : messageType == SnackbarMessage.missing
                ? AppColors.warning
                : AppColors.info,
    colorText: textColor,
    isDismissible: true,
    duration: const Duration(seconds: 2),
    dismissDirection: DismissDirection.horizontal,
  );
}
