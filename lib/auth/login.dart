import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/auth/auth_vm.dart';
import 'package:sweetchickwardrobe/auth/forgot_pwd.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/resources/validator.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (kDebugMode) {
      //   // emailTC.text = "pifedam540@kwalah.com";
      //   emailTC.text = "admin@sweetchickwardrobe.com";
      //   passwordTC.text = "12345@aA";
      //   setState(() {});
      // }
    });
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Get screen size dynamically
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          width: width * 0.7, // Adjust container width dynamically
          margin: EdgeInsets.symmetric(vertical: height * 0.03),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: R.colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: R.colors.themePink,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12), // Adjust padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          R.images.logoTransparent,
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02), // Adjust padding
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: width * 0.02, // Dynamic font size
                              fontWeight: FontWeight.bold,
                              color: R.colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02), // Dynamic spacing
                        TextFormField(
                          controller: emailTC,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FieldValidator.validateEmail,
                          decoration: R.decoration.fieldDecoration(
                            context: context,
                            hintText: "Username or Email",
                          ),
                        ),
                        h2,
                        TextFormField(
                          controller: passwordTC,
                          obscureText: _isObscure,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: FieldValidator.validatePassword,
                          decoration: R.decoration.fieldDecoration(
                            context: context,
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.009), // Dynamic spacing
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ForgotPassword();
                                },
                              );
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        h2, // Dynamic spacing

                        SizedBox(
                          width: 100.w,
                          child: AppButton(
                            onTap: () async {
                              await signinTap();
                            },
                            buttonTitle: "Login",
                          ),
                        ),
                        h2, // Dynamic spacing
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "New to wardrobe?",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go('/register');
                                },
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                      color: R.colors.themePink, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signinTap() async {
    log("tapped");
    if (formKey.currentState!.validate()) {
      ZBotToast.loadingShow();
      await context.read<AuthVm>().signInAndFetchUserData(
            emailTC.text.trim(),
            passwordTC.text.trim(),
          );
      ZBotToast.loadingClose();
    }
  }
}
