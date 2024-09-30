import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class LabelButtonWidget extends StatelessWidget {
  final String labelText;
  final String btnKey;
  final String btnTitleText;
  final bool isShowButton;
  final Function() onBtnTap;

  const LabelButtonWidget(
      {super.key,
      required this.labelText,
      required this.btnTitleText,
      this.isShowButton = true,
      required this.onBtnTap,
      required this.btnKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextWidget(
          labelText.toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: TextStyleUtility.interTextStyle(
              ColorsUtility.lightBlack, 16, FontWeight.w500, false),
        ),
        if (isShowButton)
          SizedBox(
            width: 28.w,
            child: CustomAppButton(
              key: Key(btnKey.toString()),
              text: btnTitleText.toString(),
              backgroundColor: ColorsUtility.purpleColor,
              textFontSize: 14,
              verticalPadding: 8,
              circularRadius: 8,
              onPressed: () => onBtnTap(),
            ),
          )
      ],
    );
  }
}
