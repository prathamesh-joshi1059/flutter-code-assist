import 'dart:convert';

FetchWorkPermitStatusCountsModel fetchWorkPermitStatusCountsModelFromJson(
        String str) =>
    FetchWorkPermitStatusCountsModel.fromJson(json.decode(str));

String fetchWorkPermitStatusCountsModelToJson(
        FetchWorkPermitStatusCountsModel data) =>
    json.encode(data.toJson());

class FetchWorkPermitStatusCountsModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  FetchWorkPermitStatusCountsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory FetchWorkPermitStatusCountsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchWorkPermitStatusCountsModel(
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
  final int newWorkPermitCount;
  final int approvedWorkPermitCount;
  final int rejectedWorkPermitCount;
  final int inProgressWorkPermitCount;
  final int closedWorkPermitCount;
  final int suspendedWorkPermitCount;
  final int approvalPendingCount;
  final int closePendingCount;

  Data({
    required this.newWorkPermitCount,
    required this.approvedWorkPermitCount,
    required this.rejectedWorkPermitCount,
    required this.inProgressWorkPermitCount,
    required this.closedWorkPermitCount,
    required this.suspendedWorkPermitCount,
    required this.approvalPendingCount,
    required this.closePendingCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        newWorkPermitCount: json["newWorkPermitCount"],
        approvedWorkPermitCount: json["approvedWorkPermitCount"],
        rejectedWorkPermitCount: json["rejectedWorkPermitCount"],
        inProgressWorkPermitCount: json["inProgressWorkPermitCount"],
        closedWorkPermitCount: json["closedWorkPermitCount"],
        suspendedWorkPermitCount: json["suspendedWorkPermitCount"],
        approvalPendingCount: json["approvalPendingCount"],
        closePendingCount: json["closePendingCount"],
      );

  Map<String, dynamic> toJson() => {
        "newWorkPermitCount": newWorkPermitCount,
        "approvedWorkPermitCount": approvedWorkPermitCount,
        "rejectedWorkPermitCount": rejectedWorkPermitCount,
        "inProgressWorkPermitCount": inProgressWorkPermitCount,
        "closedWorkPermitCount": closedWorkPermitCount,
        "suspendedWorkPermitCount": suspendedWorkPermitCount,
        "approvalPendingCount": approvalPendingCount,
        "closePendingCount": closePendingCount,
      };
}
