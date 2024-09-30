import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class CloseChecklistDetailsWidget extends StatefulWidget {
  final int index;
  final Map checkListMap;

  const CloseChecklistDetailsWidget({
    super.key,
    required this.index,
    required this.checkListMap,
  });

  @override
  State<CloseChecklistDetailsWidget> createState() =>
      _CloseChecklistDetailsWidgetState();
}

class _CloseChecklistDetailsWidgetState
    extends State<CloseChecklistDetailsWidget> {
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    remarkController.text = widget.checkListMap['remark'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: ColorsUtility.white,
          elevation: 1.2,
          // margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8),
          //   color: ColorsUtility.white,
          // ),
          child: Padding(
            padding: EdgeInsets.all(buildWidth(context) * .02),
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
                          ColorsUtility.lightBlack, 16, FontWeight.w400, false),
                    ),
                    SizedBox(
                      width: buildWidth(context) * .78,
                      child: TextWidget(
                        "${widget.checkListMap['checklist']}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
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
                AbsorbPointer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: buildWidth(context) * .35,
                        height: buildWidth(context) * .095,
                        child: CustomAppButton(
                          key: Key('NotApplicableButton_${widget.index}'),
                          text: ValueString.notApplicableText,
                          textColor: !widget.checkListMap['isNotApplicable']
                              ? ColorsUtility.lightBlack
                              : ColorsUtility.white,
                          backgroundColor:
                              widget.checkListMap['isNotApplicable']
                                  ? ColorsUtility.purpleColor
                                  : ColorsUtility.lightGrey5,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: buildWidth(context) * .22,
                        height: buildWidth(context) * .095,
                        child: CustomAppButton(
                            key: Key('YesButton_${widget.index}'),
                            text: ValueString.yesText,
                            textColor: !widget.checkListMap['isYes']
                                ? ColorsUtility.lightBlack
                                : ColorsUtility.white,
                            backgroundColor: widget.checkListMap['isYes']
                                ? ColorsUtility.purpleColor
                                : ColorsUtility.lightGrey5,
                            onPressed: () {}),
                      ),
                      SizedBox(
                        width: buildWidth(context) * .22,
                        height: buildWidth(context) * .095,
                        child: CustomAppButton(
                            key: Key('NoButton_${widget.index}'),
                            text: ValueString.noText,
                            textColor: !widget.checkListMap['isNo']
                                ? ColorsUtility.lightBlack
                                : ColorsUtility.white,
                            backgroundColor: widget.checkListMap['isNo']
                                ? ColorsUtility.purpleColor
                                : ColorsUtility.lightGrey5,
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                AbsorbPointer(
                  child: LabelTextWidget(
                    labelText: '',
                    controller: remarkController,
                    hintText: ValueString.addRemarkBtnText,
                    isDisableField: true,
                    isChangeBorderColor: true,
                    minLines: 2,
                    maxLines: 3,
                    onTap: () => null,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: buildWidth(context) * .02)
      ],
    );
  }
}
