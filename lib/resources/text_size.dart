import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/routes/app_routes.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';

class AdaptiveTextSize {
  const AdaptiveTextSize();
  getAdaptiveTextSize(BuildContext? context, dynamic value) {
    if (ResponsiveWidget.isLargeScreen(navigatorKey.currentState!.context)) {
      return value;
    } else if (ResponsiveWidget.isMediumScreen(navigatorKey.currentState!.context)) {
      return value;
    } else {
      return (value / 720) * MediaQuery.of(navigatorKey.currentState!.context).size.height;
    }
  }
}
