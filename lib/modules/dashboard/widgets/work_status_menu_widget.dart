import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/login/model/work_status_menu_model.dart';

class WorkStatusMenuWidget extends StatelessWidget {
  final Function(String) onTap;
  final WorkStatusMenuModel workStatusData;

  const WorkStatusMenuWidget(
      {super.key, required this.workStatusData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(workStatusData.workTitleName.toString()),
      child: SizedBox(
        width: 43.w,
        child: Card(
          color: workStatusData.backColor,
          elevation: 1.2,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          // decoration: BoxDecoration(
          //     color: workStatusData.backColor,
          //     border: Border.all(color: ColorsUtility.lightGrey, width: 0.1),
          //     borderRadius: BorderRadius.circular(6)),
          // width: 43.w,
          // alignment: Alignment.centerLeft,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                right: 0,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: workStatusData.countBackColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(4))),
                  child: TextWidget(workStatusData.workCount.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyleUtility.interTextStyle(
                          ColorsUtility.lightBlack, 19, FontWeight.w500, false),
                      softWrap: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          workStatusData.iconUrl.toString(),
                          // fit: BoxFit.scaleDown,
                          width: buildWidth(context) * .07,
                          height: buildWidth(context) * .07,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.w),
                    TextWidget(workStatusData.workTitleName.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.lightBlack,
                            16,
                            FontWeight.w500,
                            false),
                        softWrap: true)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
