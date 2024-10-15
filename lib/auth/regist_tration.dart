import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/auth/auth_vm.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/resources/validator.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  TextEditingController nameTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    return Scaffold(

      body: Center(
        child: Container(
          width: width * 0.7,
          // 800,
          height: height * .8,
          // 600,
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              // Left Panel: Illustration and Text
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: R.colors.themePink,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(R.images.logoTransparent, height: 150),
                        // 150),
                        // SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                              text: 'Join  ',
                              style: TextStyle(fontSize: 14),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: 'Sweet Chick Wardrobe',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                TextSpan(
                                  text: ' to get exclusive offers',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )
                              ]),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              // Right Panel: Registration Form
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Register Here",
                            style: R.textStyles.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              context: context,
                            ),
                          ),
                        ),
                        h2,
                        TextFormField(
                          controller: nameTC,
                          focusNode: nameFocus,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: R.decoration.fieldDecoration(
                            context: context,
                            hintText: "Full name",
                          ),
                          validator: FieldValidator.validateName,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(emailFocus);

                            setState(() {});
                          },
                        ),
                        h2,
                        TextFormField(
                          controller: emailTC,
                          focusNode: emailFocus,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: R.decoration.fieldDecoration(
                            context: context,
                            hintText: "Email",
                          ),
                          validator: FieldValidator.validateEmail,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordFocus);

                            setState(() {});
                          },
                        ),
                        h2,
                        TextFormField(
                          controller: passwordTC,
                          obscureText: obscurePassword,
                          focusNode: passwordFocus,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: R.decoration.fieldDecoration(
                            context: context,
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              child: Icon(obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                          validator: FieldValidator.validatePassword,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(confirmPasswordFocus);

                            setState(() {});
                          },
                        ),
                        h2,
                        TextFormField(
                          obscureText: obscureConfirmPassword,
                          focusNode: confirmPasswordFocus,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) => FieldValidator.validateOldPassword(
                            v,
                            passwordTC.text.trim(),
                          ),
                          decoration: R.decoration.fieldDecoration(
                              context: context,
                              hintText: "Confirm Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                  });
                                },
                                child: Icon(obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              )),
                          onFieldSubmitted: (value) async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            setState(() {});
                            await register();
                          },
                        ),
                        h2,
                        SizedBox(
                          width: 100.w,
                          child: AppButton(
                            onTap: () async {
                              await register();
                            },
                            buttonTitle: "Register",
                          ),
                        ),
                        h2,
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?",
                                  style: TextStyle(fontSize: 12)),
                              TextButton(
                                  onPressed: () {
                                    context.go('/login');
                                  },
                                  child: Text(
                                    "Login Here",
                                    style: TextStyle(
                                      color: R.colors.themePink,
                                      fontSize: 14,
                                    ),
                                  ))
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

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      ZBotToast.loadingShow();
      await context.read<AuthVm>().createUser(
            name: nameTC.text.trim(),
            email: emailTC.text.trim(),
            password: passwordTC.text.trim(),
          );
      ZBotToast.loadingClose();
    }
  }
}
