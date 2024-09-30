import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class LabelWithTextWidget extends StatelessWidget {
  final String labelText;
  final String titleText;
  final double width;
  final TextStyle labelStyle;
  final TextStyle textStyle;

  const LabelWithTextWidget(
      {super.key,
      required this.labelText,
      required this.titleText,
      this.width = 0,
      this.labelStyle = defaultLabelStyle,
      this.textStyle = defaultTextStyle});

  // Default LabelStyle
  static const TextStyle defaultLabelStyle = TextStyle(
    fontSize: 16,
    color: ColorsUtility.gray,
    fontWeight: FontWeight.w400,
  );

  // Default TextStyle
  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 16,
    color: ColorsUtility.lightBlack,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(labelText.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
            style:
                defaultLabelStyle /*TextStyleUtility.interTextStyle(
                ColorsUtility.lightBlack, 15.5, FontWeight.w400, false)*/
            ),
        SizedBox(
            width: width == 0 ? buildWidth(context) * .50 : width,
            child: TextWidget(
              titleText.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style:
                  defaultTextStyle /*?? TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 15.5, FontWeight.w500, false))*/
              ,
            )),
      ],
    );
  }
}
