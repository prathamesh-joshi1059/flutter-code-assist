class ApiConstants {
  ApiConstants._();

  static const String prodBaseUrl =
      "https://us-central1-work-permit-4c80a.cloudfunctions.net/webApi";
  static const String devBaseUrl =
      "https://us-central1-work-permit-dev.cloudfunctions.net/webApi";

  static const String api = "api";
  static const String users = "users";
  static const String workPermit = "workPermit";
  static const String fetchWorkpermitByUser = "fetchWorkpermitByUser";
  static const String fetchWorkpermitByType = "fetchWorkpermitByType";
  static const String contractor = "contractor";
  static const String locations = "locations";
  static const String labour = "labour";
  static const String checklist = "checklist";
  static const String ppe = "ppe";
  static const String getAllPPE = "getAllPPE";
  static const String createWorkPermit = "createWorkPermit";
  static const String updateWorkPermit = "updateWorkPermit";
  static const String fetchAllWorkPermitsByStatus =
      "fetchAllWorkPermitsByStatus";
  static const String getAllChecklist = "getAllChecklist";
  static const String getLabourByContractorId = "getLabourByContractorId";
  static const String getPlantLocations = "getPlantLocations";
  static const String plant = "plant";
  static const String status = "status";
  static const String user = "user";
  static const String workPermitType = "workPermitType";
  static const String getUser = "getUser";
  static const String updateUserLoginStatus = "updateUserLoginStatus";
  static const String fetchWorkPermitStatusCounts =
      "fetchWorkPermitStatusCounts";
  static const String fetchWorkPermitStatusCountsByPlant =
      "fetchWorkPermitStatusCountsByPlant";
  static const String fetchWorkPermitTypeCounts = "fetchWorkPermitTypeCounts";
  static const String fetchAllWorkPermitByType = "fetchAllWorkpermitByType";
  static const String getAllWorkPermitType = "getAllWorkPermitType";
  static const String getAllContractor = "getAllContractor";
  static const String approveOrRejectWorkPermit = "approveOrRejectWorkPermit";
  static const String suspendWorkPermit = "suspendWorkPermit";
  static const String reviewWorkPermit = "reviewWorkPermit";
  static const String closeWorkPermit = "closeWorkPermit";
}
