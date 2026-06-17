import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  Battery? _battery;
  final bool _isWeb = kIsWeb;

  BatteryService() {
    if (!_isWeb) {
      _battery = Battery();
    }
  }

  Stream<int> get batteryLevel {
    if (_isWeb || _battery == null) return const Stream.empty();
    return _battery!.onBatteryStateChanged.asyncExpand((_) async* {
      yield await _battery!.batteryLevel;
    });
  }

  Stream<BatteryState> get batteryState {
    if (_isWeb || _battery == null) return const Stream.empty();
    return _battery!.onBatteryStateChanged;
  }

  Future<int> getCurrentLevel() async {
    if (_isWeb || _battery == null) return 0;
    try {
      return await _battery!.batteryLevel;
    } catch (_) {
      return 0;
    }
  }

  Future<BatteryState> getCurrentState() async {
    if (_isWeb || _battery == null) return BatteryState.unknown;
    try {
      return await _battery!.batteryState;
    } catch (_) {
      return BatteryState.unknown;
    }
  }
}
