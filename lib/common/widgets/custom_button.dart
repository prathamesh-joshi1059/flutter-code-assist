import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class CustomAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? circularRadius;
  final double? elevation;
  final double? textFontSize;
  final TextStyle? style;

  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.verticalPadding,
    this.horizontalPadding,
    this.circularRadius,
    this.elevation,
    this.textFontSize,
    this.style,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 0.5,
          backgroundColor: backgroundColor ?? ThemeUtility.primaryColor,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding ?? 1.5,
              horizontal: horizontalPadding ?? 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius ?? 8),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.only(
              left: buildWidth(context) * .03,
              right: buildWidth(context) * .03),
          child: TextWidget(text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
              style: style ??
                  TextStyleUtility.interTextStyle(
                      textColor ?? ColorsUtility.white,
                      textFontSize ?? 16,
                      FontWeight.w400,
                      false)),
        ),
      );
}
