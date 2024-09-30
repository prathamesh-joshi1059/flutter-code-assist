import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class DateTimeWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String labelHintText;
  final String helpText;
  final int durationInStartDays;
  final int durationInLastDays;
  final bool isRequiredField;
  final bool isDisableField;
  final Function(dynamic) onSelection;
  final Function(dynamic)? validator;

  const DateTimeWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.labelHintText,
      required this.helpText,
      this.validator,
      this.isDisableField = false,
      required this.durationInStartDays,
      required this.durationInLastDays,
      required this.isRequiredField,
      required this.onSelection});

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  ValueNotifier<bool> isDropdownOpenNotifier = ValueNotifier(false);
  late Future<DateTime?> selectedDate;
  int date = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: widget.labelText.toString(),
                style: TextStyleUtility.interTextStyle(
                    (widget.isDisableField)
                        ? ColorsUtility.gray
                        : ColorsUtility.lightBlack,
                    16,
                    FontWeight.normal,
                    false),
                children: [
              if (widget.isRequiredField)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
        SizedBox(height: 2.w),
        ValueListenableBuilder(
            valueListenable: isDropdownOpenNotifier,
            builder: (context, value, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  splashFactory: NoSplash.splashFactory,
                ),
                child: InkWell(
                  onTap: onTapDropdown,
                  highlightColor: ColorsUtility.transparent,
                  child: Stack(
                    children: [
                      TextFormField(
                          controller: widget.controller,
                          enabled: false,
                          style: TextStyleUtility.interTextStyle(
                              (widget.isDisableField)
                                  ? ColorsUtility.gray
                                  : ColorsUtility.lightBlack,
                              16,
                              FontWeight.w400,
                              false),
                          validator: widget.validator != null
                              ? (value) => widget.validator!(value)
                              : null,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 15, right: 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: ColorsUtility.lightGray)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1.5, color: ColorsUtility.heather)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    width: 1.5,
                                    color: ColorsUtility.lightGray)),
                            errorStyle: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                            hintText: widget.labelHintText.toString(),
                            hintStyle: TextStyleUtility.interTextStyle(
                                ColorsUtility.gray, 16, FontWeight.w400, false),
                            // validator: (value) => widget.validator!(value),
                          )),
                      Positioned(
                          right: 13,
                          top: 11,
                          child: SizedBox(
                            width: 6.w,
                            height: 6.w,
                            child: SvgPicture.asset(
                                (!isDropdownOpenNotifier.value)
                                    ? AssetsConstant.arrowDownIcon
                                    : AssetsConstant.arrowUpIcon,
                                colorFilter: ColorFilter.mode(
                                    widget.isDisableField
                                        ? ColorsUtility.gray
                                        : ColorsUtility.transparent,
                                    BlendMode.srcIn)),
                            // color: (widget.isDisableField)
                            //     ? ColorsUtility.gray
                            //     : ColorsUtility.transparent),
                          )),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  onTapDropdown() {
    isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
    if (isDropdownOpenNotifier.value) {
      return showDialogDatePicker(context);
    }
  }

  void showDialogDatePicker(BuildContext context) {
    selectedDate = showDatePicker(
        context: context,
        initialDate:
            DateTime.now().add(Duration(days: widget.durationInStartDays)),
        firstDate:
            DateTime.now().add(Duration(days: widget.durationInStartDays)),
        //DateTime.now().subtract(Duration(days: widget.durationInStartDays)),
        lastDate: DateTime(2050),
        //DateTime.now().add(Duration(days: widget.durationInLastDays)),
        helpText: widget.helpText,
        confirmText: ValueString.confirmText,
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  // primary: MyColors.primary,
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!);
        });

    selectedDate.then((value) {
      isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
      if (value == null) return;
      DateTime newDate =
          DateTime(value.year, value.month, value.day, 09, 00, 00);
      date = newDate.millisecondsSinceEpoch;
      widget.onSelection(newDate.millisecondsSinceEpoch);
    }, onError: (error) {
      // print(error);
    });

    // isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
  }
}
