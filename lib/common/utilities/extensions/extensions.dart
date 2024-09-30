import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/common/utilities/validator.dart';

extension StringExtension on String {
  String? validateEmpty(String errorMessage) {
    if (isEmpty) {
      return errorMessage;
    } else {
      return null;
    }
  }

  String? validatePassword(String password, String errorMessage) {
    if (isEmpty) {
      return errorMessage;
    } else if (password.length < 6) {
      return ValueString.passwordValidationText;
    } else {
      return null;
    }
  }

  String? validateEmail(emailValue) {
    if (emailValue == null || emailValue!.trim().isEmpty) {
      return ValueString.emailIsEmptyText;
    } else if (!Validator.isValidEmail(emailValue!)) {
      return ValueString.inValidEmailText;
    } else {
      return null;
    }
  }

  String? validateUserName(emailValue, String errorMessage) {
    if (isEmpty) {
      return errorMessage;
    } else if (!Validator.isValidEmail(emailValue!)) {
      return ValueString.inValidUserNameText;
    } else {
      return null;
    }
  }

  String? validateMap(String errorMessage) {
    if (isEmpty) {
      return errorMessage;
    } else {
      return null;
    }
  }

  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
