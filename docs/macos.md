# macOS Installation & Usage

## Prerequisites

- Xcode with Command Line Tools (`xcode-select --install`)
- CocoaPods (`brew install cocoapods`)
- macOS 10.15+

## Build & Install

### Run in Debug Mode

```bash
flutter run -d macos
```

### Build Release App

```bash
flutter build macos --release
```

The app will be at `build/macos/Build/Products/Release/battery_notifier.app`.

### Install

Drag the built `.app` to your Applications folder.

## Permissions

The app may request notification permissions on first launch. Allow notifications for alarm alerts.

## Usage

1. Open Battery Notifier
2. Set your target percentage using the slider or text input
3. (Optional) Pick a custom alarm sound
4. Click **Activate Alarm**
5. Plug in your charger — alarm will fire when battery reaches the target
6. Unplug charger or click **Deactivate Alarm** to dismiss

## Notes

- Battery monitoring uses a 3-second polling timer (no background service on macOS)
- The app must be running for the alarm to trigger
- Notifications use macOS native notification system
- Custom alarm sounds support wav, mp3, ogg, and m4a formats
