# Linux

## Install (One Click)

1. Go to [Releases](https://github.com/desumidhun2006/battery-notifier/releases)
2. Download `battery-notifier-linux.zip`
3. Unzip the folder
4. Run `./battery_notifier`

No installation required.

### Optional: Install System-Wide

```bash
sudo cp -r battery_notifier/ /opt/battery-notifier
```

Then create a desktop shortcut at `~/.local/share/applications/battery-notifier.desktop`:

```ini
[Desktop Entry]
Name=Battery Notifier
Exec=/opt/battery-notifier/battery_notifier
Type=Application
Categories=Utility;
```

## Use

1. Run `battery_notifier`
2. Set your target percentage
3. Click **Activate Alarm**
4. Plug in charger — alarm fires at target
5. Unplug to dismiss

## Notes

- Requires a notification daemon for alerts
- Works on laptops with batteries
- App must be running for alarm to work
