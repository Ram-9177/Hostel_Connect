#!/bin/bash

# Quick API Start Script for HostelConnect
# This starts a working test API server

echo "🚀 Starting HostelConnect Test API Server..."

cd "$(dirname "$0")/hostelconnect/api"

# Kill any existing processes
pkill -f "node test-server" 2>/dev/null || true
pkill -f "node dist/main" 2>/dev/null || true
sleep 2

# Start the test server
echo "📡 Starting API on port 8080..."
node test-server.js &

# Wait for server to start
sleep 3

# Test the API
echo "🔍 Testing API..."
if curl -s http://localhost:8080/api/v1/ >/dev/null; then
    echo "✅ API is running successfully!"
    echo "📱 Mobile app should now be able to connect"
    echo "🔗 API URL: http://localhost:8080/api/v1/"
    echo "🔑 Test login: student@demo.com / password123"
else
    echo "❌ API failed to start"
    exit 1
fi

echo "💡 Press Ctrl+C to stop the server"
wait
