// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? trackingNumber;
  String? paymentStatus;
  PaymentMethod? paymentMethod;
  double? taxAmount;
  double? totalAmount;
  List<OrderItem>? items;
  String? orderStatus;
  DeliveryAddress? deliveryAddress;
  double? subtotal;
  String? deliveryStatus;
  String? orderId;
  Timestamp? orderDate;
  double? discountAmount;
  String? userId;

  OrderModel({
    this.trackingNumber,
    this.paymentStatus,
    this.paymentMethod,
    this.taxAmount,
    this.totalAmount,
    this.items,
    this.orderStatus,
    this.deliveryAddress,
    this.subtotal,
    this.deliveryStatus,
    this.orderId,
    this.orderDate,
    this.discountAmount,
    this.userId,
  });

  // fromJson method
  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      trackingNumber: json['tracking_number'],
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'] != null
          ? PaymentMethod.fromJson(json['payment_method'])
          : null,
      taxAmount: (json['tax_amount'] as num?)?.toDouble(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      items: (json['items'] as List?)
          ?.map((item) => OrderItem.fromJson(item))
          .toList(),
      orderStatus: json['order_status'],
      deliveryAddress: json['delivery_address'] != null
          ? DeliveryAddress.fromJson(json['delivery_address'])
          : null,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      deliveryStatus: json['delivery_status'],
      orderId: json['order_id'],
      orderDate: json['order_date'],
      discountAmount: (json['discount_amount'] as num?)?.toDouble(),
      userId: json['user_id'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'tracking_number': trackingNumber,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod?.toJson(),
      'tax_amount': taxAmount,
      'total_amount': totalAmount,
      'items': items?.map((item) => item.toJson()).toList(),
      'order_status': orderStatus,
      'delivery_address': deliveryAddress?.toJson(),
      'subtotal': subtotal,
      'delivery_status': deliveryStatus,
      'order_id': orderId,
      'order_date': orderDate,
      'discount_amount': discountAmount,
      'user_id': userId,
    };
  }
}

class PaymentMethod {
  String? cvv;
  String? cardHolderName;
  String? expiryDate;
  String? type;

  PaymentMethod({this.cvv, this.cardHolderName, this.expiryDate, this.type});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      cvv: json['cvv'],
      cardHolderName: json['Card_holder_name'],
      expiryDate: json['expiry_date'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cvv': cvv,
      'Card_holder_name': cardHolderName,
      'expiry_date': expiryDate,
      'type': type,
    };
  }
}

class OrderItem {
  double? pricePerUnit;
  String? productId;
  double? totalPrice;
  int? quantity;
  String? productName;
  String? size;

  OrderItem({
    this.pricePerUnit,
    this.productId,
    this.totalPrice,
    this.quantity,
    this.productName,
    this.size,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      pricePerUnit: (json['price_per_unit'] as num?)?.toDouble(),
      productId: json['product_id'],
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      quantity: json['quantity'],
      productName: json['product_name'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price_per_unit': pricePerUnit,
      'product_id': productId,
      'total_price': totalPrice,
      'quantity': quantity,
      'product_name': productName,
      'size': size,
    };
  }
}

class DeliveryAddress {
  String? city;
  String? country;
  String? postalCode;
  String? addressLine1;
  String? addressLine2;
  String? state;

  DeliveryAddress({
    this.city,
    this.country,
    this.postalCode,
    this.addressLine1,
    this.addressLine2,
    this.state,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      city: json['city'],
      country: json['country'],
      postalCode: json['postal_code'],
      addressLine1: json['address_line_1'],
      addressLine2: json['address_line_2'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'postal_code': postalCode,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'state': state,
    };
  }
}
