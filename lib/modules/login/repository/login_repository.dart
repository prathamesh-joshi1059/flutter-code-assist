import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/api/api_constant/api_constant.dart';
import 'package:work_permit_mobile_app/common/api/api_provider.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/modules/login/model/get_user_model.dart';
import 'package:work_permit_mobile_app/modules/login/model/update_user_login_status_model.dart';

abstract class LoginRepository {
  Future<dynamic> signInWithEmailPassword({required requestData});

  Future<GetUserModel> getUserDetails({required requestData});

  Future<dynamic> changePassword({required requestData});

  Future<UpdateUserLoginStatusModel> updateUserLoginStatus(
      {required requestData});

  Future<bool> logout();

  Future<dynamic> passwordResetEmail({required requestData});
}

class LoginRepositoryImpl implements LoginRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<dynamic> signInWithEmailPassword({required requestData}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: requestData['email'], password: requestData['password']);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<GetUserModel> getUserDetails({required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.users}/${ApiConstants.getUser}/${requestData['uId']}",
        null);
    return GetUserModel.fromJson(response);
  }

  @override
  Future<String> changePassword({required requestData}) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: currentUser!.email!, password: requestData['currentPassword']);

    try {
      await currentUser.reauthenticateWithCredential(cred);
      await currentUser.updatePassword(requestData['newPassword']);
      return ValueString.successText;
    } on Exception catch (_) {
      return ValueString.invalidCredentialsText;
    }
  }

  @override
  Future<UpdateUserLoginStatusModel> updateUserLoginStatus(
      {required requestData}) async {
    dynamic response = await _apiProvider.put(
        "/${ApiConstants.api}/${ApiConstants.users}/${ApiConstants.updateUserLoginStatus}",
        requestData);
    return UpdateUserLoginStatusModel.fromJson(response);
  }

  @override
  Future<bool> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
      HiveUtility.clearAllData();
      return true;
    }
    return false;
  }

  @override
  Future<dynamic> passwordResetEmail({required requestData}) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: requestData['email']);
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
