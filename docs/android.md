# Android Installation & Usage

## Prerequisites

- Android Studio or VS Code with Flutter plugin
- Android SDK (API level 21+)
- A physical Android device (battery info is limited on emulators)

## Build & Install

### Debug Build

```bash
flutter run -d android
```

### Release APK

```bash
flutter build apk --release
```

The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

### Release App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

### Install APK directly

```bash
flutter install
```

## Permissions

The app requires the following Android permissions (already configured):

- `BATTERY_STATS` — read battery level and state
- `FOREGROUND_SERVICE` — run background monitoring
- `POST_NOTIFICATIONS` — show alarm notifications
- `VIBRATE` — vibrate on notification

## Usage

1. Install the app on your Android device
2. Open Battery Notifier
3. Set your target percentage using the slider or text input
4. (Optional) Pick a custom alarm sound
5. Tap **Activate Alarm**
6. Plug in your charger — alarm will fire when battery reaches the target
7. Unplug charger or tap **Deactivate Alarm** to dismiss

## Notes

- Background monitoring works via `flutter_background_service` on Android
- The app runs a foreground service to monitor battery even when minimized
- Alarm notifications persist until dismissed
