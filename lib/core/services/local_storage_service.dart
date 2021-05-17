import 'package:flutter_app/core/common/local_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
      await _instance._init();
    }
    return _instance;
  }

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  Future<bool> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  List<String> getStringList(String key) {
    if (_preferences == null) return [];
    return _preferences.getStringList(key) ?? [];
  }

  Future<bool> putStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

  void clear() {
    _preferences.remove(LocalStorageKeys.user);
  }
}
