import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class UserInfoWidget extends StatelessWidget {
  final String userNameText;
  final Function() onCreateWorkPressed;
  final bool isUserHasCreateWorkPermitPermission;

  const UserInfoWidget(
      {super.key,
      required this.userNameText,
      required this.isUserHasCreateWorkPermitPermission,
      required this.onCreateWorkPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isUserHasCreateWorkPermitPermission
              ? buildWidth(context) * .44
              : buildWidth(context) * .82,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "Hello, ${userNameText.toString()}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: TextStyleUtility.interTextStyle(
                    ColorsUtility.lightBlack, 17, FontWeight.w500, false),
              ),
              TextWidget(
                ValueString.manageWorkPermitText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: TextStyleUtility.interTextStyle(
                    ColorsUtility.lightBlack, 14, FontWeight.w400, false),
              )
            ],
          ),
        ),
        SizedBox(width: buildWidth(context) * .02),
        isUserHasCreateWorkPermitPermission
            ? CustomAppButton(
                key: const Key(WidgetKeys.createWorkPermitBtnKey),
                text: ValueString.createWorkPermitBtnText,
                backgroundColor: ColorsUtility.purpleColor,
                textFontSize: 15,
                verticalPadding: 10,
                circularRadius: 8,
                onPressed: () => onCreateWorkPressed(),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
