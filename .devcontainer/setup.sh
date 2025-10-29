#!/bin/bash
# .devcontainer/setup.sh
# Initial setup script for Codespaces

set -e

echo "🚀 Setting up HostelConnect development environment..."

# Install root dependencies
echo "📦 Installing root dependencies..."
npm ci

# Install API dependencies
echo "📦 Installing API dependencies..."
cd hostelconnect/api && npm ci && cd ../..

# Install web dependencies (if separate)
if [ -f "package.json" ]; then
  echo "📦 Installing web dependencies..."
  npm ci
fi

# Install Flutter (for web development)
echo "🐦 Setting up Flutter..."
if [ ! -d "$HOME/flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
  export PATH="$PATH:$HOME/flutter/bin"
  flutter doctor
  flutter config --enable-web
fi

# Build API
echo "🔨 Building API..."
cd hostelconnect/api && npm run build && cd ../..

# Create .env files if they don't exist
echo "⚙️  Setting up environment variables..."
if [ ! -f ".env" ]; then
  cp .env.example .env 2>/dev/null || echo "DATABASE_URL=postgresql://postgres:password@postgres:5432/hostelconnect
REDIS_URL=redis://redis:6379
JWT_SECRET=dev-secret-change-in-production
ALLOW_UNVERIFIED_LOGIN=true
NODE_ENV=development" > .env
fi

if [ ! -f "hostelconnect/api/.env" ]; then
  cp hostelconnect/api/.env.example hostelconnect/api/.env 2>/dev/null || echo "DATABASE_URL=postgresql://postgres:password@postgres:5432/hostelconnect
REDIS_URL=redis://redis:6379
JWT_SECRET=dev-secret-change-in-production
ALLOW_UNVERIFIED_LOGIN=true" > hostelconnect/api/.env
fi

# Set up Git hooks
echo "🎣 Setting up Git hooks..."
git config core.hooksPath .githooks 2>/dev/null || true

# Create helpful aliases
echo "📝 Creating shell aliases..."
cat >> ~/.zshrc << 'EOF'

# HostelConnect Aliases
alias api-start='cd /workspace/hostelconnect/api && npm run start:dev'
alias web-start='cd /workspace && npm run dev'
alias flutter-web='cd /workspace/hostelconnect/mobile && flutter run -d chrome --web-port 8080'
alias db-reset='cd /workspace/hostelconnect/api && npm run migration:revert && npm run migration:run && npm run seed'
alias logs-api='docker logs -f hostelconnect-api'
alias logs-db='docker logs -f hostelconnect-postgres'

EOF

echo "✅ Setup complete!"
echo ""
echo "🎯 Quick Start Commands:"
echo "  api-start     - Start the NestJS API in watch mode"
echo "  web-start     - Start the React web app"
echo "  flutter-web   - Start the Flutter web app"
echo "  db-reset      - Reset and seed the database"
echo ""
echo "📚 Documentation: /workspace/DEPLOYMENT_SUCCESS.md"
echo "🚀 Future Plans: /workspace/FUTURE_ENHANCEMENTS.md"
