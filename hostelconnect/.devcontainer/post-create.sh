#!/bin/bash

# Post-create script for devcontainer setup

echo "🚀 Setting up HostelConnect development environment..."

# Install API dependencies
echo "📦 Installing API dependencies..."
cd /workspace/api
npm install

# Install Mobile dependencies
echo "📱 Installing Mobile dependencies..."
cd /workspace/mobile
flutter pub get

# Setup database
echo "🗄️ Setting up database..."
cd /workspace/api
npm run migration:run || echo "Migrations will run when database is available"
npm run seed || echo "Seeding will run when database is available"

echo "✅ Development environment ready!"
echo ""
echo "Next steps:"
echo "1. Start the API: cd api && npm run start:dev"
echo "2. Start the mobile app: cd mobile && flutter run"
echo "3. Access the API docs at http://localhost:3000/api"
