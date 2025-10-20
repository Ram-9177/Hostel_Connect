#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/mobile"

echo "📱 Devices:"
flutter devices || true

echo "▶️  Running app..."
flutter run
