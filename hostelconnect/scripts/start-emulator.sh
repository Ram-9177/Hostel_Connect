#!/bin/bash
# Start Android Emulator for HostelConnect
set -e

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"

# Get first available AVD
AVD_NAME=$(emulator -list-avds | head -n1)

if [ -z "$AVD_NAME" ]; then
  echo "❌ No Android emulators found. Please create one in Android Studio."
  exit 1
fi

echo "🚀 Starting emulator: $AVD_NAME"
emulator -avd "$AVD_NAME" -netdelay none -netspeed full >/dev/null 2>&1 &

echo "⏳ Waiting for emulator to boot..."
adb wait-for-device
echo "✅ Emulator is ready!"

# Wait a bit more for full boot
sleep 5
adb shell input keyevent 82

echo "📱 Emulator is fully booted and ready!"

