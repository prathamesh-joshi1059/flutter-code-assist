import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
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
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/widgets/checklist_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/widgets/ppelist_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/widgets/work_permit_details_widget.dart';
import 'package:work_permit_mobile_app/modules/dashboard/widgets/label_with_text_widget.dart';

class ReviewWorkPermitScreen extends StatefulWidget {
  final Map workDetails;

  const ReviewWorkPermitScreen({super.key, required this.workDetails});

  @override
  State<ReviewWorkPermitScreen> createState() => _ReviewWorkPermitScreenState();
}

class _ReviewWorkPermitScreenState extends State<ReviewWorkPermitScreen> {
  List<TextEditingController>? _checkListControllers;
  List<TextEditingController>? _ppeListControllers;

  ValueNotifier<List<Map>> selectedCheckListData = ValueNotifier([]);
  ValueNotifier<Map> selectedCheckListId = ValueNotifier({});
  ValueNotifier<List<Map>> selectedPPEListData = ValueNotifier([]);
  ValueNotifier<Map> selectedPPEListId = ValueNotifier({});
  late DashboardBloc dashboardBloc;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _checkListControllers = List.generate(
        widget.workDetails['reviewWorkDetails']['assignedCheckList'].length,
        (i) => TextEditingController());
    _ppeListControllers = List.generate(
        widget.workDetails['reviewWorkDetails']['assignedPPE'].length,
        (i) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtility.lightGrey2,
      appBar: _buildAppBar(),
      body: BlocConsumer<DashboardBloc, DashboardStates>(
          builder: (context, DashboardStates state) {
        return _body();
      }, listener: (BuildContext context, DashboardStates state) {
        if (state is DashboardLoadingState) {
          ProgressBar.show(context);
        }
        if (state is ReviewWorkPermitEventLoadedState) {
          ProgressBar.dismiss(context);
          _popOnSuccess(context, state.approveRejectSuspendPermitModel.data);
        }
        if (state is DashboardErrorState) {
          ProgressBar.dismiss(context);
          ToastUtility.showToast(state.message.toString());
        }
      }),
      bottomSheet: SizedBox(
        width: buildWidth(context),
        child: BottomNavigationWidget(
            btnKey: WidgetKeys.reviewWorkPermitBtnKey,
            btnTitle: ValueString.reviewWorkPermitText,
            onTap: () => _onReviewWorkPermitBtnClick()),
      ),
    );
  }

  _popOnSuccess(BuildContext context, msg) {
    ToastUtility.showToast(msg);
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelWithTextWidget(
                labelText: ValueString.projectNameText,
                titleText: widget.workDetails['plantDetails']['name']),
            SizedBox(height: buildWidth(context) * .02),
            const Divider(),
            SizedBox(height: buildWidth(context) * .02),
            // Work Permit Details as an ExpansionTile
            WorkPermitDetailsWidget(
                reviewWorkDetailsList: widget.workDetails['reviewWorkDetails']),

            SizedBox(height: buildWidth(context) * .05),
            TextWidget(
              ValueString.checkListText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w500, false),
            ),
            SizedBox(height: buildWidth(context) * .03),

            /// CheckList Details
            Column(
              children: List.generate(
                  widget.workDetails['reviewWorkDetails']['assignedCheckList']
                      .length, (index) {
                return ChecklistDetailsWidget(
                    index: index,
                    checkListControllers: _checkListControllers!,
                    selectedCheckListId: selectedCheckListId,
                    selectedCheckListData: selectedCheckListData,
                    onSelection: (selectedCheckList) {
                      // print('selectedCheckList only->$selectedCheckList');
                    },
                    checkListMap: widget.workDetails['reviewWorkDetails']
                        ['assignedCheckList'][index]);
              }),
            ),

            SizedBox(height: buildWidth(context) * .05),
            TextWidget(
              ValueString.ppeListText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
              style: TextStyleUtility.interTextStyle(
                  ColorsUtility.lightBlack, 16, FontWeight.w500, false),
            ),
            SizedBox(height: buildWidth(context) * .03),

            /// PPE Details
            Column(
              children: List.generate(
                  widget.workDetails['reviewWorkDetails']['assignedPPE'].length,
                  (index) {
                return PPEListDetailsWidget(
                    index: index,
                    ppeListControllers: _ppeListControllers!,
                    selectedPPEListId: selectedPPEListId,
                    selectedPPEListData: selectedPPEListData,
                    onSelection: (selectedPPEListData) {},
                    ppeListMap: widget.workDetails['reviewWorkDetails']
                        ['assignedPPE'][index]);
              }),
            ),
            SizedBox(height: buildWidth(context) * .2),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppBar(
        elevation: 1,
        bgColor: ColorsUtility.white,
        context: context,
        appBarTitle: ValueString.reviewWorkPermitText,
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
      Navigator.pop(context, false);
    }
  }

  _onReviewWorkPermitBtnClick() {
    if (widget.workDetails['reviewWorkDetails']['assignedCheckList'].length !=
        selectedCheckListData.value.length) {
      ToastUtility.showToast(ValueString.selectCheckListText, true);
      return;
    }
    if (widget.workDetails['reviewWorkDetails']['assignedPPE'].length !=
        selectedPPEListData.value.length) {
      ToastUtility.showToast(ValueString.selectPPEListText, true);
      return;
    }

    // sorting by the "index"
    selectedCheckListData.value
        .sort((a, b) => a['index'].compareTo(b['index']));

    // sorting by the "index"
    selectedPPEListData.value.sort((a, b) => a['index'].compareTo(b['index']));

    debugPrint('selectedPPEListData.value-->${selectedPPEListData.value}',
        wrapWidth: 580);

    for (int i = 0; i < _checkListControllers!.length; ++i) {
      selectedCheckListData.value[i]['remark'] = _checkListControllers![i].text;
    }

    for (int i = 0; i < _ppeListControllers!.length; ++i) {
      selectedPPEListData.value[i]['remark'] = _ppeListControllers![i].text;
    }

    Map<String, dynamic> requestData = {
      "permitId": widget.workDetails['id'],
      "assignedCheckList": selectedCheckListData.value,
      "assignedPPE": selectedPPEListData.value,
    };

    reviewWorkPermitEvent(requestData);
  }

  reviewWorkPermitEvent(requestData) {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        var userData = await HiveUtility.getDataFromHiveDb(
          boxName: HiveKeys.userDataBox,
          key: HiveKeys.userInfoKey,
        );

        removeIndexFromMap(requestData);
        requestData['updatedBy'] = userData['id'];

        dashboardBloc.add(ReviewWorkPermitEvent(requestData: requestData));
      }
    });
  }

  Map removeIndexFromMap(requestData) {
    for (int i = 0; i < requestData['assignedCheckList'].length; i++) {
      requestData['assignedCheckList'][i]
          .removeWhere((key, val) => key == 'index');
    }
    for (int i = 0; i < requestData['assignedPPE'].length; i++) {
      requestData['assignedPPE'][i].removeWhere((key, val) => key == 'index');
    }

    return requestData;
  }
}
