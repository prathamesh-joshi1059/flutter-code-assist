import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/routes/navigator_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/extensions/extensions.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/progress_bar.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/asset_constants.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_bloc.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_events.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_states.dart';
import 'package:work_permit_mobile_app/modules/login/widgets/heading_text_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKeyForgotPassword = GlobalKey<FormState>();
  LoginBloc? loginBloc;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        backgroundColor: ColorsUtility.white,
        // appBar: _buildAppBar(),
        body: BlocConsumer<LoginBloc, LoginStates>(
          builder: (context, snapshot) {
            return _body();
          },
          listener: (BuildContext context, LoginStates state) {
            if (state is PasswordResetEmailLoadingState) {
              ProgressBar.show(context);
            }
            if (state is PasswordResetEmailLoadedState) {
              ProgressBar.dismiss(context);
              _navigateToLoginScreen(context);
            }
            if (state is PasswordResetEmailErrorState) {
              ProgressBar.dismiss(context);
              ToastUtility.showToast(state.message.toString());
            }
          },
        ),
      ),
    );
  }

  // PreferredSizeWidget _buildAppBar() {
  //   return PreferredSize(
  //     preferredSize: const Size.fromHeight(kToolbarHeight),
  //     child: CustomAppBar(
  //       elevation: 1,
  //       bgColor: ColorsUtility.white,
  //       context: context,
  //       appBarTitle: '',
  //       titleColor: ColorsUtility.lightBlack,
  //       isCenterTitle: false,
  //       isBackButton: false,
  //       leading: IconButton(
  //         icon: SvgPicture.asset(
  //           AssetsConstant.backArrowIcon,
  //           width: 4.5.w,
  //           height: 4.5.w,
  //         ),
  //         onPressed: () => _onBackButtonPress(context),
  //       ),
  //     ),
  //   );
  // }

  _onBackButtonPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyForgotPassword,
        child: Stack(
          children: [
            Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  icon: SvgPicture.asset(
                    AssetsConstant.backArrowIcon,
                    width: 4.5.w,
                    height: 4.5.w,
                  ),
                  onPressed: () => _onBackButtonPress(context),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  AssetsConstant.curveIcon,
                  fit: BoxFit.contain,
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 22.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingTextWidget(
                      headingText: ValueString.forgotPasswordText,
                      subHeadingText: ValueString.resetPasswordSubText,
                    ),
                    SizedBox(height: buildWidth(context) * .12),
                    LabelTextWidget(
                      key: const Key(WidgetKeys.emailIdTextFieldKey),
                      controller: emailController,
                      labelText: ValueString.emailText,
                      hintText: ValueString.emailIdHintText,
                      isRequiredField: true,
                      hintStyle: TextStyleUtility.interTextStyle(
                          ColorsUtility.gray, 16, FontWeight.w400, false),
                      validator: (email) => _validateEmailId(email),
                      keyboardType: TextInputType.text,
                      onTap: () {},
                    ),
                    SizedBox(height: 8.w),
                    SizedBox(
                      width: buildWidth(context),
                      child: CustomAppButton(
                        key: const Key(WidgetKeys.sendInstructionBtnKey),
                        text: ValueString.sendInstructionsBtnText,
                        backgroundColor: ColorsUtility.purpleColor,
                        verticalPadding: 10,
                        circularRadius: 8,
                        onPressed: () => _onSendInstructionPressed(),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String? _validateEmailId(String emailId) {
    return emailController.text.validateEmail(emailId);
  }

  void _onSendInstructionPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKeyForgotPassword.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          // _onSendInstructionClick(context);
          loginBloc!.add(PasswordResetEmailEvent(
              requestData: {"email": emailController.text.trim()}));
        }
      });
    }
  }

  // _onSendInstructionClick(BuildContext context) async {
  //   NavigatorUtility.navigateToSetPasswordScreen(context: context);
  // }

  _navigateToLoginScreen(BuildContext context) {
    ToastUtility.showToast(ValueString.passwordResetText);
    NavigatorUtility.navigateToLoginScreen(context: context);
  }
}
