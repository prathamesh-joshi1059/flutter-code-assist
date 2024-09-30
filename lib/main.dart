import 'package:work_permit_mobile_app/common/api/api_constant/api_constant.dart';
import 'package:work_permit_mobile_app/common/utilities/enum.dart';
import 'package:work_permit_mobile_app/flavor/app_config.dart';
import 'package:work_permit_mobile_app/flavor/flavor_helper.dart';

void main() async {
  AppConfig.create(
      baseUrl: ApiConstants.prodBaseUrl, flavor: Flavor.production);
  FlavorHelper.initializeMain();
}
