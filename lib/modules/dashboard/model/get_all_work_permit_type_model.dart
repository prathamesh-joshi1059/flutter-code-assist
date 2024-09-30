import 'dart:convert';

GetAllWorkPermitTypeModel getAllWorkPermitTypeModelFromJson(String str) =>
    GetAllWorkPermitTypeModel.fromJson(json.decode(str));

String getAllWorkPermitTypeModelToJson(GetAllWorkPermitTypeModel data) =>
    json.encode(data.toJson());

class GetAllWorkPermitTypeModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetAllWorkPermitTypeModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllWorkPermitTypeModel.fromJson(Map<String, dynamic> json) =>
      GetAllWorkPermitTypeModel(
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
  final AtedAt createdAt;
  final String workPermitTypename;
  final List<Ppe> ppe;
  final int minNumberOfPeople;
  final List<Checklist> checklist;
  final DateTime startTime;
  final DateTime endTime;
  final AtedAt updatedAt;

  Datum({
    required this.id,
    required this.createdAt,
    required this.workPermitTypename,
    required this.ppe,
    required this.minNumberOfPeople,
    required this.checklist,
    required this.startTime,
    required this.endTime,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: AtedAt.fromJson(json["createdAt"]),
        workPermitTypename: json["workPermitTypename"],
        ppe: List<Ppe>.from(json["ppe"].map((x) => Ppe.fromJson(x))),
        minNumberOfPeople: json["minNumberOfPeople"],
        checklist: List<Checklist>.from(
            json["checklist"].map((x) => Checklist.fromJson(x))),
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        updatedAt: AtedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toJson(),
        "workPermitTypename": workPermitTypename,
        "ppe": List<dynamic>.from(ppe.map((x) => x.toJson())),
        "minNumberOfPeople": minNumberOfPeople,
        "checklist": List<dynamic>.from(checklist.map((x) => x.toJson())),
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "updatedAt": updatedAt.toJson(),
      };
}

class Checklist {
  final String name;
  final String id;

  Checklist({
    required this.name,
    required this.id,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class AtedAt {
  final int seconds;
  final int nanoseconds;

  AtedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}

class Ppe {
  final String image;
  final String name;
  final String id;

  Ppe({
    required this.image,
    required this.name,
    required this.id,
  });

  factory Ppe.fromJson(Map<String, dynamic> json) => Ppe(
        image: json["image"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "id": id,
      };
}
