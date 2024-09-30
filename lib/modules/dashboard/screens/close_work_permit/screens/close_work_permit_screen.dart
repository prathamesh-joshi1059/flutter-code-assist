import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/progress_bar.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/bottom_navigation_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/confirmation_dialogue_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/close_work_permit/widgets/close_checklist_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/close_work_permit/widgets/close_ppelist_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/widgets/work_permit_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class CloseWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const CloseWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<CloseWorkPermitScreen> createState() => _CloseWorkPermitScreenState();
}

class _CloseWorkPermitScreenState extends State<CloseWorkPermitScreen> {
  ValueNotifier<bool> isPermitAlreadyApprovedNotify = ValueNotifier(false);
  DashboardBloc? dashboardBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      backgroundColor: ColorsUtility.lightGrey2,
      appBar: _buildAppBar(),
      body: BlocConsumer<DashboardBloc, DashboardStates>(
        builder: (context, DashboardStates state) {
          return _body();
        },
        listener: (BuildContext context, DashboardStates state) {
          if (state is DashboardLoadingState) {
            ProgressBar.show(context);
          }
          if (state is ClosePermitEventLoadedState) {
            ProgressBar.dismiss(context);
            _popOnSuccess(context, state.approveRejectSuspendPermitModel.data);
          }
          if (state is DashboardErrorState) {
            ProgressBar.dismiss(context);
            ToastUtility.showToast(state.message.toString(), true);
            _isPermitAlreadyApproved(state.message);
          }
        },
      ),
      bottomSheet: (widget.workDetails['appBarTitle'] ==
              ValueString.closurePendingBtnText)
          ? SizedBox(
              width: buildWidth(context),
              child: BottomNavigationWidget(
                  btnKey: WidgetKeys.closeWorkPermitBtnKey,
                  btnTitle: ValueString.closeWorkPermitBtnText,
                  onTap: () => _closeWorkPermitBtnTap(context)),
            )
          : const SizedBox.shrink(),
    );
  }

  _isPermitAlreadyApproved(message) {
    if (message.toString().contains("has already been")) {
      isPermitAlreadyApprovedNotify.value = true;
    }
  }

  _popOnSuccess(BuildContext context, msg) {
    ToastUtility.showToast(msg);
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  _body() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelWithTextWidget(
              labelText: ValueString.projectNameText,
              titleText: widget.workDetails['plantDetails']['name'],
            ),
            SizedBox(height: buildWidth(context) * .02),
            const Divider(),
            SizedBox(height: buildWidth(context) * .02),
            // Work Permit Details as an ExpansionTile
            WorkPermitDetailsWidget(
                reviewWorkDetailsList:
                    widget.workDetails['closeWorkPermitDetails']),

            SizedBox(height: buildWidth(context) * .05),
            TextWidget(
              ValueString.checkListText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w500, false),
            ),
            SizedBox(height: buildWidth(context) * .03),

            /// CheckList Details
            Column(
              children: List.generate(
                  widget
                      .workDetails['closeWorkPermitDetails']
                          ['assignedCheckList']
                      .length, (index) {
                return CloseChecklistDetailsWidget(
                    index: index,
                    checkListMap: widget.workDetails['closeWorkPermitDetails']
                        ['assignedCheckList'][index]);
              }),
            ),

            SizedBox(height: buildWidth(context) * .05),
            TextWidget(
              ValueString.ppeListText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w500, false),
            ),
            SizedBox(height: buildWidth(context) * .03),

            /// PPE Details
            Column(
              children: List.generate(
                  widget.workDetails['closeWorkPermitDetails']['assignedPPE']
                      .length, (index) {
                return ClosePPEListDetailsWidget(
                    index: index,
                    ppeListMap: widget.workDetails['closeWorkPermitDetails']
                        ['assignedPPE'][index]);
              }),
            ),
            if (widget.workDetails['appBarTitle'] ==
                ValueString.closurePendingBtnText)
              SizedBox(height: buildWidth(context) * .2),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: (widget.workDetails['appBarTitle'] ==
                ValueString.closurePendingBtnText)
            ? ValueString.closurePendingBtnText
            : ValueString.closedWorkPermitBtnText,
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
      Navigator.pop(context, isPermitAlreadyApprovedNotify.value /*false*/);
    }
  }

  _closeWorkPermitBtnTap(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => ConfirmationDialogWidget(
              titleText: ValueString.confirmCloseWorkPermitText,
              subTitleText: "",
              firstBtnTap: () => Navigator.pop(context),
              secondBtnTap: () => _onReviewWorkPermitBtnClick(context),
              firstBtnText: ValueString.noText,
              secondBtnText: ValueString.yesText,
              showDivider: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 17.sp, FontWeight.normal, false),
              firstBtnStyle: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 17.sp, FontWeight.normal, false),
              secondBtnStyle: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 17.sp, FontWeight.normal, false),
            ));
  }

  _onReviewWorkPermitBtnClick(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        var userData = await HiveUtility.getDataFromHiveDb(
          boxName: HiveKeys.userDataBox,
          key: HiveKeys.userInfoKey,
        );
        dashboardBloc!.add(CloseWorkPermitEvent(requestData: {
          "permitId": widget.workDetails['closeWorkPermitDetails']['id'],
          "updatedBy": userData['id'],
        }));
      }
    });
  }
}
