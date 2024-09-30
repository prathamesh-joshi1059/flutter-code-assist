import 'dart:convert';

GetUserModel getUserModelFromJson(String str) =>
    GetUserModel.fromJson(json.decode(str));

String getUserModelToJson(GetUserModel data) => json.encode(data.toJson());

class GetUserModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  GetUserModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
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
  final bool isLoccationIncharge;
  final String updatedBy;
  final String roleId;
  final String roleName;

  final List<AssignedPlant> assignedPlants;
  final String userName;
  final AtedAt createdAt;
  final String phoneNumber;
  final List<Responsibility> responsibilities;
  final String createdBy;
  final String locationId;
  final String id;
  final String email;
  final bool isFirstTimeLogin;
  final AtedAt updatedAt;

  Data({
    required this.isLoccationIncharge,
    required this.updatedBy,
    required this.roleId,
    required this.assignedPlants,
    required this.userName,
    required this.createdAt,
    required this.phoneNumber,
    required this.responsibilities,
    required this.createdBy,
    required this.locationId,
    required this.id,
    required this.roleName,
    required this.email,
    required this.isFirstTimeLogin,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isLoccationIncharge: json["isLocationIncharge"] ?? false,
        roleName: json["roleName"] ?? "",
        updatedBy: json["updatedBy"] ?? "",
        roleId: json["roleId"] ?? "",
        assignedPlants: List<AssignedPlant>.from(
            json["assignedPlants"].map((x) => AssignedPlant.fromJson(x))),
        userName: json["userName"] ?? "",
        createdAt: AtedAt.fromJson(json["createdAt"] ?? {}),
        phoneNumber: json["phoneNumber"] ?? "",
        responsibilities: List<Responsibility>.from(
            json["responsibilities"].map((x) => Responsibility.fromJson(x))),
        createdBy: json["createdBy"] ?? "",
        locationId: json["locationId"] ?? "",
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        isFirstTimeLogin: json["isFirstTimeLogin"] ?? false,
        updatedAt: AtedAt.fromJson(json["updatedAt"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "isLoccationIncharge": isLoccationIncharge,
        "updatedBy": updatedBy,
        "roleName": roleName,
        "roleId": roleId,
        "assignedPlants":
            List<dynamic>.from(assignedPlants.map((x) => x.toJson())),
        "userName": userName,
        "createdAt": createdAt.toJson(),
        "phoneNumber": phoneNumber,
        "responsibilities":
            List<dynamic>.from(responsibilities.map((x) => x.toJson())),
        "createdBy": createdBy,
        "locationId": locationId,
        "id": id,
        "email": email,
        "isFirstTimeLogin": isFirstTimeLogin,
        "updatedAt": updatedAt.toJson(),
      };
}

class AssignedPlant {
  final String name;
  final String id;

  AssignedPlant({
    required this.name,
    required this.id,
  });

  factory AssignedPlant.fromJson(Map<String, dynamic> json) => AssignedPlant(
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

class Responsibility {
  final String name;
  final int typeId;
  final String id;
  final String type;

  Responsibility({
    required this.name,
    required this.typeId,
    required this.id,
    required this.type,
  });

  factory Responsibility.fromJson(Map<String, dynamic> json) => Responsibility(
        name: json["name"],
        typeId: json["typeId"],
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "typeId": typeId,
        "id": id,
        "type": type,
      };
}
