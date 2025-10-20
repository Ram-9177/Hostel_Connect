#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "🎉 HostelConnect Android Setup"
echo "=============================="
echo ""

echo "This script will set up Android development environment for HostelConnect."
echo "It will:"
echo "• Install Android SDK and command line tools"
echo "• Create Pixel 7 API 34 emulator"
echo "• Start the emulator"
echo "• Run the Flutter app"
echo ""

read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 0
fi

echo ""
echo "📱 Step 1: Installing Android SDK..."
bash scripts/install-android-sdk.sh

echo ""
echo "🧪 Step 2: Creating AVD..."
bash scripts/create-avd.sh

echo ""
echo "🚀 Step 3: Starting emulator..."
bash scripts/run-emulator.sh

echo ""
echo "▶️  Step 4: Running HostelConnect app..."
bash scripts/run-app.sh

echo ""
echo "✅ Setup complete! HostelConnect should now be running on your emulator."
echo ""
echo "Next time, you can just run:"
echo "bash scripts/run-emulator.sh"
echo "bash scripts/run-app.sh"
