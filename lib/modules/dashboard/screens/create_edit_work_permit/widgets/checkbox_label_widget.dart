import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class CheckboxLabelWidget extends StatefulWidget {
  final bool isShowImg;
  final List workPermitCategoryList;
  final String keyName;
  final Function(List<Map>) onChange;

  const CheckboxLabelWidget({
    super.key,
    required this.isShowImg,
    required this.onChange,
    required this.workPermitCategoryList,
    required this.keyName,
  });

  @override
  State<CheckboxLabelWidget> createState() => _CheckboxLabelWidgetState();
}

class _CheckboxLabelWidgetState extends State<CheckboxLabelWidget> {
  final ValueNotifier<List<Map>> selectedWorkListNotifier = ValueNotifier([]);
  final ValueNotifier<List> selectedWorkListIdNotifier = ValueNotifier([]);
  List<Map> newWorkList = [];
  List newWorkListId = [];

  @override
  Widget build(BuildContext context) {
    return (widget.workPermitCategoryList.isNotEmpty)
        ? SizedBox(
            height: 70.h,
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(widget.workPermitCategoryList.length,
                      (index) => _checkboxWidget(index))),
            ),
          )
        : SizedBox(
            height: 50.h,
            child: NoDataAvailableWidget(
                noDataAvailableText: ValueString.noResultFoundText),
          );
  }

  _checkboxWidget(index) {
    return Padding(
      padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: selectedWorkListIdNotifier,
              builder: (context, child, snapshot) => Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: ColorsUtility.lightBlack,
                        checkColor: ColorsUtility.white,
                        value: getDefaultSelected(index),
                        onChanged: (value) =>
                            onChanged(widget.workPermitCategoryList[index])),
                  )),
          SizedBox(width: 4.w),
          Row(
            children: [
              if (widget.isShowImg)
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                      height: 10.w,
                      child: (widget.workPermitCategoryList[index]['image'] !=
                              null)
                          ? CacheNetworkImageWidget(
                              imageUrl: widget.workPermitCategoryList[index]
                                      ['image']
                                  .toString())
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
                ),
              SizedBox(
                width: (widget.isShowImg) ? 68.w : 78.w,
                child: TextWidget(
                    widget.workPermitCategoryList[index][widget.keyName]
                        .toString()
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                      ColorsUtility.lightBlack,
                      16,
                      FontWeight.normal,
                      false,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // _checkboxWithDefaultWidget(index) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         ValueListenableBuilder(
  //             valueListenable: selectedWorkListNotifier,
  //             builder: (context, child, snapshot) {
  //               return Transform.scale(
  //                 scale: 1.2,
  //                 child: Checkbox(
  //                     visualDensity: const VisualDensity(
  //                         horizontal: VisualDensity.minimumDensity,
  //                         vertical: VisualDensity.minimumDensity),
  //                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //                     activeColor: ColorsUtility.lightBlack,
  //                     checkColor: ColorsUtility.white,
  //                     value: true,
  //                     onChanged: (value) {}),
  //               );
  //             }),
  //         SizedBox(width: 4.w),
  //         Row(
  //           children: [
  //             if (widget.isShowImg)
  //               Row(
  //                 children: [
  //                   SizedBox(
  //                     width: 10.w,
  //                     height: 10.w,
  //                     child: (widget.workPermitCategoryList[index]['image'] !=
  //                             null)
  //                         ? CacheNetworkImageWidget(
  //                             imageUrl: widget.workPermitCategoryList[index]
  //                                     ['image']
  //                                 .toString())
  //                         : ShimmerWidget(
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: ColorsUtility.gray,
  //                                 borderRadius: BorderRadius.circular(6),
  //                               ),
  //                             ),
  //                           ),
  //                   ),
  //                   SizedBox(width: 2.w),
  //                 ],
  //               ),
  //             SizedBox(
  //               width: (widget.isShowImg) ? 68.w : 78.w,
  //               child: TextWidget(
  //                   widget.workPermitCategoryList[index][widget.keyName]
  //                       .toString()
  //                       .toString(),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 3,
  //                   softWrap: true,
  //                   style: TextStyleUtility.interTextStyle(
  //                     ColorsUtility.lightBlack,
  //                     16,
  //                     FontWeight.normal,
  //                     false,
  //                   )),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  getDefaultSelected(index) {
    if (selectedWorkListIdNotifier.value
        .contains(widget.workPermitCategoryList[index]['id'])) {
      return true;
    } else {
      return false;
    }
  }

  onChanged(Map checkListDetails) {
    if (selectedWorkListIdNotifier.value.contains(checkListDetails['id'])) {
      newWorkList = selectedWorkListNotifier.value.toList();
      newWorkListId = selectedWorkListIdNotifier.value.toList();
      newWorkList.removeWhere((e) => e['id'] == checkListDetails['id']);
      newWorkListId.remove(checkListDetails['id']);
      selectedWorkListNotifier.value = newWorkList; // unselect
      selectedWorkListIdNotifier.value = newWorkListId; // unselect
    } else {
      newWorkList = selectedWorkListNotifier.value.toList();
      newWorkListId = selectedWorkListIdNotifier.value.toList();
      newWorkList.add(checkListDetails);
      newWorkListId.add(checkListDetails['id']);
      selectedWorkListNotifier.value = newWorkList; // select
      selectedWorkListIdNotifier.value = newWorkListId; // select
    }
    widget.onChange(selectedWorkListNotifier.value);
  }
}
