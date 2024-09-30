import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {}

class SignInWithEmailPasswordEvent extends LoginEvents {
  final Map<String, dynamic> requestData;

  SignInWithEmailPasswordEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetUserDetailsEvent extends LoginEvents {
  final Map<String, dynamic> requestData;

  GetUserDetailsEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordEvent extends LoginEvents {
  final Map<String, dynamic> requestData;

  ChangePasswordEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UpdateUserLoginStatusEvent extends LoginEvents {
  final Map<String, dynamic> requestData;

  UpdateUserLoginStatusEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LogoutEvent extends LoginEvents {
  LogoutEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PasswordResetEmailEvent extends LoginEvents {
  final Map<String, dynamic> requestData;

  PasswordResetEmailEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}
