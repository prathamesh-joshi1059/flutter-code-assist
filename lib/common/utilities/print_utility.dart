import 'package:flutter/foundation.dart';

class PrintUtility {
  PrintUtility._();
  static void debugPrint({required String message}) {
    if (kDebugMode) {
      print(message.toString());
    }
  }
}
