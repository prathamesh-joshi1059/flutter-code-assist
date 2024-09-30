import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/work_permit_type_model.dart';

class WorkTypeCountWidget extends StatelessWidget {
  final List<WorkPermitTypeModel> workTypeCountList;
  final bool isLoading;

  const WorkTypeCountWidget(
      {super.key, required this.workTypeCountList, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(workTypeCountList.length,
          (index) => buildTextWidget(context, workTypeCountList[index])),
    );
  }

  buildTextWidget(BuildContext context, WorkPermitTypeModel workTypeDetails) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isLoading
                  ? ColorsUtility.lightGray
                  : ColorsUtility.transparent),
          child: SizedBox(
            width: buildWidth(context) * .80,
            child: TextWidget(
              workTypeDetails.workTypeText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w400, false),
            ),
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isLoading
                  ? ColorsUtility.lightGray
                  : ColorsUtility.transparent),
          child: TextWidget(workTypeDetails.workTypeCountText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w500, false)),
        ),
        SizedBox(height: 9.w)
      ],
    );
  }
}
