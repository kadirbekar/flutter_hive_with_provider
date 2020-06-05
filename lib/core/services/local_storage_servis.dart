import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_local_storage/core/consts/ui_text_helper.dart' as text;

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  /*it checks if this service class 
  used before or not it if is return first instance*/
  static initialize() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  static Future<void> setTheme(bool newValue) async {
    return _preferences.setBool(text.themeValue, newValue);
  }

  //Get values with key
  static bool get getThemeValue => _preferences.getBool(text.themeValue) ?? false;
}
