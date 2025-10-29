#!/bin/bash
# Setup Environment Variables
set -e

cd "$(dirname "$0")/.."

if [ -f .env ]; then
  echo "⚠️  .env file already exists"
  read -p "Do you want to overwrite it? (y/N): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

echo "📝 Creating .env file from template..."
cp .env.example .env

echo "✅ .env file created!"
echo ""
echo "⚠️  IMPORTANT: Edit .env file and update:"
echo "   - DB_PASSWORD: Your PostgreSQL password"
echo "   - JWT_SECRET: Change to a random secret (min 32 chars)"
echo "   - SMTP_USER: Your email for sending verification emails"
echo "   - SMTP_PASS: Your email app password"
echo ""
echo "You can edit it with: nano .env"

