import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class NoDataAvailableWidget extends StatelessWidget {
  final String noDataAvailableText;

  const NoDataAvailableWidget(
      {super.key, this.noDataAvailableText = "No data available."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        noDataAvailableText.toString(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        style: TextStyleUtility.interTextStyle(
            ColorsUtility.lightBlack, 16, FontWeight.w400, false),
      ),
    );
  }
}
