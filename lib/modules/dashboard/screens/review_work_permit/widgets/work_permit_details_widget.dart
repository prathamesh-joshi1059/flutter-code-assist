import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/date_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class WorkPermitDetailsWidget extends StatefulWidget {
  final Map reviewWorkDetailsList;

  const WorkPermitDetailsWidget(
      {super.key, required this.reviewWorkDetailsList});

  @override
  State<WorkPermitDetailsWidget> createState() =>
      _WorkPermitDetailsWidgetState();
}

class _WorkPermitDetailsWidgetState extends State<WorkPermitDetailsWidget> {
  ValueNotifier<bool> isDropdownOpenNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        color: ColorsUtility.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        title: TextWidget(
          ValueString.workPermitDetailsText,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: TextStyleUtility.interTextStyle(
              ColorsUtility.lightBlack, 16, FontWeight.w400, false),
        ),
        trailing: ValueListenableBuilder(
            valueListenable: isDropdownOpenNotifier,
            builder: (context, child, snapshot) {
              return SizedBox(
                width: 6.w,
                height: 6.w,
                child: SvgPicture.asset(
                    (!isDropdownOpenNotifier.value)
                        ? AssetsConstant.arrowDownIcon
                        : AssetsConstant.arrowUpIcon,
                    colorFilter: const ColorFilter.mode(
                        ColorsUtility.lightBlack, BlendMode.srcIn)),
              );
            }),
        onExpansionChanged: (isExpanded) =>
            isDropdownOpenNotifier.value = isExpanded,
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        tilePadding:
            EdgeInsets.symmetric(horizontal: buildWidth(context) * .05),
        expandedAlignment: Alignment.centerLeft,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: buildWidth(context) * .05,
              right: buildWidth(context) * .05,
            ),
            child: const Divider(color: ColorsUtility.lightBlack),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: buildWidth(context) * .05,
                  right: buildWidth(context) * .05,
                  bottom: buildWidth(context) * .03,
                  top: buildWidth(context) * .03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    ValueString.contractorNameText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                  ),
                  SizedBox(height: buildWidth(context) * .01),
                  TextWidget(
                    widget.reviewWorkDetailsList['contractor'][0]
                        ['contractorName'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 16, FontWeight.w400, false),
                  ),
                  SizedBox(height: buildWidth(context) * .04),
                  TextWidget(
                    ValueString.labourListText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                  ),
                  SizedBox(height: buildWidth(context) * .01),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          widget
                              .reviewWorkDetailsList['contractor'][0]
                                  ['assignedLabours']
                              .length,
                          (index) => TextWidget(
                              widget.reviewWorkDetailsList['contractor'][0]
                                      ['assignedLabours'][index]['name']
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyleUtility.interTextStyle(
                                  ColorsUtility.lightBlack,
                                  16,
                                  FontWeight.w400,
                                  false),
                              softWrap: true))),
                  SizedBox(height: buildWidth(context) * .04),
                  TextWidget(
                    ValueString.workDescriptionText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                  ),
                  SizedBox(height: buildWidth(context) * .01),
                  TextWidget(
                    widget.reviewWorkDetailsList['description'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 16, FontWeight.w400, false),
                  ),
                  SizedBox(height: buildWidth(context) * .04),
                  Row(
                    children: [
                      TextWidget(
                        ValueString.startDateText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.gray, 16, FontWeight.w400, false),
                      ),
                      SizedBox(width: buildWidth(context) * .01),
                      TextWidget(
                        DateUtility.formatDate(widget
                            .reviewWorkDetailsList['startDate']['_seconds']
                            .toString()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.lightBlack,
                            16,
                            FontWeight.w400,
                            false),
                      ),
                    ],
                  ),
                  SizedBox(height: buildWidth(context) * .02),
                  Row(
                    children: [
                      TextWidget(
                        ValueString.endDateText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.gray, 16, FontWeight.w400, false),
                      ),
                      SizedBox(width: buildWidth(context) * .01),
                      TextWidget(
                        DateUtility.formatDate(widget
                            .reviewWorkDetailsList['endDate']['_seconds']
                            .toString()),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.lightBlack,
                            16,
                            FontWeight.w400,
                            false),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
