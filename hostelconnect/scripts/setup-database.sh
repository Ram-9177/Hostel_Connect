#!/bin/bash
# Setup PostgreSQL Database for HostelConnect
set -e

echo "🗄️  Setting up PostgreSQL database..."

# Check if PostgreSQL is installed
if ! command -v psql &> /dev/null; then
  echo "❌ PostgreSQL not found. Please install PostgreSQL first."
  echo "   On macOS: brew install postgresql"
  exit 1
fi

# Load environment variables
if [ -f .env ]; then
  export $(cat .env | grep -v '^#' | xargs)
else
  echo "⚠️  No .env file found. Using defaults..."
  DB_USER=${DB_USER:-postgres}
  DB_NAME=${DB_NAME:-hostelconnect}
fi

# Create database
echo "Creating database: ${DB_NAME}..."
psql -U "${DB_USER}" -c "CREATE DATABASE ${DB_NAME};" 2>/dev/null || {
  echo "Database might already exist. Continuing..."
}

echo "✅ Database setup complete!"
echo ""
echo "Next steps:"
echo "1. Update .env file with your database credentials"
echo "2. Run: npm run migration:run"
echo "3. Start backend: npm run start:prod"

