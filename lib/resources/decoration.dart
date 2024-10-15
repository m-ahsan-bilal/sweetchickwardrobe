import 'package:flutter/material.dart';

import 'resources.dart';

class AppDecoration {
  BoxDecoration shadowDecoration({double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 20),
      color: R.colors.white,
      boxShadow: [
        BoxShadow(
          color: R.colors.shadowColor.withOpacity(0.16),
          offset: const Offset(0, 9),
          blurRadius: 25,
        ),
      ],
    );
  }

  BoxDecoration borderDecoration({double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: R.colors.white,
      boxShadow: [
        BoxShadow(
          color: R.colors.textMediumGrey.withOpacity(.75),
          offset: const Offset(2, 2),
          spreadRadius: 2,
          blurRadius: 10,
        ),
        BoxShadow(
          color: R.colors.textMediumGrey.withOpacity(.75),
          offset: const Offset(-2, -2),
          spreadRadius: 2,
          blurRadius: 10,
        )
      ],
    );
  }

  BoxDecoration dialogDecoration({double? radius}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 10),
      color: R.colors.white,
    );
  }

  InputDecoration fieldDecoration({
    required BuildContext context,
    Widget? preIcon,
    required String hintText,
    Widget? suffixIcon,
    double? radius,
    double? iconMinWidth,
    Color? fillColor,
    bool? isNotLocalized,
    // String? labelText, required Null Function() onFieldSubmitted,
  }) {
    return InputDecoration(
      prefixIconConstraints: BoxConstraints(
        minWidth: iconMinWidth ?? 42,
      ),
      fillColor: fillColor ?? R.colors.mistyWhite,
      hintText: (isNotLocalized ?? false) ? hintText : hintText,
      hoverColor: R.colors.primaryColor.withOpacity(.03),
      prefixIcon: preIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      suffixIcon: suffixIcon != null ? Container(child: suffixIcon) : null,
      hintStyle: R.textStyles.poppins(
          context: context,
          color: R.colors.textMediumGrey.withOpacity(.6),
          fontSize: 13,
          fontWeight: FontWeight.w400),
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.textMediumGrey.withOpacity(.5)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.textMediumGrey.withOpacity(.5)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      filled: true,
    );
  }
}
