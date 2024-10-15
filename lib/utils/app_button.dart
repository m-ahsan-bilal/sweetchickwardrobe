import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class AppButton extends StatefulWidget {
  final String? buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final bool isBorder;
  final bool noGradient;
  final double? fontSize;
  final Widget? buttonWidget;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool? isTextLocalized;

  const AppButton({
    super.key,
    this.buttonTitle,
    required this.onTap,
    this.fontSize,
    this.buttonWidget,
    this.borderColor,
    this.color,
    this.textColor,
    this.width,
    this.letterSpacing,
    this.fontWeight,
    this.isBorder = false,
    this.radius,
    this.verticalPadding,
    this.horizontalPadding,
    this.noGradient = false,
    this.isTextLocalized = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: widget.horizontalPadding == 0
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 0)
            : _scaledPadding(context) /*  EdgeInsets.zero */,
        enabledMouseCursor: SystemMouseCursors.click,
        backgroundColor: widget.color ?? R.colors.themePink,
        shadowColor: R.colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: widget.isBorder
                ? widget.borderColor ?? R.colors.black
                : R.colors.transparent,
          ),
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding ?? 12,
          horizontal: widget.horizontalPadding ?? 20,
        ),
        child: widget.buttonWidget ??
            Text(
              widget.isTextLocalized!
                  ? widget.buttonTitle ?? ''
                  : widget.buttonTitle ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                context: context,
                fontSize: widget.fontSize ?? 12,
                fontWeight: widget.fontWeight ?? FontWeight.w400,
                color: widget.textColor ?? R.colors.white,
                letterSpacing: widget.letterSpacing ?? 0,
              ),
            ),
      ),
    );
  }
}

EdgeInsetsGeometry _scaledPadding(BuildContext context) {
  final bool useMaterial3 = Theme.of(context).useMaterial3;
  final double padding1x = useMaterial3 ? 24.0 : 16.0;
  return ButtonStyleButton.scaledPadding(
    EdgeInsets.symmetric(horizontal: padding1x),
    EdgeInsets.symmetric(horizontal: padding1x / 2),
    EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
    // ignore: deprecated_member_use
    MediaQuery.textScalerOf(context).textScaleFactor,
  );
}

class IconAppButton extends StatefulWidget {
  final String? buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? letterSpacing;
  final FontWeight? fontWeight;
  final bool isBorder;
  final bool onlyIcon;
  final double? fontSize;
  final Widget? buttonWidget;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? iconPadding;
  final IconData? iconData;
  final String? iconImage;

  final double? size;
  final bool? isGradient;

  const IconAppButton({
    super.key,
    this.buttonTitle,
    required this.onTap,
    this.fontSize,
    this.buttonWidget,
    this.borderColor,
    this.color,
    this.textColor,
    this.width,
    this.letterSpacing,
    this.fontWeight,
    this.isBorder = false,
    this.onlyIcon = false,
    this.radius,
    this.verticalPadding,
    this.horizontalPadding,
    this.iconPadding,
    this.iconData,
    this.iconImage,
    this.size,
    this.isGradient,
  });

  @override
  State<IconAppButton> createState() => _IconAppButtonState();
}

class _IconAppButtonState extends State<IconAppButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.onlyIcon) {
      return InkWell(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(widget.iconPadding ?? 5),
          decoration: BoxDecoration(
            color: widget.color ?? R.colors.themePink,
            borderRadius: BorderRadius.circular(widget.radius ?? 5),
          ),
          child: Icon(
            widget.iconData ?? Icons.hourglass_empty_rounded,
            color: widget.textColor ?? R.colors.white,
            size: widget.size,
          ),
        ),
      );
    } else {
      return SizedBox(
        // width: wid100.w ?? 100.w,
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            enabledMouseCursor: SystemMouseCursors.click,
            backgroundColor: widget.color ?? R.colors.transparent,
            shadowColor: R.colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: widget.isBorder
                    ? widget.borderColor ?? R.colors.black
                    : R.colors.transparent,
              ),
              borderRadius: BorderRadius.circular(widget.radius ?? 8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.verticalPadding ?? 12,
              horizontal: widget.horizontalPadding ?? 20,
            ),
            child: widget.buttonWidget ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.iconImage != null)
                      ImageIcon(
                        AssetImage(widget.iconImage ?? ""),
                        color: widget.textColor ?? R.colors.white,
                        size: 16,
                      ),
                    if (widget.iconData != null)
                      Icon(
                        widget.iconData ?? Icons.hourglass_empty_rounded,
                        color: widget.textColor ?? R.colors.white,
                        size: widget.size,
                      ),
                    if (widget.iconImage != null || widget.iconData != null)
                      const SizedBox(width: 12),
                    Text(
                      widget.buttonTitle ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: R.textStyles.poppins(
                        context: context,
                        fontSize: widget.fontSize ?? 14,
                        fontWeight: widget.fontWeight ?? FontWeight.w500,
                        color: widget.textColor ?? R.colors.white,
                        letterSpacing: widget.letterSpacing ?? 0,
                      ),
                    ),
                    if (widget.iconImage != null) const SizedBox()
                  ],
                ),
          ),
        ),
      );
    }
  }
}
