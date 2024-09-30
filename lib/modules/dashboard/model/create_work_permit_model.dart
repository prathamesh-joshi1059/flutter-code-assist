import 'dart:convert';

CreateWorkPermitModel createWorkPermitModelFromJson(String str) =>
    CreateWorkPermitModel.fromJson(json.decode(str));

String createWorkPermitModelToJson(CreateWorkPermitModel data) =>
    json.encode(data.toJson());

class CreateWorkPermitModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  CreateWorkPermitModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory CreateWorkPermitModel.fromJson(Map<String, dynamic> json) =>
      CreateWorkPermitModel(
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
  final String id;
  final String plantId;
  final List<Contractor> contractor;
  final String description;
  final String workPermitTypeId;
  final String workPermitTypeName;

  // final int minNumberOfPeople;
  final DateTime startDate;
  final DateTime endDate;
  final bool isHolidayWorkPermit;
  final String holidayId;
  final List<AssignedCheckList> assignedCheckList;
  final List<AssignedPpe> assignedPpe;
  final String statusId;
  final String status;
  final String locationId;
  final String locationInchargerId;
  final String locationInchargerName;
  final bool isApproved;
  final dynamic approvedBy;
  final dynamic approvedTime;
  final bool isHolidayPermitApproved;
  final dynamic holidayPermitApprovedBy;
  final dynamic holidayPermitApprovedTime;
  final bool isPermitStarted;
  final dynamic permitStartBy;
  final dynamic permitStartTime;
  final bool isSuspendedPermit;
  final dynamic suspendedPermitBy;
  final dynamic suspendedPermitTime;
  final bool isClosedPermit;
  final dynamic closedPermitBy;
  final dynamic closedPermitTime;
  final bool isRejected;
  final dynamic rejectedBy;
  final dynamic rejectedTime;
  final bool isReviewed;
  final String createdBy;
  final String updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.plantId,
    required this.contractor,
    required this.description,
    required this.workPermitTypeId,
    required this.workPermitTypeName,
    // required this.minNumberOfPeople,
    required this.startDate,
    required this.endDate,
    required this.isHolidayWorkPermit,
    required this.holidayId,
    required this.assignedCheckList,
    required this.assignedPpe,
    required this.statusId,
    required this.status,
    required this.locationId,
    required this.locationInchargerId,
    required this.locationInchargerName,
    required this.isApproved,
    required this.approvedBy,
    required this.approvedTime,
    required this.isHolidayPermitApproved,
    required this.holidayPermitApprovedBy,
    required this.holidayPermitApprovedTime,
    required this.isPermitStarted,
    required this.permitStartBy,
    required this.permitStartTime,
    required this.isSuspendedPermit,
    required this.suspendedPermitBy,
    required this.suspendedPermitTime,
    required this.isClosedPermit,
    required this.closedPermitBy,
    required this.closedPermitTime,
    required this.isRejected,
    required this.rejectedBy,
    required this.rejectedTime,
    required this.isReviewed,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        plantId: json["plantId"],
        contractor: List<Contractor>.from(
            json["contractor"].map((x) => Contractor.fromJson(x))),
        description: json["description"],
        workPermitTypeId: json["workPermitTypeId"],
        workPermitTypeName: json["workPermitTypeName"],
        // minNumberOfPeople: json["minNumberOfPeople"] ?? 0,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isHolidayWorkPermit: json["isHolidayWorkPermit"],
        holidayId: json["holidayId"],
        assignedCheckList: List<AssignedCheckList>.from(
            json["assignedCheckList"]
                .map((x) => AssignedCheckList.fromJson(x))),
        assignedPpe: List<AssignedPpe>.from(
            json["assignedPPE"].map((x) => AssignedPpe.fromJson(x))),
        statusId: json["statusId"],
        status: json["status"],
        locationId: json["locationId"],
        locationInchargerId: json["locationInchargerId"],
        locationInchargerName: json["locationInchargerName"],
        isApproved: json["isApproved"],
        approvedBy: json["approvedBy"],
        approvedTime: json["approvedTime"],
        isHolidayPermitApproved: json["isHolidayPermitApproved"],
        holidayPermitApprovedBy: json["holidayPermitApprovedBy"],
        holidayPermitApprovedTime: json["holidayPermitApprovedTime"],
        isPermitStarted: json["isPermitStarted"],
        permitStartBy: json["permitStartBy"],
        permitStartTime: json["permitStartTime"],
        isSuspendedPermit: json["isSuspendedPermit"],
        suspendedPermitBy: json["suspendedPermitBy"],
        suspendedPermitTime: json["suspendedPermitTime"],
        isClosedPermit: json["isClosedPermit"],
        closedPermitBy: json["closedPermitBy"],
        closedPermitTime: json["closedPermitTime"],
        isRejected: json["isRejected"],
        rejectedBy: json["rejectedBy"],
        rejectedTime: json["rejectedTime"],
        isReviewed: json["isReviewed"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plantId": plantId,
        "contractor": List<dynamic>.from(contractor.map((x) => x.toJson())),
        "description": description,
        "workPermitTypeId": workPermitTypeId,
        "workPermitTypeName": workPermitTypeName,
        // "minNumberOfPeople": minNumberOfPeople,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isHolidayWorkPermit": isHolidayWorkPermit,
        "holidayId": holidayId,
        "assignedCheckList":
            List<dynamic>.from(assignedCheckList.map((x) => x.toJson())),
        "assignedPPE": List<dynamic>.from(assignedPpe.map((x) => x.toJson())),
        "statusId": statusId,
        "status": status,
        "locationId": locationId,
        "locationInchargerId": locationInchargerId,
        "locationInchargerName": locationInchargerName,
        "isApproved": isApproved,
        "approvedBy": approvedBy,
        "approvedTime": approvedTime,
        "isHolidayPermitApproved": isHolidayPermitApproved,
        "holidayPermitApprovedBy": holidayPermitApprovedBy,
        "holidayPermitApprovedTime": holidayPermitApprovedTime,
        "isPermitStarted": isPermitStarted,
        "permitStartBy": permitStartBy,
        "permitStartTime": permitStartTime,
        "isSuspendedPermit": isSuspendedPermit,
        "suspendedPermitBy": suspendedPermitBy,
        "suspendedPermitTime": suspendedPermitTime,
        "isClosedPermit": isClosedPermit,
        "closedPermitBy": closedPermitBy,
        "closedPermitTime": closedPermitTime,
        "isRejected": isRejected,
        "rejectedBy": rejectedBy,
        "rejectedTime": rejectedTime,
        "isReviewed": isReviewed,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
  final String id;
  final String image;
  final String name;

  AssignedPpe({
    required this.id,
    required this.image,
    required this.name,
  });

  factory AssignedPpe.fromJson(Map<String, dynamic> json) => AssignedPpe(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}

class Contractor {
  final String contractorId;
  final List<AssignedLabour> assignedLabours;

  Contractor({
    required this.contractorId,
    required this.assignedLabours,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        contractorId: json["contractorId"],
        assignedLabours: List<AssignedLabour>.from(
            json["assignedLabours"].map((x) => AssignedLabour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contractorId": contractorId,
        "assignedLabours":
            List<dynamic>.from(assignedLabours.map((x) => x.toJson())),
      };
}

class AssignedLabour {
  final String id;
  final String name;
  final String laborType;

  AssignedLabour({
    required this.id,
    required this.name,
    required this.laborType,
  });

  factory AssignedLabour.fromJson(Map<String, dynamic> json) => AssignedLabour(
        id: json["id"],
        name: json["name"],
        laborType: json["laborType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "laborType": laborType,
      };
}
