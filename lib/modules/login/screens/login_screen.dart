import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/password_visibility_toggle.dart';
import 'package:work_permit_mobile_app/common/widgets/safe_area_widget.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_bloc.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_events.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_states.dart';
import 'package:work_permit_mobile_app/modules/login/model/get_user_model.dart';
import 'package:work_permit_mobile_app/modules/login/widgets/forgot_password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> obscurePasswordTextNotifier =
      ValueNotifier<bool>(true);
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  late LoginBloc loginBloc;
  UserCredential? userCredential;
  DateTime? currentBackPressTime;
  DateTime now = DateTime.now();

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
    usernameController.dispose();
    passwordController.dispose();
    obscurePasswordTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = exitButtonTap();
          if (shouldPop) {
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          backgroundColor: ColorsUtility.white,
          body: BlocConsumer<LoginBloc, LoginStates>(
            builder: (context, snapshot) {
              return _body();
            },
            listener: (BuildContext context, LoginStates state) {
              if (state is SignInWithEmailPasswordLoadingState) {
                ProgressBar.show(context);
              }
              if (state is SignInWithEmailPasswordLoadedState) {
                ProgressBar.dismiss(context);
                userCredential = state.userDetailsMap;
                _getUserDetailsEvent(uId: userCredential!.user!.uid);
              }
              if (state is SignInWithEmailPasswordErrorState) {
                ProgressBar.dismiss(context);
                ToastUtility.showToast(state.message.toString());
              }

              if (state is GetUserDetailsLoadingState) {
                ProgressBar.show(context);
              }
              if (state is GetUserDetailsLoadedState) {
                ProgressBar.dismiss(context);
                debugPrint(
                    'GetUserDetailsLoadedState->${state.getUserModel.data.toJson()}',
                    wrapWidth: 580);
                _handleNavigation(state.getUserModel.data);
              }
              if (state is GetUserDetailsErrorState) {
                ProgressBar.dismiss(context);
                _handleError(state.message.toString());
              }
            },
          ),
        ),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyLogin,
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  AssetsConstant.curveIcon,
                  fit: BoxFit.contain,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 18.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: buildWidth(context) * .46,
                      height: buildWidth(context) * .26,
                      child: SvgPicture.asset(
                        AssetsConstant.logoIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // SizedBox(height: buildWidth(context) * .04),
                  // TextWidget(ValueString.loginText,
                  //     style: TextStyleUtility.interTextStyle(
                  //         ColorsUtility.lightBlack, 22, FontWeight.w600, false),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 1,
                  //     softWrap: true),
                  SizedBox(height: buildWidth(context) * .025),
                  LabelTextWidget(
                    key: const Key(WidgetKeys.emailIdTextFieldKey),
                    controller: usernameController,
                    labelText: ValueString.emailText,
                    hintText: ValueString.emailIdHintText,
                    hintStyle: TextStyleUtility.interTextStyle(
                        ColorsUtility.gray, 16, FontWeight.w400, false),
                    keyboardType: TextInputType.text,
                    onEditingComplete: (text) {},
                    validator: (username) => _validateUserName(),
                    isRequiredField: true,
                    onTap: () {},
                  ),
                  SizedBox(height: 5.w),
                  ValueListenableBuilder(
                      valueListenable: obscurePasswordTextNotifier,
                      builder: (context, index, child) {
                        return LabelTextWidget(
                          key: const Key(WidgetKeys.passwordTextFieldKey),
                          controller: passwordController,
                          labelText: ValueString.passwordText,
                          hintText: ValueString.passwordHintText,
                          hintStyle: TextStyleUtility.interTextStyle(
                              ColorsUtility.gray, 16, FontWeight.w400, false),
                          isRequiredField: true,
                          validator: (password) => _validatePassword(),
                          keyboardType: TextInputType.text,
                          obscureText: obscurePasswordTextNotifier.value,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          suffixIcon: PasswordVisibilityToggle(
                            obscureTextNotifier: obscurePasswordTextNotifier,
                          ),
                          onTap: () {},
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ForgotPasswordWidget(
                        labelText: ValueString.forgotYourPasswordText,
                        onTap: () => _navigateToForgotPasswordScreen(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.w),
                  SizedBox(
                    width: buildWidth(context),
                    child: CustomAppButton(
                      key: const Key(WidgetKeys.loginBtnKey),
                      text: ValueString.logInBtnText,
                      verticalPadding: 10,
                      circularRadius: 8,
                      backgroundColor: ColorsUtility.purpleColor,
                      onPressed: () => _onLoginPressed(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _updateHiveDBData(Data userData) async {
    // final Map userInfo = {
    //   'roleId': userData.roleId.toString(),
    //   'userName': userData.userName.toString(),
    //   'phoneNumber': userData.phoneNumber.toString(),
    //   'locationId': userData.locationId.toString(),
    //   'id': userData.id.toString(),
    //   'email': userData.email.toString(),
    //   'isFirstTimeLogin': userData.isFirstTimeLogin
    // };

    await HiveUtility.storeDataInHiveDb(
        boxName: HiveKeys.userDataBox,
        key: HiveKeys.userInfoKey,
        value: userData.toJson());
  }

  _handleNavigation(Data userData) {
    if (!userData.isFirstTimeLogin) {
      _updateHiveDBData(userData);
    }
    !userData.isFirstTimeLogin
        ? NavigatorUtility.navigateToDashboardScreen(context: context)
        : NavigatorUtility.navigateToChangePasswordScreen(
            context: context,
            changePasswordDetails: {'userData': userData.toJson()});
  }

  _handleError(String errorMessage) async {
    if (errorMessage.toString() ==
            "Bad Request: Your request is invalid or malformed." ||
        errorMessage.toString() ==
            "Forbidden: You do not have permission to access the requested resource." ||
        errorMessage.toString() == "Session timeout!") {
      ToastUtility.showToast(ValueString.sessionTimeoutText.toString());
    } else {
      ToastUtility.showToast(errorMessage.toString());
    }
  }

  void _signInWithEmailPasswordEvent() async {
    if (usernameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          loginBloc.add(SignInWithEmailPasswordEvent(requestData: {
            "email": usernameController.text.trim().toString(),
            "password": passwordController.text.trim().toString()
          }));
        }
      });
    }
  }

  void _getUserDetailsEvent({required String uId}) async {
    InternetUtil.isInternetAvailable((status) async {
      if (status == false) {
        ToastUtility.showToast(ValueString.noInternetConnection);
      } else {
        loginBloc.add(GetUserDetailsEvent(requestData: {
          "uId": uId.toString(),
        }));
      }
    });
  }

  String? _validateUserName() {
    return usernameController.text.validateUserName(
        usernameController.text, ValueString.emailIsEmptyText);
  }

  String? _validatePassword() {
    return passwordController.text.validateEmpty(ValueString.passwordIsEmpty);
  }

  void _navigateToForgotPasswordScreen(BuildContext context) {
    NavigatorUtility.navigateToForgotPasswordScreen(context: context);
  }

  void _onLoginPressed() async {
    // FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKeyLogin.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          _signInWithEmailPasswordEvent();
        }
      });
    }
  }

  bool exitButtonTap() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ToastUtility.showToast(ValueString.exitTapText);
      return false;
    } else {
      return true;
    }
  }
}
