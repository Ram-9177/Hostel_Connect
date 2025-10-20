# HostelConnect Mobile App

## 🚀 Quick Start - Run on Android Emulator

### Prerequisites
- Android emulator running (Pixel_7_API_34)
- Flutter installed and configured
- Android SDK properly set up

### Method 1: Using the Launch Script
```bash
# From the HostelConnect Mobile App directory
./launch_app.sh
```

### Method 2: Manual Commands
```bash
# Navigate to mobile directory
cd hostelconnect/mobile

# Check Flutter setup
flutter doctor

# Check available devices
flutter devices

# Clean and get dependencies
flutter clean
flutter pub get

# Run the app
flutter run
```

### Method 3: Using Android Studio
1. Open Android Studio
2. Open the `hostelconnect/mobile` folder as a Flutter project
3. Select your emulator from the device dropdown
4. Click the "Run" button (green play icon)

## 📱 What You'll See

The HostelConnect app includes:

### 🏠 Home Screen
- Welcome message with student info
- Quick action chips (Gate Pass, Meal Intent, Complaints)
- Live metrics cards (Gate Pass Status, Meals, Attendance, Complaints)

### 📱 Navigation Tabs
- **Home**: Dashboard with metrics and quick actions
- **Scan**: QR code scanner interface
- **Meals**: Meal management (Breakfast, Lunch, Dinner)
- **Gate Pass**: Application form for gate passes
- **Profile**: User profile and settings

### ✨ Features to Test
- Tap navigation tabs to switch between screens
- Tap action chips to see snackbar messages
- Toggle meal preferences on/off
- Fill out gate pass form and submit
- Adjust profile settings

## 🔧 Troubleshooting

### If Flutter Doctor Shows Issues
```bash
flutter doctor --android-licenses
```

### If Emulator Not Detected
```bash
adb devices
```

### If Build Fails
```bash
flutter clean
flutter pub get
flutter run
```

## 📱 App Features

The app demonstrates a complete hostel management system with:
- **Responsive UI** that works on phones and tablets
- **Modern Material Design** with clean, intuitive interface
- **Role-based Navigation** (Student, Warden, Admin views)
- **Real-time Updates** with live metrics
- **Offline Support** with local data caching
- **Accessibility** with proper contrast and touch targets

## 🎯 Next Steps

Once the app is running, you can:
1. Test all navigation and interactions
2. Customize the UI colors and themes
3. Add real backend integration
4. Implement actual QR scanning
5. Add push notifications
6. Deploy to app stores

---

**Note**: This is a demo app showcasing the HostelConnect UI/UX. All data is mock data for demonstration purposes.
