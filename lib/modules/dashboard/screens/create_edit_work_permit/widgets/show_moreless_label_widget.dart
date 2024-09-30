import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class ShowMoreLessLabelWidget extends StatelessWidget {
  final bool isShowMore;
  final Function() onTap;

  const ShowMoreLessLabelWidget(
      {super.key, required this.isShowMore, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: ColorsUtility.lightGrayThree,
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.only(
            left: 1.2.w, right: 1.2.w, top: 0.5.w, bottom: 0.5.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
                (isShowMore)
                    ? ValueString.showMoreText
                    : ValueString.showLessText,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true),
            SizedBox(width: 2.w),
            SvgImage(
              fit: BoxFit.scaleDown,
              icon: (isShowMore)
                  ? AssetsConstant.arrowDownIcon
                  : AssetsConstant.arrowUpIcon,
            )
          ],
        ),
      ),
    );
  }
}
