import 'dart:convert';

FetchWorkPermitTypeCountsModel fetchWorkPermitTypeCountsModelFromJson(
        String str) =>
    FetchWorkPermitTypeCountsModel.fromJson(json.decode(str));

String fetchWorkPermitTypeCountsModelToJson(
        FetchWorkPermitTypeCountsModel data) =>
    json.encode(data.toJson());

class FetchWorkPermitTypeCountsModel {
  final int statusCode;
  final List<WorkPermitTypes> data;
  final String message;
  final bool success;

  FetchWorkPermitTypeCountsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory FetchWorkPermitTypeCountsModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkPermitTypeCountsModel(
        statusCode: json["statusCode"],
        data: List<WorkPermitTypes>.from(
            json["data"].map((x) => WorkPermitTypes.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class WorkPermitTypes {
  final String name;
  final int count;
  final String id;

  WorkPermitTypes({
    required this.name,
    required this.count,
    required this.id,
  });

  factory WorkPermitTypes.fromJson(Map<String, dynamic> json) =>
      WorkPermitTypes(
        name: json["name"],
        count: json["count"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
        "id": id,
      };
}
