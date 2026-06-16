import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static const _targetKey = 'target_percent';
  static const _alarmPathKey = 'alarm_path';
  static const _isActiveKey = 'is_active';

  final SharedPreferences _prefs;

  Settings(this._prefs);

  int get targetPercent => _prefs.getInt(_targetKey) ?? 80;
  set targetPercent(int value) => _prefs.setInt(_targetKey, value);

  String? get alarmPath => _prefs.getString(_alarmPathKey);
  set alarmPath(String? value) {
    if (value == null) {
      _prefs.remove(_alarmPathKey);
    } else {
      _prefs.setString(_alarmPathKey, value);
    }
  }

  bool get isActive => _prefs.getBool(_isActiveKey) ?? false;
  set isActive(bool value) => _prefs.setBool(_isActiveKey, value);
}
