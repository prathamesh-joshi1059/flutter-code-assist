import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/date_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/progress_bar.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/approval_bottom_navigation_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/date_time_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/dropdown_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/widgets/remark_popup_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/dropdown_text_work_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/label_button_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_less_checklist_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_less_list_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class ApprovalWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const ApprovalWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<ApprovalWorkPermitScreen> createState() =>
      _ApprovalWorkPermitScreenState();
}

class _ApprovalWorkPermitScreenState extends State<ApprovalWorkPermitScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  ValueNotifier<List> initialPPEListNotifier = ValueNotifier([]);
  ValueNotifier<List> initialCheckListNotifier = ValueNotifier([]);
  ValueNotifier<List> initialLabourListNotifier = ValueNotifier([]);
  TextEditingController workDescriptionController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController workPermitTypeController = TextEditingController();
  TextEditingController contractorController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  ValueNotifier<bool> isPermitAlreadyApprovedNotify = ValueNotifier(false);

  List workPermitCategoryList = [
    {'radioTitle': ValueString.regularWorkPermitText, 'value': 1},
    // {'radioTitle': ValueString.holidayWorkPermitText, 'value': 2},
  ];
  DashboardBloc? dashboardBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    initWorkData();
  }

  initWorkData() {
    workPermitTypeController.text =
        widget.workDetails['approvalPendingWorkDetails']['workPermitTypeName'];
    // workPermitTypeController.text =
    //     widget.workDetails['workPermitTypeDetails']['name'];
    projectController.text = widget.workDetails['plantDetails']['name'];
    projectController.text = widget.workDetails['plantDetails']['name'];
    locationController.text =
        widget.workDetails['approvalPendingWorkDetails']['locationName'];

    contractorController.text = widget.workDetails['approvalPendingWorkDetails']
        ['contractor'][0]['contractorName'];

    workDescriptionController.text =
        widget.workDetails['approvalPendingWorkDetails']['description'];
    initialLabourListNotifier.value = List.from(initialLabourListNotifier.value)
      ..addAll(widget.workDetails['approvalPendingWorkDetails']['contractor'][0]
          ['assignedLabours']);
    initialCheckListNotifier.value = List.from(initialCheckListNotifier.value)
      ..addAll(widget.workDetails['approvalPendingWorkDetails']
          ['assignedCheckList']);
    initialPPEListNotifier.value = List.from(initialPPEListNotifier.value)
      ..addAll(widget.workDetails['approvalPendingWorkDetails']['assignedPPE']);

    startDateController.text = DateUtility.formatTimestampDateFromEpoch(widget
        .workDetails['approvalPendingWorkDetails']['startDate']['_seconds']);
    endDateController.text = DateUtility.formatTimestampDateFromEpoch(widget
        .workDetails['approvalPendingWorkDetails']['endDate']['_seconds']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorsUtility.white,
        appBar: _buildAppBar(),
        body: BlocConsumer<DashboardBloc, DashboardStates>(
          builder: (context, DashboardStates state) {
            return _body();
          },
          listener: (BuildContext context, DashboardStates state) {
            if (state is DashboardLoadingState) {
              ProgressBar.show(context);
            }
            if (state is ApproveRejectWorkPermitLoadedState) {
              ProgressBar.dismiss(context);
              _popOnSuccess(
                  context, state.approveRejectSuspendPermitModel.data);
            }
            if (state is SuspendWorkPermitLoadedState) {
              ProgressBar.dismiss(context);
              _popOnSuccess(
                  context, state.approveRejectSuspendPermitModel.data);
            }
            if (state is DashboardErrorState) {
              ProgressBar.dismiss(context);
              ToastUtility.showToast(state.message.toString(), true);
              _isPermitAlreadyApproved(state.message);
            }
          },
        ),
        bottomSheet: ApprovalBottomNavigationWidget(
            btnKey1: WidgetKeys.approveBtnKey,
            btnTitle1: ValueString.approveBtnText,
            onTap1: () => onBtnClick(ValueString.approveBtnText),
            btnKey2: WidgetKeys.rejectBtnKey,
            btnTitle2: ValueString.rejectBtnText,
            onTap2: () => onBtnClick(ValueString.rejectBtnText),
            btnKey3: WidgetKeys.suspendBtnKey,
            btnTitle3: ValueString.suspendBtnText,
            onTap3: () => onBtnClick(ValueString.suspendBtnText)),
      ),
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

  onBtnClick(btnTitle) {
    if (btnTitle == ValueString.approveBtnText) {
      remarkController.clear();
      _approveRejectWorkPermitBtnPress(ValueString.approveBtnText);
    } else {
      _showDialog(context, btnTitle);
    }
  }

  _body() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LabelWithTextWidget(
            labelText: ValueString.categoryText,
            titleText: ValueString.regularWorkPermitText,
            labelStyle: TextStyleUtility.interTextStyle(
                ColorsUtility.red, 16, FontWeight.w500, false),
            textStyle: TextStyleUtility.interTextStyle(
                ColorsUtility.lightBlack, 16, FontWeight.w500, false),
          ),
          // AbsorbPointer(
          //   child: RadioLabelWidget(
          //     labelText: ValueString.workPermitCategoryText,
          //     isRequiredField: true,
          //     workPermitCategoryList: workPermitCategoryList,
          //     onChange: (workDetails) {
          //       print('workDetails->$workDetails');
          //     },
          //   ),
          // ),
          SizedBox(height: 2.w),
          AbsorbPointer(
            child: DropdownTextWorkWidget(
              controller: workPermitTypeController,
              labelText: ValueString.workPermitTypeInfoText,
              hintText: ValueString.selectWorkPermitTypeText,
              isRequiredField: true,
              onTap: () {},
              isDisableField: true,
              isDropdownOpen: false,
              titleKeyName: 'workPermitTypename',
              dropdownList: const [],
              selectedValue: (value) => null,
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: DropdownTextWidget(
              controller: projectController,
              labelText: ValueString.selectProjectText,
              hintText: ValueString.selectProjectText,
              isRequiredField: true,
              onTap: () {},
              isDisableField: true,
              isDropdownOpen: false,
              dropdownList: const [],
              selectedValue: (value) => null,
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: DropdownTextWidget(
              controller: locationController,
              labelText: ValueString.selectLocationText,
              hintText: ValueString.selectLocationText,
              isRequiredField: true,
              onTap: () {},
              isDisableField: true,
              isDropdownOpen: false,
              dropdownList: const [],
              selectedValue: (value) => null,
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: DropdownTextWorkWidget(
              controller: contractorController,
              labelText: ValueString.selectContractorText,
              hintText: ValueString.selectContractorText,
              isRequiredField: true,
              isDisableField: true,
              onTap: () {},
              isDropdownOpen: false,
              titleKeyName: 'name',
              dropdownList: const [],
              selectedValue: (value) => null,
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: LabelTextWidget(
                controller: workDescriptionController,
                labelText: ValueString.workDescriptionText,
                hintText: ValueString.workDescriptionHintText,
                isRequiredField: true,
                isDisableField: true,
                minLines: 3,
                maxLines: 5,
                style: TextStyleUtility.interTextStyle(
                    ColorsUtility.gray, 16, FontWeight.w400, false),
                onTap: () {}),
          ),
          SizedBox(height: 4.w),

          ///----------------------------
          ValueListenableBuilder(
              valueListenable: initialLabourListNotifier,
              builder: (context, child, snapshot) {
                return LabelButtonWidget(
                    btnKey: WidgetKeys.addLaboursBtnKey,
                    labelText: ValueString.labourListText,
                    btnTitleText: ValueString.addLaboursText,
                    isShowButton: false,
                    onBtnTap: () => null);
              }),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: initialLabourListNotifier,
              builder: (context, child, snapshot) {
                return ShowMoreLessListWidget(
                    workDetailsList: initialLabourListNotifier.value,
                    keyName: 'name');
              }),
          SizedBox(height: 6.w),

          ///----------------------------
          LabelButtonWidget(
              btnKey: WidgetKeys.addMoreChecklistBtnKey,
              labelText: ValueString.checkListText,
              btnTitleText: ValueString.addMoreBtnText,
              isShowButton: false,
              onBtnTap: () => null),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: initialCheckListNotifier,
              builder: (context, child, snapshot) {
                return ShowMoreLessCheckListWidget(
                    initialCheckList: initialCheckListNotifier.value,
                    selectedCheckList: const [],
                    keyName: 'name');
              }),
          SizedBox(height: 6.w),
          LabelButtonWidget(
              btnKey: WidgetKeys.addMorePPEListBtnKey,
              labelText: ValueString.ppeListText,
              btnTitleText: ValueString.addMoreBtnText,
              isShowButton: false,
              onBtnTap: () => null),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: initialPPEListNotifier,
              builder: (context, child, snapshot) {
                return ShowMoreLessCheckListWidget(
                    initialCheckList: initialPPEListNotifier.value,
                    selectedCheckList: const [],
                    isPPEList: true,
                    keyName: 'name');
              }),
          SizedBox(height: 6.w),
          AbsorbPointer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 42.w,
                  child: DateTimeWidget(
                    key: Key(WidgetKeys.startDateDrpDownKey),
                    controller: startDateController,
                    labelText: ValueString.startDateInfoText,
                    labelHintText: ValueString.startDateHintInfoText,
                    helpText: ValueString.startDateHintInfoText,
                    isRequiredField: true,
                    isDisableField: true,
                    durationInStartDays: 1,
                    durationInLastDays: 5,
                    onSelection: (startDate) => null,
                  ),
                ),
                SizedBox(
                  width: 42.w,
                  child: DateTimeWidget(
                    key: Key(WidgetKeys.endDateDrpDownKey),
                    controller: endDateController,
                    labelText: ValueString.endDateInfoText,
                    labelHintText: ValueString.endDateHintInfoText,
                    helpText: ValueString.endDateHintInfoText,
                    isRequiredField: true,
                    isDisableField: true,
                    durationInStartDays: 1,
                    durationInLastDays: 5,
                    onSelection: (endDate) => null,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.w),
        ])));
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.approvalPendingText,
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

  _showDialog(BuildContext context, btnTitle) {
    remarkController.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RemarkPopupWidget(
            remarkController: remarkController,
            submitBtnPress: (remarkText) =>
                _onSubmitBtnPress(context, remarkText, btnTitle));
      },
    );
  }

  _onSubmitBtnPress(context, remarkText, btnTitle) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    remarkController.text = remarkText.toString();
    if (btnTitle == ValueString.suspendBtnText) {
      _suspendWorkPermitBtnPress();
    } else {
      _approveRejectWorkPermitBtnPress(btnTitle);
    }
  }

  _approveRejectWorkPermitBtnPress(String btnTitle) {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        var userData = await HiveUtility.getDataFromHiveDb(
          boxName: HiveKeys.userDataBox,
          key: HiveKeys.userInfoKey,
        );
        dashboardBloc!.add(ApproveRejectWorkPermitEvent(requestData: {
          "permitId": widget.workDetails['approvalPendingWorkDetails']['id'],
          "isApprove": btnTitle == ValueString.approveBtnText ? true : false,
          "isReject": btnTitle == ValueString.rejectBtnText ? true : false,
          "updatedBy": userData['id'],
          "remark": remarkController.text.toString()
        }));
      }
    });
  }

  _suspendWorkPermitBtnPress() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        var userData = await HiveUtility.getDataFromHiveDb(
          boxName: HiveKeys.userDataBox,
          key: HiveKeys.userInfoKey,
        );
        dashboardBloc!.add(SuspendWorkPermitEvent(requestData: {
          "permitId": widget.workDetails['approvalPendingWorkDetails']['id'],
          "updatedBy": userData['id'],
          "remark": remarkController.text.toString()
        }));
      }
    });
  }
}
