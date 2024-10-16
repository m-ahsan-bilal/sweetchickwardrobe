import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/dashboard/model/additional_info_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/order-model.dart';
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/rating_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/service_card_model.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';

class BaseVm extends ChangeNotifier {
  final List<RatingModel> ratings = [
    RatingModel(
        reviewerName: 'Amar',
        title: 'Amazing collection',
        review: 'They really have trendy designs!',
        rating: 4.0),
    RatingModel(
        reviewerName: 'Rakhi',
        title: 'Timely Response',
        review:
            'The staff is really helpful and they have shown me dresses on video call.',
        rating: 4.0),
    RatingModel(
        reviewerName: 'Divya',
        title: 'Great designs',
        review:
            'I ordered a Brita dress from this brand and the quality is very good.',
        rating: 5.0),
    RatingModel(
        reviewerName: 'Sanya',
        title: 'Good Quality',
        review: 'The fabric is really soft and comfortable.',
        rating: 5.0),
    RatingModel(
        reviewerName: 'Kiran',
        title: 'Love it!',
        review: 'The designs are very unique and beautiful.',
        rating: 4.5),
    RatingModel(
        reviewerName: 'Amit',
        title: 'Highly Recommend',
        review: 'Good product quality and prompt delivery.',
        rating: 4.5),
    RatingModel(
        reviewerName: 'Priya',
        title: 'Great Service',
        review: 'Customer service was very supportive and quick.',
        rating: 4.0),
    RatingModel(
        reviewerName: 'Rohit',
        title: 'Worth the Money',
        review: 'The dresses are worth every penny.',
        rating: 4.5),
    RatingModel(
        reviewerName: 'Simran',
        title: 'Beautiful Collection',
        review: 'I loved the variety in their collection.',
        rating: 5.0),
    RatingModel(
        reviewerName: 'Maya',
        title: 'Amazing Experience',
        review: 'Shopping with them was a seamless experience.',
        rating: 5.0),
  ];

  List<CategoryModel> categories = [];

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      categories = snapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data());
      }).toList();

      print('Category Name: ${categories.length}');
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  List<CartItem> cartItems = [];

  double subtotal = 0.0;

  void calculateSubtotal() {
    subtotal = 0.0;
    for (var item in cartItems) {
      subtotal += (item.product.price ?? 0) * item.quantity;
    }
    notifyListeners();
  }

  void updateItemQuantity(CartItem item, int quantity) {
    item.quantity = quantity;
    calculateSubtotal();
  }

  List<ProductModel> filteredProducts = [];
  List<ProductModel> products = [];
  List<OrderModel> orders = [];

  void filterProductsByCategory(CategoryModel selectedCategory) {
    filteredProducts = products
        .where((product) => product.categoryId == selectedCategory.categoryId)
        .toList();
    debugPrint("filteredProducts.length ${filteredProducts.length}");
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();

      print('Products Name: ${products.length}');
    } catch (e) {
      print('Error fetching Products: $e');
    }
  }

  AdditionalInfoModel? additionalInfoModel;
  Future<bool> getAdditionalInfo(String? userId) async {
    bool done = false;
    log("AppUser.data ${userId}");
    try {
      final collection =
          FirebaseFirestore.instance.collection('additional_info');
      final querySnapshot =
          await collection.where('user_id', isEqualTo: userId).get();

      if (querySnapshot.docs.isNotEmpty) {
        log("message ${querySnapshot.docs.first.data()}");

        DocumentSnapshot document = querySnapshot.docs.first;

        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        additionalInfoModel = AdditionalInfoModel.fromJson(data);
        done = true;
        notifyListeners();
        print("additionalInfoModel: ${additionalInfoModel?.userId}");
        return done;
      } else {
        print("No document found with the specified user_id.");
      }
    } catch (e) {
      print('Error during sign-in or fetching user data: $e');

      GlobalFunction.handleFirebaseAuthError(e as Exception);
      return done;
    }
    return done;
  }

  void update() {
    notifyListeners();
  }

  List<ServiceCard> serviceCards = [];

  AppData? appData;

  Future<void> fetchAppSettings() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firestore.collection('app_settings').doc('0mrNRwmqmOfAgtvGipoC');
    DocumentSnapshot docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        appData = AppData.fromJson(data);
        notifyListeners();
      }
    }
  }
}

IconData getIconData(String iconName) {
  switch (iconName) {
    case 'local_shipping':
      return Icons.local_shipping;
    case 'call':
      return Icons.call;
    case 'chat':
      return Icons.chat;
    case 'card_giftcard':
      return Icons.card_giftcard;
    default:
      return Icons.help;
  }
}
