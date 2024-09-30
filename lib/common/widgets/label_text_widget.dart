import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class LabelTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequiredField;
  final bool? isIconRequired;
  final String hintText;
  final TextStyle? hintStyle;
  final TextInputType keyboardType;
  final Function() onTap;
  final Function(dynamic)? onChange;
  final Function(dynamic)? onEditingComplete;
  final Function(dynamic)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool readOnly;
  final bool isDisableField;
  final bool isChangeBorderColor;
  final int? minLines;
  final int? maxLines;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;

  // Default TextStyle
  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 16,
    color: ColorsUtility.lightBlack,
    fontWeight: FontWeight.w500,
  );

  const LabelTextWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.onTap,
      this.isIconRequired = false,
      this.validator,
      this.isRequiredField = false,
      this.keyboardType = TextInputType.text,
      this.inputFormatters = const [],
      this.style = defaultTextStyle,
      this.readOnly = false,
      this.isChangeBorderColor = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.field1FocusNode,
      this.isDisableField = false,
      this.onChange,
      this.onEditingComplete,
      this.suffixIcon,
      this.obscureText,
      this.hintStyle,
      this.prefixIcon});

  final FocusNode? field1FocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: labelText.toString(),
                style: style ??
                    TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 16, FontWeight.w500, false),
                children: [
              if (isRequiredField)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
        SizedBox(height: (labelText.isNotEmpty) ? 3.w : 0),
        !isChangeBorderColor
            ? TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: controller,
                keyboardType: keyboardType,
                focusNode: field1FocusNode,
                minLines: minLines,
                textInputAction: TextInputAction.done,
                maxLines: maxLines,
                readOnly: readOnly,
                onTap: onTap,
                style: TextStyleUtility.interTextStyle(
                    (isDisableField)
                        ? ColorsUtility.gray
                        : ColorsUtility.lightBlack,
                    16,
                    FontWeight.w400,
                    false),
                onChanged: (value) =>
                    (onChange != null) ? onChange!(value) : (text) {},
                decoration: InputDecoration(
                    filled: true,
                    fillColor: isDisableField
                        ? ColorsUtility.transparent
                        : ColorsUtility.white,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            width: 1.5, color: ColorsUtility.lightGray)),
                    errorStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    hintText: hintText.toString(),
                    hintStyle: hintStyle ??
                        TextStyleUtility.interTextStyle(
                            (isDisableField)
                                ? ColorsUtility.gray
                                : ColorsUtility.lightBlack,
                            16,
                            FontWeight.w400,
                            false)),
                validator:
                    validator != null ? (value) => validator!(value) : null,
                obscureText: obscureText ?? false,
                inputFormatters: inputFormatters,
              )
            : TextFormField(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: controller,
                keyboardType: keyboardType,
                focusNode: field1FocusNode,
                minLines: minLines,
                textInputAction: TextInputAction.done,
                maxLines: maxLines,
                readOnly: readOnly,
                onTap: onTap,
                style: TextStyleUtility.interTextStyle(
                    (isDisableField)
                        ? ColorsUtility.gray
                        : ColorsUtility.lightBlack,
                    16,
                    FontWeight.w400,
                    false),
                onChanged: (value) =>
                    (onChange != null) ? onChange!(value) : (text) {},
                decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorsUtility.white,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            width: 1.5, color: ColorsUtility.lightGray)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            width: 1.5, color: ColorsUtility.lightGrey)),
                    errorStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    hintText: hintText.toString(),
                    hintStyle: hintStyle ??
                        TextStyleUtility.interTextStyle(
                            (isDisableField)
                                ? ColorsUtility.gray
                                : ColorsUtility.lightBlack,
                            16,
                            FontWeight.w400,
                            false)),
                validator:
                    validator != null ? (value) => validator!(value) : null,
                obscureText: obscureText ?? false,
                inputFormatters: inputFormatters,
              )
      ],
    );
  }
}
