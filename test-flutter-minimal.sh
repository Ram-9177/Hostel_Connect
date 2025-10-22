#!/bin/bash

# Quick Flutter App Test - Minimal Working Version
echo "🚀 Testing minimal Flutter app..."

cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

# Check if emulator is running
echo "1. Checking for Android emulator..."
flutter devices | grep -q "emulator" && echo "✅ Emulator found" || echo "❌ No emulator found"

# Try to run a simple test
echo "2. Testing Flutter doctor..."
flutter doctor --android-licenses

echo "3. Testing basic Flutter commands..."
flutter --version

echo "✅ Flutter test completed!"
