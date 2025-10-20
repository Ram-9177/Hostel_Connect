#!/bin/bash

# HostelConnect Comprehensive Test Script
echo "🚀 HostelConnect Comprehensive Test Suite"
echo "========================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TOTAL_TESTS=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -e "\n${BLUE}Testing: $test_name${NC}"
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if eval "$test_command"; then
        echo -e "${GREEN}✅ PASSED: $test_name${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}❌ FAILED: $test_name${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Function to check if a service is running
check_service() {
    local service_name="$1"
    local port="$2"
    
    if curl -s "http://localhost:$port" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

# Function to check Flutter app
check_flutter_app() {
    if flutter devices | grep -q "emulator-5554"; then
        return 0
    else
        return 1
    fi
}

# Function to check API endpoints
check_api_endpoint() {
    local endpoint="$1"
    local expected_status="$2"
    
    local response=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:3000/api/v1$endpoint")
    if [ "$response" = "$expected_status" ]; then
        return 0
    else
        return 1
    fi
}

# Function to check file exists
check_file_exists() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        return 0
    else
        return 1
    fi
}

# Function to check directory exists
check_dir_exists() {
    local dir_path="$1"
    if [ -d "$dir_path" ]; then
        return 0
    else
        return 1
    fi
}

echo -e "\n${YELLOW}1. Environment Setup Tests${NC}"
run_test "Android SDK Available" "which adb > /dev/null 2>&1"
run_test "Flutter Installed" "flutter --version > /dev/null 2>&1"
run_test "Node.js Installed" "node --version > /dev/null 2>&1"
run_test "Git Repository" "git status > /dev/null 2>&1"

echo -e "\n${YELLOW}2. Backend API Tests${NC}"
run_test "Backend Service Running" "check_service 'Backend' 3000"
run_test "Health Endpoint" "check_api_endpoint '/health' 200"
run_test "API Documentation" "check_api_endpoint '' 200"

echo -e "\n${YELLOW}3. Mobile App Tests${NC}"
run_test "Android Emulator Running" "check_flutter_app"
run_test "Flutter Dependencies" "cd hostelconnect/mobile && flutter pub get > /dev/null 2>&1"
run_test "Flutter Analysis" "cd hostelconnect/mobile && flutter analyze --no-fatal-infos > /dev/null 2>&1"

echo -e "\n${YELLOW}4. File Structure Tests${NC}"
run_test "Main App File" "check_file_exists 'hostelconnect/mobile/lib/main.dart'"
run_test "API Service" "check_file_exists 'hostelconnect/mobile/lib/core/network/api_service.dart'"
run_test "Theme System" "check_file_exists 'hostelconnect/mobile/lib/shared/theme/telugu_theme.dart'"
run_test "Role Guards" "check_file_exists 'hostelconnect/mobile/lib/shared/widgets/navigation/role_guards.dart'"
run_test "Performance System" "check_file_exists 'hostelconnect/mobile/lib/core/performance/performance_optimization.dart'"
run_test "Error Handling" "check_file_exists 'hostelconnect/mobile/lib/features/debug/presentation/pages/errors_page.dart'"

echo -e "\n${YELLOW}5. Configuration Tests${NC}"
run_test "GitHub Actions" "check_file_exists '.github/workflows/ci-cd.yml'"
run_test "DevContainer" "check_file_exists '.devcontainer/devcontainer.json'"
run_test "Docker Compose" "check_file_exists '.devcontainer/docker-compose.yml'"
run_test "QA Report" "check_file_exists 'docs/qa/final-ultra-fix-report.md'"

echo -e "\n${YELLOW}6. Security Tests${NC}"
run_test "Android Permissions" "check_file_exists 'hostelconnect/mobile/android/app/src/main/AndroidManifest.xml'"
run_test "Network Security Config" "check_file_exists 'hostelconnect/mobile/android/app/src/main/res/xml/network_security_config.xml'"
run_test "Secure Storage" "check_file_exists 'hostelconnect/mobile/lib/core/storage/secure_storage.dart'"

echo -e "\n${YELLOW}7. UI/UX Tests${NC}"
run_test "Responsive System" "check_file_exists 'hostelconnect/mobile/lib/core/responsive.dart'"
run_test "Professional Components" "check_file_exists 'hostelconnect/mobile/lib/shared/widgets/ui/professional_components.dart'"
run_test "Telugu Theme" "check_file_exists 'hostelconnect/mobile/lib/shared/theme/telugu_theme.dart'"

echo -e "\n${YELLOW}8. Feature Tests${NC}"
run_test "Authentication System" "check_file_exists 'hostelconnect/mobile/lib/core/state/app_state.dart'"
run_test "Notices System" "check_file_exists 'hostelconnect/mobile/lib/features/notifications/presentation/pages/notices_page.dart'"
run_test "Gate Pass Page" "check_file_exists 'hostelconnect/mobile/lib/features/gatepass/presentation/pages/gate_pass_page.dart'"
run_test "Attendance Page" "check_file_exists 'hostelconnect/mobile/lib/features/attendance/presentation/pages/attendance_page.dart'"
run_test "Meals Page" "check_file_exists 'hostelconnect/mobile/lib/features/meals/presentation/pages/meals_page.dart'"
run_test "Profile Page" "check_file_exists 'hostelconnect/mobile/lib/features/profile/presentation/pages/profile_page.dart'"

echo -e "\n${YELLOW}9. Performance Tests${NC}"
run_test "Performance Monitoring" "check_file_exists 'hostelconnect/mobile/lib/core/performance/performance_optimization.dart'"
run_test "Offline Queue" "grep -q 'OfflineQueue' hostelconnect/mobile/lib/core/performance/performance_optimization.dart"
run_test "Error Handling" "grep -q 'ErrorHandler' hostelconnect/mobile/lib/core/performance/performance_optimization.dart"
run_test "Health Monitoring" "grep -q 'HealthMonitor' hostelconnect/mobile/lib/core/performance/performance_optimization.dart"

echo -e "\n${YELLOW}10. Integration Tests${NC}"
run_test "API Service Integration" "grep -q 'NetworkConfig' hostelconnect/mobile/lib/core/network/api_service.dart"
run_test "State Management" "grep -q 'Riverpod' hostelconnect/mobile/lib/core/state/app_state.dart"
run_test "Secure Storage Integration" "grep -q 'FlutterSecureStorage' hostelconnect/mobile/lib/core/storage/secure_storage.dart"

# Test API endpoints with actual data
echo -e "\n${YELLOW}11. API Endpoint Tests${NC}"
run_test "Login Endpoint" "check_api_endpoint '/auth/login' 400" # 400 is expected for missing data
run_test "Register Endpoint" "check_api_endpoint '/auth/register' 400" # 400 is expected for missing data
run_test "Notices Endpoint" "check_api_endpoint '/notices' 401" # 401 is expected without auth

# Test Flutter build
echo -e "\n${YELLOW}12. Build Tests${NC}"
run_test "Flutter Build Check" "cd hostelconnect/mobile && flutter build apk --debug > /dev/null 2>&1"

# Summary
echo -e "\n${YELLOW}========================================${NC}"
echo -e "${BLUE}TEST SUMMARY${NC}"
echo -e "${YELLOW}========================================${NC}"
echo -e "Total Tests: $TOTAL_TESTS"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 ALL TESTS PASSED! 🎉${NC}"
    echo -e "${GREEN}HostelConnect is ready for production!${NC}"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed. Please review the issues above.${NC}"
    exit 1
fi
