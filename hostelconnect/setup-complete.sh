#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "🎉 HostelConnect Complete Setup"
echo "==============================="
echo ""

echo "This script will install Flutter, Android SDK, and set up the emulator."
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script is designed for macOS. For other platforms, please:"
    echo "1. Install Flutter: https://docs.flutter.dev/get-started/install"
    echo "2. Install Android Studio or Android SDK"
    echo "3. Run the individual scripts in scripts/ folder"
    exit 1
fi

echo "📱 Step 1: Installing Flutter..."
if ! command -v flutter >/dev/null 2>&1; then
    echo "Downloading Flutter SDK..."
    
    # Create Flutter directory
    FLUTTER_DIR="$HOME/flutter"
    mkdir -p "$FLUTTER_DIR"
    
    # Download Flutter
    cd "$HOME"
    curl -sSL https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.24.5-stable.tar.xz -o flutter.tar.xz
    tar -xf flutter.tar.xz
    rm flutter.tar.xz
    
    # Add to PATH
    echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.zshrc
    export PATH="$HOME/flutter/bin:$PATH"
    
    echo "✅ Flutter installed to $FLUTTER_DIR"
else
    echo "✅ Flutter already installed"
fi

echo ""
echo "📦 Step 2: Installing Flutter dependencies..."
cd "$ROOT/mobile"
flutter pub get

echo ""
echo "🔧 Step 3: Setting up Android SDK..."
bash scripts/install-android-sdk.sh

echo ""
echo "🧪 Step 4: Creating Android emulator..."
bash scripts/create-avd.sh

echo ""
echo "🚀 Step 5: Starting emulator..."
bash scripts/run-emulator.sh

echo ""
echo "▶️  Step 6: Running HostelConnect app..."
bash scripts/run-app.sh

echo ""
echo "✅ Setup complete! HostelConnect should now be running on your emulator."
echo ""
echo "Next time, you can just run:"
echo "bash scripts/run-emulator.sh"
echo "bash scripts/run-app.sh"
