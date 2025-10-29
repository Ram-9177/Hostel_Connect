#!/bin/bash
# Start everything: Backend, Emulator, and Mobile App
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "🎯 Starting HostelConnect Complete Stack..."
echo ""

# Start emulator in background
echo "📱 Step 1/3: Starting Android Emulator..."
bash "$SCRIPT_DIR/start-emulator.sh" &
EMULATOR_PID=$!
sleep 10  # Give emulator time to start

# Start backend in background
echo ""
echo "🔧 Step 2/3: Starting Backend API..."
cd "$PROJECT_ROOT"
bash "$SCRIPT_DIR/start-backend.sh" > "$PROJECT_ROOT/logs/backend.log" 2>&1 &
BACKEND_PID=$!
sleep 5  # Give backend time to start

# Start mobile app
echo ""
echo "📱 Step 3/3: Starting Mobile App..."
cd "$PROJECT_ROOT/mobile"
bash "$SCRIPT_DIR/start-mobile.sh"

# Cleanup on exit
trap "kill $EMULATOR_PID $BACKEND_PID 2>/dev/null || true" EXIT

