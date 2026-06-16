# iOS

## Install

iOS apps must be installed via Xcode or TestFlight. There is no direct APK-style install.

### Option 1: TestFlight (Recommended)

If the app is uploaded to TestFlight:
1. Install [TestFlight](https://apps.apple.com/app/testflight/id899247664) from the App Store
2. Open the TestFlight invite link
3. Tap **Install**

### Option 2: Build with Xcode

1. Install [Xcode](https://apps.apple.com/xcode/) and [CocoaPods](https://cocoapods.org)
2. Run:
   ```bash
   git clone https://github.com/desumidhun2006/battery-notifier.git
   cd battery-notifier
   flutter pub get
   flutter build ios --release --no-codesign
   ```
3. Open `ios/Runner.xcworkspace` in Xcode
4. Connect your iPhone and select it as the target
5. Click **Run**

## Use

1. Open Battery Notifier
2. Set your target percentage
3. Tap **Activate Alarm**
4. Plug in charger — alarm fires at target
5. Unplug to dismiss

## Notes

- Requires iOS 13.0+
- Allow notifications when prompted
- Battery updates may have slight delay
