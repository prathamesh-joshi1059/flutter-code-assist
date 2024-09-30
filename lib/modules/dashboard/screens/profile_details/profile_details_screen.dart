import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/profile_details/model/user_info_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/profile_details/widgets/user_info_widget.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final Map userDetails;

  const ProfileDetailsScreen({super.key, required this.userDetails});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  ValueNotifier<List<UserInfoModel>> userDetailsList = ValueNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('userDetails->${widget.userDetails}', wrapWidth: 580);
    initData();
  }

  String getAssignedPlants() {
    String tempString = '';
    for (int i = 0; i < widget.userDetails['assignedPlants'].length; i++) {
      tempString =
          "${tempString + widget.userDetails['assignedPlants'][i]['name']}\n";
    }
    return tempString;
  }

  initData() {
    userDetailsList.value = [
      UserInfoModel(
          icon: AssetsConstant.userIcon,
          titleText: ValueString.userNameText,
          subTitleText: widget.userDetails['userName']),
      UserInfoModel(
          icon: AssetsConstant.emailIcon,
          titleText: ValueString.emailText,
          subTitleText: widget.userDetails['email']),
      UserInfoModel(
          icon: AssetsConstant.phoneIcon,
          titleText: ValueString.phoneNumberText,
          subTitleText: widget.userDetails['phoneNumber']),
      UserInfoModel(
          icon: AssetsConstant.userRoleIcon,
          titleText: ValueString.roleText,
          subTitleText: widget.userDetails['roleName']),
      UserInfoModel(
          icon: AssetsConstant.assignedPlantsIcon,
          titleText: ValueString.assignedPlantsText,
          subTitleText: getAssignedPlants()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: ColorsUtility.lightGrey2,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 7.w),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      userDetailsList.value.length,
                      (index) => UserInfoWidget(
                          icon: userDetailsList.value[index].icon,
                          titleText: userDetailsList.value[index].titleText,
                          subTitleText:
                              userDetailsList.value[index].subTitleText))))),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.profileDetailsText,
        titleColor: ColorsUtility.lightBlack,
        isCenterTitle: false,
        isBackButton: false,
        leading: IconButton(
          icon: SvgPicture.asset(
            AssetsConstant.backArrowIcon,
            width: 4.5.w,
            height: 4.5.w,
          ),
          onPressed: () => _onBackButtonPress(context),
        ),
      ),
    );
  }

  _onBackButtonPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
