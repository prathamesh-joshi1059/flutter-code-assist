import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/confirmation_dialogue_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/info_text_widget.dart';

enum MenuItemType { USERDETAILS, CHANGEPASSWORD, LOGOUT }

class PopupMenuBtnWidget extends StatelessWidget {
  final DashboardBloc dashboardBloc;
  final Map userDetails;

  const PopupMenuBtnWidget(
      {super.key, required this.dashboardBloc, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.w),
      child: IconButton(
        icon: SvgPicture.asset(AssetsConstant.userProfileIcon,
            width: buildWidth(context) * .09,
            height: buildWidth(context) * .09),
        onPressed: () => _showPopUpMenu(
            context,
            Offset(
                buildWidth(context) * .95, AppBar().preferredSize.height + 20)),
      ),
    );
  }

  _showPopUpMenu(BuildContext context, Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    double right = buildWidth(context) - offset.dx;
    double bottom = buildHeight(context) - offset.dy;

    await showMenu<MenuItemType>(
      context: context,
      position: RelativeRect.fromLTRB(left, top, right, bottom),
      elevation: 3,
      color: ColorsUtility.white,
      items: MenuItemType.values
          .map((MenuItemType menuItemType) => PopupMenuItem<MenuItemType>(
                value: menuItemType,
                child: getMenuItemString(context, menuItemType),
              ))
          .toList(),
    ).then(
        (MenuItemType? menuItemType) => routeNavigation(context, menuItemType));
  }

  routeNavigation(BuildContext context, menuItemType) {
    switch (menuItemType) {
      case MenuItemType.USERDETAILS:
        _onProfileDetailsClick(context);
      case MenuItemType.CHANGEPASSWORD:
        _onChangePasswordClick(context);
      case MenuItemType.LOGOUT:
        _logoutButtonTap(context);
    }
  }

  getMenuItemString(BuildContext context, MenuItemType menuItemType) {
    switch (menuItemType) {
      case MenuItemType.USERDETAILS:
        return _buildUserDetails(context);
      case MenuItemType.CHANGEPASSWORD:
        return _buildChangePassword(context);
      case MenuItemType.LOGOUT:
        return _buildLogout(context);
    }
  }

  _buildUserDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: buildWidth(context) * .02),
                  TextWidget(
                    userDetails['userName'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 17, FontWeight.w500, false),
                  ),
                  TextWidget(
                    userDetails['roleName'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 14, FontWeight.w400, false),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                AssetsConstant.forwardArrowIcon,
                width: 6.5.w,
                height: 6.5.w,
              ),
            ],
          ),
          SizedBox(height: buildWidth(context) * .02),
          const Divider(
            color: ColorsUtility.lightGrey6,
            thickness: 1.0,
          )
        ],
      ),
    );
  }

  _buildChangePassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 0.h),
        child: const InfoTextButton(
          text: ValueString.changePasswordText,
          icon: AssetsConstant.changePasswordIcon,
        ));
  }

  _buildLogout(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 0.h),
        child: InfoTextButton(
          text: ValueString.logoutText,
          icon: AssetsConstant.logoutIcon,
          iconColor: ColorsUtility.red,
        ));
  }

  _onProfileDetailsClick(BuildContext context) async {
    if (context.mounted) {
      NavigatorUtility.navigateToProfileDetailsScreen(
          context: context, userDetails: userDetails);
    }
  }

  _onChangePasswordClick(BuildContext context) async {
    if (context.mounted) {
      NavigatorUtility.navigateToChangePasswordScreen(
          context: context, changePasswordDetails: {'userData': userDetails});
    }
  }

  _logoutButtonTap(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => ConfirmationDialogWidget(
              titleText: ValueString.confirmLogoutText,
              subTitleText: "",
              firstBtnTap: () => Navigator.pop(context),
              secondBtnTap: () => _logoutEvent(context),
              firstBtnText: ValueString.cancelText,
              secondBtnText: ValueString.logoutText,
              showDivider: true,
              icon: SvgImage(
                iconSize: Size(10.w, 5.h),
                icon: AssetsConstant.alertIcon,
              ),
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.black, 17.sp, FontWeight.normal, false),
              firstBtnStyle: TextStyleUtility.interTextStyle(
                  ColorsUtility.black, 17.sp, FontWeight.normal, false),
              secondBtnStyle: TextStyleUtility.interTextStyle(
                  ColorsUtility.maroon, 17.sp, FontWeight.normal, false),
            ));
  }

  _logoutEvent(BuildContext context) {
    InternetUtil.isInternetAvailable((status) async {
      if (status) {
        // Navigator.pop(context);
        Navigator.pop(context);
        dashboardBloc.add(LogoutEvent());
      } else {
        ToastUtility.showToast(ValueString.noInternetConnection.toString());
      }
    });
  }
}
