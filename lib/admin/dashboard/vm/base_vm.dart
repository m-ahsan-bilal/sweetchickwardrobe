import 'package:flutter/cupertino.dart';

class AdminBaseVm extends ChangeNotifier {
  int selectedIndex = 0;
  int filterIndex = 0;
  bool isMini = false;
  PageController pageController = PageController(initialPage: 0);

  // gettings the users from firebase the collection is 'users'

  // gettings the orders from firebase the collection is 'orders'

  void update() {
    notifyListeners();
  }
}
