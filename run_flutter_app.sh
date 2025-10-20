#!/bin/bash

echo "Starting HostelConnect Flutter App..."

# Navigate to the mobile directory
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "Flutter not found. Please install Flutter first."
    exit 1
fi

# Check if emulator is running
echo "Checking for running emulators..."
adb devices

# Clean and get dependencies
echo "Cleaning Flutter project..."
flutter clean

echo "Getting Flutter dependencies..."
flutter pub get

# Run the app
echo "Running Flutter app on emulator..."
flutter run

echo "App should now be running on the emulator!"
