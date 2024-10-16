import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sweetchickwardrobe/dashboard/model/order-model.dart'; // For formatting date

class OrderDialog extends StatelessWidget {
  final OrderModel order;

  const OrderDialog({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Order Details'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Order ID', order.orderId),
            _buildDetailRow('Tracking Number', order.trackingNumber),
            _buildDetailRow('Payment Status', order.paymentStatus),
            if (order.paymentMethod != null) ...[
              _buildDetailRow('Payment Method', order.paymentMethod?.type),
              _buildDetailRow(
                  'Card Holder Name', order.paymentMethod?.cardHolderName),
              _buildDetailRow('Expiry Date', order.paymentMethod?.expiryDate),
            ],
            _buildDetailRow('Tax Amount', _formatCurrency(order.taxAmount)),
            _buildDetailRow('Total Amount', _formatCurrency(order.totalAmount)),
            _buildDetailRow('Subtotal', _formatCurrency(order.subtotal)),
            _buildDetailRow('Delivery Status', order.deliveryStatus),
            if (order.deliveryAddress != null) ...[
              _buildDetailRow('City', order.deliveryAddress?.city),
              _buildDetailRow('Country', order.deliveryAddress?.country),
              _buildDetailRow('Postal Code', order.deliveryAddress?.postalCode),
              _buildDetailRow(
                  'Address Line 1', order.deliveryAddress?.addressLine1),
              _buildDetailRow(
                  'Address Line 2', order.deliveryAddress?.addressLine2),
              _buildDetailRow('State', order.deliveryAddress?.state),
            ],
            _buildDetailRow('Order Status', order.orderStatus),
            _buildDetailRow(
                'Discount Amount', _formatCurrency(order.discountAmount)),
            if (order.orderDate != null)
              _buildDetailRow('Order Date', _formatDate(order.orderDate)),
            _buildItemsList(order.items ?? []), // For displaying order items
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  // Helper method to build each row in the dialog
  Widget _buildDetailRow(String title, String? value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  // Helper method to format currency
  String _formatCurrency(double? amount) {
    if (amount == null) return '';
    final formatter = NumberFormat.simpleCurrency();
    return formatter.format(amount);
  }

  // Helper method to format date
  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return '';
    final date = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Helper method to display order items
  Widget _buildItemsList(List<OrderItem> items) {
    if (items.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Order Items:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Product Name', item.productName),
                _buildDetailRow('Quantity', item.quantity?.toString()),
                _buildDetailRow(
                    'Total Price', _formatCurrency(item.totalPrice)),
                _buildDetailRow('Size', item.size),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
