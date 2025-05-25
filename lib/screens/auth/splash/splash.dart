import 'package:ecom/core/app_images.dart';
import 'package:ecom/screens/auth/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SvgPicture.asset(
              AppImages.logo,
              height: 120,
            ),
          ),
        ),
      ),
    );
  }
}
