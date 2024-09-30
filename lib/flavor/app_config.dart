import 'package:work_permit_mobile_app/common/utilities/enum.dart';

class AppConfig {
  String baseUrl = "";
  Flavor flavor = Flavor.development;
  AppConfig(this.baseUrl, this.flavor);

  static AppConfig instance = AppConfig.create();

  factory AppConfig.create(
      {String baseUrl = "", Flavor flavor = Flavor.development}) {
    return instance = AppConfig(baseUrl, flavor);
  }

  static bool get isProduction => instance.flavor == Flavor.production;
  static bool get isStaging => instance.flavor == Flavor.development;
}
