import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_permit_mobile_app/common/api/api_constant/api_constant.dart';
import 'package:work_permit_mobile_app/common/api/api_provider.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/approve_reject_permit_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/create_work_permit_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/fetch_work_permit_status_counts_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/fetch_work_permit_type_counts_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_checklist_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_close_work_permit_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_contractor_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_ppe_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_all_work_permit_type_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_labour_by_contractor_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_plant_locations_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/model/get_work_permit_by_type_model.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/model/fetch_all_work_permits_by_status_model.dart';

abstract class DashboardRepository {
  Future<bool> logout();

  Future<FetchWorkPermitStatusCountsModel> fetchWorkPermitStatusCountsForUser(
      {required requestData});

  Future<FetchWorkPermitStatusCountsModel>
      fetchWorkPermitStatusCountsForSuperUser({required requestData});

  Future<FetchWorkPermitTypeCountsModel> fetchWorkPermitTypeCounts(
      {required requestData});

  Future<FetchWorkPermitByTypeModel> fetchAllWorkPermitByTypeForUser(
      {required requestData});

  Future<FetchWorkPermitByTypeModel> fetchAllWorkPermitByTypeForSuperUser(
      {required requestData});

  Future<GetAllWorkPermitTypeModel> getAllWorkPermitType(
      {required requestData});

  Future<GetAllContractorModel> getAllContractor({required requestData});

  Future<GetPlantLocationsModel> getPlantLocations({required requestData});

  Future<GetLabourByContractorModel> getLabourByContractor(
      {required requestData});

  Future<GetAllChecklistModel> getAllChecklist({required requestData});

  Future<GetAllPPEModel> getAllPPE({required requestData});

  Future<CreateWorkPermitModel> createWorkPermit({required requestData});

  Future<Map<String, dynamic>> editWorkPermit({required requestData});

  Future<FetchAllWorkPermitsByStatusModel> fetchAllWorkPermitsByStatus(
      {required requestData});

  Future<ApproveRejectSuspendPermitModel> approveRejectWorkPermit(
      {required requestData});

  Future<ApproveRejectSuspendPermitModel> suspendWorkPermit(
      {required requestData});

  Future<ApproveRejectSuspendPermitModel> reviewWorkPermit(
      {required requestData});

  Future<GetAllCloseWorkPermitModel> getAllCloseWorkPermit(
      {required requestData});

  Future<ApproveRejectSuspendPermitModel> closeWorkPermit(
      {required requestData});
}

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  Future<bool> logout() async {
    if (FirebaseAuth.instance.currentUser != null) {
      FirebaseAuth.instance.signOut();
      HiveUtility.clearAllData();
      return true;
    }
    return false;
  }

  @override
  Future<FetchWorkPermitStatusCountsModel> fetchWorkPermitStatusCountsForUser(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchWorkPermitStatusCounts}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.user}/${requestData['userId']}",
        null);
    return FetchWorkPermitStatusCountsModel.fromJson(response);
  }

  @override
  Future<FetchWorkPermitStatusCountsModel>
      fetchWorkPermitStatusCountsForSuperUser({required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchWorkPermitStatusCountsByPlant}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.user}/${requestData['userId']}",
        null);
    return FetchWorkPermitStatusCountsModel.fromJson(response);
  }

  @override
  Future<FetchWorkPermitTypeCountsModel> fetchWorkPermitTypeCounts(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchWorkPermitTypeCounts}/${requestData['plantId']}",
        null);
    return FetchWorkPermitTypeCountsModel.fromJson(response);
  }

  @override
  Future<FetchWorkPermitByTypeModel> fetchAllWorkPermitByTypeForUser(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchWorkpermitByUser}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.workPermitType}/${requestData['workPermitType']}/${ApiConstants.user}/${requestData['userId']}",
        null);
    return FetchWorkPermitByTypeModel.fromJson(response);
  }

  @override
  Future<FetchWorkPermitByTypeModel> fetchAllWorkPermitByTypeForSuperUser(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchWorkpermitByType}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.workPermitType}/${requestData['workPermitType']}",
        null);
    return FetchWorkPermitByTypeModel.fromJson(response);
  }

  @override
  Future<GetAllWorkPermitTypeModel> getAllWorkPermitType(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermitType}/${ApiConstants.getAllWorkPermitType}",
        null);
    return GetAllWorkPermitTypeModel.fromJson(response);
  }

  @override
  Future<GetAllContractorModel> getAllContractor({required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.contractor}/${ApiConstants.getAllContractor}",
        null);
    return GetAllContractorModel.fromJson(response);
  }

  @override
  Future<GetPlantLocationsModel> getPlantLocations(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.locations}/${ApiConstants.getPlantLocations}/${requestData['plantId']}",
        null);
    return GetPlantLocationsModel.fromJson(response);
  }

  @override
  Future<GetLabourByContractorModel> getLabourByContractor(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.labour}/${ApiConstants.getLabourByContractorId}/${requestData['contractorId']}",
        null);
    return GetLabourByContractorModel.fromJson(response);
  }

  @override
  Future<GetAllChecklistModel> getAllChecklist({required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.checklist}/${ApiConstants.getAllChecklist}",
        null);
    return GetAllChecklistModel.fromJson(response);
  }

  @override
  Future<GetAllPPEModel> getAllPPE({required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.ppe}/${ApiConstants.getAllPPE}",
        null);
    return GetAllPPEModel.fromJson(response);
  }

  @override
  Future<CreateWorkPermitModel> createWorkPermit({required requestData}) async {
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.createWorkPermit}",
        requestData);
    return CreateWorkPermitModel.fromJson(response);
  }

  @override
  Future<Map<String, dynamic>> editWorkPermit({required requestData}) async {
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.updateWorkPermit}",
        requestData);
    return response;
  }

  @override
  Future<FetchAllWorkPermitsByStatusModel> fetchAllWorkPermitsByStatus(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchAllWorkPermitsByStatus}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.status}/${requestData['statusId']}",
        null);
    return FetchAllWorkPermitsByStatusModel.fromJson(response);
  }

  @override
  Future<ApproveRejectSuspendPermitModel> approveRejectWorkPermit(
      {required requestData}) async {
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.approveOrRejectWorkPermit}",
        requestData);
    return ApproveRejectSuspendPermitModel.fromJson(response);
  }

  @override
  Future<ApproveRejectSuspendPermitModel> suspendWorkPermit(
      {required requestData}) async {
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.suspendWorkPermit}",
        requestData);
    return ApproveRejectSuspendPermitModel.fromJson(response);
  }

  @override
  Future<ApproveRejectSuspendPermitModel> reviewWorkPermit(
      {required requestData}) async {
    debugPrint('requestData->$requestData', wrapWidth: 580);
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.reviewWorkPermit}",
        requestData);
    return ApproveRejectSuspendPermitModel.fromJson(response);
  }

  @override
  Future<GetAllCloseWorkPermitModel> getAllCloseWorkPermit(
      {required requestData}) async {
    dynamic response = await _apiProvider.get(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.fetchAllWorkPermitsByStatus}/${ApiConstants.plant}/${requestData['plantId']}/${ApiConstants.status}/${requestData['statusId']}",
        null);
    return GetAllCloseWorkPermitModel.fromJson(response);
  }

  @override
  Future<ApproveRejectSuspendPermitModel> closeWorkPermit(
      {required requestData}) async {
    debugPrint('requestData->${requestData}', wrapWidth: 580);
    dynamic response = await _apiProvider.post(
        "/${ApiConstants.api}/${ApiConstants.workPermit}/${ApiConstants.closeWorkPermit}",
        requestData);
    return ApproveRejectSuspendPermitModel.fromJson(response);
  }
}
