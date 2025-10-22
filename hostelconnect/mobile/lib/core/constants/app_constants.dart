class AppConstants {
  static const String appName = 'HostelConnect';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'http://10.17.134.33:3000'; // Android emulator localhost
  static const String apiVersion = '/api/v1';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userRoleKey = 'user_role';
  static const String userIdKey = 'user_id';
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration scanTimeout = Duration(seconds: 5);
  
  // QR Token TTL
  static const Duration qrTokenTTL = Duration(seconds: 30);
  
  // Ad Duration
  static const Duration adDuration = Duration(seconds: 20);
  
  // Roles
  static const String roleStudent = 'STUDENT';
  static const String roleWarden = 'WARDEN';
  static const String roleWardenHead = 'WARDEN_HEAD';
  static const String roleSuperAdmin = 'SUPER_ADMIN';
  static const String roleChef = 'CHEF';
  
  // Modules
  static const String moduleGatePass = 'gatepass';
  static const String moduleAttendance = 'attendance';
  static const String moduleMeals = 'meals';
  static const String moduleRooms = 'rooms';
  static const String moduleNotices = 'notices';
}
