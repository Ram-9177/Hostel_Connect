#!/bin/bash
# Start Flutter Mobile App
set -e

cd "$(dirname "$0")/../mobile"

echo "📦 Getting Flutter dependencies..."
flutter pub get

echo "📱 Checking for devices..."
flutter devices

echo "🚀 Starting Flutter app..."
flutter run

