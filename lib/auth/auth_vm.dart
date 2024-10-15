import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetchickwardrobe/auth/user_model.dart';
import 'package:sweetchickwardrobe/constants/app_user.dart';
import 'package:sweetchickwardrobe/constants/firebase_collections.dart';
import 'package:sweetchickwardrobe/routes/app_routes.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';
import 'package:sweetchickwardrobe/utils/hive.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class AuthVm extends ChangeNotifier {
  Future<void> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // Get the user's ID
      String uid = userCredential.user!.uid;

      // Store additional user data in Firestore
      await FBCollections.users.doc(uid).set({
        'name': name,
        'email': email,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'status': 0,
        'role': 1,
        'id': uid,
      });

      print('User created successfully');
      ZBotToast.showToastSuccess(message: "User created successfully");

      Map map = {"email": email, "password": password, 'id': uid, 'phone': ''};
      await HiveStorage.setHive(map);
      navigatorKey.currentState!.context.go('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ZBotToast.showToastError(title: "Oops!", message: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ZBotToast.showToastError(title: "Oops!", message: "The account already exists for that email");
      } else {
        print('Error: ${e.message}');
        ZBotToast.showToastError(title: "Oops!", message: e.message);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  UserModel? userModel;
  Future<void> signInAndFetchUserData(String email, String password) async {
    try {
      // Sign in the user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      // Get the signed-in user's UID
      String uid = userCredential.user?.uid ?? '';

      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // Check if document exists and create UserModel instance
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        userModel = UserModel.fromJson(data);
        AppUser.data = userModel;

        Map map = {
          "email": email,
          "password": password,
          "id": "$uid",
          'phone': userModel?.phone ?? "",
          'role': userModel?.role,
        };
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': userModel?.name,
          'email': email,
          'created_at': userModel!.createdAt,
          'updated_at': userModel?.updatedAt ?? FieldValue.serverTimestamp(),
          'status': userModel?.status ?? 0,
          'role': userModel?.role ?? 1,
        });
        await HiveStorage.setHive(map);
        log("|||| $map");
        if (userModel?.role == 1) {
          // ZBotToast.showToastSuccess(message: "Customer");
          navigatorKey.currentState!.context.go("/dashboard");
        } else if (userModel?.role == 2) {
          ZBotToast.showToastSuccess(message: "Admin");
          navigatorKey.currentState!.context.go("/admin_dashboard");
        }
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error during sign-in or fetching user data: $e');
      await HiveStorage.deleteHive();
      GlobalFunction.handleFirebaseAuthError(e as Exception);
      return null;
    }
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> logout() async {
    try {
      ZBotToast.loadingShow();
      await _firebaseAuth.signOut().then((value) {
        // userSubscription?.cancel();
        // userSubscription = null;
        return navigatorKey.currentState!.context.go("/login");
      });
      ZBotToast.loadingClose();
    } catch (e) {
      String error = e.toString().split(']').toList().last;
      debugPrintStack();
      ZBotToast.showToastError(message: error);
      ZBotToast.loadingClose();
    }
  }
}
