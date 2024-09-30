import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class DropdownTextWorkWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isRequiredField;
  final String hintText;
  final Function() onTap;
  final bool isDropdownOpen;
  final String titleKeyName;
  final List dropdownList;
  final bool isDisableField;
  final Function(dynamic) selectedValue;
  final Function(dynamic)? validator;

  const DropdownTextWorkWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      required this.onTap,
      this.validator,
      this.isDisableField = false,
      required this.isDropdownOpen,
      required this.dropdownList,
      required this.selectedValue,
      this.isRequiredField = false,
      required this.titleKeyName});

  @override
  State<DropdownTextWorkWidget> createState() => _DropdownTextWorkWidgetState();
}

class _DropdownTextWorkWidgetState extends State<DropdownTextWorkWidget> {
  ValueNotifier<bool> isDropdownOpenNotifier = ValueNotifier(false);
  ValueNotifier<dynamic> selectedValueNotifier = ValueNotifier('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    selectedValueNotifier.value = widget.controller.text.toString();
  }

  sortInitList() {
    if (widget.dropdownList.isNotEmpty) {
      widget.dropdownList.sort(
          (a, b) => (a[widget.titleKeyName]).compareTo(b[widget.titleKeyName]));
    }
  }

  @override
  Widget build(BuildContext context) {
    sortInitList();
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
                            filled: true,
                            fillColor: widget.isDisableField
                                ? ColorsUtility.transparent
                                : ColorsUtility.white,
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
                            hintText: widget.hintText.toString(),
                            hintStyle: TextStyleUtility.interTextStyle(
                                ColorsUtility.gray, 16, FontWeight.w400, false),
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
                                        : ColorsUtility.lightBlack,
                                    BlendMode.srcIn)),
                          )),
                    ],
                  ),
                ),
              );
            }),
        ValueListenableBuilder(
            valueListenable: isDropdownOpenNotifier,
            builder: (context, value, child) => Visibility(
                  visible: isDropdownOpenNotifier.value,
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.5.w),
                    child: Container(
                      width: 90.w,
                      height: 50.w,
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                          color: ColorsUtility.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: ColorsUtility.heather, width: 1.5)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              widget.dropdownList.length,
                              (index) => Padding(
                                    padding: EdgeInsets.all(0.5.w),
                                    child: ValueListenableBuilder(
                                        valueListenable: selectedValueNotifier,
                                        builder: (context, value, child) {
                                          return InkWell(
                                            onTap: () =>
                                                onDropDownSelection(index),
                                            child: labelTextWidget(index),
                                          );
                                        }),
                                  )),
                        ),
                      ),
                    ),
                  ),
                ))
      ],
    );
  }

  onTapDropdown() {
    isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
  }

  labelTextWidget(index) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
          color: (selectedValueNotifier.value == widget.dropdownList[index])
              ? ColorsUtility.lightBlue2
              : ColorsUtility.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (selectedValueNotifier.value == widget.dropdownList[index])
                  ? ColorsUtility.lightGray
                  : ColorsUtility.faintGrey,
              width: 1)),
      child: TextWidget(
        widget.dropdownList[index][widget.titleKeyName].toString(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
        style: TextStyleUtility.interTextStyle(
            ColorsUtility.lightBlack, 16, FontWeight.w400, false),
      ),
    );
  }

  onDropDownSelection(index) {
    InternetUtil.isInternetAvailable((status) async {
      if (status == true) {
        selectedValueNotifier.value = widget.dropdownList[index];
        if (selectedValueNotifier.value != null) {
          isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
        }
        widget.selectedValue(widget.dropdownList[index]);
      } else {
        if (selectedValueNotifier.value != null) {
          isDropdownOpenNotifier.value = !isDropdownOpenNotifier.value;
        }
        ToastUtility.showToast(ValueString.noInternetConnection);
      }
    });
  }
}
