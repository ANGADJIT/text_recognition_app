import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static SharedPreferences? _sharedPreferences;

  // making class singleton

  // ignore: unused_field
  static final CacheManager _ = CacheManager.init();

  CacheManager.init() {
    SharedPreferences.getInstance().then((value) => _sharedPreferences = value);
  }

  static cacheApiHost(String host) async {
    await _sharedPreferences?.setString('API_HOST', host);
  }

  static String? get apiHost => _sharedPreferences?.getString('API_HOST');
}
