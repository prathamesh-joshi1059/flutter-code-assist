import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';

class RadioLabelWidget extends StatefulWidget {
  final String labelText;
  final bool isRequiredField;
  final List workPermitCategoryList;
  final Function(dynamic) onChange;

  const RadioLabelWidget(
      {super.key,
      required this.labelText,
      required this.isRequiredField,
      required this.onChange,
      required this.workPermitCategoryList});

  @override
  State<RadioLabelWidget> createState() => _RadioLabelWidgetState();
}

class _RadioLabelWidgetState extends State<RadioLabelWidget> {
  final ValueNotifier<int> groupValueNotifier = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: widget.labelText.toString(),
                style: TextStyleUtility.interTextStyle(
                    ColorsUtility.gray, 16, FontWeight.normal, false),
                children: [
              if (widget.isRequiredField)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.red))
            ])),
        SizedBox(height: 3.w),
        Row(
            children: List.generate(
                widget.workPermitCategoryList.length,
                (index) =>
                    _radioBtnWidget(widget.workPermitCategoryList[index]))),
      ],
    );
  }

  Widget _radioBtnWidget(radioListDetails) {
    return SizedBox(
      width: 60.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ValueListenableBuilder(
              valueListenable: groupValueNotifier,
              builder: (context, index, snapshot) {
                return Radio(
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: ColorsUtility.lightBlack,
                    value: radioListDetails['value'],
                    groupValue: radioListDetails['value'],
                    //groupValueNotifier.value,
                    onChanged: (value) => onChanged(value, radioListDetails));
              }),
          SizedBox(width: 1.w),
          SizedBox(
            width: 45.w,
            child: TextWidget(radioListDetails['radioTitle'].toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: true,
                style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack,
                  15.5,
                  FontWeight.normal,
                  false,
                )),
          ),
        ],
      ),
    );
  }

  onChanged(value, radioListDetails) {
    groupValueNotifier.value = value!;
    widget.onChange(radioListDetails);
  }
}
