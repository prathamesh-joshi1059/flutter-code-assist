// To parse this JSON data, do
//
//     final getWorkPermitByTypeModel = getWorkPermitByTypeModelFromJson(jsonString);

import 'dart:convert';

FetchWorkPermitByTypeModel getWorkPermitByTypeModelFromJson(String str) =>
    FetchWorkPermitByTypeModel.fromJson(json.decode(str));

String getWorkPermitByTypeModelToJson(FetchWorkPermitByTypeModel data) =>
    json.encode(data.toJson());

class FetchWorkPermitByTypeModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  FetchWorkPermitByTypeModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory FetchWorkPermitByTypeModel.fromJson(Map<String, dynamic> json) =>
      FetchWorkPermitByTypeModel(
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
  final CreatedAt suspendedPermitTime;
  final String locationInchargerId;
  final String approvedBy;
  final String description;
  final List<AssignedCheckList> assignedCheckList;
  final String workPermitTypeId;
  final CreatedAt createdAt;
  final String workPermitTypeName;
  final String locationName;
  final String locationId;
  final bool isSuspendedPermit;
  final CreatedAt approvedTime;
  final String id;
  final bool isApproved;
  final String suspendedPermitBy;
  final bool isPermitStarted;
  final dynamic holidayPermitApprovedTime;
  final CreatedAt updatedAt;
  final CreatedAt permitStartTime;
  final String updatedBy;
  final List<AssignedPpe> assignedPpe;
  final bool isHolidayPermitApproved;
  final int minNumberOfPeople;
  final String plantId;
  final String closedPermitBy;
  final dynamic holidayPermitApprovedBy;
  final dynamic rejectedBy;
  final String statusId;
  final String createdBy;
  final CreatedAt closedPermitTime;
  final bool isRejected;
  final bool isReviewed;
  final String permitStartBy;
  final CreatedAt startDate;
  final String holidayId;
  final String status;
  final String updateBy;

  Datum({
    required this.contractor,
    required this.isHolidayWorkPermit,
    required this.isClosedPermit,
    required this.locationInchargerName,
    required this.rejectedTime,
    required this.endDate,
    required this.isReviewed,
    required this.suspendedPermitTime,
    required this.locationInchargerId,
    required this.approvedBy,
    required this.description,
    required this.assignedCheckList,
    required this.workPermitTypeId,
    required this.createdAt,
    required this.workPermitTypeName,
    required this.locationName,
    required this.locationId,
    required this.isSuspendedPermit,
    required this.approvedTime,
    required this.id,
    required this.isApproved,
    required this.suspendedPermitBy,
    required this.isPermitStarted,
    required this.holidayPermitApprovedTime,
    required this.updatedAt,
    required this.permitStartTime,
    required this.updatedBy,
    required this.assignedPpe,
    required this.isHolidayPermitApproved,
    required this.minNumberOfPeople,
    required this.plantId,
    required this.closedPermitBy,
    required this.holidayPermitApprovedBy,
    required this.rejectedBy,
    required this.statusId,
    required this.createdBy,
    required this.closedPermitTime,
    required this.isRejected,
    required this.permitStartBy,
    required this.startDate,
    required this.holidayId,
    required this.status,
    required this.updateBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      contractor: List<Contractor>.from(
          json["contractor"].map((x) => Contractor.fromJson(x))),
      isHolidayWorkPermit: json["isHolidayWorkPermit"] ?? false,
      isClosedPermit: json["isClosedPermit"] ?? false,
      isReviewed: json['isReviewed'] ?? false,
      locationInchargerName: json["locationInchargerName"] ?? '',
      rejectedTime: json["rejectedTime"],
      endDate: CreatedAt.fromJson(json["endDate"] ?? {}),
      suspendedPermitTime: CreatedAt.fromJson(
          (json["suspendedPermitTime"] != null)
              ? json["suspendedPermitTime"]
              : {}),
      locationInchargerId: json["locationInchargerId"],
      approvedBy: json["approvedBy"] ?? "",
      description: json["description"] ?? "",
      assignedCheckList: List<AssignedCheckList>.from(
          json["assignedCheckList"].map((x) => AssignedCheckList.fromJson(x))),
      workPermitTypeId: json["workPermitTypeId"] ?? "",
      createdAt: CreatedAt.fromJson(json["createdAt"] ?? {}),
      workPermitTypeName: json["workPermitTypeName"] ?? "",
      locationName: json["locationName"] ?? "",
      locationId: json["locationId"] ?? "",
      isSuspendedPermit: json["isSuspendedPermit"] ?? false,
      approvedTime: CreatedAt.fromJson(json["approvedTime"] ?? {}),
      id: json["id"] ?? '',
      isApproved: json["isApproved"] ?? false,
      suspendedPermitBy: json["suspendedPermitBy"] ?? '',
      isPermitStarted: json["isPermitStarted"] ?? false,
      holidayPermitApprovedTime: json["holidayPermitApprovedTime"] ?? {},
      updatedAt: CreatedAt.fromJson(json["updatedAt"] ?? {}),
      permitStartTime: CreatedAt.fromJson(json["permitStartTime"] ?? {}),
      updatedBy: json["updatedBy"] ?? '',
      assignedPpe: List<AssignedPpe>.from(
          json["assignedPPE"].map((x) => AssignedPpe.fromJson(x))),
      isHolidayPermitApproved: json["isHolidayPermitApproved"] ?? false,
      minNumberOfPeople: json["minNumberOfPeople"] ?? 0,
      plantId: json["plantId"] ?? '',
      closedPermitBy: json["closedPermitBy"] ?? '',
      holidayPermitApprovedBy: json["holidayPermitApprovedBy"] ?? {},
      rejectedBy: json["rejectedBy"] ?? '',
      statusId: json["statusId"] ?? '',
      createdBy: json["createdBy"] ?? '',
      closedPermitTime: CreatedAt.fromJson(json["closedPermitTime"] ?? {}),
      isRejected: json["isRejected"] ?? false,
      permitStartBy: json["permitStartBy"] ?? '',
      startDate: CreatedAt.fromJson(json["startDate"] ?? {}),
      holidayId: json["holidayId"] ?? '',
      status: json["status"] ?? '',
      updateBy: json["updateBy"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "contractor": List<dynamic>.from(contractor.map((x) => x.toJson())),
        "isHolidayWorkPermit": isHolidayWorkPermit,
        "isReviewed": isReviewed,
        "isClosedPermit": isClosedPermit,
        "locationInchargerName": locationInchargerName,
        "rejectedTime": rejectedTime,
        "endDate": endDate.toJson(),
        "suspendedPermitTime": suspendedPermitTime.toJson(),
        "locationInchargerId": locationInchargerId,
        "approvedBy": approvedBy,
        "description": description,
        "assignedCheckList":
            List<dynamic>.from(assignedCheckList.map((x) => x.toJson())),
        "workPermitTypeId": workPermitTypeId,
        "createdAt": createdAt.toJson(),
        "workPermitTypeName": workPermitTypeName,
        "locationName": locationName,
        "locationId": locationId,
        "isSuspendedPermit": isSuspendedPermit,
        "approvedTime": approvedTime.toJson(),
        "id": id,
        "isApproved": isApproved,
        "suspendedPermitBy": suspendedPermitBy,
        "isPermitStarted": isPermitStarted,
        "holidayPermitApprovedTime": holidayPermitApprovedTime,
        "updatedAt": updatedAt.toJson(),
        "permitStartTime": permitStartTime.toJson(),
        "updatedBy": updatedBy,
        "assignedPPE": List<dynamic>.from(assignedPpe.map((x) => x.toJson())),
        "isHolidayPermitApproved": isHolidayPermitApproved,
        "minNumberOfPeople": minNumberOfPeople,
        "plantId": plantId,
        "closedPermitBy": closedPermitBy,
        "holidayPermitApprovedBy": holidayPermitApprovedBy,
        "rejectedBy": rejectedBy,
        "statusId": statusId,
        "createdBy": createdBy,
        "closedPermitTime": closedPermitTime.toJson(),
        "isRejected": isRejected,
        "permitStartBy": permitStartBy,
        "startDate": startDate.toJson(),
        "holidayId": holidayId,
        "status": status,
        "updateBy": updateBy,
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

class AssignedCheckList {
  final bool isYes;
  final bool isNotApplicable;
  final int index;
  final String checklist;
  final bool isNo;
  final String remark;
  final String id;
  final String name;

  AssignedCheckList({
    required this.isYes,
    required this.isNotApplicable,
    required this.index,
    required this.checklist,
    required this.isNo,
    required this.remark,
    required this.id,
    required this.name,
  });

  factory AssignedCheckList.fromJson(Map<String, dynamic> json) =>
      AssignedCheckList(
        isYes: json["isYes"] ?? false,
        isNotApplicable: json["isNotApplicable"] ?? false,
        index: json["index"] ?? 0,
        checklist: json["checklist"] ?? '',
        isNo: json["isNo"] ?? false,
        remark: json["remark"] ?? '',
        id: json["id"] ?? '',
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "isYes": isYes,
        "isNotApplicable": isNotApplicable,
        "index": index,
        "checklist": checklist,
        "isNo": isNo,
        "remark": remark,
        "id": id,
        "name": name,
      };
}

class AssignedPpe {
  final bool isNotApplicable;
  final bool isProvided;
  final String imageUrl;
  final String name;
  final int index;
  final String remark;
  final String id;
  final bool isChecked;
  final String image;

  AssignedPpe({
    required this.isNotApplicable,
    required this.isProvided,
    required this.imageUrl,
    required this.name,
    required this.index,
    required this.remark,
    required this.id,
    required this.isChecked,
    required this.image,
  });

  factory AssignedPpe.fromJson(Map<String, dynamic> json) => AssignedPpe(
        isNotApplicable: json["isNotApplicable"] ?? false,
        isProvided: json["isProvided"] ?? false,
        imageUrl: json["imageUrl"] ?? '',
        name: json["name"] ?? '',
        index: json["index"] ?? 0,
        remark: json["remark"] ?? '',
        id: json["id"] ?? '',
        isChecked: json["isChecked"] ?? false,
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "isNotApplicable": isNotApplicable,
        "isProvided": isProvided,
        "imageUrl": imageUrl,
        "name": name,
        "index": index,
        "remark": remark,
        "id": id,
        "isChecked": isChecked,
        "image": image,
      };
}

class Contractor {
  final String contractorId;
  final String contractorName;
  final List<AssignedLabour> assignedLabours;

  Contractor({
    required this.contractorId,
    required this.assignedLabours,
    required this.contractorName,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        contractorId: json["contractorId"],
        contractorName: json["contractorName"],
        assignedLabours: List<AssignedLabour>.from(
            json["assignedLabours"].map((x) => AssignedLabour.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contractorId": contractorId,
        "contractorName": contractorName,
        "assignedLabours":
            List<dynamic>.from(assignedLabours.map((x) => x.toJson())),
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
