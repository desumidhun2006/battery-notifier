# iOS

## Why Can't I Just Download It?

Apple requires all iOS apps to be signed with a developer certificate. There is no way to install an iOS app with a single click like Android APKs.

**Your options:**

### Option 1: Ask the Developer

If you know the person who built this app, ask them to:
1. Upload it to [TestFlight](https://developer.apple.com/testflight/) (free beta testing)
2. Send you the TestFlight invite link
3. You just tap the link and install — no coding needed

### Option 2: Build It Yourself (Requires a Mac)

If you have a Mac with Xcode installed:

```bash
# Install prerequisites
brew install cocoapods

# Clone and build
git clone https://github.com/desumidhun2006/battery-notifier.git
cd battery-notifier
flutter pub get
flutter build ios --release --no-codesign

# Open in Xcode and run on your iPhone
open ios/Runner.xcworkspace
```

### Option 3: Use the macOS Version

If you have a MacBook, download the macOS version from [Releases](https://github.com/desumidhun2006/battery-notifier/releases) — it works the same way.

## How to Use

1. Open Battery Notifier
2. Set your target percentage
3. Tap **Activate Alarm**
4. Plug in charger — alarm fires at target
5. Unplug to dismiss

## Notes

- Requires iOS 13.0+
- Allow notifications when prompted
- Battery updates may have slight delay
