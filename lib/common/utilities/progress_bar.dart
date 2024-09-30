import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';

class ProgressBar {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: ColorsUtility.transparent,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ThemeUtility.primaryColor),
            // strokeWidth: 10,
          ),
        );
      },
    );
  }

  static Widget showLoadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(ThemeUtility.primaryColor),
        // strokeWidth: 10,
      ),
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop("");
  }
}
