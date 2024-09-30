import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class ClosePPEListDetailsWidget extends StatefulWidget {
  final int index;
  final Map ppeListMap;

  const ClosePPEListDetailsWidget(
      {super.key, required this.index, required this.ppeListMap});

  @override
  State<ClosePPEListDetailsWidget> createState() =>
      _ClosePPEListDetailsWidgetState();
}

class _ClosePPEListDetailsWidgetState extends State<ClosePPEListDetailsWidget> {
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    remarkController.text = widget.ppeListMap['remark'] ?? '';
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
          // padding: EdgeInsets.all(buildWidth(context) * .02),
          child: Padding(
            padding: EdgeInsets.all(buildWidth(context) * .02),
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
                              .ppeListMap['imageUrl']), // Placeholder for image
                    ),
                    SizedBox(width: buildWidth(context) * .03),
                    SizedBox(
                      width: buildWidth(context) * .70,
                      child: TextWidget(
                        "${widget.ppeListMap['name']}",
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
                            textColor: !widget.ppeListMap['isNotApplicable']
                                ? ColorsUtility.lightBlack
                                : ColorsUtility.white,
                            backgroundColor:
                                widget.ppeListMap['isNotApplicable']
                                    ? ColorsUtility.purpleColor
                                    : ColorsUtility.lightGrey5,
                            onPressed: () {}),
                      ),
                      SizedBox(
                        width: buildWidth(context) * .22,
                        height: buildWidth(context) * .095,
                        child: CustomAppButton(
                            key: Key('CheckedButton_${widget.index}'),
                            text: ValueString.checkedBtnText,
                            textColor: !widget.ppeListMap['isChecked']
                                ? ColorsUtility.lightBlack
                                : ColorsUtility.white,
                            backgroundColor: widget.ppeListMap['isChecked']
                                ? ColorsUtility.purpleColor
                                : ColorsUtility.lightGrey5,
                            onPressed: () {}),
                      ),
                      SizedBox(
                        width: buildWidth(context) * .22,
                        height: buildWidth(context) * .095,
                        child: CustomAppButton(
                            key: Key('ProvidedButton_${widget.index}'),
                            text: ValueString.providedBtnText,
                            textColor: !widget.ppeListMap['isProvided']
                                ? ColorsUtility.lightBlack
                                : ColorsUtility.white,
                            backgroundColor: widget.ppeListMap['isProvided']
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
