#!/usr/bin/env bash
set -euo pipefail

echo "🚀 HostelConnect - Flutter Run"
echo "=============================="
echo ""

# Check if Flutter is available
if ! command -v flutter >/dev/null 2>&1; then
    echo "❌ Flutter not found. Please install Flutter first."
    exit 1
fi

# Navigate to mobile directory
cd "/Users/ram/Desktop/HostelConnect Mobile App/hostelconnect/mobile"

echo "📱 Checking for devices..."
flutter devices

echo ""
echo "▶️  Starting HostelConnect..."
echo ""

# Run the app
flutter run

echo ""
echo "✅ HostelConnect is running!"
echo ""
echo "Hot reload commands:"
echo "• Press 'r' to hot reload"
echo "• Press 'R' to hot restart"
echo "• Press 'q' to quit"
echo "• Press 'h' for help"
