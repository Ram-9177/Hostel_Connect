# 🚀 HostelConnect Android Setup

Complete cross-platform Android development setup for HostelConnect Flutter app.

## 🎯 Quick Start

### macOS/Linux (Bash)
```bash
# One-time setup
bash scripts/setup-android.sh

# Daily use
bash scripts/run-emulator.sh
bash scripts/run-app.sh
```

### Windows (PowerShell)
```powershell
# One-time setup
.\scripts\setup-android.ps1

# Daily use
.\scripts\run-emulator.ps1
.\scripts\run-app.ps1
```

## 📋 What Gets Installed

- ✅ Android SDK Command Line Tools
- ✅ Android Platform API 34
- ✅ Android Build Tools 34.0.0
- ✅ Android Emulator
- ✅ Pixel 7 API 34 System Image
- ✅ Pixel 7 AVD (Android Virtual Device)

## 🔧 Individual Scripts

### Installation Scripts
- `install-android-sdk.sh/.ps1` - Downloads and installs Android SDK
- `create-avd.sh/.ps1` - Creates Pixel 7 API 34 emulator

### Runtime Scripts  
- `run-emulator.sh/.ps1` - Starts the Android emulator
- `run-app.sh/.ps1` - Runs HostelConnect on connected device/emulator

### All-in-One
- `setup-android.sh/.ps1` - Complete setup from scratch

## 📱 Features Included

- **QR Code Scanning** - Camera permission enabled
- **Internet Access** - Network permissions configured
- **Haptic Feedback** - Vibration permission enabled
- **Responsive Design** - Works on phones, tablets, and foldables
- **Role-based Navigation** - Student, Warden, Admin, Chef views
- **Ad System** - Interstitial ads with 20-second timer
- **Offline Support** - Local data caching

## 🛠️ Requirements

- **Flutter SDK** - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Git** - For version control
- **8GB+ RAM** - For smooth emulator performance
- **Virtualization** - Enable VT-x/AMD-V in BIOS

## 🐛 Troubleshooting

### Flutter Doctor Issues
```bash
flutter doctor
```
Follow the specific instructions for any red ❌ items.

### SDK Path Issues
Edit `mobile/android/local.properties`:
```properties
# macOS
sdk.dir=/Users/yourname/Library/Android/sdk

# Windows  
sdk.dir=C:\\Users\\yourname\\AppData\\Local\\Android\\Sdk
```

### Emulator Won't Start
1. Enable virtualization in BIOS
2. Check if Hyper-V is disabled (Windows)
3. Try: `emulator -avd Pixel_7_API_34 -verbose`

### Camera Permission
Grant camera permission when prompted, or enable in:
Settings → Apps → HostelConnect → Permissions → Camera

### Build Errors
```bash
cd mobile
flutter clean
flutter pub get
flutter run
```

## 📊 Success Criteria

✅ `flutter doctor` shows green ✅ for Android  
✅ Emulator appears in `flutter devices`  
✅ App installs and launches successfully  
✅ Camera permission requested on first scan  
✅ All features working (navigation, ads, QR scan)  

## 🎮 Testing Features

1. **Role Switching** - Tap profile icon → Select different roles
2. **Gate Pass** - Tap "Watch Ad & Submit" → See 20s ad timer
3. **QR Scanner** - Toggle kiosk mode → Test scan simulation
4. **Meals** - Set preferences → Use quick action chips
5. **Responsive** - Resize window → See breakpoint changes

## 📚 Documentation

- [Android Quickstart Guide](docs/run-android-quickstart.md)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Android Studio Setup](https://developer.android.com/studio)

## 🔄 Daily Workflow

```bash
# Start development
bash scripts/run-emulator.sh

# In another terminal
bash scripts/run-app.sh

# Hot reload: Press 'r' in terminal
# Hot restart: Press 'R' in terminal
# Quit: Press 'q' in terminal
```

## 🆘 Need Help?

1. Check [Android Quickstart Guide](docs/run-android-quickstart.md)
2. Run `flutter doctor` and fix any issues
3. Ensure virtualization is enabled
4. Try running scripts individually to isolate issues

---

**Ready to build amazing hostel management features! 🎉**
