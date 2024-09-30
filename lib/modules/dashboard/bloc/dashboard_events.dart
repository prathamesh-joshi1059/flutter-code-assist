import 'package:equatable/equatable.dart';

abstract class DashboardEvents extends Equatable {}

class LogoutEvent extends DashboardEvents {
  LogoutEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchWorkPermitStatusCountsEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  FetchWorkPermitStatusCountsEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchWorkPermitTypeCountsEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  FetchWorkPermitTypeCountsEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchAllWorkPermitByTypeEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  FetchAllWorkPermitByTypeEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchAllWorkPermitsByStatusEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  FetchAllWorkPermitsByStatusEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllWorkPermitTypeEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetAllWorkPermitTypeEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllContractorEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetAllContractorEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPlantLocationsEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetPlantLocationsEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetLabourByContractorEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetLabourByContractorEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllChecklistEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetAllChecklistEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllPPEEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetAllPPEEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CreateWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  CreateWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class EditWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  EditWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ApproveRejectWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  ApproveRejectWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SuspendWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  SuspendWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReviewWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  ReviewWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllCloseWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  GetAllCloseWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CloseWorkPermitEvent extends DashboardEvents {
  final Map<String, dynamic> requestData;

  CloseWorkPermitEvent({required this.requestData});

  @override
  List<Object?> get props => throw UnimplementedError();
}
