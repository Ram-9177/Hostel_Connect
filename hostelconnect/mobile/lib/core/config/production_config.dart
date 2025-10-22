// lib/core/config/production_config.dart - PRODUCTION CONFIGURATION
class ProductionConfig {
  // === API CONFIGURATION ===
  static const String baseUrl = 'https://api.hostelconnect.com';
  static const String apiVersion = 'v1';
  static const int timeoutSeconds = 30;
  
  // === SECURITY CONFIGURATION ===
  static const bool enableMockData = false; // NEVER TRUE IN PRODUCTION
  static const bool enableDebugMode = false;
  static const bool enableLogging = true;
  
  // === FEATURE FLAGS ===
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  
  // === PERFORMANCE CONFIGURATION ===
  static const int maxRetryAttempts = 3;
  static const int cacheExpirationMinutes = 15;
  static const int maxConcurrentRequests = 5;
  
  // === VALIDATION RULES ===
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxFileSizeMB = 10;
  static const List<String> allowedFileTypes = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];
  
  // === RATE LIMITING ===
  static const int maxLoginAttempts = 5;
  static const int loginLockoutMinutes = 15;
  static const int maxApiRequestsPerMinute = 100;
  
  // === ENVIRONMENT VALIDATION ===
  static void validateEnvironment() {
    assert(!enableMockData, 'Mock data must be disabled in production');
    assert(!enableDebugMode, 'Debug mode must be disabled in production');
    assert(baseUrl.startsWith('https://'), 'Base URL must use HTTPS in production');
  }
  
  // === GETTERS ===
  static String get apiBaseUrl => '$baseUrl/api/$apiVersion';
  static String get websocketUrl => baseUrl.replaceFirst('https://', 'wss://').replaceFirst('http://', 'ws://');
  
  // === VALIDATION METHODS ===
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  
  static bool isValidPassword(String password) {
    return password.length >= minPasswordLength && password.length <= maxPasswordLength;
  }
  
  static bool isValidFileType(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return allowedFileTypes.contains(extension);
  }
  
  static bool isValidFileSize(int fileSizeBytes) {
    final fileSizeMB = fileSizeBytes / (1024 * 1024);
    return fileSizeMB <= maxFileSizeMB;
  }
}
