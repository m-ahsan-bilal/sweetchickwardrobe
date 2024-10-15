import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/common_vm.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

import '../../../../../resources/resources.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
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
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: terms("Terms of use", commonVM),
              ),
              SizedBox(
                height: 400,
              ),
              GlobalWidgets.buildFooterWidget(context),
            ],
          ),
        ),
      );
    });
  }

  Widget terms(String title, CommonVM commonVm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 250),
      child: Container(
        decoration: R.decoration.shadowDecoration(radius: 20),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: R.textStyles.poppins(
                context: context,
                fontSize: 24.0,
                color: R.colors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              context.watch<BaseVm>().appData?.terms ?? "",
              style: R.textStyles.poppins(
                context: context,
                fontSize: 13,
                color: R.colors.secondaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            // HtmlWidget("termsConditions"),
          ],
        ),
      ),
    );
  }
}
