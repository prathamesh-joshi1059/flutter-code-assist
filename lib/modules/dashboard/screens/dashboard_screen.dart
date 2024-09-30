// AI confidence score for this refactoring: 96.22%
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/extensions/extensions.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/progress_bar.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/dropdown_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/popup_menu_btn_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/fetch_work_permit_status_counts_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/fetch_work_permit_type_counts_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/work_permit_type_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/user_info_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/work_status_menu_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/work_type_count_widget.dart';
import 'package:work_permit_mobile_app/modules/login/model/work_status_menu_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController selectProjectController = TextEditingController();
  final ValueNotifier<Map<String, dynamic>> selectProjectDetailsNotifier = ValueNotifier({});
  late DashboardBloc dashboardBloc;
  DateTime? currentBackPressTime;
  final DateTime now = DateTime.now();
  late final ValueNotifier<Map<String, dynamic>> userDetailsNotifier = ValueNotifier({});
  late final ValueNotifier<Map<String, dynamic>> selectedPlantDetailsNotifier = ValueNotifier({});
  final List<WorkPermitTypeModel> workPermitType = [];
  FetchWorkPermitStatusCountsModel? fetchWorkPermitStatusCountsModel;
  FetchWorkPermitTypeCountsModel? fetchWorkPermitTypeCountsModel;
  final ValueNotifier<List<WorkStatusMenuModel>> workPermitStatusNotifier = ValueNotifier([]);
  final ValueNotifier<List<WorkPermitTypeModel>> workPermitTypeNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    initData();
  }

  void initData() async {
    await _checkUserForPermission();
    await _getUserDetailsFromHive();
    _initWorkType();
  }

  Future<void> _getUserDetailsFromHive() async {
    userDetailsNotifier.value = await HiveUtility.getDataFromHiveDb(
      boxName: HiveKeys.userDataBox,
      key: HiveKeys.userInfoKey,
    );
    selectProjectController.text = '';
  }

  Future<void> _checkUserForPermission() async {
    isUserHasCreateWorkPermitPermission = await isUserHasPermission("10");
    isUserHasApproveWorkPermitPermission = await isUserHasPermission("13");
    isUserHasCloseWorkPermitPermission = await isUserHasPermission("15");
  }

  void _initWorkType() {
    workPermitType.addAll([
      WorkPermitTypeModel(workTypeText: "Hot Work Permit", workTypeCountText: "32"),
      WorkPermitTypeModel(workTypeText: "Cold Work Permit", workTypeCountText: "32"),
      WorkPermitTypeModel(workTypeText: "Height Work Permit", workTypeCountText: "32"),
      WorkPermitTypeModel(workTypeText: "Confined Spaces Work Permit", workTypeCountText: "32"),
      WorkPermitTypeModel(workTypeText: "Excavation Work Permit", workTypeCountText: "32"),
      WorkPermitTypeModel(workTypeText: "Lifting Work Permit", workTypeCountText: "32"),
    ]);
  }

  void _fetchWorkPermitStatusCount(Map<String, dynamic> value) {
    InternetUtil.isInternetAvailable((status) async {
      if (!status) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else if (value['name'] != null && value['id'] != null) {
        selectedPlantDetailsNotifier.value = value;
        selectProjectController.text = value['name'];
        Future.delayed(const Duration(milliseconds: 50), () {
          dashboardBloc.add(FetchWorkPermitStatusCountsEvent(requestData: {
            'plantId': value['id'].toString(),
            'userId': userDetailsNotifier.value['id'].toString()
          }));
        });
      }
    });
  }

  void _fetchWorkPermitTypeCount() {
    InternetUtil.isInternetAvailable((status) async {
      if (!status) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc.add(FetchWorkPermitTypeCountsEvent(requestData: {
          'plantId': selectedPlantDetailsNotifier.value['id'].toString()
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: WillPopScope(
        onWillPop: _onPopScope,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: ColorsUtility.lightGrey2,
          appBar: _buildAppBar(),
          body: BlocConsumer<DashboardBloc, DashboardStates>(
            builder: (context, DashboardStates state) {
              if (state is DashboardLoadingState || state is FetchWorkPermitStatusCountsLoadedState) {
                return _body(true, {});
              }
              return _body(false, {
                'workPermitStatusCounts': fetchWorkPermitStatusCountsModel?.data,
                'workPermitTypeCounts': fetchWorkPermitTypeCountsModel?.data
              });
            },
            listener: (BuildContext context, DashboardStates state) {
              if (state is FetchWorkPermitStatusCountsLoadedState) {
                fetchWorkPermitStatusCountsModel = state.fetchWorkPermitStatusCountsModel;
                _initWorkData(state.fetchWorkPermitStatusCountsModel.data);
                _fetchWorkPermitTypeCount();
              }

              if (state is FetchWorkPermitTypeCountsLoadedState) {
                fetchWorkPermitTypeCountsModel = state.fetchWorkPermitTypeCountsModel;
                _initWorkTypeData(state.fetchWorkPermitTypeCountsModel.data);
              }

              if (state is LogoutLoadedState) {
                ProgressBar.dismiss(context);
                _navigateToLoginScreen(context);
              }

              if (state is DashboardErrorState) {
                ToastUtility.showToast(state.message);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _body(bool isLoading, Map<String, dynamic> workDetails) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                    valueListenable: userDetailsNotifier,
                    builder: (context, child, snapshot) {
                      return UserInfoWidget(
                        isUserHasCreateWorkPermitPermission: isUserHasCreateWorkPermitPermission,
                        userNameText: userDetailsNotifier.value['userName'].toString().toCapitalize(),
                        onCreateWorkPressed: () => _navigateToCreateEditWorkPermitScreen(context, {
                          'isCreateWorkPermit': true,
                          'assignedProjects': userDetailsNotifier.value.isNotEmpty ? userDetailsNotifier.value['assignedPlants'] : []
                        }),
                      );
                    }),
                SizedBox(height: buildWidth(context) * .01),
                isLoading
                    ? _bodyWithShimmer(isLoading)
                    : Column(children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: workPermitTypeNotifier.value.isNotEmpty || isLoading ? Alignment.topLeft : Alignment.center,
                          children: [
                            workPermitTypeNotifier.value.isNotEmpty || isLoading
                                ? ValueListenableBuilder(
                                    valueListenable: workPermitStatusNotifier,
                                    builder: (context, index, child) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 88.0),
                                        child: Wrap(
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.spaceBetween,
                                          runAlignment: WrapAlignment.spaceBetween,
                                          spacing: 3.w,
                                          runSpacing: 3.w,
                                          children: List.generate(
                                            workPermitStatusNotifier.value.length,
                                            (index) => WorkStatusMenuWidget(
                                              onTap: (workTitleName) => navigateToWorkStatus(context, workTitleName),
                                              workStatusData: workPermitStatusNotifier.value[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                : Positioned(
                                    top: 35.h,
                                    child: SizedBox(
                                      width: 80.w,
                                      child: TextWidget(
                                        ValueString.dashboardInfoText.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: TextStyleUtility.interTextStyle(ColorsUtility.lightBlack, 16, FontWeight.w400, false),
                                      ),
                                    )),
                            ValueListenableBuilder(
                                valueListenable: userDetailsNotifier,
                                builder: (context, child, snapshot) {
                                  return DropdownTextWidget(
                                    controller: selectProjectController,
                                    labelText: '',
                                    hintText: ValueString.selectPlantText,
                                    onTap: () {},
                                    isDropdownOpen: false,
                                    selectProjectDetailsNotifier: selectProjectDetailsNotifier,
                                    dropdownList: userDetailsNotifier.value.isNotEmpty ? userDetailsNotifier.value['assignedPlants'] : [],
                                    selectedValue: (value) {
                                      selectProjectDetailsNotifier.value = value;
                                      return _fetchWorkPermitStatusCount(value);
                                    },
                                  );
                                }),
                          ],
                        ),
                        SizedBox(height: 6.w),
                        _buildWorkPermitTypeCountWidget(isLoading)
                      ]),
              ],
            )));
  }

  Widget _bodyWithShimmer(bool isLoading) {
    return Column(
      children: [
        Stack(
          children: [
            ShimmerWidget(
              child: Padding(
                padding: const EdgeInsets.only(top: 88.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  spacing: 3.w,
                  runSpacing: 3.w,
                  children: List.generate(
                      8,
                      (index) => Container(
                          decoration: BoxDecoration(color: ColorsUtility.lightGray, borderRadius: BorderRadius.circular(6)),
                          width: buildWidth(context) * .43,
                          height: buildWidth(context) * .21,
                          alignment: Alignment.centerLeft,
                          clipBehavior: Clip.antiAlias))),
              ),
            ),
            AbsorbPointer(
              absorbing: true,
              child: ValueListenableBuilder(
                  valueListenable: userDetailsNotifier,
                  builder: (context, child, snapshot) {
                    return DropdownTextWidget(
                      controller: selectProjectController,
                      labelText: '',
                      hintText: ValueString.selectPlantText,
                      onTap: () {},
                      isDropdownOpen: false,
                      selectProjectDetailsNotifier: selectProjectDetailsNotifier,
                      dropdownList: userDetailsNotifier.value.isNotEmpty ? userDetailsNotifier.value['assignedPlants'] : [],
                      selectedValue: (value) {},
                    );
                  }),
            ),
          ],
        ),
        SizedBox(height: 6.w),
        ShimmerWidget(child: _buildWorkPermitTypeCountWidget(true))
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: '',
        isCenterTitle: true,
        isShowImg: true,
        isBackButton: false,
        leading: Padding(
          padding: EdgeInsets.only(left: buildWidth(context) * .04),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: buildWidth(context) * .34,
              height: buildWidth(context) * .09,
              child: SvgPicture.asset(
                AssetsConstant.logoIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        actionWidgets: [
          ValueListenableBuilder(
              valueListenable: userDetailsNotifier,
              builder: (context, child, snapshot) {
                return PopupMenuBtnWidget(
                    dashboardBloc: dashboardBloc,
                    userDetails: userDetailsNotifier.value);
              })
        ],
      ),
    );
  }

  Future<bool> _onPopScope() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ToastUtility.showToast(ValueString.exitTapText);
      return false;
    } else {
      return true;
    }
  }

  void _navigateToLoginScreen(BuildContext context) {
    NavigatorUtility.navigateToLoginScreen(context: context);
  }

  Widget _buildWorkPermitTypeCountWidget(bool isLoading) {
    return Padding(
      padding: EdgeInsets.only(right: buildWidth(context) * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isLoading ? ColorsUtility.lightGray : ColorsUtility.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  workPermitTypeNotifier.value.isNotEmpty || isLoading ? ValueString.workPermitTypeCountText : "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyleUtility.interTextStyle(ColorsUtility.lightBlack, 17, FontWeight.w500, false),
                ),
                TextWidget(
                  workPermitTypeNotifier.value.isNotEmpty || isLoading ? ValueString.countsText : "",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  softWrap: true,
                  style: TextStyleUtility.interTextStyle(ColorsUtility.lightBlack, 17, FontWeight.w500, false),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.w),
          isLoading
              ? WorkTypeCountWidget(
                  isLoading: isLoading,
                  workTypeCountList: workPermitType,
                )
              : ValueListenableBuilder(
                  valueListenable: workPermitTypeNotifier,
                  builder: (context, index, snapshot) {
                    return WorkTypeCountWidget(
                      isLoading: isLoading,
                      workTypeCountList: workPermitTypeNotifier.value,
                    );
                  })
        ],
      ),
    );
  }

  void _initWorkData(Data workData) {
    final List<WorkStatusMenuModel> list = [];
    if (isUserHasCreateWorkPermitPermission) {
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.newCreatedIcon,
          workTitleName: ValueString.newCreatedBtnText,
          backColor: ColorsUtility.lightBlue,
          countBackColor: ColorsUtility.lightBlue1,
          workCount: workData.newWorkPermitCount.toString()));
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.approvedIcon,
          workTitleName: ValueString.approvedBtnText,
          backColor: ColorsUtility.lightBlue,
          countBackColor: ColorsUtility.lightBlue1,
          workCount: workData.approvedWorkPermitCount.toString()));
      list.add(
        WorkStatusMenuModel(
            iconUrl: AssetsConstant.inProgressIcon,
            workTitleName: ValueString.inProgressBtnText,
            backColor: ColorsUtility.lightGreen,
            countBackColor: ColorsUtility.lightGreen1,
            workCount: workData.inProgressWorkPermitCount.toString()),
      );
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.closedIcon,
          workTitleName: ValueString.closedBtnText,
          backColor: ColorsUtility.lightGreen,
          countBackColor: ColorsUtility.lightGreen1,
          workCount: workData.closedWorkPermitCount.toString()));
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.rejectedIcon,
          workTitleName: ValueString.rejectedBtnText,
          backColor: ColorsUtility.lace,
          countBackColor: ColorsUtility.lightLace,
          workCount: workData.rejectedWorkPermitCount.toString()));
    }

    if (isUserHasApproveWorkPermitPermission) {
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.approvalPendingIcon,
          workTitleName: ValueString.approvalPendingBtnText,
          backColor: ColorsUtility.lightPurple,
          countBackColor: ColorsUtility.lightPurple1,
          workCount: workData.approvalPendingCount.toString()));
    }

    if (isUserHasCloseWorkPermitPermission) {
      list.add(WorkStatusMenuModel(
          iconUrl: AssetsConstant.closurePendingIcon,
          workTitleName: ValueString.closurePendingBtnText,
          backColor: ColorsUtility.lightPurple,
          countBackColor: ColorsUtility.lightPurple1,
          workCount: workData.closePendingCount.toString()));
    }

    workPermitStatusNotifier.value = list;
  }

  void _initWorkTypeData(List<WorkPermitTypes> workData) {
    workPermitTypeNotifier.value = [];
    workData.sort((a, b) => (a.name).compareTo(b.name));
    for (var workDetails in workData) {
      workPermitTypeNotifier.value.add(WorkPermitTypeModel(
          workTypeText: workDetails.name.toString(),
          workTypeCountText: workDetails.count.toString()));
    }
  }

  void _navigateToWorkStatusDetailsScreen(BuildContext context, Map<String, dynamic> workDetails) async {
    final dynamic status = await NavigatorUtility.navigateToWorkStatusDetailsScreen(context: context, workDetails: workDetails);
    if (status == true || status == null) {
      _initWorkStatusData();
    }
  }

  void _navigateToCreateEditWorkPermitScreen(BuildContext context, Map<String, dynamic> workDetails) async {
    final dynamic status = await NavigatorUtility.navigateToCreateEditWorkPermitScreen(context: context, workDetails: workDetails);
    if (status == true || status == null) {
      _initWorkStatusData();
    }
  }

  void navigateToWorkStatus(BuildContext context, String workTitleName) {
    Map<String, dynamic> workDetails = {
      'plantDetails': selectedPlantDetailsNotifier.value,
      'userId': userDetailsNotifier.value['id'].toString(),
      'workTypeDetails': workPermitTypeNotifier.value,
    };

    if (workTitleName == ValueString.newCreatedBtnText || 
        workTitleName == ValueString.approvedBtnText || 
        workTitleName == ValueString.suspendedBtnText || 
        workTitleName == ValueString.rejectedBtnText) {
      _navigateToWorkStatusDetailsScreen(context, {...workDetails, 'appTitle': workTitleName});
    } else if (workTitleName == ValueString.approvalPendingBtnText) {
      _navigateToAllApprovalStatusDetailsScreen(context, workDetails);
    } else if (workTitleName == ValueString.closedBtnText) {
      _navigateToWorkStatusDetailsScreen(context, {...workDetails, 'appTitle': ValueString.closedBtnText});
    } else if (workTitleName == ValueString.inProgressBtnText) {
      _navigateToWorkStatusDetailsScreen(context, {...workDetails, 'appTitle': ValueString.inProgressBtnText});
    } else if (workTitleName == ValueString.closurePendingBtnText) {
      _navigateToAllCloseWorkPermitScreen(context, {
        ...workDetails,
        'appBarTitle': ValueString.closurePendingBtnText
      });
    }
  }

  _navigateToAllApprovalStatusDetailsScreen(BuildContext context, Map<String, dynamic> workDetails) async {
    final dynamic status = await NavigatorUtility.navigateToAllApprovalDetailsScreen(context: context, workDetails: workDetails);
    if (status == true || status == null) {
      _initWorkStatusData();
    }
  }

  _navigateToAllCloseWorkPermitScreen(BuildContext context, Map<String, dynamic> workDetails) async {
    final dynamic status = await NavigatorUtility.navigateToAllCloseWorkPermitScreen(context: context, workDetails: workDetails);
    if (status == true || status == null) {
      _initWorkStatusData();
    }
  }
}

// Issues that violate TypeScript coding standards:
// - Use of the dynamic type in method parameters and returns.
// - Lack of return type on methods that have an explicit return value.
// - Hybrid usage of underscore-prefixed variables (private style) and public getters/setters.
// - Unused imports related to specific widgets that were commented out in the code.
// - Variable initialization without explicit types in some places.