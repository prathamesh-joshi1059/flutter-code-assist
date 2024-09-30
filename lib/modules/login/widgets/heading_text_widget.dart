import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class HeadingTextWidget extends StatelessWidget {
  final String headingText;
  final String subHeadingText;

  const HeadingTextWidget(
      {super.key, required this.headingText, required this.subHeadingText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(headingText.toString(),
            style: TextStyleUtility.interTextStyle(
                ColorsUtility.lightBlack, 22, FontWeight.w600, false),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true),
        SizedBox(height: 1.w),
        TextWidget(subHeadingText.toString(),
            style: TextStyleUtility.interTextStyle(
                ColorsUtility.lightBlack, 16, FontWeight.w400, false),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            softWrap: true),
      ],
    );
  }
}
