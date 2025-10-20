#!/usr/bin/env bash
set -euo pipefail

echo "🚀 HostelConnect - Quick Flutter + Emulator Setup"
echo "================================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter >/dev/null 2>&1; then
    echo "📱 Installing Flutter..."
    
    # For macOS - install Flutter
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Installing Flutter for macOS..."
        
        # Download Flutter
        cd "$HOME"
        curl -sSL https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.24.5-stable.tar.xz -o flutter.tar.xz
        tar -xf flutter.tar.xz
        rm flutter.tar.xz
        
        # Add to PATH for current session
        export PATH="$HOME/flutter/bin:$PATH"
        
        echo "✅ Flutter installed to ~/flutter"
        echo "📝 Add this to your ~/.zshrc or ~/.bash_profile:"
        echo "export PATH=\"\$HOME/flutter/bin:\$PATH\""
    else
        echo "❌ Please install Flutter manually: https://docs.flutter.dev/get-started/install"
        exit 1
    fi
else
    echo "✅ Flutter already installed"
fi

echo ""
echo "📦 Getting Flutter dependencies..."
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"
flutter pub get

echo ""
echo "🔧 Setting up Android SDK..."
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect"
bash scripts/install-android-sdk.sh

echo ""
echo "🧪 Creating Android emulator..."
bash scripts/create-avd.sh

echo ""
echo "🚀 Starting emulator..."
bash scripts/run-emulator.sh

echo ""
echo "✅ Emulator is starting! Once it's ready, run:"
echo "bash scripts/run-app.sh"
echo ""
echo "Or manually:"
echo "cd mobile && flutter run"
