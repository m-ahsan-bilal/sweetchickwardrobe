import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class SettingsVM extends ChangeNotifier {
  Future<void> changePassword(String oldPass, String newPass) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
    } else {
      AuthCredential cred = EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser?.email ?? "", password: oldPass);
      UserCredential uCred = await user.reauthenticateWithCredential(cred).catchError((error) {
        debugPrint(error.toString());
        var er = error.toString();
        if (er.contains("wrong-password")) {
          ZBotToast.showToastError(message: "please_provide_valid_password");
        }
      });
      if (uCred.user?.email != null) {
        try {
          await user.updatePassword(newPass);
          ZBotToast.showToastSuccess(message: "password_changed_successfully");
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  void update() {
    notifyListeners();
  }
}
