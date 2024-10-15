import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class CategoryVM extends ChangeNotifier {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categoryList = [];

  Future<void> getCategories() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.categories.where("status", isNotEqualTo: 2).get();
      categoryList = q.docs.map<CategoryModel>((e) => CategoryModel.fromJson(e.data())).toList();
      debugPrint("CategoryModelList" + categoryList.length.toString());
      notifyListeners();

      ZBotToast.loadingClose();
    } catch (e) {
      debugPrint("e: $e");
      ZBotToast.loadingClose();
    }
  }

  Future<void> addCategoryToFirestore({
    required String imageUrl,
    required String categoryName,
    required String description,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final categoryModel = CategoryModel(
      categoryId: null, // We’ll set this after creating the document
      categoryName: categoryName,
      imageUrl: imageUrl,
      description: description,
      createdAt: Timestamp.now(),
      status: 0, // Default status
      updatedAt: Timestamp.now(),
    );

    try {
      // Step 1: Create a document with an auto-generated ID
      final docRef = firestore.collection('categories').doc(); // Create a new document reference with auto-generated ID

      // Step 2: Set the data in the document
      await docRef.set({
        'category_id': docRef.id,
        'category_name': categoryName,
        'image_url': imageUrl,
        'created_at': categoryModel.createdAt,
        'status': categoryModel.status,
        'description': description,
        'updated_at': categoryModel.updatedAt,
      });

      print('Category added successfully with ID: ${docRef.id}');
      ZBotToast.showToastSuccess(message: 'Category added successfully with ID: ${docRef.id}');
    } catch (e) {
      print('Failed to add category: $e');
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
