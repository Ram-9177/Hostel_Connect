#!/bin/bash

echo "🚀 HostelConnect Flutter App Launcher"
echo "======================================"

# Check if we're in the right directory
if [ ! -f "hostelconnect/mobile/pubspec.yaml" ]; then
    echo "❌ Error: Please run this script from the HostelConnect Mobile App directory"
    echo "Current directory: $(pwd)"
    exit 1
fi

# Navigate to mobile directory
cd hostelconnect/mobile

echo "📱 Checking Flutter setup..."
flutter doctor

echo ""
echo "📱 Checking available devices..."
flutter devices

echo ""
echo "🧹 Cleaning project..."
flutter clean

echo ""
echo "📦 Getting dependencies..."
flutter pub get

echo ""
echo "🚀 Starting Flutter app..."
echo "If you see device selection, choose your Android emulator (usually option 1 or 2)"
echo ""

flutter run

echo ""
echo "✅ App should now be running on your emulator!"
echo "If you see any errors, please check:"
echo "1. Android emulator is running"
echo "2. Flutter is properly installed"
echo "3. Android SDK is configured"
