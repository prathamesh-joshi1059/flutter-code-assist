import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';

class BottomNavigationWidget extends StatelessWidget {
  final String btnKey;
  final String btnTitle;
  final Function() onTap;

  const BottomNavigationWidget(
      {super.key,
      required this.btnKey,
      required this.btnTitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        color: ColorsUtility.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(-1, -1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
        child: CustomAppButton(
          key: Key(btnKey),
          text: btnTitle,
          backgroundColor: ColorsUtility.purpleColor,
          textFontSize: 16,
          verticalPadding: 12,
          circularRadius: 8,
          onPressed: () => onTap(),
        ),
      ),
    ));
  }
}
