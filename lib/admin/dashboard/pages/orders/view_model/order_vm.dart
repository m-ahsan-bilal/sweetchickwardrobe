
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/dashboard/model/order-model.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class OrderVM extends ChangeNotifier {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  List<OrderModel> orderList = [];

  Future<void> getOrders() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.orders.get();
      orderList = q.docs.map<OrderModel>((e) => OrderModel.fromJson(e.data())).toList();
      debugPrint("userlist" + orderList.length.toString());
      notifyListeners();

      ZBotToast.loadingClose();
    } catch (e) {
      debugPrint("e: $e");
      ZBotToast.loadingClose();
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
