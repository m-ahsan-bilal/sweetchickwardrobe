import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompleteOrderWidget extends StatelessWidget {
  const CompleteOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Order'),
      // content: const Text('Thank you for your purchase!'),
      actions: [
        TextButton(
          onPressed: () {
            context.go('/cart_view');
            // context.go('/dashboard');
          },
          child: const Text('Back'),
        ),
        TextButton(
          onPressed: () {
            // Navigator.pop(context);
            // context.go('/dashboard');
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Order Completed'),
                  content: const Text('Thank you for your purchase!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        context.go('/dashboard');
                      },
                      child: const Text('Continue Shopping'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
