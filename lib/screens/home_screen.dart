import 'dart:async';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../models/settings.dart';
import '../services/battery_service.dart';
import '../services/alarm_service.dart';
import '../services/notification_service.dart';
import '../services/background_service.dart';

class HomeScreen extends StatefulWidget {
  final Settings settings;
  const HomeScreen({super.key, required this.settings});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BatteryService _batteryService = BatteryService();
  final AlarmService _alarmService = AlarmService();
  final NotificationService _notificationService = NotificationService();
  final BackgroundMonitorService _bgService = BackgroundMonitorService();

  int _currentLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;
  bool _alarmActive = false;
  late double _targetPercent;
  late TextEditingController _targetController;
  String _selectedSoundName = 'Default Alarm';
  StreamSubscription<int>? _levelSub;
  StreamSubscription<BatteryState>? _stateSub;
  StreamSubscription<Map<String, dynamic>?>? _alarmSub;
  StreamSubscription<Map<String, dynamic>?>? _dismissSub;
  Timer? _batteryPollTimer;

  @override
  void initState() {
    super.initState();
    _targetPercent = widget.settings.targetPercent.toDouble();
    _targetController = TextEditingController(text: _targetPercent.toInt().toString());
    _alarmActive = widget.settings.isActive;

    if (widget.settings.alarmPath != null) {
      _selectedSoundName = widget.settings.alarmPath!.split('/').last;
      _alarmService.setCustomPath(widget.settings.alarmPath);
    }

    _init();
  }

  Future<void> _init() async {
    await _notificationService.init();
    await _bgService.init();

    _currentLevel = await _batteryService.getCurrentLevel();
    _batteryState = await _batteryService.getCurrentState();
    setState(() {});

    _batteryPollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final level = await _batteryService.getCurrentLevel();
      final state = await _batteryService.getCurrentState();
      if (mounted) {
        setState(() {
          _currentLevel = level;
          _batteryState = state;
        });
        if (_alarmActive && !_alarmTriggered &&
            (state == BatteryState.charging || state == BatteryState.full) &&
            level >= _targetPercent.toInt()) {
          _triggerAlarm();
        }
      }
    });

    _levelSub = _batteryService.batteryLevel.listen((level) {
      setState(() => _currentLevel = level);
    });

    _stateSub = _batteryService.batteryState.listen((state) {
      setState(() => _batteryState = state);
      if ((state == BatteryState.charging || state == BatteryState.full) && _alarmActive) {
        if (_currentLevel >= _targetPercent.toInt()) {
          _triggerAlarm();
        }
      }
      if (state == BatteryState.discharging && _alarmActive) {
        _dismissAlarm();
      }
    });

    _alarmSub = _bgService.onAlarm.listen((_) {
      _triggerAlarm();
    });

    _dismissSub = _bgService.onDismissAlarm.listen((_) {
      _dismissAlarm();
    });
  }

  @override
  void dispose() {
    _levelSub?.cancel();
    _stateSub?.cancel();
    _alarmSub?.cancel();
    _dismissSub?.cancel();
    _batteryPollTimer?.cancel();
    _targetController.dispose();
    super.dispose();
  }

  bool _alarmTriggered = false;

  Future<void> _triggerAlarm() async {
    if (!_alarmActive || _alarmTriggered) return;
    _alarmTriggered = true;
    await _alarmService.play();
    await _notificationService.showAlarmNotification();
    await _bgService.setAlarmFired(true);
  }

  Future<void> _dismissAlarm() async {
    _alarmTriggered = false;
    await _alarmService.stop();
    await _notificationService.cancelNotification();
    await _bgService.setAlarmFired(false);
    widget.settings.isActive = false;
    await _bgService.stop();
    setState(() => _alarmActive = false);
  }

  Future<void> _toggleAlarm() async {
    if (_alarmActive) {
      await _dismissAlarm();
      await _bgService.stop();
      widget.settings.isActive = false;
      setState(() => _alarmActive = false);
    } else {
      widget.settings.targetPercent = _targetPercent.toInt();
      widget.settings.isActive = true;
      await _bgService.start();
      setState(() => _alarmActive = true);

      if ((_batteryState == BatteryState.charging || _batteryState == BatteryState.full) &&
          _currentLevel >= _targetPercent.toInt()) {
        _triggerAlarm();
      }
    }
  }

  Future<void> _pickSound() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav', 'mp3', 'ogg', 'm4a'],
    );
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      widget.settings.alarmPath = path;
      _alarmService.setCustomPath(path);
      setState(() {
        _selectedSoundName = result.files.single.name;
      });
    }
  }

  void _resetSound() {
    widget.settings.alarmPath = null;
    _alarmService.setCustomPath(null);
    setState(() {
      _selectedSoundName = 'Default Alarm';
    });
  }

  String _getStateText() {
    switch (_batteryState) {
      case BatteryState.charging:
        return 'Charging';
      case BatteryState.discharging:
        return 'Discharging';
      case BatteryState.full:
        return 'Full';
      case BatteryState.unknown:
      default:
        return 'Unknown';
    }
  }

  IconData _getStateIcon() {
    switch (_batteryState) {
      case BatteryState.charging:
        return Icons.battery_charging_full;
      case BatteryState.discharging:
        return Icons.battery_std;
      case BatteryState.full:
        return Icons.battery_full;
      case BatteryState.unknown:
      default:
        return Icons.battery_unknown;
    }
  }

  Color _getBatteryColor() {
    if (_batteryState == BatteryState.charging || _batteryState == BatteryState.full) {
      return Colors.green;
    }
    if (_currentLevel <= 20) return Colors.red;
    if (_currentLevel <= 50) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Battery display
              Container(
                width: 140,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        heightFactor: _currentLevel / 100,
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _getBatteryColor(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$_currentLevel%',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_getStateIcon(), color: Colors.white70, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    _getStateText(),
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Target percentage
              const Text(
                'Alert at battery level',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFFE94560),
                        inactiveTrackColor: Colors.white24,
                        thumbColor: const Color(0xFFE94560),
                        overlayColor: const Color(0x29E94560),
                      ),
                      child: Slider(
                        value: _targetPercent,
                        min: 1,
                        max: 100,
                        label: '${_targetPercent.toInt()}%',
                        onChanged: _alarmActive
                            ? null
                            : (value) {
                                setState(() => _targetPercent = value);
                                _targetController.text = value.toInt().toString();
                              },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: _targetController,
                      enabled: !_alarmActive,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 3,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        suffixText: '%',
                        suffixStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.white54,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        isDense: true,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white10),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        filled: true,
                        fillColor: Colors.white10,
                      ),
                      onChanged: _alarmActive
                          ? null
                          : (value) {
                              final parsed = int.tryParse(value);
                              if (parsed != null && parsed >= 1 && parsed <= 100) {
                                setState(() => _targetPercent = parsed.toDouble());
                              }
                            },
                      onSubmitted: (value) {
                        final parsed = int.tryParse(value);
                        if (parsed != null && parsed >= 1 && parsed <= 100) {
                          setState(() => _targetPercent = parsed.toDouble());
                          _targetController.text = parsed.toString();
                        } else {
                          _targetController.text = _targetPercent.toInt().toString();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Sound picker
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _alarmActive ? null : _pickSound,
                      icon: const Icon(Icons.volume_up, color: Colors.white70),
                      label: Text(
                        _selectedSoundName,
                        style: const TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (_selectedSoundName != 'Default Alarm' && !_alarmActive) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _resetSound,
                      icon: const Icon(Icons.close, color: Colors.white54),
                      tooltip: 'Reset to default',
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 30),

              // Activate button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _toggleAlarm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _alarmActive
                        ? const Color(0xFFE94560)
                        : const Color(0xFF0F3460),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _alarmActive ? Icons.alarm_off : Icons.alarm,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _alarmActive ? 'Deactivate Alarm' : 'Activate Alarm',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
