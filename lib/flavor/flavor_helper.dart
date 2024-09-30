import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:work_permit_mobile_app/common/utilities/hive/hive_utility.dart';
import 'package:work_permit_mobile_app/firebase_options.dart';
import 'package:work_permit_mobile_app/flavor/app_config.dart';
import 'package:work_permit_mobile_app/modules/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FlavorHelper {
  static initializeMain() async {
    WidgetsFlutterBinding.ensureInitialized();
    HiveUtility.initHive();
    await Firebase.initializeApp(
        name: AppConfig.isProduction ? 'work permit' : 'work permit dev',
        options: DefaultFirebaseOptions.currentPlatform);
    initializeFirebaseCrashlytics();
    HttpOverrides.global = MyHttpOverrides();
    runApp(const MyApp());
  }

  static Future<void> initializeFirebaseCrashlytics() async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: AppConfig.isProduction ? false : true,
        home: const SplashScreen(),
      );
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
