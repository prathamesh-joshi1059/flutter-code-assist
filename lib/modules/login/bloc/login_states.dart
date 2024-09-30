import 'package:equatable/equatable.dart';
import 'package:work_permit_mobile_app/modules/login/model/get_user_model.dart';
import 'package:work_permit_mobile_app/modules/login/model/update_user_login_status_model.dart';

abstract class LoginStates extends Equatable {}

class LoginInitialState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

/// SignIn With Email, Password
class SignInWithEmailPasswordLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SignInWithEmailPasswordLoadedState extends LoginStates {
  final dynamic userDetailsMap;

  SignInWithEmailPasswordLoadedState({required this.userDetailsMap});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SignInWithEmailPasswordErrorState extends LoginStates {
  final String message;

  SignInWithEmailPasswordErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Get user details
class GetUserDetailsLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDetailsLoadedState extends LoginStates {
  final GetUserModel getUserModel;

  GetUserDetailsLoadedState({required this.getUserModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDetailsErrorState extends LoginStates {
  final String message;

  GetUserDetailsErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Change Password
class ChangePasswordLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordLoadedState extends LoginStates {
  final dynamic userDetailsMap;

  ChangePasswordLoadedState({required this.userDetailsMap});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordErrorState extends LoginStates {
  final String message;

  ChangePasswordErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Update User Login Status
class UpdateUserLoginStatusLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateUserLoginStatusLoadedState extends LoginStates {
  final UpdateUserLoginStatusModel updateUserLoginStatusModel;

  UpdateUserLoginStatusLoadedState({required this.updateUserLoginStatusModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateUserLoginStatusErrorState extends LoginStates {
  final String message;

  UpdateUserLoginStatusErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Logout
class LogoutLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LogoutLoadedState extends LoginStates {
  LogoutLoadedState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LogoutErrorState extends LoginStates {
  final String message;

  LogoutErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Forgot password
class PasswordResetEmailLoadingState extends LoginStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordResetEmailLoadedState extends LoginStates {
  PasswordResetEmailLoadedState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordResetEmailErrorState extends LoginStates {
  final String message;

  PasswordResetEmailErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
