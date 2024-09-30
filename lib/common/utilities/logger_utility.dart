import 'package:flutter/material.dart';

class LoggerService {
  static final LoggerService _singleton = LoggerService._internal();
  bool isFirstTimeInstall = true;

  factory LoggerService() {
    if (_singleton.isFirstTimeInstall == true) {
      debugPrint("FirstTimeInstall");
      _singleton.isFirstTimeInstall = false;
    }
    return _singleton;
  }

  LoggerService._internal();

  void logError(String error) {
    debugPrint('Error: $error');
  }

// void _log(String message) {
//   debugPrint(message);
// }
}
