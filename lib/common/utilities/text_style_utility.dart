import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/font_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class TextStyleUtility {
  const TextStyleUtility._();

  static const interFont = FontConstant.interRegular;

  static interTextStyle(Color? color, double? fontSize, FontWeight fontWeight,
      bool showUnderline) {
    return TextStyle(
      fontFamily: interFont,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: TextOverflow.ellipsis,
      decoration:
          showUnderline ? TextDecoration.underline : TextDecoration.none,
      decorationColor: ColorsUtility.blue,
    );
  }

// static poppinsTextStyle(
//     Color color, double fontSize, FontWeight fontWeight, bool showUnderline) {
//   return TextStyle(
//     fontFamily: poppinsFont,
//     color: color,
//     fontSize: fontSize,
//     fontWeight: fontWeight,
//     overflow: TextOverflow.visible,
//     decoration:
//         showUnderline ? TextDecoration.underline : TextDecoration.none,
//   );
// }
}
