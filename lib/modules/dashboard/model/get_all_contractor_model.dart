import 'dart:convert';

GetAllContractorModel getAllContractorModelFromJson(String str) =>
    GetAllContractorModel.fromJson(json.decode(str));

String getAllContractorModelToJson(GetAllContractorModel data) =>
    json.encode(data.toJson());

class GetAllContractorModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetAllContractorModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllContractorModel.fromJson(Map<String, dynamic> json) =>
      GetAllContractorModel(
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
  final String id;
  final CreatedAt createdAt;
  final String phoneNumber;
  final String updatedBy;
  final String name;
  final String emailId;
  final CreatedAt licenceExpiry;
  final String officeLocation;
  final CreatedAt updatedAt;

  Datum({
    required this.id,
    required this.createdAt,
    required this.phoneNumber,
    required this.updatedBy,
    required this.name,
    required this.emailId,
    required this.licenceExpiry,
    required this.officeLocation,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: CreatedAt.fromJson(json["createdAt"] ?? {}),
        phoneNumber: json["phoneNumber"],
        updatedBy: json["updatedBy"],
        name: json["name"],
        emailId: json["emailId"],
        licenceExpiry: CreatedAt.fromJson(json["licenceExpiry"]),
        officeLocation: json["officeLocation"],
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toJson(),
        "phoneNumber": phoneNumber,
        "updatedBy": updatedBy,
        "name": name,
        "emailId": emailId,
        "licenceExpiry": licenceExpiry.toJson(),
        "officeLocation": officeLocation,
        "updatedAt": updatedAt.toJson(),
      };
}

class CreatedAt {
  final int seconds;
  final int nanoseconds;

  CreatedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        seconds: json["_seconds"] ?? 0,
        nanoseconds: json["_nanoseconds"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
