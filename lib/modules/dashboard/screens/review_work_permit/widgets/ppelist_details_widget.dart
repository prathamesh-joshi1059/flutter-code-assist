import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class PPEListDetailsWidget extends StatefulWidget {
  final int index;
  final Map ppeListMap;
  final List ppeListControllers;
  final ValueNotifier<List<Map>> selectedPPEListData;
  final ValueNotifier<Map> selectedPPEListId;
  final Function(List<Map>) onSelection;

  const PPEListDetailsWidget(
      {super.key,
      required this.index,
      required this.ppeListMap,
      required this.ppeListControllers,
      required this.selectedPPEListData,
      required this.selectedPPEListId,
      required this.onSelection});

  @override
  State<PPEListDetailsWidget> createState() => _PPEListDetailsWidgetState();
}

class _PPEListDetailsWidgetState extends State<PPEListDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: ColorsUtility.white,
          elevation: 1.2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.all(buildWidth(context) * .03),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: buildWidth(context) * .11,
                      height: buildWidth(context) * .11,
                      child: CacheNetworkImageWidget(
                          imageUrl: widget
                              .ppeListMap['image']), // Placeholder for image
                    ),
                    SizedBox(width: buildWidth(context) * .03),
                    SizedBox(
                      width: buildWidth(context) * .67,
                      child: TextWidget(
                        "${widget.ppeListMap['name']}",
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
                    valueListenable: widget.selectedPPEListId,
                    builder: (context, child, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: buildWidth(context) * .33,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                              key: Key('NotApplicableButton_${widget.index}'),
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
                            width: buildWidth(context) * .23,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                                key: Key('CheckedButton_${widget.index}'),
                                text: ValueString.checkedBtnText,
                                textColor: !getBtnSelectedValue(
                                        ValueString.checkedBtnText)
                                    ? ColorsUtility.lightBlack
                                    : ColorsUtility.white,
                                backgroundColor: getBtnSelectedValue(
                                        ValueString.checkedBtnText)
                                    ? ColorsUtility.purpleColor
                                    : ColorsUtility.lightGrey5,
                                onPressed: () => prepareDataOnSelection(
                                    ValueString
                                        .checkedBtnText) //onOptionSelected(1),
                                ),
                          ),
                          SizedBox(
                            width: buildWidth(context) * .23,
                            height: buildWidth(context) * .095,
                            child: CustomAppButton(
                                key: Key('ProvidedButton_${widget.index}'),
                                text: ValueString.providedBtnText,
                                textColor: !getBtnSelectedValue(
                                        ValueString.providedBtnText)
                                    ? ColorsUtility.lightBlack
                                    : ColorsUtility.white,
                                backgroundColor:
                                    getBtnSelectedValueForProvided()
                                        ? ColorsUtility.purpleColor
                                        : ColorsUtility.lightGrey5,
                                onPressed: () =>
                                    _prepareDataOnProvided() //onOptionSelected(2),
                                ),
                          ),
                        ],
                      );
                    }),
                LabelTextWidget(
                  labelText: '',
                  controller: widget.ppeListControllers[widget.index],
                  hintText: ValueString.addRemarkBtnText,
                  minLines: 2,
                  maxLines: 3,
                  isChangeBorderColor: true,
                  onTap: () => null,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: buildWidth(context) * .03)
      ],
    );
  }

  getBtnSelectedValue(btnTitle) {
    List keyList = widget.selectedPPEListId.value.keys.toList();

    if (keyList.contains(widget.ppeListMap['id'])) {
      return btnTitle == ValueString.notApplicableText
          ? widget.selectedPPEListId.value[widget.ppeListMap['id']]
              ['isNotApplicable']
          : btnTitle == ValueString.checkedBtnText
              ? widget.selectedPPEListId.value[widget.ppeListMap['id']]
                  ['isChecked']
              : widget.selectedPPEListId.value[widget.ppeListMap['id']]
                  ['isProvided'];
    }
    return false;
  }

  prepareDataOnSelection(btnTitle) {
    bool isProvided = false;
    for (int i = 0; i < widget.selectedPPEListData.value.length; i++) {
      if (widget.selectedPPEListData.value[i]['id'] ==
          widget.ppeListMap['id']) {
        widget.selectedPPEListData.value.removeAt(i);
      }
    }

    if (widget.selectedPPEListId.value.keys.contains(widget.ppeListMap['id'])) {
      if (widget.selectedPPEListId
              .value[widget.ppeListMap['id']]['isNotApplicable']
              .toString() ==
          "true") {
        isProvided = false;
      } else {
        isProvided = widget.selectedPPEListId.value[widget.ppeListMap['id']]
            ['isProvided'];
      }

      if (btnTitle == ValueString.notApplicableText) {
        isProvided = false;
      }
      widget.selectedPPEListId.value.remove(widget.ppeListMap['id']);
    }

    List<Map> tempList = [];
    tempList = widget.selectedPPEListData.value;
    tempList.add({
      "index": widget.index,
      "id": widget.ppeListMap['id'],
      "name": widget.ppeListMap['name'],
      "imageUrl": widget.ppeListMap['image'],
      "isNotApplicable":
          (btnTitle == ValueString.notApplicableText) ? true : false,
      "isChecked": (btnTitle == ValueString.checkedBtnText) ? true : false,
      "isProvided": isProvided,
    });

    Map tempList1 = widget.selectedPPEListId.value;
    tempList1[widget.ppeListMap['id']] = {
      "isNotApplicable":
          (btnTitle == ValueString.notApplicableText) ? true : false,
      "isChecked": (btnTitle == ValueString.checkedBtnText) ? true : false,
      "isProvided": isProvided,
    };
    widget.selectedPPEListId.value = tempList1;
    widget.selectedPPEListData.value = tempList;

    widget.onSelection(widget.selectedPPEListData.value);
    setState(() {});
  }

  _prepareDataOnProvided() {
    var data = {};

    for (int i = 0; i < widget.selectedPPEListData.value.length; i++) {
      if (widget.selectedPPEListData.value[i]['id'] ==
          widget.ppeListMap['id']) {
        widget.selectedPPEListData.value.removeAt(i);
      }
    }

    if (widget.selectedPPEListId.value.keys.contains(widget.ppeListMap['id'])) {
      data = widget.selectedPPEListId.value[widget.ppeListMap['id']];
    }
    if (!data['isNotApplicable']) {
      data['isProvided'] = !data['isProvided'];
      Map tempList1 = widget.selectedPPEListId.value;
      tempList1[widget.ppeListMap['id']] = data;
      widget.selectedPPEListId.value = tempList1;

      List<Map> tempList = [];
      tempList = widget.selectedPPEListData.value;
      tempList.add({
        "index": widget.index,
        "id": widget.ppeListMap['id'],
        "name": widget.ppeListMap['name'],
        "imageUrl": widget.ppeListMap['image'],
        "isNotApplicable": data['isNotApplicable'],
        "isChecked": data['isChecked'],
        "isProvided": data['isProvided'],
      });

      widget.selectedPPEListData.value = tempList;
      setState(() {});
    }
  }

  getBtnSelectedValueForProvided() {
    List keyList = widget.selectedPPEListId.value.keys.toList();

    if (keyList.contains(widget.ppeListMap['id'])) {
      return widget.selectedPPEListId.value[widget.ppeListMap['id']]
              ['isProvided'] ??
          false;
    }
    return false;
  }
}
