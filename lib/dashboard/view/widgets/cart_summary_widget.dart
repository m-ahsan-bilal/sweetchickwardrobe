import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';

class CartSummaryWidget extends StatefulWidget {
  const CartSummaryWidget({super.key});

  @override
  State<CartSummaryWidget> createState() => _CartSummaryWidgetState();
}

class _CartSummaryWidgetState extends State<CartSummaryWidget> {
// subtotal
  double get subtotal => context
      .watch<BaseVm>()
      .cartItems
      .fold(0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);
  // double get subtotal => context
  //     .read<BaseVm>()
  //     .cartItems
  //     .fold(0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
