import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/dropdown_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_work_permit_by_type_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/work_details_widget.dart';

class WorkStatusDetailsScreen extends StatefulWidget {
  final Map workDetails;

  const WorkStatusDetailsScreen({super.key, required this.workDetails});

  @override
  State<WorkStatusDetailsScreen> createState() =>
      _WorkStatusDetailsScreenState();
}

class _WorkStatusDetailsScreenState extends State<WorkStatusDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier workStatusDetailsNotifier = ValueNotifier({});
  TextEditingController selectWorkTypeController = TextEditingController();
  ValueNotifier selectWorkTypeNotifier = ValueNotifier({});
  FetchWorkPermitByTypeModel? fetchWorkPermitByTypeModel;
  DashboardBloc? dashboardBloc;
  ValueNotifier<List<Datum>> filterDataByStatusNotifier = ValueNotifier([]);

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
  void dispose() {
    super.dispose();
  }

  _fetchWorkPermitByType(workPermitTypeId) {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        Future.delayed(const Duration(milliseconds: 50), () {
          dashboardBloc!.add(FetchAllWorkPermitByTypeEvent(requestData: {
            'plantId': widget.workDetails['plantDetails']['id'],
            'workPermitType': workPermitTypeId.toString(),
            'userId': widget.workDetails['userId'].toString()
          }));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorsUtility.lightGrey2,
        appBar: _buildAppBar(),
        body: BlocConsumer<DashboardBloc, DashboardStates>(
          builder: (context, DashboardStates state) {
            if (state is DashboardLoadingState) {
              return _bodyWithShimmer();
            }
            if (state is DashboardErrorState) {
              return Center(
                  child: NoDataAvailableWidget(
                      noDataAvailableText: state.message));
            }
            return _body();
          },
          listener: (BuildContext context, DashboardStates state) {
            if (state is DashboardLoadingState) {
              // ProgressBar.show(context);
            }
            if (state is FetchAllWorkPermitByTypeLoadedState) {
              filterData(state);
            }
            if (state is DashboardErrorState) {
              ToastUtility.showToast(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  void filterData(FetchAllWorkPermitByTypeLoadedState state) async {
    bool isUserSuperAdminVal = await isUserSuperAdmin();

    fetchWorkPermitByTypeModel = state.fetchWorkPermitByTypeModel;

    List<Datum> data = fetchWorkPermitByTypeModel!.data
        .where((workData) =>
            workData.status == widget.workDetails['appTitle'].toString())
        .toList();

    if (widget.workDetails['appTitle'].toString() ==
        ValueString.inProgressBtnText) {
      if (!isUserSuperAdminVal) {
        data = data
            .where((workData) =>
                workData.createdBy == widget.workDetails['userId'].toString() &&
                !workData.isReviewed)
            .toList();
      } else {
        data = data.where((workData) => workData.isReviewed == false).toList();
      }
    } else if (!isUserSuperAdminVal) {
      data = data
          .where((workData) =>
              workData.createdBy == widget.workDetails['userId'].toString())
          .toList();
    }

    filterDataByStatusNotifier.value = data;
  }

  void filterInProgressData(FetchAllWorkPermitByTypeLoadedState state) async {
    fetchWorkPermitByTypeModel = state.fetchWorkPermitByTypeModel;

    bool isUserSuperAdminVal = await isUserSuperAdmin();

    if (!isUserSuperAdminVal) {
      filterDataByStatusNotifier.value = fetchWorkPermitByTypeModel!.data
          .where((workData) =>
              workData.createdBy == widget.workDetails['userId'].toString() &&
              !workData.isReviewed)
          .toList();
    } else {
      filterDataByStatusNotifier.value = fetchWorkPermitByTypeModel!.data
          .where((workData) => workData.isReviewed == false)
          .toList();
    }
  }

  _body() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
        child: Column(
          children: [
            Stack(
                clipBehavior: Clip.none,
                alignment: (selectWorkTypeController.text.isNotEmpty)
                    ? Alignment.topCenter
                    : Alignment.center,
                children: [
                  (selectWorkTypeController.text.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 85.0),
                          child: SizedBox(
                            height: 74.h,
                            child: SingleChildScrollView(
                              child: ValueListenableBuilder(
                                  valueListenable: filterDataByStatusNotifier,
                                  builder: (context, child, snapshot) {
                                    return (filterDataByStatusNotifier
                                            .value.isNotEmpty)
                                        ? Column(
                                            children: List.generate(
                                                filterDataByStatusNotifier
                                                    .value.length,
                                                (index) => Padding(
                                                      padding: EdgeInsets.only(
                                                          top: (index == 0 ||
                                                                  index ==
                                                                      filterDataByStatusNotifier
                                                                          .value
                                                                          .length)
                                                              ? 0
                                                              : 1.w,
                                                          bottom: 1.w),
                                                      child: WorkDetailsWidget(
                                                        workDetailsByType: {
                                                          'isLoading': false,
                                                          'projectName': widget
                                                                      .workDetails[
                                                                  'plantDetails']
                                                              ['name'],
                                                          'workPermitTypeName':
                                                              filterDataByStatusNotifier
                                                                  .value[index]
                                                                  .workPermitTypeName
                                                                  .toString(),
                                                          'workDateTimeDetails':
                                                              {
                                                            'startDate':
                                                                filterDataByStatusNotifier
                                                                    .value[
                                                                        index]
                                                                    .startDate
                                                                    .seconds
                                                                    .toString(),
                                                            'endDate':
                                                                filterDataByStatusNotifier
                                                                    .value[
                                                                        index]
                                                                    .endDate
                                                                    .seconds
                                                                    .toString()
                                                          }
                                                        },
                                                        onTap: (title) {
                                                          _navigateToScreen(
                                                              context, index);
                                                        },
                                                      ),
                                                    )),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(top: 30.h),
                                            child:
                                                const NoDataAvailableWidget(),
                                          );
                                  }),
                            ),
                          ))
                      : Positioned(
                          top: 40.h,
                          child: SizedBox(
                            width: buildWidth(context) * .88,
                            child: TextWidget(
                              ValueString.workStatusText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: TextStyleUtility.interTextStyle(
                                  ColorsUtility.lightBlack,
                                  15,
                                  FontWeight.w400,
                                  false),
                            ),
                          )),
                  ValueListenableBuilder(
                      valueListenable: workStatusDetailsNotifier,
                      builder: (context, child, snapshot) {
                        return DropdownTextWidget(
                          controller: selectWorkTypeController,
                          labelText: '',
                          hintText: ValueString.selectWorkPermitTypeText,
                          //ValueString.selectProjectText,
                          onTap: () {},
                          isDropdownOpen: false,
                          selectProjectDetailsNotifier: selectWorkTypeNotifier,
                          dropdownList: widget.workDetails['workTypeDetails'],
                          selectedValue: (value) {
                            selectWorkTypeController.text = "";
                            selectWorkTypeController.text = value['name'];
                            selectWorkTypeNotifier.value = value;
                            _fetchWorkPermitByType(value['id']);
                          },
                        );
                      }),
                ]),
          ],
        ));
  }

  _bodyWithShimmer() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
        child: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              ShimmerWidget(
                child: Padding(
                    padding: const EdgeInsets.only(top: 85.0),
                    child: SizedBox(
                      height: buildHeight(context) * .75,
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              4,
                              (index) => Padding(
                                    padding: EdgeInsets.only(
                                        top: (index == 0) ? 0 : 1.w,
                                        bottom: (index == 9) ? 0 : 1.w),
                                    child: WorkDetailsWidget(
                                      workDetailsByType: const {
                                        'isLoading': true
                                      },
                                      onTap: (title) {},
                                    ),
                                  )),
                        ),
                      ),
                    )),
              ),
              ValueListenableBuilder(
                  valueListenable: workStatusDetailsNotifier,
                  builder: (context, child, snapshot) {
                    return DropdownTextWidget(
                      controller: selectWorkTypeController,
                      labelText: '',
                      hintText: ValueString.selectWorkPermitTypeText,
                      onTap: () {},
                      isDropdownOpen: false,
                      dropdownList: const [],
                      selectedValue: (value) {},
                    );
                  }),
            ]),
          ],
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: widget.workDetails['appTitle'].toString(),
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
      Navigator.pop(context, true);
    }
  }

  _navigateToScreen(BuildContext context, int index) {
    if (widget.workDetails['appTitle'].toString() == ValueString.newBtnText) {
      _navigateToCreateEditWorkPermitScreen(context, {
        'editWorkDetails': filterDataByStatusNotifier.value[index].toJson(),
        'selectedProject': widget.workDetails['plantDetails'],
      });
    } else if (widget.workDetails['appTitle'].toString() ==
            ValueString.approvedBtnText ||
        widget.workDetails['appTitle'].toString() ==
            ValueString.rejectedBtnText ||
        widget.workDetails['appTitle'].toString() ==
            ValueString.suspendBtnText) {
      NavigatorUtility.navigateToApproveRejectSuspendScreen(
          context: context,
          workDetails: {
            'appTitle': widget.workDetails['appTitle'].toString(),
            'workDetails': filterDataByStatusNotifier.value[index].toJson(),
            'selectedProject': widget.workDetails['plantDetails'],
          });
    } else if (widget.workDetails['appTitle'].toString() ==
        ValueString.closedBtnText) {
      _navigateToCloseWorkPermitScreen(context, {
        'plantDetails': widget.workDetails['plantDetails'],
        'id': filterDataByStatusNotifier.value[index].id,
        'appBarTitle': widget.workDetails['appBarTitle'],
        'closeWorkPermitDetails':
            filterDataByStatusNotifier.value[index].toJson()
      });
    } else if (widget.workDetails['appTitle'].toString() ==
        ValueString.inProgressBtnText) {
      if (filterDataByStatusNotifier.value[index].createdBy ==
          widget.workDetails['userId'].toString()) {
        _navigateToReviewWorkPermitScreen(context, {
          'plantDetails': widget.workDetails['plantDetails'],
          'id': filterDataByStatusNotifier.value[index].id,
          'reviewWorkDetails': filterDataByStatusNotifier.value[index].toJson()
        });
      } else {
        NavigatorUtility.navigateToApproveRejectSuspendScreen(
            context: context,
            workDetails: {
              'appTitle': ValueString.inProgressBtnText,
              'workDetails': filterDataByStatusNotifier.value[index].toJson(),
              'selectedProject': widget.workDetails['plantDetails'],
            });
      }
    }
  }

  _navigateToCreateEditWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    var status = await NavigatorUtility.navigateToCreateEditWorkPermitScreen(
        context: context, workDetails: workDetails);

    status ??= false;
    if (status) {
      _fetchWorkPermitByType(selectWorkTypeNotifier.value['id']);
    }
  }

  _navigateToCloseWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    NavigatorUtility.navigateToCloseWorkPermitScreen(
        context: context, workDetails: workDetails);
  }

  _navigateToReviewWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    var status = await NavigatorUtility.navigateToReviewWorkPermitScreen(
        context: context, workDetails: workDetails);

    status ??= false;
    if (status) {
      _fetchWorkPermitByType(selectWorkTypeNotifier.value['id']);
    }
  }
}
