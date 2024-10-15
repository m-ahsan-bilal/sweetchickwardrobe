
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';
import '../../../../../../resources/resources.dart';

class AddTermsDialog extends StatefulWidget {
  final String text;
  final String label;
  final bool isTerms;

  const AddTermsDialog({
    Key? key,
    required this.text,
    required this.label,
    required this.isTerms,
  }) : super(key: key);

  @override
  State<AddTermsDialog> createState() => _AddTermsDialogState();
}

class _AddTermsDialogState extends State<AddTermsDialog> {
  ScrollController sc = ScrollController();
  final QuillEditorController quillController = QuillEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.transparent,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(ResponsiveWidget.isLargeScreen(context) ? 20 : 10),
          padding: EdgeInsets.symmetric(vertical: ResponsiveWidget.isLargeScreen(context) ? 4.sp : 10.sp, horizontal: 7.sp),
          decoration: BoxDecoration(
            color: R.colors.themePink,
            borderRadius: BorderRadius.circular(25),
          ),
          width: ResponsiveWidget.isLargeScreen(context) ? 60.w : 80.w,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: R.textStyles.poppins(fontSize: ResponsiveWidget.isLargeScreen(context) ? 28 : 22, fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: R.colors.offWhite)),
                        child: Icon(
                          Icons.clear,
                          size: 15,
                          color: R.colors.offWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                h3,
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: R.colors.videoBorderColor,
                      )),
                  child: Column(
                    children: [
                      ToolBar(controller: quillController, toolBarColor: R.colors.transparent, activeIconColor: R.colors.themePink, iconColor: R.colors.offWhite),
                      QuillHtmlEditor(
                        controller: quillController,
                        minHeight: 35.h,
                        text: widget.text,
                        backgroundColor: R.colors.transparent,
                        textStyle: TextStyle(color: R.colors.offWhite),
                      ),
                    ],
                  ),
                ),
                h3,
                AppButton(
                  textColor: R.colors.white,
                  buttonTitle: 'save',
                  onTap: () async {
                    String htmlText = await quillController.getText();
                    if (widget.isTerms) {
                      // vm.appDataModel.termsOfUse=vm.htmlText;
                    } else {
                      // vm.appDataModel.privacyPolicy=vm.htmlText;
                    }
                    // await updateContent(widget.isTerms?"terms_of_use": "privacy_policy", vm.htmlText??"",vm);
                                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> updateContent(String id,String text,ContentVM vm)
  // async {
  //   try {
  //     ZBotToast.loadingShow();
  //     await FBCollections.content.doc("app_content").update({id:text});
  //     ZBotToast.loadingClose();
  //     Get.back();
  //     ZBotToast.showToastSuccess(message: widget.isTerms?"You have successfully updated terms of use!":"You have successfully updated privacy policy!");
  //   } on Exception catch (e) {
  //     debugPrintStack();
  //     log(e.toString());
  //     ZBotToast.loadingClose();
  //   }
  // }
}
