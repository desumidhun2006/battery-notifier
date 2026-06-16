# Battery Notifier

A cross-platform battery alarm app. Set a target charge percentage and get alerted when your battery reaches it — so you know when to disconnect the charger.

## Download

Go to [Releases](https://github.com/desumidhun2006/battery-notifier/releases) and download the file for your platform:

| Platform | File | Install |
|----------|------|---------|
| Android | `battery-notifier-android.apk` | Tap to install |
| macOS | `battery-notifier-macos.zip` | Unzip, drag to Applications |
| Windows | `battery-notifier-windows.zip` | Unzip, run `battery_notifier.exe` |
| Linux | `battery-notifier-linux.zip` | Unzip, run `battery_notifier` |

> iOS requires building from source with Xcode (see below).

## How to Use

1. Open the app
2. Set your target percentage (when to be alerted)
3. Tap **Activate Alarm**
4. Plug in your charger — alarm fires when battery reaches the target
5. Unplug or tap **Deactivate Alarm** to dismiss

## Features

- Continuous slider + direct text input for target percentage
- Alarm sound when battery reaches target while charging
- Auto-dismiss when charger is disconnected
- Custom alarm sound support (wav, mp3, ogg, m4a)
- Dark theme UI

## Platform-Specific Guides

- [Android](docs/android.md)
- [iOS](docs/ios.md)
- [macOS](docs/macos.md)
- [Windows](docs/windows.md)
- [Linux](docs/linux.md)

## Building from Source (Developers)

```bash
git clone https://github.com/desumidhun2006/battery-notifier.git
cd battery-notifier
flutter pub get
flutter run
```
