#!/bin/bash

# HostelConnect Complete Project Runner
# This script will run the entire HostelConnect project (API + Mobile + Web)

set -e

echo "🏠 HostelConnect Complete Project Runner"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if required tools are installed
check_dependencies() {
    print_status "Checking dependencies..."
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js first."
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm first."
        exit 1
    fi
    
    if ! command -v flutter &> /dev/null; then
        print_warning "Flutter is not installed. Mobile app will not be available."
    fi
    
    print_success "Dependencies check completed"
}

# Install API dependencies
install_api_deps() {
    print_status "Installing API dependencies..."
    cd hostelconnect/api
    
    if [ ! -f package.json ]; then
        print_error "package.json not found in API directory"
        exit 1
    fi
    
    npm install
    print_success "API dependencies installed"
    cd ../..
}

# Install Web dependencies
install_web_deps() {
    print_status "Installing Web dependencies..."
    
    if [ ! -f package.json ]; then
        print_error "package.json not found in root directory"
        exit 1
    fi
    
    npm install
    print_success "Web dependencies installed"
}

# Install Mobile dependencies
install_mobile_deps() {
    if command -v flutter &> /dev/null; then
        print_status "Installing Mobile dependencies..."
        cd hostelconnect/mobile
        
        if [ ! -f pubspec.yaml ]; then
            print_error "pubspec.yaml not found in mobile directory"
            exit 1
        fi
        
        flutter pub get
        print_success "Mobile dependencies installed"
        cd ../..
    else
        print_warning "Skipping mobile dependencies (Flutter not installed)"
    fi
}

# Start API server
start_api() {
    print_status "Starting API server..."
    cd hostelconnect/api
    
    # Check if database is configured
    if [ ! -f .env ]; then
        print_warning "No .env file found. Creating default configuration..."
        cat > .env << EOF
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=postgres
DB_PASSWORD=password
DB_NAME=hostelconnect

# JWT Configuration
JWT_SECRET=your-secret-key-here
JWT_EXPIRES_IN=1d
JWT_REFRESH_SECRET=your-refresh-secret-here
JWT_REFRESH_EXPIRES_IN=7d

# Server Configuration
PORT=3000
NODE_ENV=development
EOF
        print_warning "Please update the .env file with your database credentials"
    fi
    
    # Start the API server in background
    npm run start:dev &
    API_PID=$!
    print_success "API server started (PID: $API_PID)"
    cd ../..
}

# Start Web server
start_web() {
    print_status "Starting Web server..."
    
    # Start the web server in background
    npm run dev &
    WEB_PID=$!
    print_success "Web server started (PID: $WEB_PID)"
}

# Start Mobile app
start_mobile() {
    if command -v flutter &> /dev/null; then
        print_status "Starting Mobile app..."
        cd hostelconnect/mobile
        
        # Check if Android emulator is running
        if flutter devices | grep -q "emulator"; then
            print_success "Android emulator detected"
            flutter run &
            MOBILE_PID=$!
            print_success "Mobile app started (PID: $MOBILE_PID)"
        else
            print_warning "No Android emulator detected. Please start an emulator first."
            print_status "You can start the mobile app manually with: cd hostelconnect/mobile && flutter run"
        fi
        
        cd ../..
    else
        print_warning "Flutter not installed. Skipping mobile app."
    fi
}

# Wait for services to start
wait_for_services() {
    print_status "Waiting for services to start..."
    sleep 5
    
    # Check if API is running
    if curl -s http://localhost:3000 > /dev/null; then
        print_success "API server is running on http://localhost:3000"
    else
        print_warning "API server may not be ready yet"
    fi
    
    # Check if Web is running
    if curl -s http://localhost:5173 > /dev/null; then
        print_success "Web server is running on http://localhost:5173"
    else
        print_warning "Web server may not be ready yet"
    fi
}

# Show access information
show_access_info() {
    echo ""
    echo "🎉 HostelConnect is now running!"
    echo "================================="
    echo ""
    echo "📱 Access Points:"
    echo "  • API Server: http://localhost:3000"
    echo "  • Web App: http://localhost:5173"
    echo "  • Mobile App: Running on Android emulator"
    echo ""
    echo "🔑 Demo Login Credentials:"
    echo "  • Student: student@demo.com / password123"
    echo "  • Warden: warden@demo.com / password123"
    echo "  • Super Admin: admin@demo.com / password123"
    echo "  • Chef: chef@demo.com / password123"
    echo ""
    echo "🏠 New Features Available:"
    echo "  • Room Allotment System"
    echo "  • Hostel Data Management"
    echo "  • Bed Assignment Tracking"
    echo "  • Occupancy Analytics"
    echo ""
    echo "📚 Documentation: PROJECT_DOCUMENTATION.md"
    echo ""
    echo "Press Ctrl+C to stop all services"
}

# Cleanup function
cleanup() {
    echo ""
    print_status "Stopping all services..."
    
    if [ ! -z "$API_PID" ]; then
        kill $API_PID 2>/dev/null || true
        print_success "API server stopped"
    fi
    
    if [ ! -z "$WEB_PID" ]; then
        kill $WEB_PID 2>/dev/null || true
        print_success "Web server stopped"
    fi
    
    if [ ! -z "$MOBILE_PID" ]; then
        kill $MOBILE_PID 2>/dev/null || true
        print_success "Mobile app stopped"
    fi
    
    print_success "All services stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Main execution
main() {
    print_status "Starting HostelConnect Complete Project..."
    
    check_dependencies
    install_api_deps
    install_web_deps
    install_mobile_deps
    
    start_api
    start_web
    start_mobile
    
    wait_for_services
    show_access_info
    
    # Keep the script running
    while true; do
        sleep 1
    done
}

# Run main function
main "$@"
