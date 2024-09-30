import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_permit_mobile_app/common/utilities/globals.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_events.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_states.dart';
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
import 'package:work_permit_mobile_app/modules/dashboard/repository/dashboard_repository.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/model/fetch_all_work_permits_by_status_model.dart';

class DashboardBloc extends Bloc<DashboardEvents, DashboardStates> {
  DashboardRepository dashboardRepository;

  DashboardStates get initialState => DashboardInitialState();

  DashboardBloc({required this.dashboardRepository})
      : super(DashboardInitialState()) {
    on<LogoutEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        bool status = await dashboardRepository.logout();
        if (status) {
          emit(LogoutLoadedState());
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<FetchWorkPermitStatusCountsEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        bool isUserSuperAdminVal = await isUserSuperAdmin();

        FetchWorkPermitStatusCountsModel? fetchWorkPermitStatusCountsModel;

        if (isUserSuperAdminVal) {
          fetchWorkPermitStatusCountsModel =
              await dashboardRepository.fetchWorkPermitStatusCountsForSuperUser(
                  requestData: event.requestData);
        } else {
          fetchWorkPermitStatusCountsModel =
              await dashboardRepository.fetchWorkPermitStatusCountsForUser(
                  requestData: event.requestData);
        }

        if (fetchWorkPermitStatusCountsModel.statusCode == 200) {
          emit(FetchWorkPermitStatusCountsLoadedState(
              fetchWorkPermitStatusCountsModel:
                  fetchWorkPermitStatusCountsModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<FetchWorkPermitTypeCountsEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        FetchWorkPermitTypeCountsModel fetchWorkPermitTypeCountsModel =
            await dashboardRepository.fetchWorkPermitTypeCounts(
                requestData: event.requestData);

        if (fetchWorkPermitTypeCountsModel.statusCode == 200) {
          emit(FetchWorkPermitTypeCountsLoadedState(
              fetchWorkPermitTypeCountsModel: fetchWorkPermitTypeCountsModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<FetchAllWorkPermitByTypeEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        bool isUserSuperAdminVal = await isUserSuperAdmin();

        FetchWorkPermitByTypeModel? fetchWorkPermitByTypeModel;

        if (isUserSuperAdminVal) {
          fetchWorkPermitByTypeModel =
              await dashboardRepository.fetchAllWorkPermitByTypeForSuperUser(
                  requestData: event.requestData);
        } else {
          fetchWorkPermitByTypeModel = await dashboardRepository
              .fetchAllWorkPermitByTypeForUser(requestData: event.requestData);
        }

        if (fetchWorkPermitByTypeModel.statusCode == 200) {
          emit(FetchAllWorkPermitByTypeLoadedState(
              fetchWorkPermitByTypeModel: fetchWorkPermitByTypeModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetAllWorkPermitTypeEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetAllWorkPermitTypeModel getAllWorkPermitTypeModel =
            await dashboardRepository.getAllWorkPermitType(
                requestData: event.requestData);

        if (getAllWorkPermitTypeModel.statusCode == 200) {
          emit(GetAllWorkPermitTypeLoadedState(
              getAllWorkPermitTypeModel: getAllWorkPermitTypeModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetAllContractorEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetAllContractorModel getAllContractorModel = await dashboardRepository
            .getAllContractor(requestData: event.requestData);

        if (getAllContractorModel.statusCode == 200) {
          emit(GetAllContractorLoadedState(
              getAllContractorModel: getAllContractorModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetPlantLocationsEvent>((event, emit) async {
      emit(GetPlantLocationsLoadingState());
      try {
        GetPlantLocationsModel getPlantLocationsModel =
            await dashboardRepository.getPlantLocations(
                requestData: event.requestData);

        if (getPlantLocationsModel.statusCode == 200) {
          emit(GetPlantLocationsLoadedState(
              getPlantLocationsModel: getPlantLocationsModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetLabourByContractorEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetLabourByContractorModel getLabourByContractorModel =
            await dashboardRepository.getLabourByContractor(
                requestData: event.requestData);

        if (getLabourByContractorModel.statusCode == 200) {
          emit(GetLabourByContractorLoadedState(
              getLabourByContractorModel: getLabourByContractorModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetAllPPEEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetAllPPEModel getAllPPEModel =
            await dashboardRepository.getAllPPE(requestData: event.requestData);

        if (getAllPPEModel.statusCode == 200) {
          emit(GetAllPPELoadedState(getAllPPEModel: getAllPPEModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetAllChecklistEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetAllChecklistModel getAllChecklistModel = await dashboardRepository
            .getAllChecklist(requestData: event.requestData);

        if (getAllChecklistModel.statusCode == 200) {
          emit(GetAllChecklistLoadedState(
              getAllChecklistModel: getAllChecklistModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<CreateWorkPermitEvent>((event, emit) async {
      emit(CreateEditWorkPermitLoadingState());
      try {
        CreateWorkPermitModel createWorkPermitModel = await dashboardRepository
            .createWorkPermit(requestData: event.requestData);

        if (createWorkPermitModel.statusCode == 201) {
          emit(CreateWorkPermitLoadedState(
              createWorkPermitModel: createWorkPermitModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<EditWorkPermitEvent>((event, emit) async {
      emit(CreateEditWorkPermitLoadingState());
      try {
        Map<String, dynamic> response = await dashboardRepository
            .editWorkPermit(requestData: event.requestData);

        if (response['success'] == true) {
          emit(EditWorkPermitLoadedState());
        } else {
          emit(DashboardErrorState(message: response['message'].toString()));
        }
      } catch (e) {
        emit(DashboardErrorState(message: e.toString()));
      }
    });

    on<FetchAllWorkPermitsByStatusEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        FetchAllWorkPermitsByStatusModel fetchAllWorkPermitsByStatusModel =
            await dashboardRepository.fetchAllWorkPermitsByStatus(
                requestData: event.requestData);

        if (fetchAllWorkPermitsByStatusModel.statusCode == 200) {
          emit(FetchAllWorkPermitsByStatusLoadedState(
              fetchAllWorkPermitsByStatusModel:
                  fetchAllWorkPermitsByStatusModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<ApproveRejectWorkPermitEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel =
            await dashboardRepository.approveRejectWorkPermit(
                requestData: event.requestData);

        if (approveRejectSuspendPermitModel.statusCode == 200) {
          emit(ApproveRejectWorkPermitLoadedState(
              approveRejectSuspendPermitModel:
                  approveRejectSuspendPermitModel));
        } else {
          emit(DashboardErrorState(
              message: approveRejectSuspendPermitModel.message.toString()));
        }
      } catch (e) {
        emit(DashboardErrorState(message: e.toString()));
      }
    });

    on<SuspendWorkPermitEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel =
            await dashboardRepository.suspendWorkPermit(
                requestData: event.requestData);

        if (approveRejectSuspendPermitModel.statusCode == 200) {
          emit(ApproveRejectWorkPermitLoadedState(
              approveRejectSuspendPermitModel:
                  approveRejectSuspendPermitModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<ReviewWorkPermitEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel =
            await dashboardRepository.reviewWorkPermit(
                requestData: event.requestData);

        if (approveRejectSuspendPermitModel.statusCode == 200) {
          emit(ReviewWorkPermitEventLoadedState(
              approveRejectSuspendPermitModel:
                  approveRejectSuspendPermitModel));
        } else {
          emit(DashboardErrorState(
              message: approveRejectSuspendPermitModel.message));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<GetAllCloseWorkPermitEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        GetAllCloseWorkPermitModel getAllCloseWorkPermitModel =
            await dashboardRepository.getAllCloseWorkPermit(
                requestData: event.requestData);

        if (getAllCloseWorkPermitModel.statusCode == 200) {
          emit(GetAllClosePermitEventLoadedState(
              getAllCloseWorkPermitModel: getAllCloseWorkPermitModel));
        } else {
          emit(DashboardErrorState(
              message: ValueString.wentWrongText.toString()));
        }
      } catch (e) {
        emit(
            DashboardErrorState(message: ValueString.wentWrongText.toString()));
      }
    });

    on<CloseWorkPermitEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        ApproveRejectSuspendPermitModel approveRejectSuspendPermitModel =
            await dashboardRepository.closeWorkPermit(
                requestData: event.requestData);

        if (approveRejectSuspendPermitModel.statusCode == 200) {
          emit(ClosePermitEventLoadedState(
              approveRejectSuspendPermitModel:
                  approveRejectSuspendPermitModel));
        } else {
          emit(DashboardErrorState(message: ValueString.wentWrongText));
        }
      } catch (e) {
        emit(DashboardErrorState(message: e.toString()));
      }
    });
  }
}
