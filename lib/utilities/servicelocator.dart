import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initSharedPref();
  _initSession();
}

Future<void> _initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  sharedPref.setString('version', packageInfo.version);
  serviceLocator.registerSingleton<SharedPreferences>(sharedPref);
}

void _initSession() {
  // inilize provider
}
