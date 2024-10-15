import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/common_vm.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

import '../../../../../resources/resources.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                padding: const EdgeInsets.symmetric(horizontal: 250),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: terms("About Us", commonVM),
                ),
              ),
              SizedBox(
                height: 500,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GlobalWidgets.buildFooterWidget(context),
              ),
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
            context.watch<BaseVm>().appData?.aboutApp ?? "",
            style: R.textStyles.poppins(
              context: context,
              fontSize: 13,
              color: R.colors.secondaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
