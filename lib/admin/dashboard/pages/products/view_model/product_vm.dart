import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class ProductVM extends ChangeNotifier {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  List<ProductModel> productList = [];

  Future<void> getProducts() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.products.where("status", isNotEqualTo: 2).get();
      productList = q.docs.map<ProductModel>((e) => ProductModel.fromJson(e.data())).toList();
      debugPrint("CategoryModelList" + productList.length.toString());
      notifyListeners();

      ZBotToast.loadingClose();
    } catch (e) {
      debugPrint("e: $e");
      ZBotToast.loadingClose();
    }
  }

  // Future<void> addCategoryToFirestore({
  //   required String imageUrl,
  //   required String categoryName,
  //   required String description,
  // }) async {
  //   final firestore = FirebaseFirestore.instance;
  //   final categoryModel = ProductModel(
  //       // categoryId: null, // We’ll set this after creating the document
  //       // categoryName: categoryName,
  //       // imageUrl: imageUrl,
  //       // description: description,
  //       // createdAt: Timestamp.now(),
  //       // status: 0, // Default status
  //       // updatedAt: Timestamp.now(),
  //       );

  //   try {
  //     // Step 1: Create a document with an auto-generated ID
  //     // final docRef = firestore.collection('categories').doc(); // Create a new document reference with auto-generated ID
  //     // Step 2: Set the data in the document
  //     // await docRef.set({
  //     //   'category_id': docRef.id,
  //     //   'category_name': categoryName,
  //     //   'image_url': imageUrl,
  //     //   'created_at': categoryModel.createdAt,
  //     //   'status': categoryModel.status,
  //     //   'description': description,
  //     //   'updated_at': categoryModel.updatedAt,
  //     // });
  //     // print('Category added successfully with ID: ${docRef.id}');
  //     // ZBotToast.showToastSuccess(message: 'Category added successfully with ID: ${docRef.id}');
  //   } catch (e) {
  //     print('Failed to add category: $e');
  //   }
  // }

  Future<void> addProductToFirestore({
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required String color,
    required List<String> sizes,
    required List<String> imageUrl,
    required int stockQuantity,
    required Discount discount,
    required AdditionalInfo additionalInfo,
    required Rating rating,
    required Shipping shipping,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final productModel = ProductModel(
      status: 0,
      discount: discount,
      description: description,
      categoryId: categoryId,
      sizes: sizes,
      createdAt: Timestamp.now(),
      color: color,
      name: name,
      updatedAt: Timestamp.now(),
      id: null,
      isFeatured: false,
      favorites: false,
      stockQuantity: stockQuantity,
      shareable: true,
      additionalInfo: additionalInfo,
      gender: null,
      rating: rating,
      shipping: shipping,
      price: price,
      imageUrl: imageUrl,
      tags: [],
    );

    try {
      // Create a document with an auto-generated ID
      final docRef = firestore.collection('products').doc();

      // Set the data in the document
      await docRef.set(productModel.toJson()..['id'] = docRef.id);

      print('Product added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  void resetUser() {
    selectedIndex = 0;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
