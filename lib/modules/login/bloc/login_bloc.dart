import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_events.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_states.dart';
import 'package:work_permit_mobile_app/modules/login/model/update_user_login_status_model.dart';
import 'package:work_permit_mobile_app/modules/login/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginRepository loginRepository;

  LoginStates get initialState => LoginInitialState();

  LoginBloc({required this.loginRepository}) : super(LoginInitialState()) {
    on<SignInWithEmailPasswordEvent>((event, emit) async {
      emit(SignInWithEmailPasswordLoadingState());
      try {
        dynamic userCredentials = await loginRepository.signInWithEmailPassword(
            requestData: event.requestData);
        if (userCredentials != null) {
          emit(SignInWithEmailPasswordLoadedState(
              userDetailsMap: userCredentials));
        } else {
          emit(SignInWithEmailPasswordErrorState(
              message: ValueString.invalidCredentialsText.toString()));
        }
      } catch (e) {
        emit(SignInWithEmailPasswordErrorState(
            message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetUserDetailsEvent>((event, emit) async {
      emit(GetUserDetailsLoadingState());
      // try {
      dynamic getUserModel =
          await loginRepository.getUserDetails(requestData: event.requestData);
      if (getUserModel.statusCode == 200) {
        emit(GetUserDetailsLoadedState(getUserModel: getUserModel));
      } else {
        emit(SignInWithEmailPasswordErrorState(
            message: ValueString.wentWrongText.toString()));
      }
      // } catch (e) {
      //   emit(GetUserDetailsErrorState(message: e.toString()));
      // }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoadingState());
      try {
        dynamic userDetails = await loginRepository.changePassword(
            requestData: event.requestData);

        if (userDetails == ValueString.successText) {
          emit(ChangePasswordLoadedState(userDetailsMap: userDetails));
        } else {
          emit(ChangePasswordErrorState(
              message: ValueString.oldPasswordIncorrectText.toString()));
        }
      } catch (e) {
        emit(ChangePasswordErrorState(
            message: ValueString.wentWrongText.toString()));
      }
    });

    on<UpdateUserLoginStatusEvent>((event, emit) async {
      emit(UpdateUserLoginStatusLoadingState());
      try {
        UpdateUserLoginStatusModel updateUserLoginStatusModel =
            await loginRepository.updateUserLoginStatus(
                requestData: event.requestData);

        if (updateUserLoginStatusModel.statusCode == 200) {
          emit(UpdateUserLoginStatusLoadedState(
              updateUserLoginStatusModel: updateUserLoginStatusModel));
        } else {
          emit(UpdateUserLoginStatusErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(ChangePasswordErrorState(
            message: ValueString.wentWrongText.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoadingState());
      try {
        bool status = await loginRepository.logout();
        if (status) {
          emit(LogoutLoadedState());
        } else {
          emit(LogoutErrorState(message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(LogoutErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<PasswordResetEmailEvent>((event, emit) async {
      emit(PasswordResetEmailLoadingState());
      try {
        await loginRepository.passwordResetEmail(
            requestData: event.requestData);

        emit(PasswordResetEmailLoadedState());
      } catch (e) {
        emit(PasswordResetEmailErrorState(
            message: ValueString.wentWrongText.toString()));
      }
    });
  }
}
