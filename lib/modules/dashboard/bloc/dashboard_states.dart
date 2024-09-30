import 'package:equatable/equatable.dart';
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

abstract class DashboardStates extends Equatable {}

class DashboardInitialState extends DashboardStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Common dashboard Loading and Error state
class DashboardLoadingState extends DashboardStates {
  @override
  List<Object> get props => []; // Return the properties of this state
}

class DashboardErrorState extends DashboardStates {
  final String message;

  DashboardErrorState({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// Logout
class LogoutLoadedState extends DashboardStates {
  LogoutLoadedState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// FetchWorkPermitTypeCountsEvent
class FetchWorkPermitTypeCountsLoadedState extends DashboardStates {
  final FetchWorkPermitTypeCountsModel fetchWorkPermitTypeCountsModel;

  FetchWorkPermitTypeCountsLoadedState(
      {required this.fetchWorkPermitTypeCountsModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// FetchWorkPermitStatusCountsEvent
class FetchWorkPermitStatusCountsLoadedState extends DashboardStates {
  final FetchWorkPermitStatusCountsModel fetchWorkPermitStatusCountsModel;

  FetchWorkPermitStatusCountsLoadedState(
      {required this.fetchWorkPermitStatusCountsModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// FetchWorkPermitStatusCountsEvent
class FetchAllWorkPermitByTypeLoadedState extends DashboardStates {
  final FetchWorkPermitByTypeModel fetchWorkPermitByTypeModel;

  FetchAllWorkPermitByTypeLoadedState(
      {required this.fetchWorkPermitByTypeModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// GetAllWorkPermitTypeEvent
class GetAllWorkPermitTypeLoadedState extends DashboardStates {
  final GetAllWorkPermitTypeModel getAllWorkPermitTypeModel;

  GetAllWorkPermitTypeLoadedState({required this.getAllWorkPermitTypeModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// GetAllContractorEvent
class GetAllContractorLoadedState extends DashboardStates {
  final GetAllContractorModel getAllContractorModel;

  GetAllContractorLoadedState({required this.getAllContractorModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// GetPlantLocationsEvent
class GetPlantLocationsLoadedState extends DashboardStates {
  final GetPlantLocationsModel getPlantLocationsModel;

  GetPlantLocationsLoadedState({required this.getPlantLocationsModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPlantLocationsLoadingState extends DashboardStates {
  GetPlantLocationsLoadingState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// GetLabourByContractor
class GetLabourByContractorLoadedState extends DashboardStates {
  final GetLabourByContractorModel getLabourByContractorModel;

  GetLabourByContractorLoadedState({required this.getLabourByContractorModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// GetAllChecklist
class GetAllChecklistLoadedState extends DashboardStates {
  final GetAllChecklistModel getAllChecklistModel;

  GetAllChecklistLoadedState({required this.getAllChecklistModel});

  @override
  List<Object?> get props => [getAllChecklistModel];
}

/// getAllPPE
class GetAllPPELoadedState extends DashboardStates {
  final GetAllPPEModel getAllPPEModel;

  GetAllPPELoadedState({required this.getAllPPEModel});

  @override
  List<Object?> get props => [getAllPPEModel];
}

/// CreateWorkPermitEvent
class CreateWorkPermitLoadedState extends DashboardStates {
  final CreateWorkPermitModel createWorkPermitModel;

  CreateWorkPermitLoadedState({required this.createWorkPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateEditWorkPermitLoadingState extends DashboardStates {
  CreateEditWorkPermitLoadingState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

/// EditWorkPermitEvent
class EditWorkPermitLoadedState extends DashboardStates {
  EditWorkPermitLoadedState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchAllWorkPermitsByStatusLoadedState extends DashboardStates {
  final FetchAllWorkPermitsByStatusModel fetchAllWorkPermitsByStatusModel;

  FetchAllWorkPermitsByStatusLoadedState(
      {required this.fetchAllWorkPermitsByStatusModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApproveRejectWorkPermitLoadedState extends DashboardStates {
  final ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel;

  ApproveRejectWorkPermitLoadedState(
      {required this.approveRejectSuspendPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SuspendWorkPermitLoadedState extends DashboardStates {
  final ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel;

  SuspendWorkPermitLoadedState({required this.approveRejectSuspendPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReviewWorkPermitEventLoadedState extends DashboardStates {
  final ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel;

  ReviewWorkPermitEventLoadedState(
      {required this.approveRejectSuspendPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllClosePermitEventLoadedState extends DashboardStates {
  final GetAllCloseWorkPermitModel getAllCloseWorkPermitModel;

  GetAllClosePermitEventLoadedState({required this.getAllCloseWorkPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ClosePermitEventLoadedState extends DashboardStates {
  final ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel;

  ClosePermitEventLoadedState({required this.approveRejectSuspendPermitModel});

  @override
  List<Object?> get props => throw UnimplementedError();
}
