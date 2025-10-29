#!/bin/bash
# Start Backend API Server
set -e

cd "$(dirname "$0")/.."

echo "🧹 Cleaning up old bcrypt if exists..."
rm -rf node_modules/bcrypt node_modules/@types/bcrypt 2>/dev/null || true

echo "🔧 Installing dependencies..."
if [ ! -d "node_modules" ] || [ ! -f "package-lock.json" ]; then
  echo "   Fresh install (removing old lockfile)..."
  rm -rf node_modules package-lock.json 2>/dev/null || true
  npm cache clean --force 2>/dev/null || true
  npm install --no-optional --legacy-peer-deps
else
  echo "   Dependencies exist, skipping install..."
fi

echo "🔍 Verifying bcryptjs is installed..."
if npm ls bcryptjs >/dev/null 2>&1; then
  echo "✅ bcryptjs found"
else
  echo "❌ bcryptjs missing, forcing install..."
  npm install bcryptjs @types/bcryptjs --save --save-dev --no-optional
fi

echo "🏗️  Building backend..."
npm run build

echo "📝 Checking for .env file..."
if [ ! -f .env ]; then
  echo "⚠️  WARNING: .env file not found!"
  echo "   Copy .env.example to .env and update with your settings"
  echo "   cp .env.example .env"
fi

echo "🗄️  Running migrations..."
npm run migration:run || echo "⚠️  Migration warning (may be OK if tables exist)"

echo "🚀 Starting backend server..."
npm run start:prod

