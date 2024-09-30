import 'package:fluttertoast/fluttertoast.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';

class ToastUtility {
  static void showToast(String msg, [showCenter = false]) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: showCenter ? ToastGravity.CENTER : ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: ThemeUtility.primaryColor,
        textColor: ColorsUtility.white,
        fontSize: 16.0);
  }
}
