import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/common_vm.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

import '../../../../../resources/resources.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  FocusNode titleFocus = FocusNode();
  FocusNode messageFocus = FocusNode();
  TextEditingController messageController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<BaseVm>().fetchAppSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonVM>(builder: (context, commonVM, _) {
      return Scaffold(
        backgroundColor: R.colors.mistyWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              GlobalWidgets.buildHeader(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 250),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: terms("Contact Us", commonVM),
                ),
              ),
              GlobalWidgets.buildFooterWidget(context),
            ],
          ),
        ),
      );
    });
  }

  Widget terms(String title, CommonVM commonVm) {
    return Container(
      decoration: R.decoration.shadowDecoration(radius: 20),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: R.textStyles.poppins(
                context: context,
                fontSize: 24.0,
                color: R.colors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Text("Title"),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: titleController,
            focusNode: titleFocus,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: R.decoration.fieldDecoration(
              context: context,
              hintText: "Title",
            ),
          ),

          h2,

          TextFormField(
              maxLines: 4,
              textInputAction: TextInputAction.next,
              controller: messageController,
              focusNode: messageFocus,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: R.decoration.fieldDecoration(
                context: context,
                hintText: "Message",
              )
              //  onFieldSubmitted: (_) {
              //   // Move focus to the next field
              //   FocusScope.of(context).requestFocus(_focusNode3);
              // },
              ),
          h2,

          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  ZBotToast.loadingShow();
                  // Update user information and get the result
                  Map? mapUser = await GlobalFunction.updateUser();

                  if (mapUser != null) {
                    // Log user information
                    log("email ${mapUser['email']}");
                    log("id ${mapUser['id']}");

                    // Get the actual text from the controllers
                    String titleText = titleController.text.trim();
                    String messageText = messageController.text.trim();

                    if (titleText.isEmpty || messageText.isEmpty) {
                      ZBotToast.showToastError(
                          message: "Title or message cannot be empty.");
                      return;
                    }

                    // Define your Firestore collection and document
                    DocumentReference docRef = FirebaseFirestore.instance
                        .collection('contact_us')
                        .doc();
                    String docId = docRef.id;

                    // Set the actual text values from the controllers
                    await docRef.set({
                      'id': docId,
                      'user_id': mapUser['id'],
                      'email': mapUser['email'],
                      'title':
                          titleText, // passing the text get from controllers
                      'message':
                          messageText, // passing the text get from controllers
                    });

                    // Log success message
                    ZBotToast.showToastSuccess(
                        message: "Your message has been sent successfully.");
                  } else {
                    log("No user data received.");
                  }
                } catch (e) {
                  // Log any errors that occur
                  log("Error: $e");
                }
                ZBotToast.loadingClose();
              },
              child: Text("Send Message"),
            ),
          ),
          SizedBox(
            height: 270,
          ),
        ],
      ),
    );
  }
}
