import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:work_permit_mobile_app/common/widgets/password_visibility_toggle.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_bloc.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_events.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_states.dart';

class ChangePasswordScreen extends StatefulWidget {
  final Map changePasswordDetails;

  const ChangePasswordScreen({super.key, required this.changePasswordDetails});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final ValueNotifier<bool> obscureNewPasswordTextNotifier =
      ValueNotifier<bool>(true);
  final ValueNotifier<bool> obscureConfirmPasswordTextNotifier =
      ValueNotifier<bool>(true);
  final GlobalKey<FormState> _formKeyChangePassword = GlobalKey<FormState>();
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    obscureNewPasswordTextNotifier.dispose();
    obscureConfirmPasswordTextNotifier.dispose();
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
            if (state is ChangePasswordLoadingState) {
              ProgressBar.show(context);
            }
            if (state is ChangePasswordLoadedState) {
              ProgressBar.dismiss(context);
              _handleChangePasswordState();
            }
            if (state is ChangePasswordErrorState) {
              ProgressBar.dismiss(context);
              ToastUtility.showToast(state.message.toString());
            }

            if (state is UpdateUserLoginStatusLoadingState) {
              ProgressBar.show(context);
            }

            if (state is UpdateUserLoginStatusLoadedState) {
              ProgressBar.dismiss(context);
              _handleNavigation();
            }

            if (state is UpdateUserLoginStatusErrorState) {
              ProgressBar.dismiss(context);
              ToastUtility.showToast(state.message.toString());
            }

            if (state is LogoutLoadingState) {
              ProgressBar.show(context);
            }

            if (state is LogoutLoadedState) {
              ProgressBar.dismiss(context);
              navigateToLoginScreen(context);
            }

            if (state is LogoutErrorState) {
              ProgressBar.dismiss(context);
            }
          },
        ),
      ),
    );
  }

  // PreferredSizeWidget _buildAppBar() {
  //   return widget.changePasswordDetails['userData']['isFirstTimeLogin']
  //       ? const PreferredSize(
  //           preferredSize: Size.zero, child: SizedBox.shrink())
  //       : PreferredSize(
  //           preferredSize: const Size.fromHeight(kToolbarHeight),
  //           child: CustomAppBar(
  //             elevation: 1,
  //             bgColor: ColorsUtility.white,
  //             context: context,
  //             appBarTitle: '',
  //             titleColor: ColorsUtility.lightBlack,
  //             isCenterTitle: false,
  //             isBackButton: false,
  //             leading: IconButton(
  //               icon: SvgPicture.asset(
  //                 AssetsConstant.backArrowIcon,
  //                 width: 4.5.w,
  //                 height: 4.5.w,
  //               ),
  //               onPressed: () => _onBackButtonPress(context),
  //             ),
  //           ),
  //         );
  // }

  _onBackButtonPress(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyChangePassword,
        child: Stack(
          children: [
            widget.changePasswordDetails['userData']['isFirstTimeLogin']
                ? const SizedBox.shrink()
                : Positioned(
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
                    TextWidget(
                        widget.changePasswordDetails['userData']
                                ['isFirstTimeLogin']
                            ? ValueString.resetPasswordText
                            : ValueString.changePasswordText,
                        style: TextStyleUtility.interTextStyle(
                            ColorsUtility.lightBlack,
                            22,
                            FontWeight.w600,
                            false),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true),
                    if (widget.changePasswordDetails['userData']
                        ['isFirstTimeLogin'])
                      Column(children: [
                        SizedBox(height: 1.w),
                        TextWidget(ValueString.changePasswordSubText,
                            style: TextStyleUtility.interTextStyle(
                                ColorsUtility.lightBlack,
                                16.sp,
                                FontWeight.w400,
                                false),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: true),
                      ]),
                    SizedBox(height: 10.w),
                    // if (widget.changePasswordDetails['userData']
                    //     ['isFirstTimeLogin'])
                    Column(
                      children: [
                        LabelTextWidget(
                          key: const Key(WidgetKeys.oldPasswordTextFieldKey),
                          controller: oldPasswordController,
                          labelText: widget.changePasswordDetails['userData']
                                  ['isFirstTimeLogin']
                              ? ValueString.systemGeneratedPasswordText
                              : ValueString.oldPasswordText,
                          hintText: widget.changePasswordDetails['userData']
                                  ['isFirstTimeLogin']
                              ? ValueString.systemGeneratedPasswordHint
                              : ValueString.oldPasswordHintText,
                          validator: (username) => _validateOldPassword(),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          isRequiredField: true,
                          onTap: () {},
                        ),
                        SizedBox(height: 5.w),
                      ],
                    ),
                    ValueListenableBuilder(
                        valueListenable: obscureNewPasswordTextNotifier,
                        builder: (context, index, child) {
                          return LabelTextWidget(
                            key: const Key(WidgetKeys.newPasswordTextFieldKey),
                            controller: newPasswordController,
                            labelText: ValueString.newPasswordText,
                            hintText: ValueString.newPasswordHintText,
                            isRequiredField: true,
                            validator: (password) =>
                                _validateNewPassword(password),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureNewPasswordTextNotifier.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            suffixIcon: PasswordVisibilityToggle(
                              obscureTextNotifier:
                                  obscureNewPasswordTextNotifier,
                            ),
                            onTap: () {},
                          );
                        }),
                    SizedBox(height: 5.w),
                    ValueListenableBuilder(
                        valueListenable: obscureConfirmPasswordTextNotifier,
                        builder: (context, index, child) {
                          return LabelTextWidget(
                            key: const Key(
                                WidgetKeys.confirmNewPasswordTextFieldKey),
                            controller: confirmNewPasswordController,
                            labelText: ValueString.confirmNewPasswordText,
                            hintText: ValueString.confirmNewPasswordHintText,
                            isRequiredField: true,
                            validator: (password) =>
                                _validateConfirmNewPassword(),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                obscureConfirmPasswordTextNotifier.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            ],
                            suffixIcon: PasswordVisibilityToggle(
                              obscureTextNotifier:
                                  obscureConfirmPasswordTextNotifier,
                            ),
                            onTap: () {},
                          );
                        }),
                    SizedBox(height: 8.w),
                    SizedBox(
                      width: buildWidth(context),
                      child: CustomAppButton(
                        key: const Key(WidgetKeys.changePasswordBtnKey),
                        text: widget.changePasswordDetails['userData']
                                ['isFirstTimeLogin']
                            ? ValueString.resetPasswordText
                            : ValueString.changePasswordBtnText,
                        backgroundColor: ColorsUtility.purpleColor,
                        verticalPadding: 10,
                        circularRadius: 8,
                        onPressed: () => _onChangePasswordBtnPressed(),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String? _validateOldPassword() {
    return oldPasswordController.text.trim().validateEmpty(
        widget.changePasswordDetails['userData']['isFirstTimeLogin']
            ? ValueString.systemGeneratedPasswordEmptyText
            : ValueString.oldPasswordIsEmptyText);
  }

  String? _validateNewPassword(String password) {
    if (oldPasswordController.text.trim().isNotEmpty &&
        newPasswordController.text.trim().isNotEmpty) {
      if (oldPasswordController.text.trim() ==
          newPasswordController.text.trim()) {
        return widget.changePasswordDetails['userData']['isFirstTimeLogin']
            ? ValueString.systemGeneratedPasswordSameText
            : ValueString.passwordSameText;
      }
    }
    return newPasswordController.text
        .trim()
        .validatePassword(password, ValueString.newPasswordIsEmptyText);
  }

  String? _validateConfirmNewPassword() {
    if (newPasswordController.text.trim() !=
        confirmNewPasswordController.text.trim()) {
      return ValueString.passwordNotMatchText;
    }
    return confirmNewPasswordController.text
        .trim()
        .validateEmpty(ValueString.confirmNewPasswordIsEmptyText);
  }

  void _onChangePasswordBtnPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKeyChangePassword.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          loginBloc!.add(ChangePasswordEvent(requestData: {
            "currentPassword": oldPasswordController.text.trim(),
            "newPassword": confirmNewPasswordController.text.trim()
          }));
        }
      });
    }
  }

  _updateUserLoginStatus() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKeyChangePassword.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          loginBloc!.add(UpdateUserLoginStatusEvent(requestData: {
            "isFirstTimeLogin": false,
            "userId": widget.changePasswordDetails['userData']['id']
          }));
        }
      });
    }
  }

  void _handleChangePasswordState() {
    if (!widget.changePasswordDetails['userData']['isFirstTimeLogin']) {
      _handleNavigation();
    } else {
      _updateUserLoginStatus();
    }
  }

  _handleNavigation() {
    loginBloc!.add(LogoutEvent());
  }

  navigateToLoginScreen(BuildContext context) {
    ToastUtility.showToast(ValueString.passwordChangedText);
    NavigatorUtility.navigateToLoginScreen(context: context);
  }
}
