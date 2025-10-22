#!/bin/bash

# Quick API Test Script
echo "🧪 Testing HostelConnect API..."

# Test API health
echo "1. Testing API health..."
curl -s http://localhost:3000/api/v1/health | jq . || echo "❌ API health check failed"

# Test login
echo "2. Testing login endpoint..."
curl -s -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"student@demo.com","password":"password123"}' | jq . || echo "❌ Login test failed"

# Test from emulator perspective
echo "3. Testing from emulator perspective..."
curl -s http://10.0.2.2:3000/api/v1/health | jq . || echo "❌ Emulator connectivity test failed"

echo "✅ API tests completed!"
