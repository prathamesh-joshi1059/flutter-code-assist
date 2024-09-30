import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class ChecklistDetailsWidget extends StatefulWidget {
  final int index;
  final Map checkListMap;
  final List checkListControllers;
  final bool isCloseWorkPermit;
  final String keyName;
  final ValueNotifier<List<Map>> selectedCheckListData;
  final ValueNotifier<Map> selectedCheckListId;
  final Function(List<Map>) onSelection;

  const ChecklistDetailsWidget(
      {super.key,
      required this.index,
      required this.checkListMap,
      required this.checkListControllers,
      required this.onSelection,
      required this.selectedCheckListData,
      required this.selectedCheckListId,
      this.isCloseWorkPermit = false,
      this.keyName = 'name'});

  @override
  State<ChecklistDetailsWidget> createState() => _ChecklistDetailsWidgetState();
}

class _ChecklistDetailsWidgetState extends State<ChecklistDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isCloseWorkPermit
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: ColorsUtility.white,
                elevation: 1.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(buildWidth(context) * .03),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            "${widget.index + 1}. ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyleUtility.interTextStyle(
                                ColorsUtility.lightBlack,
                                16,
                                FontWeight.w400,
                                false),
                          ),
                          SizedBox(
                            width: buildWidth(context) * .78,
                            child: TextWidget(
                              "${widget.checkListMap[widget.keyName]}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyleUtility.interTextStyle(
                                  ColorsUtility.lightBlack,
                                  16,
                                  FontWeight.w400,
                                  false),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: buildWidth(context) * .015),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: buildWidth(context) * .33,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                              key: Key('NotApplicableButton_${widget.index}'),
                              text: ValueString.notApplicableText,
                              textColor: getBtnSelectedValue(
                                      ValueString.notApplicableText)
                                  ? ColorsUtility.lightBlack
                                  : ColorsUtility.white,
                              backgroundColor: getBtnSelectedValue(
                                      ValueString.notApplicableText)
                                  ? ColorsUtility.purpleColor
                                  : ColorsUtility.lightGrey5,
                              onPressed: () => prepareDataOnSelection(
                                  ValueString.notApplicableText),
                            ),
                          ),
                          SizedBox(
                            width: buildWidth(context) * .23,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                                key: Key('YesButton_${widget.index}'),
                                text: ValueString.yesText,
                                textColor:
                                    getBtnSelectedValue(ValueString.yesText)
                                        ? ColorsUtility.lightBlack
                                        : ColorsUtility.white,
                                backgroundColor:
                                    getBtnSelectedValue(ValueString.yesText)
                                        ? ColorsUtility.purpleColor
                                        : ColorsUtility.lightGrey5,
                                onPressed: () => prepareDataOnSelection(
                                    ValueString.yesText) //onOptionSelected(1),
                                ),
                          ),
                          SizedBox(
                            width: buildWidth(context) * .23,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                                key: Key('NoButton_${widget.index}'),
                                text: ValueString.noText,
                                textColor:
                                    getBtnSelectedValue(ValueString.noText)
                                        ? ColorsUtility.lightBlack
                                        : ColorsUtility.white,
                                backgroundColor:
                                    getBtnSelectedValue(ValueString.noText)
                                        ? ColorsUtility.purpleColor
                                        : ColorsUtility.lightGrey5,
                                onPressed: () => prepareDataOnSelection(
                                    ValueString.noText) //onOptionSelected(2),
                                ),
                          ),
                        ],
                      ),
                      LabelTextWidget(
                        labelText: '',
                        controller: widget.checkListControllers[widget.index],
                        hintText: ValueString.addRemarkBtnText,
                        minLines: 2,
                        maxLines: 3,
                        onTap: () => null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: buildWidth(context) * .03)
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: ColorsUtility.white,
                elevation: 1.2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(buildWidth(context) * .03),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            "${widget.index + 1}. ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyleUtility.interTextStyle(
                                ColorsUtility.lightBlack,
                                16,
                                FontWeight.w400,
                                false),
                          ),
                          SizedBox(
                            width: buildWidth(context) * .77,
                            child: TextWidget(
                              "${widget.checkListMap['name']}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: TextStyleUtility.interTextStyle(
                                  ColorsUtility.lightBlack,
                                  16,
                                  FontWeight.w400,
                                  false),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: buildWidth(context) * .015),
                      const Divider(),
                      ValueListenableBuilder(
                          valueListenable: widget.selectedCheckListId,
                          builder: (context, child, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: buildWidth(context) * .35,
                                  height: buildWidth(context) * .095,
                                  child: CustomAppButton(
                                    key: Key(
                                        'NotApplicableButton_${widget.index}'),
                                    text: ValueString.notApplicableText,
                                    textColor: !getBtnSelectedValue(
                                            ValueString.notApplicableText)
                                        ? ColorsUtility.lightBlack
                                        : ColorsUtility.white,
                                    backgroundColor: getBtnSelectedValue(
                                            ValueString.notApplicableText)
                                        ? ColorsUtility.purpleColor
                                        : ColorsUtility.lightGrey5,
                                    onPressed: () => prepareDataOnSelection(
                                        ValueString.notApplicableText),
                                  ),
                                ),
                                SizedBox(
                                  width: buildWidth(context) * .22,
                                  height: buildWidth(context) * .095,
                                  child: CustomAppButton(
                                      key: Key('YesButton_${widget.index}'),
                                      text: ValueString.yesText,
                                      textColor: !getBtnSelectedValue(
                                              ValueString.yesText)
                                          ? ColorsUtility.lightBlack
                                          : ColorsUtility.white,
                                      backgroundColor: getBtnSelectedValue(
                                              ValueString.yesText)
                                          ? ColorsUtility.purpleColor
                                          : ColorsUtility.lightGrey5,
                                      onPressed: () => prepareDataOnSelection(
                                          ValueString
                                              .yesText) //onOptionSelected(1),
                                      ),
                                ),
                                SizedBox(
                                  width: buildWidth(context) * .22,
                                  height: buildWidth(context) * .095,
                                  child: CustomAppButton(
                                      key: Key('NoButton_${widget.index}'),
                                      textColor: !getBtnSelectedValue(
                                              ValueString.noText)
                                          ? ColorsUtility.lightBlack
                                          : ColorsUtility.white,
                                      text: ValueString.noText,
                                      backgroundColor: getBtnSelectedValue(
                                              ValueString.noText)
                                          ? ColorsUtility.purpleColor
                                          : ColorsUtility.lightGrey5,
                                      onPressed: () => prepareDataOnSelection(
                                          ValueString
                                              .noText) //onOptionSelected(2),
                                      ),
                                ),
                              ],
                            );
                          }),
                      LabelTextWidget(
                        labelText: '',
                        controller: widget.checkListControllers[widget.index],
                        hintText: ValueString.addRemarkBtnText,
                        minLines: 2,
                        maxLines: 3,
                        isChangeBorderColor: true,
                        onTap: () => null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: buildWidth(context) * .03)
            ],
          );
  }

  getBtnSelectedValue(btnTitle) {
    List keyList = widget.selectedCheckListId.value.keys.toList();

    if (keyList.contains(widget.checkListMap['id'])) {
      return btnTitle == ValueString.yesText
          ? widget.selectedCheckListId.value[widget.checkListMap['id']]['isYes']
          : btnTitle == ValueString.noText
              ? widget.selectedCheckListId.value[widget.checkListMap['id']]
                  ['isNo']
              : widget.selectedCheckListId.value[widget.checkListMap['id']]
                  ['isNotApplicable'];
    }
    return false;
  }

  prepareDataOnSelection(btnTitle) {
    for (int i = 0; i < widget.selectedCheckListData.value.length; i++) {
      if (widget.selectedCheckListData.value[i]['id'] ==
          widget.checkListMap['id']) {
        widget.selectedCheckListData.value.removeAt(i);
      }
    }

    if (widget.selectedCheckListId.value.keys == widget.checkListMap['id']) {
      widget.selectedCheckListId.value.remove(widget.checkListMap['id']);
    }

    List<Map> tempList = [];
    tempList = widget.selectedCheckListData.value;
    tempList.add({
      "index": widget.index,
      "id": widget.checkListMap['id'],
      "checklist": widget.checkListMap['name'],
      "isYes": (btnTitle == ValueString.yesText) ? true : false,
      "isNo": (btnTitle == ValueString.noText) ? true : false,
      "isNotApplicable":
          (btnTitle == ValueString.notApplicableText) ? true : false,
    });

    Map tempList1 = widget.selectedCheckListId.value;
    tempList1[widget.checkListMap['id']] = {
      "isYes": (btnTitle == ValueString.yesText) ? true : false,
      "isNo": (btnTitle == ValueString.noText) ? true : false,
      "isNotApplicable":
          (btnTitle == ValueString.notApplicableText) ? true : false,
    };
    widget.selectedCheckListId.value = tempList1;
    widget.selectedCheckListData.value = tempList;

    widget.onSelection(widget.selectedCheckListData.value);
    setState(() {});
  }
}
