import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  final Battery _battery = Battery();

  Stream<int> get batteryLevel => _battery.onBatteryStateChanged.asyncExpand((_) async* {
        yield await _battery.batteryLevel;
      });

  Stream<BatteryState> get batteryState => _battery.onBatteryStateChanged;

  Future<int> getCurrentLevel() => _battery.batteryLevel;

  Future<BatteryState> getCurrentState() => _battery.batteryState;
}
