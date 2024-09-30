import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class ForgotPasswordWidget extends StatelessWidget {
  final String labelText;
  final Function() onTap;

  const ForgotPasswordWidget({
    super.key,
    required this.labelText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onTap(),
            child: TextWidget(
              key: const Key(WidgetKeys.forgotPasswordBtnKey),
              labelText.toString(),
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.slateGray, 16.sp, FontWeight.w400, false),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
