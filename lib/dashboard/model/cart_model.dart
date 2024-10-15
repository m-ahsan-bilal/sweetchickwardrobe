// Cart Item model
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;
  String? selectedSize;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
  });
}
