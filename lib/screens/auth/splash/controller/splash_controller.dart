import 'package:ecom/core/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (_auth.currentUser != null) {
      // User is logged in
      Get.offAllNamed(AppRoutes.productList);
    } else {
      // User is not logged in
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
