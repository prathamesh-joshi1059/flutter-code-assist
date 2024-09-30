import 'dart:convert';

UpdateUserLoginStatusModel updateUserLoginStatusModelFromJson(String str) =>
    UpdateUserLoginStatusModel.fromJson(json.decode(str));

String updateUserLoginStatusModelToJson(UpdateUserLoginStatusModel data) =>
    json.encode(data.toJson());

class UpdateUserLoginStatusModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  UpdateUserLoginStatusModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory UpdateUserLoginStatusModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserLoginStatusModel(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "message": message,
        "success": success,
      };
}

class Data {
  final bool isFirstTimeLogin;
  final String userId;

  Data({
    required this.isFirstTimeLogin,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isFirstTimeLogin: json["isFirstTimeLogin"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "isFirstTimeLogin": isFirstTimeLogin,
        "userId": userId,
      };
}
