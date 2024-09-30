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
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_close_work_permit_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/work_details_widget.dart';

class AllCloseWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const AllCloseWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<AllCloseWorkPermitScreen> createState() =>
      _AllCloseWorkPermitScreenState();
}

class _AllCloseWorkPermitScreenState extends State<AllCloseWorkPermitScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GetAllCloseWorkPermitModel? getAllCloseWorkPermitModel;
  ValueNotifier<List<Datum>> filterDataByStatusNotifier = ValueNotifier([]);
  DashboardBloc? dashboardBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _fetchAllCloseWorkPermit();
  }

  _fetchAllCloseWorkPermit() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetAllCloseWorkPermitEvent(requestData: {
          'plantId': widget.workDetails['plantDetails']['id'].toString(),
          'statusId': widget.workDetails['appBarTitle'] ==
                  ValueString.closurePendingBtnText
              ? "3"
              : "4",
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
            if (state is GetAllClosePermitEventLoadedState) {
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

  void filterData(GetAllClosePermitEventLoadedState state) {
    filterDataByStatusNotifier.value.clear();
    if (widget.workDetails['appBarTitle'] ==
        ValueString.closurePendingBtnText) {
      filterDataByStatusNotifier.value = state.getAllCloseWorkPermitModel.data
          .where((workData) => workData.isReviewed == true)
          .toList();
    } else {
      filterDataByStatusNotifier.value = state.getAllCloseWorkPermitModel.data
          .where((workData) =>
              workData.createdBy == widget.workDetails['userId'].toString())
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
                              padding: EdgeInsets.only(
                                  top: buildHeight(context) * .40),
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
    _navigateToCloseWorkPermitScreen(context, {
      'plantDetails': widget.workDetails['plantDetails'],
      'id': filterDataByStatusNotifier.value[index].id,
      'appBarTitle': widget.workDetails['appBarTitle'],
      'closeWorkPermitDetails': filterDataByStatusNotifier.value[index].toJson()
    });
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
                        4,
                        (index) => Padding(
                              padding: EdgeInsets.only(
                                  top: (index == 0) ? 0 : 1.w,
                                  bottom: (index == 9) ? 0 : 1.w),
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
        appBarTitle: widget.workDetails['appBarTitle'],
        //ValueString.closePendingBtnText,
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

  _navigateToCloseWorkPermitScreen(
      BuildContext context, Map workDetails) async {
    bool status = await NavigatorUtility.navigateToCloseWorkPermitScreen(
        context: context, workDetails: workDetails);
    if (status) {
      _fetchAllCloseWorkPermit();
    }
  }
}
