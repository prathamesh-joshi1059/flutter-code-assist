import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsUtility.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: buildWidth(context) * .80,
              height: buildWidth(context) * .50,
              child: SvgPicture.asset(
                AssetsConstant.workPermitLogoIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ));
  }

  void initData() {
    Future.delayed(
        const Duration(
          seconds: 4,
        ),
        () => navigateToLoginScreen());
  }

  navigateToLoginScreen() async {
    if (await _isUserLoggedIn()) {
      if (mounted) {
        NavigatorUtility.navigateToDashboardScreen(context: context);
      }
    } else {
      if (mounted) {
        NavigatorUtility.navigateToLoginScreen(context: context);
      }
    }
  }

  Future<bool> _isUserLoggedIn() async {
    var userData = await HiveUtility.getDataFromHiveDb(
      boxName: HiveKeys.userDataBox,
      key: HiveKeys.userInfoKey,
    );

    return userData != null ? true : false;
  }
}
