import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/date_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/date_time_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/dropdown_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/dropdown_text_work_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/label_button_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_less_list_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_list.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class ApproveRejectSuspendScreen extends StatefulWidget {
  final Map workDetails;

  const ApproveRejectSuspendScreen({super.key, required this.workDetails});

  @override
  State<ApproveRejectSuspendScreen> createState() =>
      _ApproveRejectSuspendScreenState();
}

class _ApproveRejectSuspendScreenState
    extends State<ApproveRejectSuspendScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// TextEditingController
  TextEditingController projectController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contractorController = TextEditingController();
  TextEditingController workPermitNameController = TextEditingController();
  TextEditingController workDescriptionController = TextEditingController();
  TextEditingController workPermitTypeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  DateTime? workPermitStartDate;

  /// ValueNotifier
  ValueNotifier<List> labourListNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> ppeListNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> checkListNotifier = ValueNotifier([]);

  List workPermitCategoryList = [
    {'radioTitle': ValueString.regularWorkPermitText, 'value': 1},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    workPermitTypeController.text =
        widget.workDetails['workDetails']['workPermitTypeName'];
    projectController.text = widget.workDetails['selectedProject']['name'];

    locationController.text = widget.workDetails['workDetails']['locationName'];

    contractorController.text =
        widget.workDetails['workDetails']['contractor'][0]['contractorName'];

    labourListNotifier.value.clear();
    labourListNotifier.value =
        widget.workDetails['workDetails']['contractor'][0]['assignedLabours'];

    workDescriptionController.text =
        widget.workDetails['workDetails']['description'];
    //
    checkListNotifier.value.clear();
    checkListNotifier.value =
        List<Map>.from(widget.workDetails['workDetails']['assignedCheckList']);
    ppeListNotifier.value.clear();
    ppeListNotifier.value =
        List<Map>.from(widget.workDetails['workDetails']['assignedPPE']);

    workPermitStartDate = DateUtility.convertToDateTime(
        widget.workDetails['workDetails']['startDate']['_seconds'],
        widget.workDetails['workDetails']['startDate']['_nanoseconds']);

    startDateController.text =
        DateFormat('dd MMM yyyy').format(workPermitStartDate!);
    endDateController.text =
        DateFormat('dd MMM yyyy').format(workPermitStartDate!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorsUtility.white,
        appBar: _buildAppBar(),
        body: _body(),
      ),
    );
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
          // RadioLabelWidget(
          //   labelText: ValueString.workPermitCategoryText,
          //   isRequiredField: true,
          //   workPermitCategoryList: workPermitCategoryList,
          //   onChange: (workDetails) {},
          // ),
          SizedBox(height: buildWidth(context) * .03),
          AbsorbPointer(
            child: DropdownTextWorkWidget(
              isDisableField: true,
              controller: workPermitTypeController,
              labelText: ValueString.workPermitTypeInfoText,
              hintText: ValueString.selectWorkPermitTypeText,
              isRequiredField: true,
              onTap: () {},
              isDropdownOpen: false,
              titleKeyName: 'workPermitTypename',
              dropdownList: const [],
              selectedValue: (value) {},
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: DropdownTextWidget(
              controller: projectController,
              labelText: ValueString.selectProjectText,
              hintText: ValueString.selectProjectText,
              isRequiredField: true,
              isDisableField: true,
              onTap: () {},
              isDropdownOpen: false,
              dropdownList: widget.workDetails['assignedProjects'] ?? [],
              selectedValue: (value) {},
            ),
          ),
          SizedBox(height: 4.w),
          AbsorbPointer(
            child: DropdownTextWidget(
              controller: locationController,
              isDisableField: true,
              labelText: ValueString.selectLocationText,
              hintText: ValueString.selectLocationText,
              isRequiredField: true,
              onTap: () {},
              isDropdownOpen: false,
              dropdownList: const [],
              selectedValue: (value) {},
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
              selectedValue: (value) {},
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
                isChangeBorderColor: true,
                minLines: 3,
                maxLines: 5,
                style: TextStyleUtility.interTextStyle(
                    ColorsUtility.gray, 16, FontWeight.w400, false),
                onTap: () {}),
          ),
          SizedBox(height: 4.w),

          ///----------------------------
          LabelButtonWidget(
              btnKey: WidgetKeys.addLaboursBtnKey,
              labelText: ValueString.labourListText,
              isShowButton: false,
              btnTitleText: ValueString.addLaboursText,
              onBtnTap: () {}),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: labourListNotifier,
              builder: (context, child, snapshot) {
                return ShowMoreLessListWidget(
                    workDetailsList: labourListNotifier.value, keyName: 'name');
              }),
          SizedBox(height: 6.w),

          ///----------------------------
          LabelButtonWidget(
              btnKey: WidgetKeys.addMoreChecklistBtnKey,
              labelText: ValueString.checkListText,
              btnTitleText: ValueString.addMoreBtnText,
              isShowButton: false,
              onBtnTap: () {}),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: checkListNotifier,
              builder: (context, child, snapshot) => ShowMoreListWidget(
                  selectedDataList: checkListNotifier.value)),
          SizedBox(height: 6.w),
          LabelButtonWidget(
              btnKey: WidgetKeys.addMorePPEListBtnKey,
              labelText: ValueString.ppeListText,
              btnTitleText: ValueString.addMoreBtnText,
              isShowButton: false,
              onBtnTap: () {}),
          SizedBox(height: 4.w),
          ValueListenableBuilder(
              valueListenable: ppeListNotifier,
              builder: (context, child, snapshot) => ShowMoreListWidget(
                    selectedDataList: ppeListNotifier.value,
                    isPPEList: true,
                  )),
          SizedBox(height: 6.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 42.w,
                child: AbsorbPointer(
                  child: DateTimeWidget(
                    key: Key(WidgetKeys.startDateDrpDownKey),
                    isDisableField: true,
                    controller: startDateController,
                    labelText: ValueString.startDateInfoText,
                    labelHintText: ValueString.startDateHintInfoText,
                    helpText: ValueString.startDateHintInfoText,
                    isRequiredField: true,
                    durationInStartDays: 1,
                    durationInLastDays: 1,
                    onSelection: (startDate) {},
                  ),
                ),
              ),
              SizedBox(
                width: 42.w,
                child: AbsorbPointer(
                  child: DateTimeWidget(
                    key: Key(WidgetKeys.endDateDrpDownKey),
                    isDisableField: true,
                    controller: endDateController,
                    labelText: ValueString.endDateInfoText,
                    labelHintText: ValueString.endDateHintInfoText,
                    helpText: ValueString.endDateHintInfoText,
                    isRequiredField: true,
                    durationInStartDays: 1,
                    durationInLastDays: 1,
                    onSelection: (endDate) {},
                  ),
                ),
              ),
            ],
          ),
        ])));
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: widget.workDetails['appTitle'].toString() +
            ValueString.workPermitBtnText,
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
