#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/mobile"

echo "🧰 Checking Flutter..."
if ! command -v flutter >/dev/null 2>&1; then
  echo "❌ Flutter not found. Install: https://docs.flutter.dev/get-started/install"
  exit 1
fi

echo "📦 flutter pub get"
flutter pub get

# Try to find Android SDK
SDK_DIR="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-$HOME/Library/Android/sdk}}"
[ -d "$SDK_DIR" ] || SDK_DIR="$HOME/Android/Sdk"
mkdir -p "$SDK_DIR"

echo "📍 Android SDK at: $SDK_DIR"
mkdir -p "$SDK_DIR/cmdline-tools"

# Install cmdline-tools if missing
if [ ! -d "$SDK_DIR/cmdline-tools/latest" ]; then
  echo "⬇️  Downloading Android cmdline-tools..."
  TMP="$(mktemp -d)"
  OS="$(uname -s)"
  if [ "$OS" = "Darwin" ]; then
    URL="https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
  else
    URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
  fi
  curl -sSL "$URL" -o "$TMP/cmdline-tools.zip"
  unzip -q "$TMP/cmdline-tools.zip" -d "$TMP"
  mkdir -p "$SDK_DIR/cmdline-tools/latest"
  mv "$TMP/cmdline-tools/"* "$SDK_DIR/cmdline-tools/latest/" || true
  rm -rf "$TMP"
fi

export ANDROID_SDK_ROOT="$SDK_DIR"
export PATH="$SDK_DIR/cmdline-tools/latest/bin:$SDK_DIR/platform-tools:$PATH"

echo "✅ Accepting licenses..."
yes | sdkmanager --licenses >/dev/null

echo "📦 Installing platform tools + API 34 + emulator image..."
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" \
          "emulator" "system-images;android-34;google_apis;x86_64" >/dev/null

echo "🔧 Writing local.properties..."
mkdir -p android
echo "sdk.dir=$SDK_DIR" > android/local.properties

echo "✅ Android SDK setup complete."
