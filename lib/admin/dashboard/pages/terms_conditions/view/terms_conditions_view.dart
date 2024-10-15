import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/utils/app_button.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';
import '../../../../../resources/resources.dart';
import 'widgets/add_terms_dialog.dart';

class TermsConditionsView extends StatefulWidget {
  const TermsConditionsView({Key? key}) : super(key: key);

  @override
  TermsConditionsViewState createState() => TermsConditionsViewState();
}

class TermsConditionsViewState extends State<TermsConditionsView> {
  ScrollController sc = ScrollController();
  int termsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: R.colors.transparent,
        body: Column(
          children: [
            topWidget(
              title: "terms_and_condition",
            ),
            Flexible(
              child: Container(
                width: 100.w,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: R.colors.themePink,
                ),
                child: GlobalWidgets.scrollerWidget(
                  context: context,
                  controller: sc,
                  child: ListView(
                    controller: sc,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    children: [
                      HtmlWidget(
                        "Terms & Conditions",
                        textStyle: TextStyle(color: R.colors.offWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget topWidget({required String title}) {
    return Container(
      width: 100.w,
      margin: EdgeInsets.fromLTRB(12, 12, 12, ResponsiveWidget.isLargeScreen(context) ? 12 : 0),
      padding: EdgeInsets.symmetric(vertical: ResponsiveWidget.isLargeScreen(context) ? 22 : 15, horizontal: ResponsiveWidget.isLargeScreen(context) ? 25 : 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: R.colors.themePink,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: R.textStyles.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          AppButton(
              radius: 10,
              textColor: R.colors.white,
              buttonTitle: 'edit',
              fontSize: 15,
              onTap: () {
                Get.dialog(AddTermsDialog(
                  text: "Terms & Conditions",
                  label: "terms_and_condition",
                  isTerms: true,
                ));
              })
        ],
      ),
    );
  }
}
