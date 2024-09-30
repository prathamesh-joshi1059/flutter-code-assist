import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class PPECheckboxLabelWidget extends StatefulWidget {
  final List workPermitCategoryList;
  final List defaultPermitCategoryList;
  final Function(List<Map>) onChange;

  const PPECheckboxLabelWidget(
      {super.key,
      required this.onChange,
      required this.workPermitCategoryList,
      required this.defaultPermitCategoryList});

  @override
  State<PPECheckboxLabelWidget> createState() => _PPECheckboxLabelWidgetState();
}

class _PPECheckboxLabelWidgetState extends State<PPECheckboxLabelWidget> {
  final ValueNotifier<List<Map>> selectedPPEListNotifier = ValueNotifier([]);
  final ValueNotifier<List> selectedPPEListIdNotifier = ValueNotifier([]);
  List<Map> newWorkList = [];
  List newWorkListId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateCheckList();
  }

  updateCheckList() {
    if (widget.defaultPermitCategoryList.isNotEmpty) {
      for (int i = 0; i < widget.defaultPermitCategoryList.length; i++) {
        selectedPPEListIdNotifier.value =
            List.from(selectedPPEListIdNotifier.value)
              ..add(widget.defaultPermitCategoryList[i]['id']);

        selectedPPEListNotifier.value = List.from(selectedPPEListNotifier.value)
          ..add(widget.defaultPermitCategoryList[i]);
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChange(selectedPPEListNotifier.value);
      });
    }
    widget.workPermitCategoryList
        .sort((a, b) => (a['name']).compareTo(b['name']));
  }

  @override
  Widget build(BuildContext context) {
    return (widget.workPermitCategoryList.isNotEmpty)
        ? SizedBox(
            height: 70.h,
            child: SingleChildScrollView(
              child: Column(
                  children: List.generate(widget.workPermitCategoryList.length,
                      (index) => ppeRowWidget(index))),
            ),
          )
        : SizedBox(
            height: 50.h,
            child: NoDataAvailableWidget(
                noDataAvailableText: ValueString.noResultFoundText),
          );
  }

  ppeRowWidget(index) {
    return Padding(
      padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
      child: InkWell(
        onTap: () {
          onChanged(widget.workPermitCategoryList[index]);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder(
                valueListenable: selectedPPEListIdNotifier,
                builder: (context, child, snapshot) => Transform.scale(
                      scale: 1.2,
                      child: Checkbox(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: ColorsUtility.lightBlack,
                          checkColor: ColorsUtility.white,
                          value: getDefaultSelected(index),
                          onChanged: (value) =>
                              onChanged(widget.workPermitCategoryList[index])),
                    )),
            SizedBox(width: 4.w),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                  height: 10.w,
                  child: (widget.workPermitCategoryList[index]['image'] != null)
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
              width: 60.w,
              child: TextWidget(
                  widget.workPermitCategoryList[index]['name']
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
      ),
    );
  }

  getDefaultSelected(index) {
    if (selectedPPEListIdNotifier.value
        .contains(widget.workPermitCategoryList[index]['id'])) {
      return true;
    } else {
      return false;
    }
  }

  onChanged(Map checkListDetails) {
    newWorkList = selectedPPEListNotifier.value.toList();
    newWorkListId = selectedPPEListIdNotifier.value.toList();

    if (selectedPPEListIdNotifier.value.contains(checkListDetails['id'])) {
      newWorkList.removeWhere((e) => e['id'] == checkListDetails['id']);
      newWorkListId.remove(checkListDetails['id']);
      selectedPPEListNotifier.value = newWorkList; // unselect
      selectedPPEListIdNotifier.value = newWorkListId; // unselect
    } else {
      newWorkList.add(checkListDetails);
      newWorkListId.add(checkListDetails['id']);
      selectedPPEListNotifier.value = newWorkList; // select
      selectedPPEListIdNotifier.value = newWorkListId; // select
    }

    widget.onChange(selectedPPEListNotifier.value);
  }
}
