import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/date_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/extensions/extensions.dart';
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
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/date_time_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/dropdown_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_work_permit_type_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/dropdown_text_work_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/label_button_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_less_list_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/widgets/show_more_list.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class CreateEditWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const CreateEditWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<CreateEditWorkPermitScreen> createState() =>
      _CreateEditWorkPermitScreenState();
}

class _CreateEditWorkPermitScreenState
    extends State<CreateEditWorkPermitScreen> {
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

  /// ValueNotifiers
  ValueNotifier<List> selectedLabourListNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> selectedPPEListNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> selectedCheckListNotifier = ValueNotifier([]);
  ValueNotifier<Map> getPlantLocationsNotifier = ValueNotifier({});
  ValueNotifier<bool> isPermitAlreadyApprovedNotify = ValueNotifier(false);

  List<Map> defaultCheckList = [];
  List<Map> defaultPPEList = [];
  Map allWorkPermitTypes = {};
  Map allContractors = {};
  Map selectedWorkPermitType = {};
  Map selectedContractor = {};
  Map selectedProject = {};
  Map selectedLocation = {};

  List workPermitCategoryList = [
    {'radioTitle': ValueString.regularWorkPermitText, 'value': 1},
    // {'radioTitle': ValueString.holidayWorkPermitText, 'value': 2},
  ];

  DashboardBloc? dashboardBloc;
  final GlobalKey<FormState> _formKeyCreateWorkPermit = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    if (widget.workDetails['editWorkDetails'] != null) {
      workPermitTypeController.text =
          widget.workDetails['editWorkDetails']['workPermitTypeName'];
      projectController.text = widget.workDetails['selectedProject']['name'];
      selectedProject = widget.workDetails['selectedProject'];

      locationController.text =
          widget.workDetails['editWorkDetails']['locationName'];
      selectedLocation = {
        'id': widget.workDetails['editWorkDetails']['locationId'],
        'name': locationController.text
      };
      //
      //
      selectedLabourListNotifier.value.clear();

      selectedLabourListNotifier.value = widget.workDetails['editWorkDetails']
          ['contractor'][0]['assignedLabours'];

      workDescriptionController.text =
          widget.workDetails['editWorkDetails']['description'];
      //
      selectedCheckListNotifier.value.clear();
      selectedCheckListNotifier.value = List<Map>.from(
          widget.workDetails['editWorkDetails']['assignedCheckList']);
      selectedPPEListNotifier.value.clear();
      selectedPPEListNotifier.value =
          List<Map>.from(widget.workDetails['editWorkDetails']['assignedPPE']);

      workPermitStartDate = DateUtility.convertToDateTime(
          widget.workDetails['editWorkDetails']['startDate']['_seconds'],
          widget.workDetails['editWorkDetails']['startDate']['_nanoseconds']);

      startDateController.text =
          DateFormat('dd MMM yyyy').format(workPermitStartDate!);
      endDateController.text =
          DateFormat('dd MMM yyyy').format(workPermitStartDate!);

      debugPrint('data-./${widget.workDetails['editWorkDetails']}',
          wrapWidth: 580);
    }
    _getAllWorkPermitTypeEvent();
  }

  _getAllWorkPermitTypeEvent() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetAllWorkPermitTypeEvent(requestData: const {}));
      }
    });
  }

  _getAllContractorEvent() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetAllContractorEvent(requestData: const {}));
      }
    });
  }

  _getPlantLocationsEvent(value) {
    selectedProject = value;
    selectedLocation = {};

    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        projectController.text = value['name'];
        Future.delayed(const Duration(milliseconds: 50), () {
          dashboardBloc!.add(GetPlantLocationsEvent(requestData: {
            'plantId': value['id'].toString(),
          }));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorsUtility.lightGrey2,
          appBar: _buildAppBar(),
          body: BlocConsumer<DashboardBloc, DashboardStates>(
            builder: (context, DashboardStates state) {
              if (state is GetAllContractorLoadedState ||
                  state is GetPlantLocationsLoadedState ||
                  state is CreateEditWorkPermitLoadingState ||
                  state is GetPlantLocationsLoadingState) {}

              return _body();
            },
            listener: (BuildContext context, DashboardStates state) {
              if (state is DashboardLoadingState) {
                ProgressBar.show(context);
              }

              if (state is GetPlantLocationsLoadingState) {
                ProgressBar.show(context);
              }

              if (state is CreateEditWorkPermitLoadingState) {
                ProgressBar.show(context);
              }

              if (state is GetAllWorkPermitTypeLoadedState) {
                ProgressBar.dismiss(context);
                _updateAllWorkPermitType(state.getAllWorkPermitTypeModel);
              }
              if (state is GetAllContractorLoadedState) {
                ProgressBar.dismiss(context);
                _updateAllContractorType(state);
              }

              if (state is GetPlantLocationsLoadedState) {
                ProgressBar.dismiss(context);
                _updatePlantLocationsType(state);
              }

              if (state is CreateWorkPermitLoadedState) {
                ProgressBar.dismiss(context);
                _navigateToDashboardScreen(context);
                ToastUtility.showToast(state.createWorkPermitModel.message);
              }

              if (state is EditWorkPermitLoadedState) {
                ProgressBar.dismiss(context);
                ToastUtility.showToast(
                    ValueString.updateWorkPermitSuccessMessage);

                _navigateToDashboardScreen(context);
              }

              if (state is DashboardErrorState) {
                ProgressBar.dismiss(context);
                ToastUtility.showToast(state.message.toString(), true);
                _isPermitAlreadyApproved(state.message);
              }
            },
          ),
          bottomSheet: SizedBox(
            width: buildWidth(context),
            child: BottomNavigationWidget(
                btnKey: WidgetKeys.createWorkPermitScreenBtnKey,
                btnTitle: widget.workDetails['editWorkDetails'] == null
                    ? ValueString.createWorkPermitBtnText
                    : ValueString.updateWorkPermitBtnText,
                onTap: () => _onCreateEditWorkPermitClick()),
          ),
        ),
      ),
    );
  }

  _isPermitAlreadyApproved(message) {
    if (message.toString().contains("has already been")) {
      isPermitAlreadyApprovedNotify.value = true;
    }
  }

  _updateAllWorkPermitType(GetAllWorkPermitTypeModel workPermitTypes) {
    allWorkPermitTypes = workPermitTypes.toJson();

    if (widget.workDetails['editWorkDetails'] != null) {
      selectedWorkPermitType = allWorkPermitTypes['data'].firstWhere((item) =>
          item['id'] ==
          widget.workDetails['editWorkDetails']['workPermitTypeId']);
      initCheckListPPEDataForEditWorkPermit(selectedWorkPermitType);
    }
    _getAllContractorEvent();
  }

  _updateAllContractorType(state) {
    allContractors = state.getAllContractorModel.toJson();
    if (widget.workDetails['editWorkDetails'] != null) {
      selectedContractor = allContractors['data'].firstWhere((item) =>
          item['id'] ==
          widget.workDetails['editWorkDetails']['contractor'][0]
              ['contractorId']);
      contractorController.text = widget.workDetails['editWorkDetails']
          ['contractor'][0]['contractorName'];
    }
  }

  _updatePlantLocationsType(state) {
    selectedLocation = {};
    locationController.text = "";
    getPlantLocationsNotifier.value = state.getPlantLocationsModel.toJson();
  }

  String? _validateWorkPermitType() {
    return workPermitTypeController.text == "" ||
            workPermitTypeController.text.isEmpty
        ? ValueString.workPermitTypeEmptyText
        : null;
  }

  String? _validateStartDate() {
    return startDateController.text == "" || startDateController.text.isEmpty
        ? ValueString.workPermitStartDateEmptyText
        : null;
  }

  String? _validateContractor() {
    return selectedContractor.isEmpty
        ? ValueString.workPermitContractorEmptyText
        : null;
  }

  String? _validateWorkDescription() {
    return workDescriptionController.text
        .trim()
        .validateEmpty(ValueString.workPermitDescriptionEmptyText);
  }

  String? _validateProjectDetails() {
    return selectedProject.isEmpty
        ? ValueString.workPermitProjectEmptyText
        : null;
  }

  String? _validateProjectLocation() {
    return selectedLocation.isEmpty
        ? ValueString.workPermitLocationEmptyText
        : null;
  }

  _prepareLabourList() {
    List<Map<String, String>> labourList = [];
    List selectedLabourList = selectedLabourListNotifier.value.toList();
    for (int index = 0; index < selectedLabourList.length; ++index) {
      labourList.add({
        "id": selectedLabourList[index]['id'],
        "name": selectedLabourList[index]['name'],
        "laborType": selectedLabourList[index]['laborType']
      });
    }

    return labourList;
  }

  _onCreateEditWorkPermitClick() {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKeyCreateWorkPermit.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else if (selectedLabourListNotifier.value.isEmpty) {
          ToastUtility.showToast(ValueString.workPermitLabourEmptyText);
        } else {
          final Map userData = await HiveUtility.getDataFromHiveDb(
              boxName: HiveKeys.userDataBox, key: HiveKeys.userInfoKey);

          if (widget.workDetails['editWorkDetails'] == null) {
            Map<String, dynamic> requestData = {
              "plantId": selectedProject['id'].toString(),
              "plantName": selectedProject['name'].toString(),
              "contractor": [
                {
                  "contractorId": selectedContractor['id'].toString(),
                  "contractorName": contractorController.text.toString(),
                  "assignedLabours": _prepareLabourList()
                }
              ],
              "description": workDescriptionController.text.toString(),
              "workPermitTypeId": selectedWorkPermitType['id'].toString(),
              "startDate": workPermitStartDate?.toIso8601String(),
              "endDate": workPermitStartDate?.toIso8601String(),
              "isHolidayWorkPermit": false,
              "holidayId": "",
              "assignedCheckList": selectedCheckListNotifier.value.toList(),
              "assignedPPE": selectedPPEListNotifier.value.toList(),
              "locationId": selectedLocation['id'].toString(),
              "locationName": selectedLocation['name'].toString(),
              "statusId": "1",
              "status": "New",
              "createdBy": userData['id'].toString(),
              "updatedBy": userData['id'].toString()
            };

            _createEditWorkPermitEvent(requestData);
          } else {
            Map<String, dynamic> requestData = {
              "plantId": selectedProject['id'].toString(),
              "plantName": selectedProject['name'].toString(),
              "id": widget.workDetails['editWorkDetails']['id'],
              "contractor": [
                {
                  "contractorId": selectedContractor['id'].toString(),
                  "contractorName": contractorController.text.toString(),
                  "assignedLabours": _prepareLabourList()
                }
              ],
              "description": workDescriptionController.text.toString(),
              "workPermitTypeId": selectedWorkPermitType['id'].toString(),
              "startDate": workPermitStartDate?.toIso8601String(),
              "endDate": workPermitStartDate?.toIso8601String(),
              "isHolidayWorkPermit": false,
              "holidayId": "",
              "assignedCheckList": selectedCheckListNotifier.value.toList(),
              "assignedPPE": selectedPPEListNotifier.value.toList(),
              "locationId": selectedLocation['id'].toString(),
              "locationName": selectedLocation['name'].toString(),
              "statusId": "1",
              "status": "New",
              "createdBy": userData['id'].toString(),
              "updatedBy": userData['id'].toString()
            };

            _editEditWorkPermitEvent(requestData);
          }
        }
      });
    }
  }

  void _createEditWorkPermitEvent(requestData) async {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else if (selectedLabourListNotifier.value.isEmpty) {
        ToastUtility.showToast(ValueString.workPermitLabourEmptyText);
      } else {
        dashboardBloc!.add(CreateWorkPermitEvent(requestData: requestData));
      }
    });
  }

  void _editEditWorkPermitEvent(requestData) async {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else if (selectedLabourListNotifier.value.isEmpty) {
        ToastUtility.showToast(ValueString.workPermitLabourEmptyText);
      } else {
        dashboardBloc!.add(EditWorkPermitEvent(requestData: requestData));
      }
    });
  }

  _navigateToDashboardScreen(context) {
    // NavigatorUtility.navigateToDashboardScreen(context: context);
    Navigator.pop(context, true);
  }

  _body() {
    return Form(
      key: _formKeyCreateWorkPermit,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                SizedBox(height: 5.w),

                AbsorbPointer(
                  absorbing: widget.workDetails['editWorkDetails'] != null
                      ? true
                      : false,
                  child: DropdownTextWorkWidget(
                    isDisableField:
                        widget.workDetails['editWorkDetails'] != null
                            ? true
                            : false,
                    controller: workPermitTypeController,
                    labelText: ValueString.workPermitTypeInfoText,
                    hintText: ValueString.selectWorkPermitTypeText,
                    isRequiredField: true,
                    onTap: () {},
                    isDropdownOpen: false,
                    titleKeyName: 'workPermitTypename',
                    validator: (selectedWorkPermitType) =>
                        _validateWorkPermitType(),
                    dropdownList: allWorkPermitTypes.isNotEmpty &&
                            allWorkPermitTypes['data'] != null
                        ? allWorkPermitTypes['data']
                        : [],
                    selectedValue: (value) {
                      workPermitTypeController.text =
                          value['workPermitTypename'].toString();
                      selectedWorkPermitType = value;
                      initDataOnWorkPermitTypeSelection(value);
                    },
                  ),
                ),
                SizedBox(height: 4.w),
                AbsorbPointer(
                  absorbing: widget.workDetails['editWorkDetails'] != null
                      ? true
                      : false,
                  child: DropdownTextWidget(
                    controller: projectController,
                    labelText: ValueString.selectProjectText,
                    hintText: ValueString.selectProjectText,
                    isRequiredField: true,
                    isDisableField:
                        widget.workDetails['editWorkDetails'] != null
                            ? true
                            : false,
                    onTap: () {},
                    isDropdownOpen: false,
                    validator: (projectDetails) => _validateProjectDetails(),
                    dropdownList: widget.workDetails['assignedProjects'] ?? [],
                    selectedValue: (value) => _getPlantLocationsEvent(value),
                  ),
                ),
                SizedBox(height: 4.w),
                AbsorbPointer(
                  absorbing: widget.workDetails['editWorkDetails'] != null
                      ? true
                      : false,
                  child: DropdownTextWidget(
                    controller: locationController,
                    isDisableField:
                        widget.workDetails['editWorkDetails'] != null
                            ? true
                            : false,
                    labelText: ValueString.selectLocationText,
                    hintText: ValueString.selectLocationText,
                    isRequiredField: true,
                    onTap: () {},
                    isDropdownOpen: false,
                    validator: (selectedWorkPermitType) =>
                        _validateProjectLocation(),
                    dropdownList: getPlantLocationsNotifier.value.isNotEmpty
                        ? getPlantLocationsNotifier.value['data']
                        : [],
                    selectedValue: (value) {
                      selectedLocation = value;
                      locationController.text = value['name'].toString();
                    },
                  ),
                ),
                SizedBox(height: 4.w),
                DropdownTextWorkWidget(
                  controller: contractorController,
                  labelText: ValueString.selectContractorText,
                  hintText: ValueString.selectContractorText,
                  isRequiredField: true,
                  onTap: () {},
                  validator: (selectedWorkPermitType) {
                    return _validateContractor();
                  },
                  isDropdownOpen: false,
                  titleKeyName: 'name',
                  dropdownList:
                      allContractors.isNotEmpty ? allContractors['data'] : [],
                  selectedValue: (value) {
                    contractorController.text = value['name'].toString();
                    selectedContractor = value;
                    selectedLabourListNotifier.value =
                        List.from(selectedLabourListNotifier.value)..clear();
                  },
                ),
                SizedBox(height: 4.w),
                LabelTextWidget(
                    controller: workDescriptionController,
                    labelText: ValueString.workDescriptionText,
                    hintText: ValueString.workDescriptionHintText,
                    isRequiredField: true,
                    minLines: 3,
                    maxLines: 5,
                    isChangeBorderColor: true,
                    validator: (selectedWorkPermitType) =>
                        _validateWorkDescription(),
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack, 16, FontWeight.w400, false),
                    hintStyle: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                    onTap: () {}),
                SizedBox(height: 4.w),

                ///----------------------------
                ValueListenableBuilder(
                    valueListenable: selectedLabourListNotifier,
                    builder: (context, child, snapshot) {
                      return LabelButtonWidget(
                          btnKey: WidgetKeys.addLaboursBtnKey,
                          labelText: (selectedLabourListNotifier.value.isEmpty)
                              ? ValueString.labourNotAddedText
                              : ValueString.labourListText,
                          btnTitleText: ValueString.addLaboursText,
                          onBtnTap: () {
                            if (selectedContractor.isNotEmpty) {
                              _navigateToAddMoreLabourDetailsScreen(context, {
                                'contractorDetails': selectedContractor,
                                'minNumberOfPeople':
                                    selectedWorkPermitType['minNumberOfPeople'],
                                'labourSelectedList':
                                    selectedLabourListNotifier.value
                              });
                            } else {
                              ToastUtility.showToast(
                                  ValueString.contractorIsEmptyText);
                            }
                          });
                    }),
                SizedBox(height: 4.w),
                ValueListenableBuilder(
                    valueListenable: selectedLabourListNotifier,
                    builder: (context, child, snapshot) {
                      return ShowMoreLessListWidget(
                          workDetailsList: selectedLabourListNotifier.value,
                          keyName: 'name');
                    }),
                SizedBox(height: 6.w),

                ///----------------------------
                LabelButtonWidget(
                    btnKey: WidgetKeys.addMoreChecklistBtnKey,
                    labelText: ValueString.checkListText,
                    btnTitleText: ValueString.addMoreBtnText,
                    onBtnTap: () =>
                        _navigateToAddMoreChecklistDetailsScreen(context, {
                          'defaultCheckList': defaultCheckList,
                          'moreSelectedChecklistList':
                              selectedCheckListNotifier.value
                        })),
                SizedBox(height: 4.w),
                ValueListenableBuilder(
                    valueListenable: selectedCheckListNotifier,
                    builder: (context, child, snapshot) => ShowMoreListWidget(
                        selectedDataList: selectedCheckListNotifier.value)),
                SizedBox(height: 6.w),
                LabelButtonWidget(
                    btnKey: WidgetKeys.addMorePPEListBtnKey,
                    labelText: ValueString.ppeListText,
                    btnTitleText: ValueString.addMoreBtnText,
                    onBtnTap: () =>
                        _navigateToAddMorePPEDetailsScreen(context, {
                          'defaultPPEList': defaultPPEList,
                          'moreSelectedPPEList': selectedPPEListNotifier.value
                        })),
                SizedBox(height: 4.w),
                ValueListenableBuilder(
                    valueListenable: selectedPPEListNotifier,
                    builder: (context, child, snapshot) => ShowMoreListWidget(
                          selectedDataList: selectedPPEListNotifier.value,
                          isPPEList: true,
                        )),
                SizedBox(height: 6.w),
                AbsorbPointer(
                  absorbing: widget.workDetails['editWorkDetails'] != null
                      ? true
                      : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 42.w,
                        child: DateTimeWidget(
                          key: Key(WidgetKeys.startDateDrpDownKey),
                          isDisableField:
                              widget.workDetails['editWorkDetails'] != null
                                  ? true
                                  : false,
                          controller: startDateController,
                          labelText: ValueString.startDateInfoText,
                          labelHintText: ValueString.startDateHintInfoText,
                          helpText: ValueString.startDateHintInfoText,
                          isRequiredField: true,
                          durationInStartDays: 1,
                          durationInLastDays: 1,
                          validator: (selectedWorkPermitType) {
                            return _validateStartDate();
                          },
                          onSelection: (startDate) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            workPermitStartDate =
                                DateTime.fromMillisecondsSinceEpoch(startDate);
                            endDateController.text =
                                DateUtility.formatTimestampDate(startDate);
                            startDateController.text =
                                DateUtility.formatTimestampDate(startDate);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 42.w,
                        child: DateTimeWidget(
                          key: Key(WidgetKeys.endDateDrpDownKey),
                          isDisableField:
                              widget.workDetails['editWorkDetails'] != null
                                  ? true
                                  : false,
                          controller: endDateController,
                          labelText: ValueString.endDateInfoText,
                          labelHintText: ValueString.endDateHintInfoText,
                          helpText: ValueString.endDateHintInfoText,
                          isRequiredField: true,
                          durationInStartDays: 1,
                          durationInLastDays: 1,
                          validator: (selectedWorkPermitType) {
                            return _validateStartDate();
                          },
                          onSelection: (endDate) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime.fromMicrosecondsSinceEpoch(endDate);
                            startDateController.text =
                                DateUtility.formatTimestampDate(endDate);
                            endDateController.text =
                                DateUtility.formatTimestampDate(endDate);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.w),
              ]))),
    );
  }

  initCheckListPPEDataForEditWorkPermit(value) {
    defaultCheckList = List<Map>.from(value['checklist']);
    defaultPPEList = List<Map>.from(value['ppe']);
  }

  initDataOnWorkPermitTypeSelection(value) {
    defaultCheckList = List<Map>.from(value['checklist']);
    selectedCheckListNotifier.value.clear();
    selectedCheckListNotifier.value = defaultCheckList;

    selectedCheckListNotifier.value
        .sort((a, b) => (a['name']).compareTo(b['name']));

    defaultPPEList = List<Map>.from(value['ppe']);
    selectedPPEListNotifier.value.clear();
    selectedPPEListNotifier.value = defaultPPEList;
    selectedPPEListNotifier.value
        .sort((a, b) => (a['name']).compareTo(b['name']));
  }

  _navigateToAddMoreLabourDetailsScreen(
      BuildContext context, addDetailsMap) async {
    if (workPermitTypeController.text.isEmpty) {
      ToastUtility.showToast(ValueString.workTypeIsEmptyText);
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      Map selectedDetailsMap;
      selectedDetailsMap =
          await NavigatorUtility.navigateToAddMoreLabourDetailsScreen(
              context: context, addDetailsMap: addDetailsMap);
      updateLabourList(selectedDetailsMap);
    }
  }

  updateLabourList(selectedDetailsMap) {
    if (!selectedDetailsMap['isFromBackButton']) {
      selectedLabourListNotifier.value = selectedDetailsMap['selectedList'];
    }
  }

  _navigateToAddMoreChecklistDetailsScreen(
      BuildContext context, addDetailsMap) async {
    if (workPermitTypeController.text.isEmpty) {
      ToastUtility.showToast(ValueString.workTypeIsEmptyText);
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      Map selectedDetailsMap;
      selectedDetailsMap =
          await NavigatorUtility.navigateToAddMoreChecklistDetailsScreen(
              context: context, addDetailsMap: addDetailsMap);
      updateCheckList(selectedDetailsMap);
    }
  }

  updateCheckList(selectedDetailsMap) {
    if (!selectedDetailsMap['isFromBackButton']) {
      selectedCheckListNotifier.value = selectedDetailsMap['selectedList'];
    }
  }

  _navigateToAddMorePPEDetailsScreen(
      BuildContext context, addDetailsMap) async {
    if (workPermitTypeController.text.isEmpty) {
      ToastUtility.showToast(ValueString.workTypeIsEmptyText);
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      Map selectedDetailsMap;
      selectedDetailsMap =
          await NavigatorUtility.navigateToAddMorePPEDetailsScreen(
              context: context, addDetailsMap: addDetailsMap);
      updatePPEList(selectedDetailsMap);
    }
  }

  updatePPEList(selectedDetailsMap) {
    if (!selectedDetailsMap['isFromBackButton']) {
      selectedPPEListNotifier.value = selectedDetailsMap['selectedList'];
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: widget.workDetails['editWorkDetails'] == null
            ? ValueString.createWorkPermitText
            : ValueString.editWorkPermitText,
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
    print('val->${isPermitAlreadyApprovedNotify.value}');
    if (Navigator.canPop(context)) {
      Navigator.pop(context, isPermitAlreadyApprovedNotify.value);
    }
  }
}
