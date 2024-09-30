import 'dart:convert';

FetchAllWorkPermitsByStatusModel fetchAllWorkPermitsByStatusModelFromJson(
        String str) =>
    FetchAllWorkPermitsByStatusModel.fromJson(json.decode(str));

String fetchAllWorkPermitsByStatusModelToJson(
        FetchAllWorkPermitsByStatusModel data) =>
    json.encode(data.toJson());

class FetchAllWorkPermitsByStatusModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  FetchAllWorkPermitsByStatusModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory FetchAllWorkPermitsByStatusModel.fromJson(
          Map<String, dynamic> json) =>
      FetchAllWorkPermitsByStatusModel(
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
  final List<Contractor> contractor;
  final bool isHolidayWorkPermit;
  final bool isClosedPermit;
  final String locationInchargerName;
  final dynamic rejectedTime;
  final CreatedAt endDate;
  final dynamic suspendedPermitTime;
  final String locationInchargerId;
  final dynamic approvedBy;
  final String description;
  final List<AssignedCheckList> assignedCheckList;
  final String workPermitTypeId;
  final CreatedAt createdAt;
  final String workPermitTypeName;
  final String locationId;
  final bool isSuspendedPermit;
  final dynamic approvedTime;
  final String id;
  final bool isApproved;
  final dynamic suspendedPermitBy;
  final bool isPermitStarted;
  final dynamic holidayPermitApprovedTime;
  final CreatedAt updatedAt;
  final String locationName;
  final dynamic permitStartTime;
  final String updatedBy;
  final List<AssignedPpe> assignedPpe;
  final bool isHolidayPermitApproved;
  final bool isReviewed;
  final String plantId;
  final dynamic closedPermitBy;
  final dynamic holidayPermitApprovedBy;
  final dynamic rejectedBy;
  final String statusId;
  final String createdBy;
  final dynamic closedPermitTime;
  final bool isRejected;
  final dynamic permitStartBy;
  final String plantName;
  final String holidayId;
  final String status;
  final CreatedAt startDate;

  Datum({
    required this.contractor,
    required this.isHolidayWorkPermit,
    required this.isClosedPermit,
    required this.locationInchargerName,
    required this.rejectedTime,
    required this.endDate,
    required this.suspendedPermitTime,
    required this.locationInchargerId,
    required this.approvedBy,
    required this.description,
    required this.assignedCheckList,
    required this.workPermitTypeId,
    required this.createdAt,
    required this.workPermitTypeName,
    required this.locationId,
    required this.isSuspendedPermit,
    required this.approvedTime,
    required this.id,
    required this.isApproved,
    required this.suspendedPermitBy,
    required this.isPermitStarted,
    required this.holidayPermitApprovedTime,
    required this.updatedAt,
    required this.locationName,
    required this.permitStartTime,
    required this.updatedBy,
    required this.assignedPpe,
    required this.isHolidayPermitApproved,
    required this.isReviewed,
    required this.plantId,
    required this.closedPermitBy,
    required this.holidayPermitApprovedBy,
    required this.rejectedBy,
    required this.statusId,
    required this.createdBy,
    required this.closedPermitTime,
    required this.isRejected,
    required this.permitStartBy,
    required this.plantName,
    required this.holidayId,
    required this.status,
    required this.startDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        contractor: List<Contractor>.from(
            json["contractor"].map((x) => Contractor.fromJson(x))),
        isHolidayWorkPermit: json["isHolidayWorkPermit"],
        isClosedPermit: json["isClosedPermit"],
        locationInchargerName: json["locationInchargerName"],
        rejectedTime: json["rejectedTime"],
        endDate: CreatedAt.fromJson(json["endDate"]),
        suspendedPermitTime: json["suspendedPermitTime"],
        locationInchargerId: json["locationInchargerId"],
        approvedBy: json["approvedBy"],
        description: json["description"],
        assignedCheckList: List<AssignedCheckList>.from(
            json["assignedCheckList"]
                .map((x) => AssignedCheckList.fromJson(x))),
        workPermitTypeId: json["workPermitTypeId"],
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        workPermitTypeName: json["workPermitTypeName"],
        locationId: json["locationId"],
        isSuspendedPermit: json["isSuspendedPermit"],
        approvedTime: json["approvedTime"],
        id: json["id"],
        isApproved: json["isApproved"],
        suspendedPermitBy: json["suspendedPermitBy"],
        isPermitStarted: json["isPermitStarted"],
        holidayPermitApprovedTime: json["holidayPermitApprovedTime"],
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
        locationName: json["locationName"],
        permitStartTime: json["permitStartTime"],
        updatedBy: json["updatedBy"],
        assignedPpe: List<AssignedPpe>.from(
            json["assignedPPE"].map((x) => AssignedPpe.fromJson(x))),
        isHolidayPermitApproved: json["isHolidayPermitApproved"],
        isReviewed: json["isReviewed"],
        plantId: json["plantId"],
        closedPermitBy: json["closedPermitBy"],
        holidayPermitApprovedBy: json["holidayPermitApprovedBy"],
        rejectedBy: json["rejectedBy"],
        statusId: json["statusId"],
        createdBy: json["createdBy"],
        closedPermitTime: json["closedPermitTime"],
        isRejected: json["isRejected"],
        permitStartBy: json["permitStartBy"],
        plantName: json["plantName"],
        holidayId: json["holidayId"],
        status: json["status"],
        startDate: CreatedAt.fromJson(json["startDate"]),
      );

  Map<String, dynamic> toJson() => {
        "contractor": List<dynamic>.from(contractor.map((x) => x.toJson())),
        "isHolidayWorkPermit": isHolidayWorkPermit,
        "isClosedPermit": isClosedPermit,
        "locationInchargerName": locationInchargerName,
        "rejectedTime": rejectedTime,
        "endDate": endDate.toJson(),
        "suspendedPermitTime": suspendedPermitTime,
        "locationInchargerId": locationInchargerId,
        "approvedBy": approvedBy,
        "description": description,
        "assignedCheckList":
            List<dynamic>.from(assignedCheckList.map((x) => x.toJson())),
        "workPermitTypeId": workPermitTypeId,
        "createdAt": createdAt.toJson(),
        "workPermitTypeName": workPermitTypeName,
        "locationId": locationId,
        "isSuspendedPermit": isSuspendedPermit,
        "approvedTime": approvedTime,
        "id": id,
        "isApproved": isApproved,
        "suspendedPermitBy": suspendedPermitBy,
        "isPermitStarted": isPermitStarted,
        "holidayPermitApprovedTime": holidayPermitApprovedTime,
        "updatedAt": updatedAt.toJson(),
        "locationName": locationName,
        "permitStartTime": permitStartTime,
        "updatedBy": updatedBy,
        "assignedPPE": List<dynamic>.from(assignedPpe.map((x) => x.toJson())),
        "isHolidayPermitApproved": isHolidayPermitApproved,
        "isReviewed": isReviewed,
        "plantId": plantId,
        "closedPermitBy": closedPermitBy,
        "holidayPermitApprovedBy": holidayPermitApprovedBy,
        "rejectedBy": rejectedBy,
        "statusId": statusId,
        "createdBy": createdBy,
        "closedPermitTime": closedPermitTime,
        "isRejected": isRejected,
        "permitStartBy": permitStartBy,
        "plantName": plantName,
        "holidayId": holidayId,
        "status": status,
        "startDate": startDate.toJson(),
      };
}

class AssignedCheckList {
  final String name;
  final String id;

  AssignedCheckList({
    required this.name,
    required this.id,
  });

  factory AssignedCheckList.fromJson(Map<String, dynamic> json) =>
      AssignedCheckList(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class AssignedPpe {
  final String image;
  final String name;
  final String id;

  AssignedPpe({
    required this.image,
    required this.name,
    required this.id,
  });

  factory AssignedPpe.fromJson(Map<String, dynamic> json) => AssignedPpe(
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

class Contractor {
  final String contractorId;
  final List<AssignedLabour> assignedLabours;
  final String contractorName;

  Contractor({
    required this.contractorId,
    required this.assignedLabours,
    required this.contractorName,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        contractorId: json["contractorId"] ?? '',
        assignedLabours: List<AssignedLabour>.from(
            json["assignedLabours"].map((x) => AssignedLabour.fromJson(x))),
        contractorName: json["contractorName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "contractorId": contractorId,
        "assignedLabours":
            List<dynamic>.from(assignedLabours.map((x) => x.toJson())),
        "contractorName": contractorName,
      };
}

class AssignedLabour {
  final String laborType;
  final String name;
  final String id;

  AssignedLabour({
    required this.laborType,
    required this.name,
    required this.id,
  });

  factory AssignedLabour.fromJson(Map<String, dynamic> json) => AssignedLabour(
        laborType: json["laborType"] ?? '',
        name: json["name"] ?? '',
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "laborType": laborType,
        "name": name,
        "id": id,
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
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
}
