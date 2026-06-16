import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const macOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );
    const windowsSettings = WindowsInitializationSettings(
      appName: 'Battery Notifier',
      appUserModelId: 'com.example.battery_notifier',
      guid: '72b886c6-9f40-4f3e-8e6b-4a1d2c3b4e5f',
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
      macOS: macOSSettings,
      linux: linuxSettings,
      windows: windowsSettings,
    );

    await _plugin.initialize(settings: settings);
    _initialized = true;
  }

  Future<void> showAlarmNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'battery_alarm',
      'Battery Alarm',
      channelDescription: 'Alerts when battery reaches target',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentSound: true,
      ),
      macOS: DarwinNotificationDetails(
        presentSound: true,
      ),
      linux: LinuxNotificationDetails(),
      windows: WindowsNotificationDetails(),
    );

    await _plugin.show(
      id: 0,
      title: 'Battery Alert!',
      body: 'Your battery has reached the target level. Disconnect the charger.',
      notificationDetails: details,
    );
  }

  Future<void> cancelNotification() async {
    await _plugin.cancel(id: 0);
  }
}
