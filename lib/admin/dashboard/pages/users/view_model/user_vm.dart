import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/auth/user_model.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class UserVM extends ChangeNotifier {
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  List<UserModel> userList = [];

  Future<void> getUsers() async {
    try {
      ZBotToast.loadingShow();
      QuerySnapshot q = await FBCollections.users
          .where("role", isEqualTo: 1)
          .where(
            "status",
            isNotEqualTo: 2,
          )
          .get();
      userList = q.docs.map<UserModel>((e) => UserModel.fromJson(e.data())).toList();
      debugPrint("userlist" + userList.length.toString());
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
