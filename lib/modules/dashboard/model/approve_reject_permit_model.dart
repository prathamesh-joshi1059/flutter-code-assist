import 'dart:convert';

ApproveRejectSuspendPermitModel approveRejectWorkPermitModelFromJson(
        String str) =>
    ApproveRejectSuspendPermitModel.fromJson(json.decode(str));

String approveRejectWorkPermitModelToJson(
        ApproveRejectSuspendPermitModel data) =>
    json.encode(data.toJson());

class ApproveRejectSuspendPermitModel {
  final int statusCode;
  final String data;
  final String message;
  final bool success;

  ApproveRejectSuspendPermitModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ApproveRejectSuspendPermitModel.fromJson(Map<String, dynamic> json) =>
      ApproveRejectSuspendPermitModel(
        statusCode: json["statusCode"],
        data: json["data"] ?? "",
        message: json["message"] ?? "",
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data,
        "message": message,
        "success": success,
      };
}
