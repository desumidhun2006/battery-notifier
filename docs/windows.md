# Windows Installation & Usage

## Prerequisites

- Visual Studio 2022 with "Desktop development with C++" workload
- Windows 10 SDK

## Build & Install

### Run in Debug Mode

```bash
flutter run -d windows
```

### Build Release

```bash
flutter build windows --release
```

The app will be at `build/windows/x64/runner/Release/`.

### Install

Copy the entire `Release` folder or create an installer. The app is portable — no installation required.

## Usage

1. Open `battery_notifier.exe`
2. Set your target percentage using the slider or text input
3. (Optional) Pick a custom alarm sound
4. Click **Activate Alarm**
5. Plug in your charger — alarm will fire when battery reaches the target
6. Unplug charger or click **Deactivate Alarm** to dismiss

## Notes

- Battery monitoring uses a 3-second polling timer (no background service on Windows)
- The app must be running for the alarm to trigger
- Notifications use Windows native notification system
- Works on laptops with batteries; desktops will show 0% / Unknown
