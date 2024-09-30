import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/extensions/extensions.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/widget_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/text_style_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/theme/colors_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';
import 'package:work_permit_mobile_app/common/widgets/custom_button.dart';
import 'package:work_permit_mobile_app/common/widgets/label_text_widget.dart';
import 'package:work_permit_mobile_app/common/widgets/password_visibility_toggle.dart';
import 'package:work_permit_mobile_app/common/widgets/text_widget.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_bloc.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_states.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _formKeyChangePassword = GlobalKey<FormState>();
  LoginBloc? loginBloc;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final ValueNotifier<bool> obscureNewPasswordTextNotifier =
      ValueNotifier<bool>(true);
  final ValueNotifier<bool> obscureConfirmPasswordTextNotifier =
      ValueNotifier<bool>(true);

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
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsUtility.white,
      body: BlocConsumer<LoginBloc, LoginStates>(
        builder: (context, snapshot) {
          return _body();
        },
        listener: (BuildContext context, LoginStates state) {},
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyChangePassword,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 18.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(ValueString.setNewPasswordText,
                    style: TextStyleUtility.interTextStyle(
                        ColorsUtility.lightBlack,
                        22.sp,
                        FontWeight.w600,
                        false),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true),
                SizedBox(height: 10.w),
                ValueListenableBuilder(
                    valueListenable: obscureNewPasswordTextNotifier,
                    builder: (context, index, child) {
                      return LabelTextWidget(
                        key: const Key(WidgetKeys.newSetPasswordTextFieldKey),
                        controller: newPasswordController,
                        labelText: ValueString.newPasswordText,
                        hintText: ValueString.newPasswordHintText,
                        isRequiredField: true,
                        validator: (password) => _validateNewPassword(password),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureNewPasswordTextNotifier.value,
                        suffixIcon: PasswordVisibilityToggle(
                          obscureTextNotifier: obscureNewPasswordTextNotifier,
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
                            WidgetKeys.newConfirmSetPasswordTextFieldKey),
                        controller: confirmNewPasswordController,
                        labelText: ValueString.confirmNewPasswordText,
                        hintText: ValueString.confirmNewPasswordHintText,
                        isRequiredField: true,
                        validator: (password) => _validateConfirmNewPassword(),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureConfirmPasswordTextNotifier.value,
                        suffixIcon: PasswordVisibilityToggle(
                          obscureTextNotifier:
                              obscureConfirmPasswordTextNotifier,
                        ),
                        onTap: () {},
                      );
                    }),
                SizedBox(height: 8.w),
                CustomAppButton(
                  key: const Key(WidgetKeys.changePasswordBtnKey),
                  text: ValueString.changeNewPasswordBtnText,
                  backgroundColor: ColorsUtility.black,
                  verticalPadding: 10,
                  circularRadius: 8,
                  onPressed: () => _onChangeNewPasswordBtnPressed(),
                )
              ],
            )),
      ),
    );
  }

  String? _validateNewPassword(String password) {
    return newPasswordController.text
        .validatePassword(password, ValueString.newPasswordIsEmptyText);
  }

  String? _validateConfirmNewPassword() {
    if (newPasswordController.text != confirmNewPasswordController.text) {
      return ValueString.passwordNotMatchText;
    }
    return confirmNewPasswordController.text
        .validateEmpty(ValueString.confirmNewPasswordIsEmptyText);
  }

  void _onChangeNewPasswordBtnPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKeyChangePassword.currentState!.validate()) {
      InternetUtil.isInternetAvailable((status) async {
        if (status == false) {
          ToastUtility.showToast(ValueString.noInternetConnection);
        } else {
          // loginBloc!.add(ChangePasswordEvent(requestData: {
          //   "currentPassword": oldPasswordController.text.trim(),
          //   "newPassword": confirmNewPasswordController.text.trim()
          // }));
        }
      });
    }
  }
}
