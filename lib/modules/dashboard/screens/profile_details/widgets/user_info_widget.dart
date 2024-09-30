import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class UserInfoWidget extends StatelessWidget {
  final String icon;
  final String titleText;
  final String subTitleText;

  const UserInfoWidget(
      {super.key,
      required this.icon,
      required this.titleText,
      required this.subTitleText});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: SvgImage(
            icon: icon,
            iconSize:
                Size(buildWidth(context) * .09, buildWidth(context) * .09),
          ),
        ),
        SizedBox(width: buildWidth(context) * .03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              titleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                ThemeUtility.primaryColor,
                16,
                FontWeight.w400,
                false,
              ),
            ),
            SizedBox(height: buildWidth(context) * .01),
            TextWidget(
              subTitleText,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                ColorsUtility.lightBlack,
                16,
                FontWeight.w500,
                false,
              ),
            ),
            SizedBox(height: buildWidth(context) * .05),
          ],
        )
      ],
    );
  }
}
