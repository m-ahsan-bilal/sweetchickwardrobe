import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';

import '../../../../../resources/resources.dart';
import '../../../../resources/validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FocusNode emailFocus = FocusNode();

  TextEditingController emailController = TextEditingController();
  final _forgotFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 7.sp),
          decoration: BoxDecoration(
            color: R.colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          width: 30.w,
          child: Form(
            key: _forgotFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: R.colors.black)),
                      child: Icon(
                        Icons.clear,
                        size: 20,
                        color: R.colors.black,
                      ),
                    ),
                  ),
                ),
                Text(
                  'Forgot password',
                  style: R.textStyles.poppins(
                    fontSize: 5.sp,
                    color: R.colors.black,
                    fontWeight: FontWeight.w600,
                    context: context,
                  ),
                ),
                SizedBox(height: 5.sp),
                Text(
                  'Enter your registered email to get change password link',
                  textAlign: TextAlign.center,
                  style: R.textStyles.poppins(
                    fontSize: 3.6.sp,
                    color: R.colors.blueGrey,
                    context: context,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 2.sp, bottom: 1.sp, top: 5.sp),
                  child: Text(
                    'e-mail',
                    style: R.textStyles.poppins(
                        color: R.colors.black,
                        fontWeight: FontWeight.w600,
                        context: context),
                  ),
                ),
                TextFormField(
                  focusNode: emailFocus,
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  validator: FieldValidator.validateEmail,
                  onTap: () {
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  decoration: R.decoration.fieldDecoration(
                    hintText: 'email',
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                  height: 9.sp,
                  width: 15.w,
                  margin: EdgeInsets.symmetric(vertical: 4.sp),
                  child: AppButton(
                      buttonTitle: 'save',
                      onTap: () async {
                        if (_forgotFormKey.currentState!.validate()) {
                          // try{
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text.trim())
                              .then((value) => context.pop());
                          // Get.back();
                        }
                      }
                      // }
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
