#!/bin/bash
# HostelConnect API Startup Script
# Run this to start the API server

set -e

echo "🧹 Cleaning up old processes..."
pkill -f "node.*dist/main.js" 2>/dev/null || true
pkill -f "nest start" 2>/dev/null || true
lsof -nP -iTCP:3000 -sTCP:LISTEN | awk 'NR>1 {print $2}' | xargs kill -9 2>/dev/null || true

echo "📦 Building API..."
cd "$(dirname "$0")/hostelconnect/api"
npm run build

echo "🚀 Starting API server..."
echo "   API will run at: http://localhost:3000"
echo "   Swagger docs at: http://localhost:3000/api"
echo ""
echo "   Press Ctrl+C to stop"
echo ""

ALLOW_UNVERIFIED_LOGIN=true node dist/main.js
