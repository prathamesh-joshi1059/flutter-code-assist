import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:work_permit_mobile_app/common/internet_utility/internet_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/strings/value_string.dart';

/// Error logs instance

class ForceUpdateUtility {
  static checkUpdate(BuildContext context) {
    InternetUtil.isInternetAvailable((status) async {
      if (status) {
        try {
          final newVersionPlus = NewVersionPlus(
            androidId: ValueString.androidBundleName,
            iOSId: ValueString.iOSBundleName,
          );
          await newVersionPlus.getVersionStatus().then((status) {
            if (status != null) {
              if (status.canUpdate) {
                return newVersionPlus.showUpdateDialog(
                    context: context,
                    versionStatus: status,
                    allowDismissal: false);
              }
            }
          });
        } catch (e) {
          // LoggerService().logError(
          //     'Force update exception - ${e.toString()}');
          // throw Exception(e);
        }
      }
    });
  }
}
