// import '../services/config/config_dev.dart';
// import '../services/config/config_production.dart';
// import '../services/config/config_staging.dart';

import 'package:wms_app/services/config/config_dev.dart';

import '../services/config/config_stag.dart';

class ConstData {
  static const int version = 16;

  static const String baseUrl = EnvironmentConfigStag.apiUrl;
}
