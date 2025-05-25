import 'product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;

  //apply a fixed discount % (like 18%)
  double get discount => 0.18 * totalPrice;

  double get finalPrice => totalPrice - discount;
}
