# Battery Notifier

A cross-platform battery alarm app built with Flutter. Set a target charge percentage and get alerted when your battery reaches it — so you know when to disconnect the charger.

## Supported Platforms

| Platform | Status |
|----------|--------|
| Android  | ✅ Fully supported |
| iOS      | ✅ Fully supported |
| macOS    | ✅ Fully supported |
| Windows  | ✅ Fully supported |
| Linux    | ✅ Fully supported |

## Installation & Usage

See platform-specific guides:

- [Android](docs/android.md)
- [iOS](docs/ios.md)
- [macOS](docs/macos.md)
- [Windows](docs/windows.md)
- [Linux](docs/linux.md)

## Features

- Set a target battery percentage (1-100%)
- Continuous slider + direct text input
- Alarm sound when battery reaches target while charging
- Auto-dismiss when charger is disconnected
- Custom alarm sound support (wav, mp3, ogg, m4a)
- Local notifications on supported platforms
- Dark theme UI

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── settings.dart           # Persistent settings (SharedPreferences)
├── screens/
│   └── home_screen.dart        # Main UI
└── services/
    ├── alarm_service.dart      # Audio playback (just_audio)
    ├── background_service.dart # Background monitoring (Android/iOS only)
    ├── battery_service.dart    # Battery level/state (battery_plus)
    └── notification_service.dart # Local notifications
```

## Building from Source

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.11.1+
- Platform-specific tools (see platform guides below)

### Quick Start

```bash
# Clone the repo
git clone https://github.com/desumidhun2006/battery-notifier.git
cd battery-notifier

# Install dependencies
flutter pub get

# Run on connected device
flutter run
```
