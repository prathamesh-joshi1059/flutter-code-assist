import 'dart:convert';

GetAllCloseWorkPermitModel getAllCloseWorkPermitModelFromJson(String str) =>
    GetAllCloseWorkPermitModel.fromJson(json.decode(str));

String getAllCloseWorkPermitModelToJson(GetAllCloseWorkPermitModel data) =>
    json.encode(data.toJson());

class GetAllCloseWorkPermitModel {
  final int statusCode;
  final List<Datum> data;
  final String message;
  final bool success;

  GetAllCloseWorkPermitModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory GetAllCloseWorkPermitModel.fromJson(Map<String, dynamic> json) =>
      GetAllCloseWorkPermitModel(
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
  final bool isHolidayWorkPermit;
  final bool isClosedPermit;
  final String locationInchargerName;
  final dynamic rejectedTime;
  final ApprovedTime endDate;
  final dynamic suspendedPermitTime;
  final String locationInchargerId;
  final String description;
  final String workPermitTypeId;
  final ApprovedTime createdAt;
  final String workPermitTypeName;
  final String locationId;
  final bool isSuspendedPermit;
  final String id;
  final dynamic suspendedPermitBy;
  final dynamic holidayPermitApprovedTime;
  final String locationName;
  final String updatedBy;
  final bool isHolidayPermitApproved;
  final int minNumberOfPeople;
  final bool isReviewed;
  final String plantId;
  final dynamic closedPermitBy;
  final dynamic holidayPermitApprovedBy;
  final dynamic rejectedBy;
  final String createdBy;
  final dynamic closedPermitTime;
  final bool isRejected;
  final String plantName;
  final ApprovedTime startDate;
  final String holidayId;
  final List<Contractor> contractor;
  final List<AssignedPpe> assignedPpe;
  final List<AssignedCheckList> assignedCheckList;
  final String updateBy;
  final String approvedBy;
  final ApprovedTime approvedTime;
  final bool isApproved;
  final ApprovedTime permitStartTime;
  final String statusId;
  final String permitStartBy;
  final bool isPermitStarted;
  final String status;
  final ApprovedTime updatedAt;

  Datum({
    required this.isHolidayWorkPermit,
    required this.isClosedPermit,
    required this.locationInchargerName,
    required this.rejectedTime,
    required this.endDate,
    required this.suspendedPermitTime,
    required this.locationInchargerId,
    required this.description,
    required this.workPermitTypeId,
    required this.createdAt,
    required this.workPermitTypeName,
    required this.locationId,
    required this.isSuspendedPermit,
    required this.id,
    required this.suspendedPermitBy,
    required this.holidayPermitApprovedTime,
    required this.locationName,
    required this.updatedBy,
    required this.isHolidayPermitApproved,
    required this.minNumberOfPeople,
    required this.isReviewed,
    required this.plantId,
    required this.closedPermitBy,
    required this.holidayPermitApprovedBy,
    required this.rejectedBy,
    required this.createdBy,
    required this.closedPermitTime,
    required this.isRejected,
    required this.plantName,
    required this.startDate,
    required this.holidayId,
    required this.contractor,
    required this.assignedPpe,
    required this.assignedCheckList,
    required this.updateBy,
    required this.approvedBy,
    required this.approvedTime,
    required this.isApproved,
    required this.permitStartTime,
    required this.statusId,
    required this.permitStartBy,
    required this.isPermitStarted,
    required this.status,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        isHolidayWorkPermit: json["isHolidayWorkPermit"] ?? false,
        isClosedPermit: json["isClosedPermit"] ?? false,
        locationInchargerName: json["locationInchargerName"] ?? '',
        rejectedTime: json["rejectedTime"] ?? '',
        endDate: ApprovedTime.fromJson(json["endDate"] ?? ''),
        suspendedPermitTime: json["suspendedPermitTime"] ?? '',
        locationInchargerId: json["locationInchargerId"] ?? '',
        description: json["description"] ?? '',
        workPermitTypeId: json["workPermitTypeId"] ?? '',
        createdAt: ApprovedTime.fromJson(json["createdAt"] ?? ''),
        workPermitTypeName: json["workPermitTypeName"] ?? '',
        locationId: json["locationId"] ?? '',
        isSuspendedPermit: json["isSuspendedPermit"] ?? false,
        id: json["id"] ?? '',
        suspendedPermitBy: json["suspendedPermitBy"] ?? '',
        holidayPermitApprovedTime: json["holidayPermitApprovedTime"] ?? '',
        locationName: json["locationName"] ?? '',
        updatedBy: json["updatedBy"] ?? '',
        isHolidayPermitApproved: json["isHolidayPermitApproved"] ?? false,
        minNumberOfPeople: json["minNumberOfPeople"] ?? '',
        isReviewed: json["isReviewed"] ?? false,
        plantId: json["plantId"] ?? '',
        closedPermitBy: json["closedPermitBy"] ?? '',
        holidayPermitApprovedBy: json["holidayPermitApprovedBy"] ?? '',
        rejectedBy: json["rejectedBy"] ?? '',
        createdBy: json["createdBy"] ?? '',
        closedPermitTime: json["closedPermitTime"] ?? '',
        isRejected: json["isRejected"] ?? false,
        plantName: json["plantName"] ?? '',
        startDate: ApprovedTime.fromJson(json["startDate"] ?? ''),
        holidayId: json["holidayId"] ?? '',
        contractor: List<Contractor>.from(
            json["contractor"].map((x) => Contractor.fromJson(x))),
        assignedPpe: List<AssignedPpe>.from(
            json["assignedPPE"].map((x) => AssignedPpe.fromJson(x))),
        assignedCheckList: List<AssignedCheckList>.from(
            json["assignedCheckList"]
                .map((x) => AssignedCheckList.fromJson(x))),
        updateBy: json["updateBy"] ?? '',
        approvedBy: json["approvedBy"] ?? '',
        approvedTime: ApprovedTime.fromJson(json["approvedTime"]),
        isApproved: json["isApproved"],
        permitStartTime: ApprovedTime.fromJson(json["permitStartTime"] ?? {}),
        statusId: json["statusId"] ?? '',
        permitStartBy: json["permitStartBy"] ?? '',
        isPermitStarted: json["isPermitStarted"] ?? false,
        status: json["status"] ?? '',
        updatedAt: ApprovedTime.fromJson(json["updatedAt"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "isHolidayWorkPermit": isHolidayWorkPermit,
        "isClosedPermit": isClosedPermit,
        "locationInchargerName": locationInchargerName,
        "rejectedTime": rejectedTime,
        "endDate": endDate.toJson(),
        "suspendedPermitTime": suspendedPermitTime,
        "locationInchargerId": locationInchargerId,
        "description": description,
        "workPermitTypeId": workPermitTypeId,
        "createdAt": createdAt.toJson(),
        "workPermitTypeName": workPermitTypeName,
        "locationId": locationId,
        "isSuspendedPermit": isSuspendedPermit,
        "id": id,
        "suspendedPermitBy": suspendedPermitBy,
        "holidayPermitApprovedTime": holidayPermitApprovedTime,
        "locationName": locationName,
        "updatedBy": updatedBy,
        "isHolidayPermitApproved": isHolidayPermitApproved,
        "minNumberOfPeople": minNumberOfPeople,
        "isReviewed": isReviewed,
        "plantId": plantId,
        "closedPermitBy": closedPermitBy,
        "holidayPermitApprovedBy": holidayPermitApprovedBy,
        "rejectedBy": rejectedBy,
        "createdBy": createdBy,
        "closedPermitTime": closedPermitTime,
        "isRejected": isRejected,
        "plantName": plantName,
        "startDate": startDate.toJson(),
        "holidayId": holidayId,
        "contractor": List<dynamic>.from(contractor.map((x) => x.toJson())),
        "assignedPPE": List<dynamic>.from(assignedPpe.map((x) => x.toJson())),
        "assignedCheckList":
            List<dynamic>.from(assignedCheckList.map((x) => x.toJson())),
        "updateBy": updateBy,
        "approvedBy": approvedBy,
        "approvedTime": approvedTime.toJson(),
        "isApproved": isApproved,
        "permitStartTime": permitStartTime.toJson(),
        "statusId": statusId,
        "permitStartBy": permitStartBy,
        "isPermitStarted": isPermitStarted,
        "status": status,
        "updatedAt": updatedAt.toJson(),
      };
}

class ApprovedTime {
  final int seconds;
  final int nanoseconds;

  ApprovedTime({
    required this.seconds,
    required this.nanoseconds,
  });

  factory ApprovedTime.fromJson(Map<String, dynamic> json) => ApprovedTime(
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
  final String name;
  final bool isNo;
  final String remark;
  final String id;
  final String checklist;

  AssignedCheckList({
    required this.isYes,
    required this.isNotApplicable,
    required this.name,
    required this.isNo,
    required this.remark,
    required this.id,
    required this.checklist,
  });

  factory AssignedCheckList.fromJson(Map<String, dynamic> json) =>
      AssignedCheckList(
        isYes: json["isYes"] ?? false,
        isNotApplicable: json["isNotApplicable"] ?? false,
        name: json["name"] ?? '',
        isNo: json["isNo"] ?? false,
        remark: json["remark"] ?? '',
        id: json["id"] ?? '',
        checklist: json["checklist"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "isYes": isYes,
        "isNotApplicable": isNotApplicable,
        "name": name,
        "isNo": isNo,
        "remark": remark,
        "id": id,
        "checklist": checklist,
      };
}

class AssignedPpe {
  final String image;
  final bool isRequired;
  final bool isVerified;
  final bool isProvided;
  final String name;
  final String remark;
  final String id;
  final bool isNotApplicable;
  final String imageUrl;
  final bool isChecked;

  AssignedPpe({
    required this.image,
    required this.isRequired,
    required this.isVerified,
    required this.isProvided,
    required this.name,
    required this.remark,
    required this.id,
    required this.isNotApplicable,
    required this.imageUrl,
    required this.isChecked,
  });

  factory AssignedPpe.fromJson(Map<String, dynamic> json) => AssignedPpe(
        image: json["image"] ?? '',
        isRequired: json["isRequired"] ?? false,
        isVerified: json["isVerified"] ?? false,
        isProvided: json["isProvided"] ?? false,
        name: json["name"] ?? '',
        remark: json["remark"] ?? '',
        id: json["id"],
        isNotApplicable: json["isNotApplicable"] ?? false,
        imageUrl: json["imageUrl"] ?? '',
        isChecked: json["isChecked"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "isRequired": isRequired,
        "isVerified": isVerified,
        "isProvided": isProvided,
        "name": name,
        "remark": remark,
        "id": id,
        "isNotApplicable": isNotApplicable,
        "imageUrl": imageUrl,
        "isChecked": isChecked,
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
        contractorId: json["contractorId"],
        assignedLabours: List<AssignedLabour>.from(
            json["assignedLabours"].map((x) => AssignedLabour.fromJson(x))),
        contractorName: json["contractorName"],
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
