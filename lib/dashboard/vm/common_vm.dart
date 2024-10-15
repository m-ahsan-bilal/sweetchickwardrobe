import 'package:flutter/material.dart';

class CommonVM extends ChangeNotifier {
  int appSettingsPC = 0;
  int selectedIndex = 0;
  bool fromLogin = false;
  update() {
    notifyListeners();
  }

  CommonVM() {
    // Future.any([
    //   getBusinessContent(0),
    //   getCustomerContent(1),
    // ]);
    // contentData = businessContent;
  }
  int customerNavIndex = 0;
}
