import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_keys.dart';
import 'package:work_permit_mobile_app/common/utilities/logger_utility.dart';
import 'package:work_permit_mobile_app/common/utilities/toast_utility.dart';

class HiveUtility {
  HiveUtility._();

  static initHive() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      Hive.init(appDocPath);
      await Hive.openBox(HiveKeys.userDataBox);
    } on Exception catch (e) {
      LoggerService()
          .logError('Hive initialization exception - ${e.toString()}');
      rethrow;
    }
  }

  static clearAllData() async {
    try {
      await Hive.deleteFromDisk();
      await Hive.close();
      await initHive();
    } catch (e) {
      LoggerService()
          .logError('Hive data clearing exception - ${e.toString()}');
      rethrow;
    }
  }

  static storeDataInHiveDb(
      {required String boxName,
      required String key,
      required dynamic value}) async {
    try {
      if (key.isNotEmpty) {
        Hive.box(boxName).put(key, value);
      }
    } catch (e) {
      LoggerService().logError('Hive data storing exception - ${e.toString()}');
      ToastUtility.showToast(e.toString());
    }
  }

  static Future<dynamic> getDataFromHiveDb({
    required String boxName,
    required String key,
  }) async {
    try {
      await initHive();
      await Hive.openBox(boxName);

      if (key.isNotEmpty) {
        return Hive.box<dynamic>(boxName).get(key);
      }
      return null;
    } catch (e) {
      LoggerService().logError('Hive data fetch error - ${e.toString()}');
      return null;
    }
  }

  static deleteBoxes() async {
    try {
      await Hive.deleteFromDisk();
      await Hive.close();
      await initHive();
    } catch (e) {
      LoggerService().logError('Hive box delete exception - ${e.toString()}');
      ToastUtility.showToast(e.toString());
    }
  }
}
