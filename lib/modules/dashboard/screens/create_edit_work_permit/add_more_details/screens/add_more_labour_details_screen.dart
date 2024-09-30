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
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/add_more_details/widgets/labour_checkbox_label_widget.dart';

class AddMoreLabourDetailsScreen extends StatefulWidget {
  final Map addDetailsMap;

  const AddMoreLabourDetailsScreen({super.key, required this.addDetailsMap});

  @override
  State<AddMoreLabourDetailsScreen> createState() =>
      _AddMoreLabourDetailsScreenState();
}

class _AddMoreLabourDetailsScreenState
    extends State<AddMoreLabourDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<List<Map>> searchResultNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> selectedListNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> defaultSelectedListNotifier = ValueNotifier([]);
  ValueNotifier<List> getAllLabourDetailListNotifier = ValueNotifier([]);
  final List<Map> workDetailsList = [
    {'imgUrl': '', 'descriptionText': '', 'value': 1},
    {'imgUrl': '', 'descriptionText': ''},
    {'imgUrl': '', 'descriptionText': '', 'value': 2},
    {'imgUrl': '', 'descriptionText': '', 'value': 3},
    {'imgUrl': '', 'descriptionText': '', 'value': 4},
    {'imgUrl': '', 'descriptionText': '', 'value': 5},
    {'imgUrl': '', 'descriptionText': '', 'value': 6},
  ];
  DashboardBloc? dashboardBloc;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    initLabourList();
    getDetails();
  }

  initLabourList() {
    if (widget.addDetailsMap['labourSelectedList'].isNotEmpty) {
      defaultSelectedListNotifier.value.clear();
      defaultSelectedListNotifier.value =
          List<Map>.from(widget.addDetailsMap['labourSelectedList']);
    }
  }

  getDetails() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetLabourByContractorEvent(requestData: {
          'contractorId':
              widget.addDetailsMap['contractorDetails']['id'].toString()
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
            return ProgressBar.showLoadingWidget(context);
          }
          return _body();
        }, listener: (BuildContext context, DashboardStates state) {
          if (state is GetLabourByContractorLoadedState) {
            var data = jsonEncode(state.getLabourByContractorModel.data);
            getAllLabourDetailListNotifier.value = jsonDecode(data);
          }
          if (state is DashboardErrorState) {
            ToastUtility.showToast(state.message.toString());
          }
        }),
        bottomSheet: SizedBox(
          width: buildWidth(context),
          child: BottomNavigationWidget(
              btnKey: WidgetKeys.addLaboursBtnKey,
              btnTitle: ValueString.addBtnText.toString(),
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
                    hintText: ValueString.searchLabourText.toString(),
                    onChange: (text) => _onSearchTextChanged(text, 'name'),
                    isChangeBorderColor: true,
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
                SizedBox(height: 3.w),
                TextWidget(getLaborNoteText(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.greyBlack, 16, FontWeight.normal, false),
                    softWrap: true),
                SizedBox(height: 5.w),
                ValueListenableBuilder(
                    valueListenable: searchResultNotifier,
                    builder: (context, child, snapshot) {
                      return LabourCheckboxLabelWidget(
                        workPermitCategoryList: getDetailsList(),
                        defaultPermitCategoryList:
                            defaultSelectedListNotifier.value,
                        onChange: (selectedList) {
                          selectedListNotifier.value = selectedList;
                        },
                      );
                    })
              ]),
        ));
  }

  _onSearchTextChanged(searchText, keyName) {
    List<Map>? searchResult = [];
    List tempList = getAllLabourDetailListNotifier.value;
    searchResultNotifier.value.clear();
    if (searchText.toString().isEmpty) {
      searchResultNotifier.value = searchResult;
      return;
    }

    if (searchText.isNotEmpty) {
      searchResult = tempList
          .where((workDetails) =>
              workDetails[keyName].toLowerCase().contains(searchText) ||
              workDetails[keyName].contains(searchText))
          .cast<Map>()
          .toList();
      searchResultNotifier.value = searchResult;
    } else {
      searchResult = [];
      searchResultNotifier.value = searchResult;
    }
  }

  getDetailsList() {
    return searchResultNotifier.value.isNotEmpty
        ? searchResultNotifier.value
        : (searchController.text.isNotEmpty)
            ? []
            : (getAllLabourDetailListNotifier.value.isNotEmpty)
                ? getAllLabourDetailListNotifier.value
                : [];
  }

  _onBtnPress(BuildContext context) {
    if (widget.addDetailsMap['minNumberOfPeople'] >
        selectedListNotifier.value.length) {
      ToastUtility.showToast(
          "Please select minimum ${widget.addDetailsMap['minNumberOfPeople']} labours");
    } else if (Navigator.canPop(context)) {
      selectedListNotifier.value
          .sort((a, b) => (a['name']).compareTo(b['name']));
      Navigator.pop(context, {
        'selectedList': selectedListNotifier.value,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': false
      });
    }
  }

  getLaborNoteText() {
    return "Note: Minimum ${widget.addDetailsMap['minNumberOfPeople'].toString()} Labours required to create work permit";
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.selectLaboursText.toString(),
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
          Padding(
            padding: EdgeInsets.only(right: buildWidth(context) * .06),
            child: ValueListenableBuilder(
                valueListenable: selectedListNotifier,
                builder: (context, child, snapshot) {
                  return Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsUtility.lightGrey3),
                    padding: EdgeInsets.all(buildWidth(context) * .03),
                    child: TextWidget(
                        selectedListNotifier.value.length.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.purpleColor,
                            18,
                            FontWeight.w500,
                            false)),
                  );
                }),
          )
        ],
      ),
    );
  }

  _onBackButtonPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, {
        'selectedList': selectedListNotifier.value,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': true
      });
    }
  }
}
