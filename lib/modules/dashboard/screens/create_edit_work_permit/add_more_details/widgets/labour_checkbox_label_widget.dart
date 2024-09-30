import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class LabourCheckboxLabelWidget extends StatefulWidget {
  final List workPermitCategoryList;
  final List defaultPermitCategoryList;
  final Function(List<Map>) onChange;

  const LabourCheckboxLabelWidget(
      {super.key,
      required this.onChange,
      required this.workPermitCategoryList,
      required this.defaultPermitCategoryList});

  @override
  State<LabourCheckboxLabelWidget> createState() =>
      _LabourCheckboxLabelWidgetState();
}

class _LabourCheckboxLabelWidgetState extends State<LabourCheckboxLabelWidget> {
  final ValueNotifier<List<Map>> selectedWorkListNotifier = ValueNotifier([]);
  final ValueNotifier<List> selectedWorkListIdNotifier = ValueNotifier([]);
  List<Map> newWorkList = [];
  List newWorkListId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateLabourList();
  }

  updateLabourList() {
    if (widget.defaultPermitCategoryList.isNotEmpty) {
      for (int i = 0; i < widget.defaultPermitCategoryList.length; i++) {
        selectedWorkListIdNotifier.value =
            List.from(selectedWorkListIdNotifier.value)
              ..add(widget.defaultPermitCategoryList[i]['id']);
        selectedWorkListNotifier.value =
            List.from(selectedWorkListNotifier.value)
              ..add(widget.defaultPermitCategoryList[i]);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onChange(selectedWorkListNotifier.value);
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
                      (index) => _checkboxWidget(index))),
            ),
          )
        : SizedBox(
            height: 50.h,
            child: const NoDataAvailableWidget(),
          );
  }

  _checkboxWidget(index) {
    return Padding(
      padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
      child: InkWell(
        onTap: () {
          onChanged(widget.workPermitCategoryList[index]);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                  valueListenable: selectedWorkListIdNotifier,
                  builder: (context, child, snapshot) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: getDefaultSelected(index)
                              ? ColorsUtility.transparent
                              : ColorsUtility.lightGrey4,
                        ),
                        child: Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: ColorsUtility.purpleColor,
                              checkColor: ColorsUtility.white,
                              value: getDefaultSelected(index),
                              side: BorderSide.none,
                              onChanged: (value) => onChanged(
                                  widget.workPermitCategoryList[index])),
                        ),
                      )),
              SizedBox(width: 4.w),
              Row(
                children: [
                  SizedBox(
                    width: 78.w,
                    child: TextWidget(
                        widget.workPermitCategoryList[index]['name'].toString(),
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
        ),
      ),
    );
  }

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
