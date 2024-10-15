// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    initFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: R.colors.themePink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // height: 500,
              child: Image.asset(
                R.images.logoTransparent,
                height: 300,
                // scale: 4,
              ),
            ),
            // h1,
            GlobalWidgets.loaderWidget(),
            // const Text("Loading...")
          ],
        ),
      ),
    );
  }

  void initFn() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 3));
      // Future.delayed(
      //   const Duration(milliseconds: 2000),
      //   () async {
      //     Map? map = await HiveStorage.getHive();
      //     map.toString().debugPrintIfDebug(printColor: R.colors.printRed);
      //     if (map != null) {
      //       map.toString().debugPrintIfDebug(printColor: R.colors.printRed);
      //       Future.delayed(const Duration(microseconds: 1), () {
      //         Map m = {
      //           "password": map['password'],
      //           "email": map['email'],
      //           "fcmToken": AppData.fcmToken ?? "eeee",
      //         };
      //         MainVM.authVm(context).userLogin(m, context, isFromSplash: true);
      //       });
      //     } else {
      //       ProjectFunctions.contextWarning(() async {
      // context.go("/dashboard");
      //
      //
      // ShippingTotalWidget();

      context.go("/login");
      // context.go("/cart_view");

      //         await MainVM.authVm(context).getCompanyCategories();
      //         context.go("/guestCustomerDashboardView");
      //       });
      //     }
      //   },
      // );
    });
  }
}
