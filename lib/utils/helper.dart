
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class Helper {
  static String mapApiKey = "AIzaSyAt3PWM8cA4KgTy_itOOzTT1fRoHOl1rhA";

  static focusOut(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void inSnackBar(String title, String message, Color color) {
    ZBotToast.showToastError(title: title, message: message);
  }

  static void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg, fontSize: 12.sp, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM);
  }

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

static List<String> getErrorForBusinessSignup(dynamic map) {
   List<dynamic> error = [];
    Map<String, dynamic> errorObject = map['errors'] ;
    for (String key in errorObject.keys) {
      error.addAll(errorObject[key]);
    }

    return error.map((e) => e.toString()).toList();
  }

  
}
