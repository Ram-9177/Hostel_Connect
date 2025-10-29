# Android Setup on macOS (Apple Silicon friendly)

This guide installs everything needed to build and run the Flutter mobile app on Android.

## 1) Install prerequisites

- Homebrew
- Java 17 (Temurin)
- Android Studio
- Android platform tools (adb)
- Android command-line tools (sdkmanager/avdmanager)

You can run the helper script (recommended):

```bash
chmod +x scripts/setup-android-macos.sh
./scripts/setup-android-macos.sh
```

Or follow the steps below manually.

## 2) Java 17 (Temurin)

```bash
brew install --cask temurin@17
```

Verify:

```bash
/usr/libexec/java_home -v 17
java -version
```

## 3) Android Studio + tools

```bash
brew install --cask android-studio
brew install --cask android-platform-tools   # adb
brew install --cask android-commandlinetools # sdkmanager/avdmanager
```

Open Android Studio once and let it install the Android SDK and command-line tools.

## 4) Environment variables (add to ~/.zshrc or ~/.bashrc)

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
```

Apply:

```bash
source ~/.zshrc   # or: source ~/.bashrc
```

## 5) Install SDK packages

```bash
sdkmanager --sdk_root="$ANDROID_HOME" --install \
  "platform-tools" \
  "emulator" \
  "build-tools;34.0.0" \
  "platforms;android-34" \
  "cmdline-tools;latest" \
  "sources;android-34"
```

Accept licenses:

```bash
yes | sdkmanager --sdk_root="$ANDROID_HOME" --licenses
```

## 6) Create an emulator (ARM64)

```bash
sdkmanager --sdk_root="$ANDROID_HOME" --install "system-images;android-34;google_apis;arm64-v8a"
avdmanager create avd -n Pixel_7_API_34 -k "system-images;android-34;google_apis;arm64-v8a" -d pixel_7
```

Run the emulator:

```bash
emulator -avd Pixel_7_API_34 &
```

## 7) Verify Flutter toolchain

```bash
flutter doctor -v
flutter doctor --android-licenses
```

## 8) Run the app

```bash
cd hostelconnect/mobile
flutter pub get
flutter run
```

## Notes

- Use Android API level 34+ with build tools 34.0.0 (compatible with current Flutter/AGP).
- On Apple Silicon, prefer ARM64 system images (e.g., `arm64-v8a`).
- If the emulator is slow, enable hardware acceleration in Android Studio > Preferences > Emulators.
- If `sdkmanager` is not found, ensure `cmdline-tools` is installed and `PATH` includes `$ANDROID_HOME/cmdline-tools/latest/bin`.
