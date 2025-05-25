import 'package:ecom/components/snackbar/snackbar.dart';
import 'package:ecom/core/app_routes.dart';
import 'package:ecom/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnackbar(SnackbarMessage.missing, 'Please fill in all fields');
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      showSnackbar(
          SnackbarMessage.missing, 'Please enter a valid email address');
      return;
    }

    if (password != confirmPassword) {
      showSnackbar(SnackbarMessage.missing, 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;
      await _authService.signUpWithEmail(email: email, password: password);
      showSnackbar(SnackbarMessage.success, 'Account created successfully');
      emailController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.productList);
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMsg;
      switch (e.code) {
        case 'email-already-in-use':
          errorMsg = 'This email is already registered.';
          break;
        case 'invalid-email':
          errorMsg = 'Invalid email format.';
          break;
        case 'weak-password':
          errorMsg = 'Password is too weak.';
          break;
        case 'operation-not-allowed':
          errorMsg = 'Email sign-up is currently disabled.';
          break;
        default:
          errorMsg = 'Signup failed. Please try again later.';
      }
      showSnackbar(SnackbarMessage.error, errorMsg);
    } catch (e) {
      isLoading.value = false;
      e.printError(info: 'Something went wrong. Please try later.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.onClose();
  }
}
