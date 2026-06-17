# macOS

## Install

1. Go to [Releases](https://github.com/desumidhun2006/battery-notifier/releases)
2. Download `battery-notifier-macos.zip`
3. Unzip the file
4. Drag `battery_notifier.app` to your Applications folder

### If macOS Says "App is Damaged" or "Cannot Be Opened"

This is because the app isn't signed with an Apple Developer certificate. To fix:

**Option 1: Right-click method**
- Right-click (or Control-click) the app → Click **Open** → Click **Open** again

**Option 2: Terminal method**
Open Terminal and run:
```bash
xattr -cr /Applications/battery_notifier.app
```
Then open the app normally.

## Use

1. Open Battery Notifier
2. Set your target percentage
3. Click **Activate Alarm**
4. Plug in charger — alarm fires at target
5. Unplug to dismiss

## Notes

- Requires macOS 10.15+
- App must be running for alarm to work
- Allow notifications when prompted
- The app is not signed — this is normal for open-source projects
