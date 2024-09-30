import 'package:animated_flutter_widgets/page_transitions/page_transition_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:work_permit_mobile_app/modules/dashboard/repository/dashboard_repository.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/screens/all_approval_pending_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approval_work_permit/screens/approval_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/approve_reject_suspend_screen/screens/approve_reject_suspend_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/close_work_permit/screens/all_close_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/close_work_permit/screens/close_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/add_more_details/screens/add_more_checklist_details_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/add_more_details/screens/add_more_labour_details_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/add_more_details/screens/add_more_ppe_details_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/create_edit_work_permit/screens/create_edit_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/dashboard_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/profile_details/profile_details_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/screens/all_review_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/review_work_permit/screens/review_work_permit_screen.dart';
import 'package:work_permit_mobile_app/modules/dashboard/screens/work_status_details_screen.dart';
import 'package:work_permit_mobile_app/modules/login/bloc/login_bloc.dart';
import 'package:work_permit_mobile_app/modules/login/repository/login_repository.dart';
import 'package:work_permit_mobile_app/modules/login/screens/change_password.dart';
import 'package:work_permit_mobile_app/modules/login/screens/forgot_password.dart';
import 'package:work_permit_mobile_app/modules/login/screens/login_screen.dart';
import 'package:work_permit_mobile_app/modules/login/screens/set_password_screen.dart';

class NavigatorUtility {
  static navigateToLoginScreen({required BuildContext context}) {
    return Navigator.pushAndRemoveUntil(
        context,
        FadePageAnimation(
            page: BlocProvider(
          create: (context) => LoginBloc(
            loginRepository: LoginRepositoryImpl(),
          ),
          child: const LoginScreen(),
        )),
        (Route<dynamic> route) => false);
  }

  static navigateToForgotPasswordScreen({required BuildContext context}) {
    return Navigator.push(
        context,
        FadePageAnimation(
          page: BlocProvider(
            create: (context) => LoginBloc(
              loginRepository: LoginRepositoryImpl(),
            ),
            child: const ForgotPasswordScreen(),
          ),
        ));
  }

  static navigateToChangePasswordScreen(
      {required BuildContext context, required Map changePasswordDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => LoginBloc(
          loginRepository: LoginRepositoryImpl(),
        ),
        child:
            ChangePasswordScreen(changePasswordDetails: changePasswordDetails),
      )),
    );
  }

  static navigateToSetPasswordScreen({required BuildContext context}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => LoginBloc(
          loginRepository: LoginRepositoryImpl(),
        ),
        child: const SetPasswordScreen(),
      )),
    );
  }

  static navigateToDashboardScreen({required BuildContext context}) {
    return Navigator.pushAndRemoveUntil(
        context,
        FadePageAnimation(
            page: BlocProvider(
          create: (context) => DashboardBloc(
            dashboardRepository: DashboardRepositoryImpl(),
          ),
          child: const DashboardScreen(),
        )),
        (Route<dynamic> route) => false);
  }

  static navigateToWorkStatusDetailsScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: WorkStatusDetailsScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToAllApprovalDetailsScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AllApprovalPendingPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToCreateEditWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: CreateEditWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToApproveRejectSuspendScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
        page: ApproveRejectSuspendScreen(workDetails: workDetails),
      ),
    );
  }

  // static navigateToAddMoreDetailsScreen(
  //     {required BuildContext context, required Map addDetailsMap}) {
  //   return Navigator.push(
  //     context,
  //     FadePageAnimation(
  //         page: BlocProvider(
  //       create: (context) => DashboardBloc(
  //         dashboardRepository: DashboardRepositoryImpl(),
  //       ),
  //       child: AddMoreDetailsScreen(addDetailsMap: addDetailsMap),
  //     )),
  //   );
  // }

  static navigateToAddMoreLabourDetailsScreen(
      {required BuildContext context, required Map addDetailsMap}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AddMoreLabourDetailsScreen(addDetailsMap: addDetailsMap),
      )),
    );
  }

  static navigateToAddMoreChecklistDetailsScreen(
      {required BuildContext context, required Map addDetailsMap}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AddMoreChecklistDetailsScreen(addDetailsMap: addDetailsMap),
      )),
    );
  }

  static navigateToAddMorePPEDetailsScreen(
      {required BuildContext context, required Map addDetailsMap}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AddMorePPEDetailsScreen(addDetailsMap: addDetailsMap),
      )),
    );
  }

  static navigateToApprovalWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: ApprovalWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToAllReviewWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AllReviewWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToReviewWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: ReviewWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToAllCloseWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: AllCloseWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToCloseWorkPermitScreen(
      {required BuildContext context, required Map workDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
          page: BlocProvider(
        create: (context) => DashboardBloc(
          dashboardRepository: DashboardRepositoryImpl(),
        ),
        child: CloseWorkPermitScreen(workDetails: workDetails),
      )),
    );
  }

  static navigateToProfileDetailsScreen(
      {required BuildContext context, required Map userDetails}) {
    return Navigator.push(
      context,
      FadePageAnimation(
        page: ProfileDetailsScreen(userDetails: userDetails),
      ),
    );
  }
}
