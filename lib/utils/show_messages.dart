import 'package:fluttertoast/fluttertoast.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class ShowMessage {
  static void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg, fontSize: 16, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER);
  }

  static void ofJson(var jsonResponse) {
    Fluttertoast.showToast(
        msg: jsonResponse['ShortMessage'],
        fontSize: 16,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  static void inDialog(String message, bool isError) {
    ZBotToast.showToastError(message: message, title: "Data Not Retrieve");
  }
}
