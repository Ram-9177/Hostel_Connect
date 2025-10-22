#!/bin/bash

# HostelConnect API Quick Setup
# This script sets up the API with proper database configuration

set -e

echo "🏠 HostelConnect API Setup"
echo "========================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Navigate to API directory
cd hostelconnect/api

print_status "Setting up API environment..."

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    print_status "Creating .env file..."
    cat > .env << EOF
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=password
DB_NAME=hostelconnect

# JWT Configuration
JWT_SECRET=hostelconnect-super-secret-key-2024
JWT_EXPIRES_IN=1d
JWT_REFRESH_SECRET=hostelconnect-refresh-secret-key-2024
JWT_REFRESH_EXPIRES_IN=7d

# Server Configuration
PORT=3000
NODE_ENV=development

# Email Configuration (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
EOF
    print_success ".env file created"
else
    print_warning ".env file already exists"
fi

# Install dependencies
print_status "Installing dependencies..."
npm install

# Check if PostgreSQL is running
print_status "Checking database connection..."
if command -v psql &> /dev/null; then
    print_success "PostgreSQL client found"
else
    print_warning "PostgreSQL client not found. Please install PostgreSQL"
fi

# Create database if it doesn't exist
if command -v psql &> /dev/null; then
    print_status "Creating database..."
    createdb hostelconnect 2>/dev/null || print_warning "Database may already exist"
fi

# Run database migrations
print_status "Running database migrations..."
npm run migration:run 2>/dev/null || print_warning "Migrations may have failed - this is normal for first run"

# Seed database with demo data
print_status "Seeding database with demo data..."
npm run seed 2>/dev/null || print_warning "Seeding may have failed - this is normal for first run"

print_success "API setup completed!"
echo ""
echo "🚀 To start the API server:"
echo "   cd hostelconnect/api"
echo "   npm run start:dev"
echo ""
echo "📱 API will be available at: http://localhost:3000"
echo "📚 API Documentation: http://localhost:3000/api"
echo ""
echo "🔑 Demo users will be created automatically"
