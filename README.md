# Battery Notifier

A cross-platform battery alarm app. Set a target charge percentage and get alerted when your battery reaches it — so you know when to disconnect the charger.

## Download

**[Download Latest Release](https://github.com/desumidhun2006/battery-notifier/releases/latest)**

| Platform | Status | How to Install |
|----------|--------|----------------|
| macOS | ✅ Available | Download zip → Unzip → Drag to Applications |
| Android | 🔜 Coming soon | Requires Android SDK to build |
| iOS | 🔜 Coming soon | Requires Xcode + Apple Developer account |
| Windows | 🔜 Coming soon | Requires Visual Studio to build |
| Linux | 🔜 Coming soon | Requires GTK dev packages to build |

## How to Use

1. Open the app
2. Set your target percentage (when to be alerted)
3. Click/tap **Activate Alarm**
4. Plug in your charger — alarm fires when battery reaches the target
5. Unplug or click **Deactivate Alarm** to dismiss

## Features

- Continuous slider + direct text input for target percentage
- Alarm sound when battery reaches target while charging
- Auto-dismiss when charger is disconnected
- Custom alarm sound support (wav, mp3, ogg, m4a)
- Dark theme UI

## Why Only macOS Right Now?

Building for Android, iOS, Windows, and Linux requires platform-specific SDKs and tools. The GitHub Actions CI pipeline (`.github/workflows/release.yml`) is set up to auto-build for all platforms when a new tag is pushed, but needs the build environments configured.

### To enable more platforms:
- **Android**: Install Android SDK, set `ANDROID_HOME`
- **iOS**: Requires Xcode on macOS + Apple Developer account for signing
- **Windows**: Requires Windows machine with Visual Studio
- **Linux**: Requires GTK dev packages (see `docs/linux.md`)

## Building from Source (Developers)

```bash
git clone https://github.com/desumidhun2006/battery-notifier.git
cd battery-notifier
flutter pub get
flutter run
```
