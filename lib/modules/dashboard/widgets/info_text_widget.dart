import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class InfoTextButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color iconColor;

  const InfoTextButton({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SvgImage(
            icon: icon,
            iconSize: Size(3.w, 3.h),
            iconColor: iconColor,
          ),
        ),
        TextWidget(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: true,
          style: TextStyleUtility.interTextStyle(
            ThemeUtility.primaryColor,
            16,
            FontWeight.w400,
            false,
          ),
        )
      ],
    );
  }
}
