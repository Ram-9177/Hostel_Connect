#!/bin/bash

# HostelConnect Full Stack Startup Script
# This script starts both the NestJS API and Flutter mobile app

echo "🚀 Starting HostelConnect Full Stack Application..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if port is in use
port_in_use() {
    lsof -i :$1 >/dev/null 2>&1
}

# Check prerequisites
echo -e "${BLUE}📋 Checking prerequisites...${NC}"

if ! command_exists node; then
    echo -e "${RED}❌ Node.js is not installed${NC}"
    exit 1
fi

if ! command_exists flutter; then
    echo -e "${RED}❌ Flutter is not installed${NC}"
    exit 1
fi

if ! command_exists adb; then
    echo -e "${RED}❌ Android SDK (adb) is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ All prerequisites found${NC}"

# Check if Android emulator is running
echo -e "${BLUE}📱 Checking Android emulator...${NC}"
if ! adb devices | grep -q "emulator"; then
    echo -e "${YELLOW}⚠️  No Android emulator detected. Please start an emulator first.${NC}"
    echo -e "${YELLOW}   You can start one with: emulator -avd Pixel_7_API_34${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Android emulator detected${NC}"

# Kill any existing processes
echo -e "${BLUE}🧹 Cleaning up existing processes...${NC}"
pkill -f "nest start" 2>/dev/null || true
pkill -f "node dist/main" 2>/dev/null || true
pkill -f "flutter run" 2>/dev/null || true
sleep 2

# Start API Server
echo -e "${BLUE}🔧 Starting NestJS API Server...${NC}"
cd "$(dirname "$0")/hostelconnect/api"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}📦 Installing API dependencies...${NC}"
    npm install
fi

# Build the API
echo -e "${YELLOW}🔨 Building API...${NC}"
npm run build

# Start API in background
echo -e "${GREEN}🚀 Starting API server on port 3000...${NC}"
PORT=3000 HOST=0.0.0.0 node dist/main.js &
API_PID=$!

# Wait for API to start
echo -e "${YELLOW}⏳ Waiting for API to start...${NC}"
for i in {1..30}; do
    if curl -s http://localhost:3000/api/v1/ >/dev/null 2>&1; then
        echo -e "${GREEN}✅ API server is running!${NC}"
        break
    fi
    sleep 1
    if [ $i -eq 30 ]; then
        echo -e "${RED}❌ API server failed to start${NC}"
        kill $API_PID 2>/dev/null || true
        exit 1
    fi
done

# Start Flutter App
echo -e "${BLUE}📱 Starting Flutter Mobile App...${NC}"
cd "../mobile"

# Clean and get dependencies
echo -e "${YELLOW}🧹 Cleaning Flutter app...${NC}"
flutter clean >/dev/null 2>&1
flutter pub get >/dev/null 2>&1

# Run build runner
echo -e "${YELLOW}🔨 Running build runner...${NC}"
flutter pub run build_runner build --delete-conflicting-outputs >/dev/null 2>&1

# Start Flutter app
echo -e "${GREEN}🚀 Starting Flutter app on emulator...${NC}"
flutter run -d emulator-5554 &
FLUTTER_PID=$!

# Wait for Flutter app to start
echo -e "${YELLOW}⏳ Waiting for Flutter app to start...${NC}"
sleep 15

# Test API connectivity from emulator perspective
echo -e "${BLUE}🔍 Testing API connectivity...${NC}"
if curl -s http://10.0.2.2:3000/api/v1/ >/dev/null 2>&1; then
    echo -e "${GREEN}✅ API is accessible from emulator (10.0.2.2:3000)${NC}"
else
    echo -e "${YELLOW}⚠️  API may not be accessible from emulator${NC}"
fi

# Display test credentials
echo -e "${BLUE}🔑 Test Credentials:${NC}"
echo -e "${GREEN}   Student: student@demo.com / password123${NC}"
echo -e "${GREEN}   Warden: warden@demo.com / password123${NC}"
echo -e "${GREEN}   Warden Head: wardenhead@demo.com / password123${NC}"
echo -e "${GREEN}   Chef: chef@demo.com / password123${NC}"
echo -e "${GREEN}   Super Admin: admin@demo.com / password123${NC}"

echo -e "${GREEN}🎉 HostelConnect is now running!${NC}"
echo -e "${BLUE}📱 Mobile App: Running on Android emulator${NC}"
echo -e "${BLUE}🔧 API Server: http://localhost:3000/api/v1/${NC}"
echo -e "${BLUE}📚 API Docs: http://localhost:3000/api${NC}"

echo -e "${YELLOW}💡 Press Ctrl+C to stop both services${NC}"

# Function to cleanup on exit
cleanup() {
    echo -e "\n${YELLOW}🛑 Stopping services...${NC}"
    kill $API_PID 2>/dev/null || true
    kill $FLUTTER_PID 2>/dev/null || true
    pkill -f "nest start" 2>/dev/null || true
    pkill -f "node dist/main" 2>/dev/null || true
    pkill -f "flutter run" 2>/dev/null || true
    echo -e "${GREEN}✅ All services stopped${NC}"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Keep script running
while true; do
    sleep 1
done
