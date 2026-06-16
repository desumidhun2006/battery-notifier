# Linux Installation & Usage

## Prerequisites

- Flutter SDK installed
- Required system packages:

```bash
# Ubuntu/Debian
sudo apt install cmake ninja-build clang pkg-config libgtk-3-dev

# Fedora
sudo dnf install cmake ninja-build clang pkg-config gtk3-devel

# Arch
sudo pacman -S cmake ninja clang pkg-config gtk3
```

## Build & Install

### Run in Debug Mode

```bash
flutter run -d linux
```

### Build Release

```bash
flutter build linux --release
```

The app will be at `build/linux/x64/release/bundle/`.

### Install System-Wide

```bash
sudo cp -r build/linux/x64/release/bundle/ /opt/battery-notifier
```

Or create a desktop entry in `~/.local/share/applications/battery-notifier.desktop`:

```ini
[Desktop Entry]
Name=Battery Notifier
Exec=/opt/battery-notifier/battery_notifier
Icon=battery-notifier
Type=Application
Categories=Utility;
```

## Usage

1. Run `battery_notifier` from terminal or application menu
2. Set your target percentage using the slider or text input
3. (Optional) Pick a custom alarm sound
4. Click **Activate Alarm**
5. Plug in your charger — alarm will fire when battery reaches the target
6. Unplug charger or click **Deactivate Alarm** to dismiss

## Notes

- Battery monitoring uses a 3-second polling timer (no background service on Linux)
- The app must be running for the alarm to trigger
- Notifications use Linux native notification system (requires a notification daemon)
- Works on laptops with batteries; desktops will show 0% / Unknown
- On Wayland, notification support may vary by desktop environment
