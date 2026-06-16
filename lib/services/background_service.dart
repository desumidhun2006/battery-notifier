import 'dart:async';
import 'dart:io';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundMonitorService {
  static const _targetKey = 'target_percent';
  static const _isActiveKey = 'is_active';
  static const _alarmFiredKey = 'alarm_fired';

  FlutterBackgroundService? _service;
  bool _isUnsupportedPlatform = Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  Future<void> init() async {
    if (_isUnsupportedPlatform) return;

    _service = FlutterBackgroundService();
    await _service!.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: false,
        isForegroundMode: true,
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onBackground,
      ),
    );
  }

  Future<void> start() async {
    if (_isUnsupportedPlatform || _service == null) return;
    await _service!.startService();
  }

  Future<void> stop() async {
    if (_isUnsupportedPlatform || _service == null) return;
    _service!.invoke('stop');
  }

  static void _onStart(ServiceInstance service) async {
    final battery = Battery();
    final prefs = await SharedPreferences.getInstance();

    Timer.periodic(const Duration(seconds: 30), (_) async {
      final isActive = prefs.getBool(_isActiveKey) ?? false;
      if (!isActive) return;

      final level = await battery.batteryLevel;
      final state = await battery.batteryState;
      final target = prefs.getInt(_targetKey) ?? 80;
      final alarmFired = prefs.getBool(_alarmFiredKey) ?? false;

      if (state == BatteryState.discharging && level <= target && !alarmFired) {
        await prefs.setBool(_alarmFiredKey, true);
        service.invoke('alarm', {'level': level, 'target': target});
      }

      if (state == BatteryState.charging || state == BatteryState.full) {
        if (alarmFired) {
          await prefs.setBool(_alarmFiredKey, false);
          service.invoke('dismiss_alarm');
        }
      }
    });

    service.on('stop').listen((_) {
      service.stopSelf();
    });
  }

  static Future<bool> _onBackground(ServiceInstance service) async {
    return true;
  }

  Future<void> setAlarmFired(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_alarmFiredKey, value);
  }

  Stream<Map<String, dynamic>?> get onAlarm {
    return _service?.on('alarm') ?? const Stream.empty();
  }

  Stream<Map<String, dynamic>?> get onDismissAlarm {
    return _service?.on('dismiss_alarm') ?? const Stream.empty();
  }
}
