// lib/core/config/environment.dart
class Environment {
  static const String _baseUrl = 'http://10.17.134.33:8080/api/v1';
  static const String _apiKey = 'your-api-key-here';
  static const int _timeoutSeconds = 30;
  static const int _maxRetries = 3;
  static const int _retryDelayMs = 1000;

  // API Configuration
  static String get baseUrl => _baseUrl;
  static String get apiKey => _apiKey;
  static Duration get timeout => Duration(seconds: _timeoutSeconds);
  static int get maxRetries => _maxRetries;
  static Duration get retryDelay => Duration(milliseconds: _retryDelayMs);

  // Environment-specific settings
  static bool get isDevelopment => true; // Set to false for production
  static bool get enableLogging => isDevelopment;
  static bool get enableMockData => false; // Set to true to use mock data

  // API Endpoints
  static const String authLogin = '/auth/login';
  static const String authRefresh = '/auth/refresh';
  static const String authProfile = '/auth/profile';
  static const String authRegister = '/auth/register';
  static const String authForgotPassword = '/auth/forgot-password';
  static const String authResetPassword = '/auth/reset-password';

  static const String users = '/users';
  static const String usersProfile = '/users/profile';

  static const String students = '/students';
  static const String studentsUnassigned = '/students/unassigned';
  static const String studentsByHostel = '/students/hostel';
  static const String studentsByRoom = '/students/room';

  static const String hostels = '/hostels';
  static const String hostelsBlocks = '/hostels/blocks';
  static const String hostelsRooms = '/hostels/rooms';
  static const String hostelsAnalytics = '/hostels/analytics';
  static const String hostelsRoomMap = '/hostels/room-map';

  static const String rooms = '/rooms';
  static const String roomsMap = '/rooms/map';
  static const String roomsAvailable = '/rooms/available';
  static const String roomsAllocate = '/rooms/allocate';
  static const String roomsTransfer = '/rooms/transfer';
  static const String roomsSwap = '/rooms/swap';

  static const String notices = '/notices';
  static const String noticesTest = '/test-notices';

  static const String ads = '/ads';
  static const String adsEligible = '/ads/eligible';
  static const String adsEvent = '/ads/event';
  static const String adsStats = '/ads/stats';

  static const String health = '/health';
}
