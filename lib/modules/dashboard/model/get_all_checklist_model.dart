import 'dart:convert';

GetAllChecklistModel getAllChecklistModelFromJson(String str) =>
    GetAllChecklistModel.fromJson(json.decode(str));

String getAllChecklistModelToJson(GetAllChecklistModel data) =>
    json.encode(data.toJson());

class GetAllChecklistModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetAllChecklistModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllChecklistModel.fromJson(Map<String, dynamic> json) =>
      GetAllChecklistModel(
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
  final CreatedUpdatedAt createdAt;
  final String name;
  final CreatedUpdatedAt updatedAt;

  Datum({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: CreatedUpdatedAt.fromJson(json["createdAt"]),
        name: json["name"],
        updatedAt: CreatedUpdatedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toJson(),
        "name": name,
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
