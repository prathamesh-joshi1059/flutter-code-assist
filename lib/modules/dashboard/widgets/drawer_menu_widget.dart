// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
// import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
// import 'package:work_permit_mobile_app/common/utilities/globals.dart';
// import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
// import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
// import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
// import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
// import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
// import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
// import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
// import 'package:work_permit_mobile_app/common/utilities/theme/theme_utility.dart';
// import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
// import 'package:work_permit_mobile_app/common/widgets/confirmation_dialogue_widget.dart';
// import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
// import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
// import 'package:work_permit_mobile_app/modules/dashboard/widgets/info_text_widget.dart';
//
// class DrawerMenuWidget extends StatelessWidget {
//   final DashboardBloc dashboardBloc;
//
//   const DrawerMenuWidget({super.key, required this.dashboardBloc});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: ThemeUtility.background,
//       shape: Border.all(style: BorderStyle.none),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 12.h,
//             // width: double.infinity,
//             padding: EdgeInsets.zero,
//             decoration: const BoxDecoration(
//               color: ColorsUtility.lightGrayTwo,
//             ),
//             child: DrawerHeader(
//               margin: EdgeInsets.zero,
//               padding: EdgeInsets.zero,
//               decoration: const BoxDecoration(
//                 color: ColorsUtility.lightGrayTwo,
//               ),
//               child: Container(
//                 decoration: const BoxDecoration(color: ColorsUtility.white),
//                 padding: EdgeInsets.zero,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: buildWidth(context) * .40,
//                         height: buildWidth(context) * .06,
//                         child: SvgPicture.asset(
//                           AssetsConstant.logoIcon,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () => _onCloseBtnPress(context),
//                           icon: const Icon(
//                             Icons.close,
//                             color: ColorsUtility.black,
//                           ))
//                     ]),
//               ),
//             ),
//           ),
//           Padding(
//               padding: EdgeInsets.only(top: 2.h),
//               child: const InfoTextButton(
//                 text: ValueString.changePasswordText,
//                 icon: AssetsConstant.changePasswordIcon,
//               )),
//           Padding(
//               padding: EdgeInsets.only(top: 2.h),
//               child: InfoTextButton(
//                 text: ValueString.logoutText,
//                 icon: AssetsConstant.logoutIcon,
//                 iconColor: ColorsUtility.red,
//                 onTap: () => _logoutButtonTap(context),
//               )),
//         ],
//       ),
//     );
//   }
//
//   _onCloseBtnPress(BuildContext context) {
//     if (Navigator.canPop(context)) {
//       Navigator.of(context).pop();
//     }
//   }
//
//   _onChangePasswordClick(BuildContext context) async {
//     final Map userData = await HiveUtility.getDataFromHiveDb(
//         boxName: HiveKeys.userDataBox, key: HiveKeys.userInfoKey);
//     if (context.mounted) {
//       NavigatorUtility.navigateToChangePasswordScreen(
//           context: context, changePasswordDetails: {'userData': userData});
//     }
//   }
//
//   // _onSetPasswordClick(BuildContext context) async {
//   //   NavigatorUtility.navigateToForgotPasswordScreen(context: context);
//   // }
//
//   _logoutButtonTap(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) => ConfirmationDialogWidget(
//               titleText: ValueString.confirmLogoutText,
//               subTitleText: "",
//               firstBtnTap: () => Navigator.pop(context),
//               secondBtnTap: () => _logoutEvent(context),
//               firstBtnText: ValueString.cancelText,
//               secondBtnText: ValueString.logoutText,
//               showDivider: true,
//               icon: SvgImage(
//                 iconSize: Size(10.w, 5.h),
//                 icon: AssetsConstant.alertIcon,
//               ),
//               style: TextStyleUtility.interTextStyle(
//                   ColorsUtility.black, 17.sp, FontWeight.normal, false),
//               firstBtnStyle: TextStyleUtility.interTextStyle(
//                   ColorsUtility.black, 17.sp, FontWeight.normal, false),
//               secondBtnStyle: TextStyleUtility.interTextStyle(
//                   ColorsUtility.maroon, 17.sp, FontWeight.normal, false),
//             ));
//   }
//
//   _logoutEvent(BuildContext context) {
//     InternetUtil.isInternetAvailable((status) async {
//       if (status) {
//         Navigator.pop(context);
//         Navigator.pop(context);
//         dashboardBloc.add(LogoutEvent());
//       } else {
//         ToastUtility.showToast(ValueString.noInternetConnection.toString());
//       }
//     });
//   }
// }
