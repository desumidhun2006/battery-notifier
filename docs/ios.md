# iOS Installation & Usage

## Prerequisites

- Xcode 14.0+
- CocoaPods (`sudo gem install cocoapods`)
- A physical iOS device (battery APIs are limited on Simulator)

## Build & Install

### Run on Device

```bash
flutter run -d ios
```

### Build IPA

```bash
flutter build ios --release
```

Then archive in Xcode for distribution.

### Install via Flutter

```bash
flutter install
```

## Permissions

Already configured in `ios/Runner/Info.plist`:

- `NSBatteryUsageDescription` — access battery level and charging state
- `UIBackgroundModes` — background processing for monitoring

## Usage

1. Install the app on your iOS device
2. Open Battery Notifier
3. Set your target percentage using the slider or text input
4. (Optional) Pick a custom alarm sound
5. Tap **Activate Alarm**
6. Plug in your charger — alarm will fire when battery reaches the target
7. Unplug charger or tap **Deactivate Alarm** to dismiss

## Notes

- Background monitoring works via `flutter_background_service` on iOS
- Allow notifications when prompted for alarm alerts
- Battery level updates may have a slight delay on iOS
