import 'package:ecom/screens/product/controller/product_controller.dart';
import 'package:ecom/screens/product/controller/cart_controller.dart';
import 'package:get/get.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
