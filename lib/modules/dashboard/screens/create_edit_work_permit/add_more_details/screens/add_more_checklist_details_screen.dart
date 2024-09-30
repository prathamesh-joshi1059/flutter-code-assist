import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/progress_bar.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/svg_image.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/bottom_navigation_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';

class AddMoreChecklistDetailsScreen extends StatefulWidget {
  final Map addDetailsMap;

  const AddMoreChecklistDetailsScreen({super.key, required this.addDetailsMap});

  @override
  State<AddMoreChecklistDetailsScreen> createState() =>
      _AddMoreChecklistDetailsScreenState();
}

class _AddMoreChecklistDetailsScreenState
    extends State<AddMoreChecklistDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<List<Map>> selectedCheckListNotifier = ValueNotifier([]);
  ValueNotifier<int> selectedCheckListCountNotifier = ValueNotifier(0);

  DashboardBloc? dashboardBloc;
  List<Map> defaultCheckList = [];
  List<Map> selectedCheckList = [];
  List<Map> allCheckList = [];
  List<Map> showCheckList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    initCheckList();
  }

  initCheckList() {
    defaultCheckList = List<Map>.from(widget.addDetailsMap['defaultCheckList']);

    if (widget.addDetailsMap['moreSelectedChecklistList'].isNotEmpty) {
      selectedCheckList =
          List<Map>.from(widget.addDetailsMap['moreSelectedChecklistList']);
    }
    getDetails();
  }

  void filterCheckListData(List<Map> checkList) {
    allCheckList.clear(); // Clear previous data

    allCheckList = List<Map<String, dynamic>>.from(
        checkList.map((item) => {"id": item['id'], "name": item['name']}));

    Set<String> defaultChecklistIds =
        defaultCheckList.map((item) => item['id'] as String).toSet();

    allCheckList
        .removeWhere((item) => defaultChecklistIds.contains(item['id']));

    allCheckList
        .sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));

    showCheckList = List<Map>.from(allCheckList);
    selectedCheckListNotifier.value = List<Map>.from(showCheckList);
    selectedCheckListCountNotifier.value =
        selectedCheckList.length - defaultCheckList.length;
  }

  getDetails() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetAllChecklistEvent(requestData: const {}));
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
            return ProgressBar.showLoadingWidget(context);
          }
          return _body();
        }, listener: (BuildContext context, DashboardStates state) {
          if (state is GetAllChecklistLoadedState) {
            var data = jsonEncode(state.getAllChecklistModel.data);

            filterCheckListData(
                List<Map<dynamic, dynamic>>.from(jsonDecode(data)));
          }
          if (state is DashboardErrorState) {
            ToastUtility.showToast(state.message.toString());
          }
        }),
        bottomSheet: SizedBox(
          width: buildWidth(context),
          child: BottomNavigationWidget(
              btnKey: WidgetKeys.updateChecklistBtnKey,
              btnTitle: ValueString.updateChecklistText,
              onTap: () => _onBtnPress(context)),
        ),
      ),
    );
  }

  _body() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelTextWidget(
                    controller: searchController,
                    labelText: '',
                    hintText: ValueString.searchCheckPointText,
                    isChangeBorderColor: true,
                    onChange: (text) => _onSearchTextChanged(text, 'name'),
                    hintStyle: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                    prefixIcon: SizedBox(
                      width: 3.w,
                      height: 1.w,
                      child: SvgImage(
                        fit: BoxFit.scaleDown,
                        iconSize: Size(3.w, 3.h),
                        icon: AssetsConstant.searchIcon,
                      ),
                    ),
                    onTap: () {}),
                SizedBox(height: 5.w),
                ValueListenableBuilder(
                  valueListenable: selectedCheckListNotifier,
                  builder: (BuildContext context,
                      List<Map<dynamic, dynamic>> value, Widget? child) {
                    if (value.isNotEmpty) {
                      return SizedBox(
                        height: 67.h,
                        child: SingleChildScrollView(
                          child: Column(
                              children: List.generate(showCheckList.length,
                                  (index) => checkPointRowWidget(index))),
                        ),
                      );
                    }

                    return SizedBox(
                        height: 50.h,
                        child: NoDataAvailableWidget(
                            noDataAvailableText:
                                ValueString.noResultFoundText));
                  },
                )
              ]),
        ));
  }

  isCheckboxChecked(Map checkPoint) {
    for (int index = 0; index < selectedCheckList.length; ++index) {
      if (selectedCheckList[index]['id'] == checkPoint['id']) {
        return true;
      }
    }
    return false;
  }

  void _onCheckPointSelection(int index) {
    int i = 0;
    bool checkpointFound = false;
    for (; i < selectedCheckList.length; ++i) {
      if (selectedCheckList[i]['id'] == showCheckList[index]['id']) {
        checkpointFound = true;
        break;
      }
    }

    if (checkpointFound == false) {
      selectedCheckList.add(showCheckList[index]);

      selectedCheckListNotifier.value = List<Map>.from(selectedCheckList);
      selectedCheckListCountNotifier.value =
          selectedCheckList.length - defaultCheckList.length;
    } else {
      selectedCheckList.removeAt(i);
      selectedCheckListNotifier.value = List<Map>.from(selectedCheckList);
      selectedCheckListCountNotifier.value =
          selectedCheckList.length - defaultCheckList.length;
    }
  }

  checkPointRowWidget(index) {
    return Padding(
      padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
      child: InkWell(
        onTap: () => _onCheckPointSelection(index),
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: isCheckboxChecked(showCheckList[index])
                      ? ColorsUtility.transparent
                      : ColorsUtility.lightGrey4,
                ),
                child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                        visualDensity: const VisualDensity(
                            horizontal: VisualDensity.minimumDensity,
                            vertical: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: ColorsUtility.purpleColor,
                        checkColor: ColorsUtility.white,
                        side: BorderSide.none,
                        value: isCheckboxChecked(showCheckList[index]),
                        onChanged: (value) => _onCheckPointSelection(index))),
              ),
              SizedBox(width: 4.w),
              Row(
                children: [
                  SizedBox(
                    width: 78.w,
                    child: TextWidget(showCheckList[index]['name'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                          ColorsUtility.lightBlack,
                          16,
                          FontWeight.normal,
                          false,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSearchTextChanged(searchText, keyName) {
    List<Map>? searchResult = [];

    if (searchText.isNotEmpty) {
      searchResult = allCheckList
          .where((workDetails) =>
              workDetails[keyName].toLowerCase().contains(searchText) ||
              workDetails[keyName].contains(searchText))
          .cast<Map>()
          .toList();
      showCheckList = searchResult;
    } else {
      showCheckList = allCheckList;
    }

    selectedCheckListNotifier.value = showCheckList;
  }

  _onBtnPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, {
        'selectedList': selectedCheckList,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': false
      });
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.addMoreCheckPointsText,
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
        actionWidgets: [
          ValueListenableBuilder(
              valueListenable: selectedCheckListCountNotifier,
              builder: (BuildContext context, int value, Widget? child) {
                return Padding(
                    padding: EdgeInsets.only(right: buildWidth(context) * .06),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsUtility.lightGrey3),
                      padding: EdgeInsets.all(buildWidth(context) * .03),
                      child: TextWidget(value.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyleUtility.interTextStyle(
                              ColorsUtility.purpleColor,
                              18,
                              FontWeight.w500,
                              false)),
                    ));
              })
        ],
      ),
    );
  }

  _onBackButtonPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, {
        'selectedList': selectedCheckList,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': true
      });
    }
  }
}
