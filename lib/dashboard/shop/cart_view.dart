import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/cart_summary_widget.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/shipping_summary_widget.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((c) async {
      userId = await GlobalFunction.updateAuthToken();
      setState(() {});
    });
  }

  // subtotal
  double get subtotal => context
      .read<BaseVm>()
      .cartItems
      .fold(0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);
  @override
  Widget build(BuildContext context) {
    // Access the cart items from the ViewModel
    final cartItems = context.watch<BaseVm>().cartItems;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GlobalWidgets.buildHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: cartItems.isNotEmpty
                            ? buildCartItemsContainer(context)
                            : buildEmptyCartMessage(context),
                      ),
                      SizedBox(width: 40),
                      Align(
                        alignment: Alignment.topLeft,
                        child: ShippingSummaryWidget(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            GlobalWidgets.buildFooterWidget(context),
          ],
        ),
      ),
    );
  }

  /// Displays a message when the cart is empty.
  Widget buildEmptyCartMessage(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.64,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Your cart is empty!',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          InkWell(
            onTap: () {
              context.go("/shop_view");
            },
            child: const Text(
              'Click Here to Add Items',
              style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the container that holds the cart items and the checkout button.
  Widget buildCartItemsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.sizeOf(context).width * 0.63,
      // Maintain width for cart items container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Column(
              children: [
                buildCartItemsList(context),
                const CartSummaryWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the list of cart items.
  Widget buildCartItemsList(BuildContext context) {
    final cartItems = context.read<BaseVm>().cartItems;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return buildCartItem(item);
      },
    );
  }

  /// Builds a single cart item widget.
  Widget buildCartItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.product.imageUrl?.first ?? '',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Regular',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹ ${item.product.price?.toStringAsFixed(2) ?? '0'}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ],
              ),
            ),
            buildItemQuantityControls(context, item),
            TextButton(
              onPressed: () {
                showRemoveConfirmationDialog(item);
              },
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the quantity control buttons for each cart item.
  Widget buildItemQuantityControls(BuildContext context, CartItem item) {
    final baseVm = context.read<BaseVm>();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (item.quantity > 1) {
                baseVm.updateItemQuantity(item, item.quantity - 1);
              }
            });
          },
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('${item.quantity}'),
        IconButton(
          onPressed: () {
            setState(() {
              if (item.quantity < (item.product.stockQuantity ?? 0)) {
                baseVm.updateItemQuantity(item, item.quantity + 1);
              } else {
                showErrorDialog('Cannot exceed available stock quantity');
              }
            });
          },
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }

  // Widget buildItemQuantityControls(CartItem item) {
  //   return Row(
  //     children: [
  //       IconButton(
  //         onPressed: () {
  //           setState(() {
  //             if (item.quantity > 1) {
  //               item.quantity--;
  //             }
  //           });
  //         },
  //         icon: const Icon(Icons.remove_circle_outline),
  //       ),
  //       Text('${item.quantity}'),
  //       IconButton(
  //         onPressed: () {
  //           setState(() {
  //             if (item.quantity < (item.product.stockQuantity ?? 0)) {
  //               item.quantity++;
  //             } else {
  //               showErrorDialog('Cannot exceed available stock quantity');
  //             }
  //           });
  //         },
  //         icon: const Icon(Icons.add_circle_outline),
  //       ),
  //     ],
  //   );
  // }

  /// Shows a confirmation dialog before removing an item from the cart.
  Future<void> showRemoveConfirmationDialog(CartItem item) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: const Text(
              'Are you sure you want to remove this item from your cart?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Remove'),
              onPressed: () {
                setState(() {
                  context.read<BaseVm>().cartItems.remove(item);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows an error dialog with a custom message.
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
