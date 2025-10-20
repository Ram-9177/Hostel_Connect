# HostelConnect – Android Quickstart (Beginner Friendly)

## What you need once
- Flutter SDK installed
- Android Studio **or** Android SDK CLI tools
- Git

### Verify tools
```bash
flutter doctor
```

Fix any red ❌ items it shows.

## One-time setup (automated scripts)

### Install / Verify Android SDK + CLI tools + AVD image

**macOS/Linux:**
```bash
bash scripts/install-android-sdk.sh
```

**Windows (PowerShell):**
```powershell
./scripts/install-android-sdk.ps1
```

### Create the emulator (AVD)

**macOS/Linux:**
```bash
bash scripts/create-avd.sh
```

**Windows:**
```powershell
./scripts/create-avd.ps1
```

### Start emulator + run app

**macOS/Linux:**
```bash
bash scripts/run-emulator.sh
bash scripts/run-app.sh
```

**Windows:**
```powershell
./scripts/run-emulator.ps1
./scripts/run-app.ps1
```

## You can also use your real phone:

Enable Developer options → USB debugging on your Android phone, connect USB cable, then run:

```bash
cd mobile
flutter run
```

## Common fixes

**SDK not found** → edit `mobile/android/local.properties` with your SDK path:
- **macOS:** `/Users/<you>/Library/Android/sdk`
- **Windows:** `C:\\Users\\<you>\\AppData\\Local\\Android\\Sdk`

**Java version** → use JDK 17 in Android Studio.

**No devices** → start the AVD from Device Manager or run `run-emulator` script again.

**Camera/QR** → allow camera permission when app starts.

## Quick Commands

**First time setup (macOS/Linux):**
```bash
bash scripts/install-android-sdk.sh
bash scripts/create-avd.sh
bash scripts/run-emulator.sh
bash scripts/run-app.sh
```

**First time setup (Windows):**
```powershell
./scripts/install-android-sdk.ps1
./scripts/create-avd.ps1
./scripts/run-emulator.ps1
./scripts/run-app.ps1
```

**Daily use:**
```bash
bash scripts/run-emulator.sh
bash scripts/run-app.sh
```

## Troubleshooting

1. **Flutter doctor shows red ❌** → Follow the specific instructions it provides
2. **Emulator won't start** → Check if virtualization is enabled in BIOS
3. **App crashes on camera** → Grant camera permission in device settings
4. **Build fails** → Run `flutter clean && flutter pub get` in mobile directory
5. **No devices found** → Ensure emulator is running or phone is connected with USB debugging

## Success Criteria

✅ `flutter doctor` shows green ✅ for Android toolchain & device  
✅ Emulator Pixel_7_API_34 boots and appears under `flutter devices`  
✅ `flutter run` installs & opens HostelConnect  
✅ Camera permission asked on first QR/scan use  

If anything fails: follow the "Common fixes" section above.
