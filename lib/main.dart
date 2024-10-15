// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/categories/view_model/category_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/orders/view_model/order_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/products/view_model/product_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/pages/users/view_model/user_vm.dart';
import 'package:sweetchickwardrobe/admin/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/auth/auth_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/common_vm.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:sizer/sizer.dart';

import 'resources/resources.dart';
import 'routes/app_routes.dart';

final currencyFormat = NumberFormat("#,##0.00", "en_US");
Future<void> main() async {
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  // const firebaseConfig = {
  //   apiKey: "AIzaSyCici-dNaatz0o36BAvnEt5wYEvPRfglfE",
  //   authDomain: "sweetchickwardrobe.firebaseapp.com",
  //   projectId: "sweetchickwardrobe",
  //   storageBucket: "sweetchickwardrobe.appspot.com",
  //   messagingSenderId: "1085202824567",
  //   appId: "1:1085202824567:web:697a7f4a633302a83ab572",
  //   measurementId: "G-2WRD2LHGTT"
  // };

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.openBox('credential');

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCici-dNaatz0o36BAvnEt5wYEvPRfglfE",
        authDomain: "sweetchickwardrobe.firebaseapp.com",
        projectId: "sweetchickwardrobe",
        storageBucket: "sweetchickwardrobe.appspot.com",
        messagingSenderId: "1085202824567",
        appId: "1:1085202824567:web:697a7f4a633302a83ab572",
        measurementId: "G-2WRD2LHGTT"),
  );
  setPathUrlStrategy();
  // await Hive.openBox("credential");

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: R.colors.transparent),
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthVm()),
      ChangeNotifierProvider(create: (context) => BaseVm()),
      ChangeNotifierProvider(create: (context) => CommonVM()),
      ChangeNotifierProvider(create: (context) => AdminBaseVm()),
      ChangeNotifierProvider(create: (context) => UserVM()),
      ChangeNotifierProvider(create: (context) => CategoryVM()),
      ChangeNotifierProvider(create: (context) => OrderVM()),
      ChangeNotifierProvider(create: (context) => ProductVM()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool start = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<BaseVm>().fetchAppSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp.router(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        // theme: ThemeData(primaryColor: R.colors.primaryColor),
        theme: ThemeData(
          // Define your default scaffold background color here
          scaffoldBackgroundColor: R.colors.transparent,

          // Optionally, you can define other theme properties here
          primarySwatch: Colors.blue,

          // Add more theme properties as needed
        ),
        title: "Sweet Chick Wardrobe",
        fallbackLocale: const Locale('en', 'US'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
        ],
        localeResolutionCallback:
            (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        routeInformationParser: basicRoutes.routeInformationParser,
        routeInformationProvider: basicRoutes.routeInformationProvider,
        routerDelegate: basicRoutes.routerDelegate,
      );
    });
  }
}
