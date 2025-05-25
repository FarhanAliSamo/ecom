import 'package:ecom/models/cart_model.dart';
import 'package:ecom/models/product_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      cartItems.add(CartItem(product: product));
    } else {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void increaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        // Remove item if quantity reaches 0
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get totalDiscount =>
      cartItems.fold(0, (sum, item) => sum + item.discount);

  double get finalTotalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.finalPrice);
}
