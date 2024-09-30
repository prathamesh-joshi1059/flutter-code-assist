import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/model/fetch_all_work_permits_by_status_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/work_details_widget.dart';

class AllReviewWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const AllReviewWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<AllReviewWorkPermitScreen> createState() =>
      _AllReviewWorkPermitScreenState();
}

class _AllReviewWorkPermitScreenState extends State<AllReviewWorkPermitScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FetchAllWorkPermitsByStatusModel? fetchAllWorkPermitsByStatusModel;
  ValueNotifier<List<Datum>> filterDataByStatusNotifier = ValueNotifier([]);
  DashboardBloc? dashboardBloc;
  bool isUserSuperAdminVal = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _fetchWorkPermitByType();
  }

  _fetchWorkPermitByType() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(FetchAllWorkPermitsByStatusEvent(requestData: {
          'plantId': widget.workDetails['plantDetails']['id'].toString(),
          'statusId': "3"
        }));
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
            if (state is FetchAllWorkPermitsByStatusLoadedState) {
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

  void filterData(FetchAllWorkPermitsByStatusLoadedState state) async {
    fetchAllWorkPermitsByStatusModel = state.fetchAllWorkPermitsByStatusModel;

    isUserSuperAdminVal = await isUserSuperAdmin();

    if (!isUserSuperAdminVal) {
      filterDataByStatusNotifier.value = fetchAllWorkPermitsByStatusModel!.data
          .where((workData) =>
              workData.createdBy == widget.workDetails['userId'].toString() &&
              !workData.isReviewed)
          .toList();
    } else {
      filterDataByStatusNotifier.value = fetchAllWorkPermitsByStatusModel!.data
          .where((workData) => workData.isReviewed == false)
          .toList();
    }
  }

  _body() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: Column(
          children: [
            SizedBox(
              height: buildHeight(context) * .83,
              child: SingleChildScrollView(
                child: ValueListenableBuilder(
                    valueListenable: filterDataByStatusNotifier,
                    builder: (context, child, snapshot) {
                      return (filterDataByStatusNotifier.value.isNotEmpty)
                          ? Column(
                              children: List.generate(
                                  filterDataByStatusNotifier.value.length,
                                  (index) => Padding(
                                        padding: EdgeInsets.only(
                                            top: (index == 0 ||
                                                    index ==
                                                        filterDataByStatusNotifier
                                                            .value.length)
                                                ? 0
                                                : 2.w,
                                            bottom: 2.w),
                                        child: WorkDetailsWidget(
                                          workDetailsByType:
                                              prepareWorkDetailsByTypeMap(
                                                  index),
                                          onTap: (title) => onTap(index),
                                        ),
                                      )),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: const NoDataAvailableWidget(),
                            );
                    }),
              ),
            ),
          ],
        ));
  }

  prepareWorkDetailsByTypeMap(index) {
    return {
      'isLoading': false,
      'projectName': widget.workDetails['plantDetails']['name'],
      'workPermitTypeName':
          filterDataByStatusNotifier.value[index].workPermitTypeName.toString(),
      'workDateTimeDetails': {
        'startDate': filterDataByStatusNotifier.value[index].startDate.seconds
            .toString(),
        'endDate':
            filterDataByStatusNotifier.value[index].endDate.seconds.toString()
      }
    };
  }

  onTap(index) {
    if (isUserSuperAdminVal &&
        filterDataByStatusNotifier.value[index].createdBy !=
            widget.workDetails['userIad']) {
      _navigateToCloseWorkPermitScreen(context, {
        'appTitle': ValueString.inProgressBtnText,
        'workDetails': filterDataByStatusNotifier.value[index].toJson(),
        'selectedProject': widget.workDetails['plantDetails'],
      });
    } else {
      _navigateToAllReviewWorkPermitScreen(context, {
        'plantDetails': widget.workDetails['plantDetails'],
        'id': filterDataByStatusNotifier.value[index].id,
        'reviewWorkDetails': filterDataByStatusNotifier.value[index].toJson()
      });
    }
  }

  _navigateToCloseWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    NavigatorUtility.navigateToApproveRejectSuspendScreen(
        context: context, workDetails: workDetails);
  }

  _bodyWithShimmer() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
        child: Column(
          children: [
            ShimmerWidget(
              child: SizedBox(
                height: 78.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        10,
                        (index) => Padding(
                              padding: EdgeInsets.only(
                                  top: (index == 0) ? 0 : 2.w,
                                  bottom: (index == 9) ? 0 : 2.w),
                              child: WorkDetailsWidget(
                                workDetailsByType: const {'isLoading': true},
                                onTap: (title) {},
                              ),
                            )),
                  ),
                ),
              ),
            ),
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
        appBarTitle: ValueString.inProgressBtnText,
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

  _navigateToAllReviewWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    var status = await NavigatorUtility.navigateToReviewWorkPermitScreen(
        context: context, workDetails: workDetails);

    status ??= false;
    if (status) {
      _fetchWorkPermitByType();
    }
  }
}
