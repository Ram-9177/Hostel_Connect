#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SDK_DIR="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/Library/Android/sdk}}"
[ -d "$SDK_DIR" ] || SDK_DIR="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$SDK_DIR/cmdline-tools/latest/bin:$SDK_DIR/platform-tools:$SDK_DIR/emulator:$PATH"

AVD_NAME="Pixel_7_API_34"

echo "🧪 Checking system image..."
sdkmanager --list | grep -q "system-images;android-34;google_apis;x86_64" || {
  echo "Installing image..."
  sdkmanager "system-images;android-34;google_apis;x86_64" >/dev/null
}

if avdmanager list avd | grep -q "$AVD_NAME"; then
  echo "✅ AVD $AVD_NAME already exists."
else
  echo "🆕 Creating AVD $AVD_NAME..."
  echo "no" | avdmanager create avd -n "$AVD_NAME" -k "system-images;android-34;google_apis;x86_64" -d pixel_7
fi

echo "✅ AVD ready: $AVD_NAME"
