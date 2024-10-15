import 'package:cloud_firestore/cloud_firestore.dart';

class FBCollections {
  static FirebaseFirestore fb = FirebaseFirestore.instance;
  static CollectionReference additional_info = fb.collection("additional_info");
  static CollectionReference categories = fb.collection("categories");
  static CollectionReference orders = fb.collection("orders");
  static CollectionReference products = fb.collection("products");
  static CollectionReference users = fb.collection("users");
  static String adminEmail = 'admin@sweetchick.com';
}
