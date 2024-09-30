import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/extensions/extensions.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class RemarkPopupWidget extends StatefulWidget {
  final TextEditingController remarkController;
  final Function(String) submitBtnPress;

  const RemarkPopupWidget(
      {super.key,
      required this.remarkController,
      required this.submitBtnPress});

  @override
  State<RemarkPopupWidget> createState() => _RemarkPopupWidgetState();
}

class _RemarkPopupWidgetState extends State<RemarkPopupWidget> {
  final GlobalKey<FormState> _formKeyRemarkPopup = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsUtility.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: -15,
              right: -20,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _onCloseBtnPress(context),
              )),
          Form(
            key: _formKeyRemarkPopup,
            child: SizedBox(
              width: buildWidth(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: buildWidth(context) * .02),
                  TextWidget(ValueString.addRemarkBtnText,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyleUtility.interTextStyle(
                          ColorsUtility.lightBlack, 20, FontWeight.w500, false),
                      softWrap: true),
                  SizedBox(height: buildWidth(context) * .01),
                  const Divider(),
                  LabelTextWidget(
                      controller: widget.remarkController,
                      labelText: '',
                      hintText: ValueString.remarkHintText,
                      minLines: 3,
                      maxLines: 5,
                      validator: (text) => _addRemarkValidator(),
                      style: TextStyleUtility.interTextStyle(
                          ColorsUtility.gray, 16, FontWeight.w400, false),
                      onTap: () {}),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: buildWidth(context),
                    child: CustomAppButton(
                      key: Key(WidgetKeys.submitBtnKey),
                      text: ValueString.submitBtnText,
                      backgroundColor: ColorsUtility.black,
                      textFontSize: 16,
                      verticalPadding: 12,
                      circularRadius: 8,
                      onPressed: () => _onSubmitBtnPress(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onSubmitBtnPress() {
    if (_formKeyRemarkPopup.currentState!.validate()) {
      widget.submitBtnPress(widget.remarkController.text);
    }
  }

  _addRemarkValidator() {
    return widget.remarkController.text
        .trim()
        .validateEmpty(ValueString.remarkEmptyText);
  }

  _onCloseBtnPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
