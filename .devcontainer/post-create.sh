#!/bin/bash

# Post-create script for HostelConnect devcontainer
echo "🚀 Setting up HostelConnect development environment..."

# Install API dependencies
echo "📦 Installing API dependencies..."
cd hostelconnect/api
npm install

# Install Mobile dependencies
echo "📱 Installing Mobile dependencies..."
cd ../mobile
flutter pub get

# Accept Android licenses
echo "📋 Accepting Android licenses..."
yes | flutter doctor --android-licenses

# Run Flutter doctor
echo "🔍 Running Flutter doctor..."
flutter doctor

# Create environment files
echo "⚙️ Creating environment files..."
cd ../api
if [ ! -f .env ]; then
    cat > .env << EOF
NODE_ENV=development
PORT=3000
HOST=0.0.0.0
JWT_SECRET=your-jwt-secret-here
DB_TYPE=sqlite
DB_DATABASE=hostelconnect.db
FCM_SERVER_KEY=your-fcm-server-key-here
EOF
    echo "✅ Created .env file"
else
    echo "✅ .env file already exists"
fi

# Initialize database
echo "🗄️ Initializing database..."
npm run db:seed

echo "✅ HostelConnect development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Start the API: cd hostelconnect/api && npm start"
echo "2. Start the mobile app: cd hostelconnect/mobile && flutter run"
echo "3. Open http://localhost:3000/api for API documentation"
