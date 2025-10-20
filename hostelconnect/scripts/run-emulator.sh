#!/usr/bin/env bash
set -euo pipefail

SDK_DIR="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/Library/Android/sdk}}"
[ -d "$SDK_DIR" ] || SDK_DIR="$HOME/Android/Sdk"
export PATH="$SDK_DIR/emulator:$SDK_DIR/platform-tools:$PATH"

AVD_NAME="${1:-Pixel_7_API_34}"

echo "🚀 Starting emulator: $AVD_NAME"
nohup emulator -avd "$AVD_NAME" -no-snapshot -netdelay none -netspeed full >/dev/null 2>&1 &

echo "⏳ Waiting for device..."
adb wait-for-device
adb devices

echo "✅ Emulator ready."
