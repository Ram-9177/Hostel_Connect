// Network configuration and API endpoints
class ApiConfig {
  static const String baseUrl = 'http://10.17.134.33:3000/api/v1';
  static const Duration timeout = Duration(seconds: 30);
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

class ApiEndpoints {
  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  
  // Gate Pass
  static const String gatePass = '/gate-pass';
  static const String gatePassApprove = '/gate-pass/{id}/approve';
  static const String gatePassQR = '/gate-pass/{id}/qr';
  
  // Attendance
  static const String attendanceSessions = '/attendance/sessions';
  static const String attendanceScan = '/attendance/scan';
  static const String attendanceManual = '/attendance/manual';
  
  // Meals
  static const String mealIntents = '/meals/intents';
  static const String mealForecast = '/meals/forecast';
  static const String mealChefBoard = '/meals/chef-board';
  
  // Dashboards
  static const String dashboardHostelLive = '/dash/hostel-live';
  static const String dashboardMonthly = '/dash/monthly';
  
  // Ads
  static const String ads = '/ads';
  static const String adEvents = '/ads/events';
}
