import 'package:ecom/screens/auth/login/binding/login_binding.dart';
import 'package:ecom/screens/auth/login/login.dart';
import 'package:ecom/screens/auth/signup/binding/signup_binding.dart';
import 'package:ecom/screens/auth/signup/signup.dart';
import 'package:ecom/screens/auth/splash/binding/splash_binding.dart';
import 'package:ecom/screens/auth/splash/splash.dart';
import 'package:ecom/screens/product/binding/product_binding.dart';
import 'package:ecom/screens/product/product_list.dart';
import 'package:ecom/screens/product/cart.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/Splash';
  static const login = '/Login';
  static const signup = '/Signup';
  static const productList = '/ProductList';
  static const cart = '/Cart';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => Signup(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => ProductList(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => Cart(),
      binding: ProductBinding(),
    ),
  ];
}
