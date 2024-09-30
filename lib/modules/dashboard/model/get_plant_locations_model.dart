import 'dart:convert';

GetPlantLocationsModel getPlantLocationsModelFromJson(String str) =>
    GetPlantLocationsModel.fromJson(json.decode(str));

String getPlantLocationsModelToJson(GetPlantLocationsModel data) =>
    json.encode(data.toJson());

class GetPlantLocationsModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetPlantLocationsModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetPlantLocationsModel.fromJson(Map<String, dynamic> json) =>
      GetPlantLocationsModel(
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
  final String updatedBy;
  final String name;
  final String plantId;
  final String id;
  final String locationInchargeId;
  final String locationInchargeName;
  final CreatedUpdatedAt updatedAt;

  Datum({
    required this.createdAt,
    required this.updatedBy,
    required this.name,
    required this.plantId,
    required this.id,
    required this.locationInchargeId,
    required this.locationInchargeName,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: CreatedUpdatedAt.fromJson(json["createdAt"]),
        updatedBy: json["updatedBy"],
        name: json["name"],
        plantId: json["plantId"],
        id: json["id"],
        locationInchargeId: json["locationInchargeId"],
        locationInchargeName: json["locationInchargeName"],
        updatedAt: CreatedUpdatedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toJson(),
        "updatedBy": updatedBy,
        "name": name,
        "plantId": plantId,
        "id": id,
        "locationInchargeId": locationInchargeId,
        "locationInchargeName": locationInchargeName,
        "updatedAt": updatedAt.toJson(),
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
