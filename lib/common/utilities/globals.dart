import 'package:flutter/cupertino.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';

buildWidth(context) => MediaQuery.of(context).size.width;

buildHeight(context) => MediaQuery.of(context).size.height;

Future<bool> isUserHasPermission(String permissionId) async {
  var userData = await HiveUtility.getDataFromHiveDb(
    boxName: HiveKeys.userDataBox,
    key: HiveKeys.userInfoKey,
  );

  List userResponsibilities = userData['responsibilities'];

  dynamic isUserHasResponsibility = userResponsibilities
      .where((responsibility) => responsibility['id'] == permissionId)
      .toList()
      .firstOrNull;

  if (isUserHasResponsibility != null) {
    return true;
  }
  return false;
}

Future<bool> isUserSuperAdmin() async {
  var userData = await HiveUtility.getDataFromHiveDb(
    boxName: HiveKeys.userDataBox,
    key: HiveKeys.userInfoKey,
  );

  if (userData['roleName'] == "Super Admin") {
    return true;
  }

  return false;
}
