#!/bin/bash

# Installation script for new features dependencies
# HostelConnect - New Features Setup

echo "🚀 Installing dependencies for new features..."

cd hostelconnect/api

# Install missing npm packages
echo "📦 Installing npm packages..."
npm install csv-parser @types/multer @types/bcrypt

# Check if @nestjs/schedule is installed
if ! npm list @nestjs/schedule > /dev/null 2>&1; then
  echo "Installing @nestjs/schedule..."
  npm install @nestjs/schedule
fi

# Check if @nestjs/platform-express is installed
if ! npm list @nestjs/platform-express > /dev/null 2>&1; then
  echo "Installing @nestjs/platform-express..."
  npm install @nestjs/platform-express
fi

echo "✅ Dependencies installed successfully!"

echo ""
echo "📋 Next steps:"
echo "1. Build the project: npm run build"
echo "2. Start the development server: npm run start:dev"
echo "3. Test the endpoints (see NEW_FEATURES_GUIDE.md)"
echo ""
echo "🔔 Scheduled notifications will run at:"
echo "   - 7:00 AM IST - Morning meal reminder"
echo "   - 6:00 PM IST - Evening cutoff warning"
echo "   - 9:00 AM IST - Daily menu announcement"
echo ""
echo "📖 For detailed usage, see: NEW_FEATURES_GUIDE.md"
