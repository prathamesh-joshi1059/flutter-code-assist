import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';

class ApprovalBottomNavigationWidget extends StatelessWidget {
  final String btnKey1;
  final String btnKey2;
  final String btnKey3;
  final String btnTitle1;
  final String btnTitle2;
  final String btnTitle3;
  final Function() onTap1;
  final Function() onTap2;
  final Function() onTap3;

  const ApprovalBottomNavigationWidget({
    super.key,
    required this.btnKey1,
    required this.btnKey2,
    required this.btnKey3,
    required this.btnTitle1,
    required this.btnTitle2,
    required this.btnTitle3,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  });

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.w),
            child: SizedBox(
              width: 45.w,
              child: CustomAppButton(
                key: Key(btnKey1),
                text: btnTitle1,
                backgroundColor: ColorsUtility.purpleColor,
                textFontSize: 16,
                verticalPadding: 12,
                circularRadius: 8,
                onPressed: () => onTap1(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.w),
            child: SizedBox(
              width: 45.w,
              child: CustomAppButton(
                key: Key(btnKey2),
                text: btnTitle2,
                backgroundColor: ColorsUtility.purpleColor,
                textFontSize: 16,
                verticalPadding: 12,
                circularRadius: 8,
                onPressed: () => onTap2(),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.w),
          //   child: SizedBox(
          //     width: 30.w,
          //     child: CustomAppButton(
          //       key: Key(btnKey3),
          //       text: btnTitle3,
          //       backgroundColor: ColorsUtility.purpleColor,
          //       textFontSize: 16,
          //       verticalPadding: 12,
          //       circularRadius: 8,
          //       onPressed: () => onTap3(),
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
