// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetchickwardrobe/admin/dashboard/view/base_view.dart';
import 'package:sweetchickwardrobe/auth/login.dart';
import 'package:sweetchickwardrobe/auth/regist_tration.dart';
import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/category_model.dart';
import 'package:sweetchickwardrobe/dashboard/model/product_model.dart';
import 'package:sweetchickwardrobe/dashboard/settings/about_us.dart';
import 'package:sweetchickwardrobe/dashboard/settings/contact_us.dart';
import 'package:sweetchickwardrobe/dashboard/settings/privacy_policy_view.dart';
import 'package:sweetchickwardrobe/dashboard/settings/terms_view.dart';
import 'package:sweetchickwardrobe/dashboard/settings/user_profile.dart';
import 'package:sweetchickwardrobe/dashboard/shop/cart_view.dart';
import 'package:sweetchickwardrobe/dashboard/shop/check_out_view.dart';
import 'package:sweetchickwardrobe/dashboard/shop/shop_view.dart';
import 'package:sweetchickwardrobe/dashboard/view/dashboard.dart';
import 'package:sweetchickwardrobe/dashboard/view/product_detail.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/complete_order_widget.dart';
import 'package:sweetchickwardrobe/landing/splash.dart';
import 'package:sweetchickwardrobe/resources/resources.dart';
import 'package:sweetchickwardrobe/utils/hive.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter basicRoutes = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: appRoutesList,
  errorBuilder: (context, state) => Center(
      child: Container(
    color: R.colors.white,
    child: Text(
      state.error.toString(),
    ),
  )),
);

List<RouteBase> appRoutesList = [
  GoRoute(
    path: '/',
    name: "splash",
    builder: (BuildContext context, GoRouterState state) => const SplashView(),
  ),
  GoRoute(
    path: '/login',
    name: "login",
    builder: (BuildContext context, GoRouterState state) {
      return const Login();
    },
  ),
  GoRoute(
    path: '/register',
    name: "register",
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterUser();
    },
  ),
  GoRoute(
    path: '/admin_dashboard',
    name: "admin_dashboard",
    redirect: (context, state) async {
      // Map? m = await GlobalFunction.updateUser();
      Map? m = await HiveStorage.getHive();
      log("${m?['role']}");
      if (m != null) {
        if (m['role'] == 2) {
          log("admin_dashboard");
          return '/admin_dashboard';
        } else {
          log("login");

          return '/login';
        }
      }
      return null;
    },
    builder: (BuildContext context, GoRouterState state) {
      return const AdminDashboard();
    },
  ),
  GoRoute(
      path: '/dashboard',
      name: "dashboard",
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardView();
      },
      routes: [
        GoRoute(
          path: 'product_detail',
          name: "product_detail",
          redirect: (context, state) {
            if (state.extra == null)
              return "/shop_view";
            else
              null;
            return null;
          },
          builder: (BuildContext context, GoRouterState state) {
            final product = state.extra as ProductModel;
            return ProductDetailScreen(product: product);
          },
        ),
      ]),
  GoRoute(
    path: '/privacy_policy',
    name: "privacy_policy",
    builder: (BuildContext context, GoRouterState state) {
      return const PrivacyPolicyView();
    },
  ),
  GoRoute(
    path: '/terms_and_conditions',
    name: "terms_and_conditions",
    builder: (BuildContext context, GoRouterState state) {
      return const TermsAndConditions();
    },
  ),
  GoRoute(
    path: '/contact_us',
    name: "contact_us",
    builder: (BuildContext context, GoRouterState state) {
      return const ContactUs();
    },
  ),
  GoRoute(
    path: '/user_profile',
    name: "user_profile",
    builder: (BuildContext context, GoRouterState state) {
      return UserProfileSidebar();
    },
  ),
  GoRoute(
    path: '/shop_view',
    name: "shop_view",
    builder: (BuildContext context, GoRouterState state) {
      final selectedCategory = state.extra as CategoryModel?;
      return ShopView(selectedCategory: selectedCategory);
    },
  ),
  GoRoute(
    path: '/cart_view',
    name: "cart_view",
    builder: (BuildContext context, GoRouterState state) {
      return const CartView();
    },
  ),
  GoRoute(
    path: '/complete_order',
    name: "complete_order",
    builder: (BuildContext context, GoRouterState state) {
      return const CompleteOrderWidget();
    },
  ),
  GoRoute(
    path: '/check_out_view',
    name: "check_out_view",
    redirect: (context, state) {
      if (state.extra == null) {
        return "/cart_view";
      }
      return null;
    },
    builder: (BuildContext context, GoRouterState state) {
      return CheckOutView(cartItems: state.extra as List<CartItem>);
    },
  ),
  //
  GoRoute(
    path: '/about_us',
    name: "about_us",
    builder: (BuildContext context, GoRouterState state) {
      return const AboutUs();
    },
  ),
];
