import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/date_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class WorkDetailsWidget extends StatelessWidget {
  final Map workDetailsByType;
  final Function(String) onTap;

  const WorkDetailsWidget(
      {super.key, required this.onTap, required this.workDetailsByType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(''),
      child: Card(
        color: ColorsUtility.white,
        elevation: 1.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding:
              EdgeInsets.only(left: 4.w, right: 4.w, top: 3.w, bottom: 3.w),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  child: SvgPicture.asset(
                    AssetsConstant.forwardIcon,
                    width: 7.w,
                    height: 7.w,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      LabelWithTextWidget(
                        labelText: ValueString.projectText,
                        width: buildWidth(context) * .35,
                        titleText: workDetailsByType['isLoading']
                            ? ''
                            : workDetailsByType['projectName'].toString(),
                      ),
                      SizedBox(height: 1.w),
                      LabelWithTextWidget(
                        labelText: ValueString.workPermitTypeText,
                        width: buildWidth(context) * .35,
                        titleText: workDetailsByType['isLoading']
                            ? ''
                            : workDetailsByType['workPermitTypeName']
                                .toString(),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.w),
                  LabelWithTextWidget(
                      labelText: ValueString.startDateText,
                      titleText: workDetailsByType['isLoading']
                          ? ''
                          : DateUtility.formatDate(
                              workDetailsByType['workDateTimeDetails']
                                      ['startDate']
                                  .toString())),
                  SizedBox(height: 1.w),
                  LabelWithTextWidget(
                      labelText: ValueString.endDateText,
                      titleText: workDetailsByType['isLoading']
                          ? ''
                          : DateUtility.formatDate(
                              workDetailsByType['workDateTimeDetails']
                                      ['endDate']
                                  .toString()))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
