import 'package:ecom/components/snackbar/snackbar.dart';
import 'package:ecom/core/app_routes.dart';
import 'package:ecom/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final resetEmailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  final FirebaseAuthService _authService = FirebaseAuthService();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    FocusScope.of(Get.context!).unfocus();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Email and password are required');
      return;
    }

    try {
      isLoading.value = true;
      await _authService.loginWithEmail(email: email, password: password);
      showSnackbar(SnackbarMessage.success, 'Login successful');
      emailController.text = '';
      passwordController.text = '';
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.productList);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid email address format.';
          break;
        case 'user-not-found':
          message = 'No user found for this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Try again.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        default:
          message = 'Authentication failed. Please try again.';
      }
      showSnackbar(SnackbarMessage.error, message);
    } catch (e) {
      e.printError(info: e.toString());
      showSnackbar(SnackbarMessage.error, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    final email = resetEmailController.text.trim();

    if (email.isEmpty) {
      showSnackbar(
          SnackbarMessage.error, 'Please enter your email to reset password');
      return;
    }

    try {
      isLoading.value = true;
      await _authService.sendPasswordResetEmail(email: email);
      Get.back();
      showSnackbar(SnackbarMessage.success,
          'Reset link sent to $email. Please check your inbox.');
      resetEmailController.text = '';
    } catch (e) {
      isLoading.value = false;
      e.printError(info: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
