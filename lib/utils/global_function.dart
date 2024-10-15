import 'package:intl/intl.dart';
import 'package:sweetchickwardrobe/constants/enums.dart';
import 'package:sweetchickwardrobe/utils/hive.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class GlobalFunction {
// Function to extract error code and show toast
  static void handleFirebaseAuthError(Exception e) {
    String errorMessage = e.toString();

    // Extract error code using regex
    final RegExp regex = RegExp(r'\[firebase_auth/(.*)\]');
    final Match? match = regex.firstMatch(errorMessage);
    String? errorCode;

    if (match != null && match.groupCount > 0) {
      errorCode = match.group(1);
    }

    // Show the extracted error code in a toast
    if (errorCode != null) {
      ZBotToast.showToastError(title: "Oops!", message: errorCode);
    } else {
      ZBotToast.showToastError(
          title: "Oops!", message: "Unknown error occurred");
    }
  }

  static Future<String?> updateAuthToken() async {
    String? id;
    Map? m = await HiveStorage.getHive();
    if (m != null) {
      print("i am in token condition $m");

      id = m["id"] ?? "";

      print("my hive here ${id}");
    }
    return id;
  }

  static Future<Map?> updateUser() async {
    Map? m = await HiveStorage.getHive();
    if (m != null) {
      print("i am in token condition ");

      print("my hive here ${m['id']}");
    }
    return m;
  }

    static UserStatus getUserStatus({required int selectedIndex}){
    switch(selectedIndex){
      case 1:
        return UserStatus.ACTIVE;
      case 2:
        return UserStatus.BLOCKED;
      default:
        return UserStatus.DELETED;
    }
  }
    static getDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy hh:mm a').format(dateTime);
  }
}
