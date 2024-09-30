import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_moreless_label_widget.dart';

class ShowMoreLessCheckListWidget extends StatefulWidget {
  final List initialCheckList;
  final List selectedCheckList;
  final String keyName;
  final bool isPPEList;

  const ShowMoreLessCheckListWidget(
      {super.key,
      required this.initialCheckList,
      this.selectedCheckList = const [],
      this.isPPEList = false,
      required this.keyName});

  @override
  State<ShowMoreLessCheckListWidget> createState() =>
      _ShowMoreLessCheckListWidgetState();
}

class _ShowMoreLessCheckListWidgetState
    extends State<ShowMoreLessCheckListWidget> {
  ValueNotifier showMoreLessNotifier = ValueNotifier(true);
  List allDetailsList = [];

  initData() {
    allDetailsList = widget.initialCheckList + widget.selectedCheckList;
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return ValueListenableBuilder(
        valueListenable: showMoreLessNotifier,
        builder: (context, child, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  children: List.generate(
                      (showMoreLessNotifier.value)
                          ? allDetailsList.length > 5
                              ? 5
                              : allDetailsList.length
                          : allDetailsList.length,
                      (index) =>
                          textWithNumbers(allDetailsList[index], index))),
              if (allDetailsList.length > 5)
                Column(
                  children: [
                    SizedBox(height: 3.w),
                    ShowMoreLessLabelWidget(
                      isShowMore: showMoreLessNotifier.value,
                      onTap: () => _onTapShowMoreLess(),
                    ),
                  ],
                )
            ],
          );
        });
  }

  _onTapShowMoreLess() {
    showMoreLessNotifier.value = !showMoreLessNotifier.value;
  }

  textWithNumbers(checkListData, index) {
    return Padding(
      padding: EdgeInsets.only(top: (widget.isPPEList) ? 2.w : 0.5.w),
      child: Row(
        crossAxisAlignment: (widget.isPPEList)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          if (widget.isPPEList)
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                  height: 10.w,
                  child: (checkListData['image'] != null)
                      ? CacheNetworkImageWidget(
                          imageUrl: checkListData['image'].toString())
                      : ShimmerWidget(
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorsUtility.gray,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                ),
                SizedBox(width: 2.w),
              ],
            )
          else
            TextWidget(
              "${index + 1}. ",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.greyBlack, 15, FontWeight.normal, false),
            ),
          SizedBox(width: 1.w),
          SizedBox(
            width: 76.w,
            child: TextWidget(
              checkListData['name'].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.greyBlack, 15, FontWeight.normal, false),
            ),
          )
        ],
      ),
    );
  }
}
