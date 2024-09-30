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
import 'package:work_permit_mobile_app/common/widgets/cache_network_image_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_appbar_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/no_data_available_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/shimmer_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';

class AddMorePPEDetailsScreen extends StatefulWidget {
  final Map addDetailsMap;

  const AddMorePPEDetailsScreen({super.key, required this.addDetailsMap});

  @override
  State<AddMorePPEDetailsScreen> createState() =>
      _AddMorePPEDetailsScreenState();
}

class _AddMorePPEDetailsScreenState extends State<AddMorePPEDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  ValueNotifier<List<Map>> searchResultNotifier = ValueNotifier([]);
  ValueNotifier<List<Map>> selectedPPEListNotifier = ValueNotifier([]);
  ValueNotifier<int> selectedPPEListCountNotifier = ValueNotifier(0);

  ValueNotifier<List> getAllPPEDetailListNotifier = ValueNotifier([]);
  DashboardBloc? dashboardBloc;
  List<Map> defaultPPEList = [];
  List<Map> showPPEList = [];
  List<Map> selectedPPEList = [];
  List<Map> allPPEList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    getDetails();

    initCheckList();
  }

  initCheckList() {
    selectedPPEListNotifier.value.clear();
    defaultPPEList = List<Map>.from(widget.addDetailsMap['defaultPPEList']);

    if (widget.addDetailsMap['moreSelectedPPEList'].isNotEmpty) {
      selectedPPEList =
          List<Map>.from(widget.addDetailsMap['moreSelectedPPEList']);
    }
    getDetails();
  }

  void filterPPEListWithDefaultPPEList(List<Map<String, dynamic>> ppeList) {
    allPPEList.clear();

    allPPEList = List<Map<String, dynamic>>.from(ppeList.map((item) =>
        {"id": item['id'], "name": item['name'], "image": item['image']}));
    Set<String> defaultPPEIds =
        defaultPPEList.map((item) => item['id'] as String).toSet();

    allPPEList.removeWhere((item) => defaultPPEIds.contains(item['id']));

    allPPEList.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));

    showPPEList = List<Map<String, dynamic>>.from(allPPEList);
    selectedPPEListNotifier.value =
        List<Map<String, dynamic>>.from(showPPEList);

    selectedPPEListCountNotifier.value =
        selectedPPEList.length - defaultPPEList.length;
  }

  getDetails() {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        dashboardBloc!.add(GetAllPPEEvent(requestData: const {}));
      }
    });
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
          if (state is DashboardLoadingState) {
            return ProgressBar.showLoadingWidget(context);
          }
          return _body();
        }, listener: (BuildContext context, DashboardStates state) {
          if (state is GetAllPPELoadedState) {
            var data = jsonEncode(state.getAllPPEModel.data);
            List<Map<String, dynamic>> mapList =
                List<Map<String, dynamic>>.from(jsonDecode(data));

            filterPPEListWithDefaultPPEList(mapList);
          }
          if (state is DashboardErrorState) {
            ToastUtility.showToast(state.message.toString());
          }
        }),
        bottomSheet: SizedBox(
          width: buildWidth(context),
          child: BottomNavigationWidget(
              btnKey: WidgetKeys.addPPEBtnKey,
              btnTitle: ValueString.addBtnText,
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
                    hintText: ValueString.searchPPEText,
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
                  valueListenable: selectedPPEListNotifier,
                  builder: (BuildContext context,
                      List<Map<dynamic, dynamic>> value, Widget? child) {
                    if (value.isNotEmpty) {
                      return SizedBox(
                        height: 67.h,
                        child: SingleChildScrollView(
                          child: Column(
                              children: List.generate(showPPEList.length,
                                  (index) => ppeRowWidget(index))),
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

  isCheckboxChecked(Map ppe) {
    for (int index = 0; index < selectedPPEList.length; ++index) {
      if (selectedPPEList[index]['id'] == ppe['id']) {
        return true;
      }
    }
    return false;
  }

  ppeRowWidget(index) {
    return Padding(
      padding: EdgeInsets.only(top: 2.w, bottom: 2.w),
      child: InkWell(
        onTap: () {
          // onChanged(widget.workPermitCategoryList[index]);
          _onPPESelection(index);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: isCheckboxChecked(showPPEList[index])
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
                        value: isCheckboxChecked(showPPEList[index]),
                        onChanged: (value) => _onPPESelection(index)
                        // onChanged(widget.workPermitCategoryList[index])),
                        )),
              ),
              SizedBox(width: 4.w),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                    height: 10.w,
                    child: (showPPEList[index]['image'] != null)
                        ? CacheNetworkImageWidget(
                            imageUrl: showPPEList[index]['image'].toString())
                        : ShimmerWidget(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorsUtility.gray,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(width: 2.w),
                ],
              ),
              SizedBox(
                width: 60.w,
                child: TextWidget(showPPEList[index]['name'].toString(),
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
        ),
      ),
    );
  }

  _onSearchTextChanged(searchText, keyName) {
    List<Map>? searchResult = [];

    if (searchText.isNotEmpty) {
      searchResult = allPPEList
          .where((workDetails) =>
              workDetails['name']
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              workDetails['name'].contains(searchText.toLowerCase()))
          .cast<Map>()
          .toList();

      showPPEList = searchResult;
    } else {
      searchResult = [];
      showPPEList = allPPEList;
    }

    selectedPPEListNotifier.value = showPPEList;
  }

  _onBtnPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, {
        'selectedList': selectedPPEListNotifier.value,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': false
      });
    }
  }

  void _onPPESelection(int index) {
    int i = 0;
    bool ppeFound = false;
    for (; i < selectedPPEList.length; ++i) {
      if (selectedPPEList[i]['id'] == showPPEList[index]['id']) {
        ppeFound = true;
        break;
      }
    }

    if (ppeFound == false) {
      selectedPPEList.add(showPPEList[index]);

      selectedPPEListNotifier.value = List<Map>.from(selectedPPEList);
      selectedPPEListCountNotifier.value =
          selectedPPEList.length - defaultPPEList.length;
    } else {
      selectedPPEList.removeAt(i);
      selectedPPEListNotifier.value = List<Map>.from(selectedPPEList);
      selectedPPEListCountNotifier.value =
          selectedPPEList.length - defaultPPEList.length;
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.selectPPEText,
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
                valueListenable: selectedPPEListCountNotifier,
                builder: (context, count, snapshot) {
                  return Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsUtility.lightGrey3),
                    padding: EdgeInsets.all(buildWidth(context) * .03),
                    child: TextWidget(count.toString(),
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
        'selectedList': selectedPPEListNotifier.value,
        'title': widget.addDetailsMap['appBarTitle'].toString(),
        'isFromBackButton': true
      });
    }
  }
}
