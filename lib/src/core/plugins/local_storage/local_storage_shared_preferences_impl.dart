import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast/src/core/plugins/local_storage/local_storage.dart';

class SharedPreferencesStorage implements LocalStorage {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesStorage(this._sharedPreferences);

  @override
  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return _sharedPreferences.getString(key);
  }
}
