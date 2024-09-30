import 'dart:convert';

GetLabourByContractorModel getLabourByContractorModelFromJson(String str) =>
    GetLabourByContractorModel.fromJson(json.decode(str));

String getLabourByContractorModelToJson(GetLabourByContractorModel data) =>
    json.encode(data.toJson());

class GetLabourByContractorModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetLabourByContractorModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetLabourByContractorModel.fromJson(Map<String, dynamic> json) =>
      GetLabourByContractorModel(
        statusCode: json["statusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  final CreatedUpdatedAt createdAt;
  final String phoneNumber;
  final String contractorId;
  final String name;
  final String id;
  final String laborType;
  final String updatedBy;
  final CreatedUpdatedAt updatedAt;
  final String contractorName;

  Datum({
    required this.createdAt,
    required this.phoneNumber,
    required this.contractorId,
    required this.name,
    required this.id,
    required this.laborType,
    required this.updatedBy,
    required this.updatedAt,
    required this.contractorName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: CreatedUpdatedAt.fromJson(json["createdAt"]),
        phoneNumber: json["phoneNumber"] ?? '',
        contractorId: json["contractorId"] ?? '',
        name: json["name"] ?? '',
        id: json["id"] ?? '',
        laborType: json["laborType"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        updatedAt: CreatedUpdatedAt.fromJson(json["updatedAt"]),
        contractorName: json["contractorName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toJson(),
        "phoneNumber": phoneNumber,
        "contractorId": contractorId,
        "name": name,
        "id": id,
        "laborType": laborType,
        "updatedBy": updatedBy,
        "updatedAt": updatedAt.toJson(),
        "contractorName": contractorName,
      };
}

class CreatedUpdatedAt {
  final int seconds;
  final int nanoseconds;

  CreatedUpdatedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  factory CreatedUpdatedAt.fromJson(Map<String, dynamic> json) =>
      CreatedUpdatedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
