import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:work_permit_mobile_app/common/utilities/logger_utility.dart';

class InternetUtil {
  static void isInternetAvailable(Function(bool) completionHandler) {
    try {
      var connectionStatus = _checkNetworkStatus();
      connectionStatus.then((bool status) {
        completionHandler(status);
      });
    } catch (e) {
      LoggerService()
          .logError('Internet Connection exception - ${e.toString()}');
      completionHandler(
          false); // Assuming internet is not available if an error occurs
    }
  }

  static Future<bool> _checkNetworkStatus() async {
    try {
      var connectionStatus = await (Connectivity().checkConnectivity());
      if (connectionStatus.first == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on Exception catch (e) {
      LoggerService()
          .logError('Checking Network Status exception - ${e.toString()}');
      return false;
    }
  }
}
