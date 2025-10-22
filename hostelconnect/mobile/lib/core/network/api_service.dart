// lib/core/network/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'network_config.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;
  final String? endpoint;

  ApiException(this.message, {this.statusCode, this.details, this.endpoint});

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}${endpoint != null ? ' at $endpoint' : ''}';
}

class NetworkException implements Exception {
  final String message;
  final String? details;

  NetworkException(this.message, {this.details});

  @override
  String toString() => 'NetworkException: $message';
}

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);
  
  // Headers
  static Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'User-Agent': 'HostelConnect-Mobile/1.0.0',
  };

  static Map<String, String> _getAuthHeaders(String? token) {
    final headers = Map<String, String>.from(_defaultHeaders);
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  static void _handleResponse(http.Response response, String endpoint) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String errorMessage = 'Request failed';
    String? details;
    
    try {
      final errorData = jsonDecode(response.body);
      errorMessage = errorData['message'] ?? errorData['error'] ?? errorMessage;
      details = errorData['details'];
    } catch (e) {
      errorMessage = response.body.isNotEmpty ? response.body : errorMessage;
    }
    
    throw ApiException(
      errorMessage,
      statusCode: response.statusCode,
      details: details,
      endpoint: endpoint,
    );
  }

  static Future<T> _makeRequest<T>(
    Future<http.Response> Function() request,
    T Function(Map<String, dynamic>) parser,
    String endpoint,
  ) async {
    try {
      // Check network connectivity first
      final hasInternet = await NetworkConfig.hasInternetConnection();
      if (!hasInternet) {
        throw NetworkException('No internet connection available');
      }

      final response = await request().timeout(_timeout);
      _handleResponse(response, endpoint);
      return parser(jsonDecode(response.body));
    } on SocketException catch (e) {
      throw NetworkException('Network error: ${e.message}');
    } on HttpException catch (e) {
      throw NetworkException('HTTP error: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}', endpoint: endpoint);
    } catch (e) {
      if (e is ApiException || e is NetworkException) {
        rethrow;
      }
      throw NetworkException('Unexpected error: ${e.toString()}');
    }
  }

  // Authentication endpoints
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    const endpoint = '/auth/login';
    return _makeRequest(
      () => http.post(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _defaultHeaders,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }

  static Future<Map<String, dynamic>> register({
    required String studentId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String roomId,
    required String hostelId,
  }) async {
    const endpoint = '/auth/register';
    return _makeRequest(
      () => http.post(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _defaultHeaders,
        body: jsonEncode({
          'studentId': studentId,
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
          'password': password,
          'roomId': roomId,
          'hostelId': hostelId,
        }),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }

  static Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    const endpoint = '/auth/refresh';
    return _makeRequest(
      () => http.post(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _defaultHeaders,
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }

  static Future<Map<String, dynamic>> getProfile(String token) async {
    const endpoint = '/auth/profile';
    return _makeRequest(
      () => http.get(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _getAuthHeaders(token),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }

  // Gate Pass endpoints
  static Future<Map<String, dynamic>> createGatePass({
    required String token,
    required String reason,
    required String destination,
    required DateTime departureTime,
    required DateTime returnTime,
  }) async {
    final response = await http.post(
      Uri.parse('${NetworkConfig.apiUrl}/gate-pass'),
      headers: _getAuthHeaders(token),
      body: jsonEncode({
        'reason': reason,
        'destination': destination,
        'departureTime': departureTime.toIso8601String(),
        'returnTime': returnTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create gate pass: ${response.body}');
    }
  }

  static Future<List<dynamic>> getGatePasses(String token) async {
    final response = await http.get(
      Uri.parse('${NetworkConfig.apiUrl}/gate-pass'),
      headers: _getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get gate passes: ${response.body}');
    }
  }

  // Attendance endpoints
  static Future<Map<String, dynamic>> scanAttendance({
    required String token,
    required String qrToken,
  }) async {
    final response = await http.post(
      Uri.parse('${NetworkConfig.apiUrl}/attendance/scan'),
      headers: _getAuthHeaders(token),
      body: jsonEncode({
        'qrToken': qrToken,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to scan attendance: ${response.body}');
    }
  }

  static Future<List<dynamic>> getAttendanceHistory(String token) async {
    final response = await http.get(
      Uri.parse('${NetworkConfig.apiUrl}/attendance/history'),
      headers: _getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get attendance history: ${response.body}');
    }
  }

  // Meals endpoints
  static Future<Map<String, dynamic>> updateMealPreferences({
    required String token,
    required Map<String, bool> mealIntents,
    required DateTime date,
  }) async {
    final response = await http.post(
      Uri.parse('${NetworkConfig.apiUrl}/meals/preferences'),
      headers: _getAuthHeaders(token),
      body: jsonEncode({
        'mealIntents': mealIntents,
        'date': date.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update meal preferences: ${response.body}');
    }
  }

  static Future<List<dynamic>> getMealHistory(String token) async {
    final response = await http.get(
      Uri.parse('${NetworkConfig.apiUrl}/meals/history'),
      headers: _getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get meal history: ${response.body}');
    }
  }

  // Dashboard endpoints
  static Future<Map<String, dynamic>> getDashboard(String token) async {
    final response = await http.get(
      Uri.parse('${NetworkConfig.apiUrl}/dashboards/student'),
      headers: _getAuthHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get dashboard: ${response.body}');
    }
  }

  // Notices endpoints
  static Future<Map<String, dynamic>> getNotices(String token) async {
    const endpoint = '/notices';
    return _makeRequest(
      () => http.get(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _getAuthHeaders(token),
      ),
      (data) => data,
      endpoint,
    );
  }

  static Future<Map<String, dynamic>> createNotice(String token, String title, String content, List<String> roles) async {
    const endpoint = '/notices';
    return _makeRequest(
      () => http.post(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _getAuthHeaders(token),
        body: jsonEncode({'title': title, 'content': content, 'roles': roles}),
      ),
      (data) => data,
      endpoint,
    );
  }

  static Future<Map<String, dynamic>> markNoticeAsRead(String noticeId) async {
    const endpoint = '/notices/read';
    return _makeRequest(
      () => http.post(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint/$noticeId'),
        headers: _defaultHeaders,
      ),
      (data) => data,
      endpoint,
    );
  }

  // Health check endpoint
  static Future<Map<String, dynamic>> getHealth() async {
    const endpoint = '/health';
    return _makeRequest(
      () => http.get(
        Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
        headers: _defaultHeaders,
      ),
      (data) => data,
      endpoint,
    );
  }


  // Forgot password endpoint
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    const endpoint = "/auth/forgot-password";
    return _makeRequest(
      () => http.post(
        Uri.parse("${NetworkConfig.apiUrl}$endpoint"),
        headers: _defaultHeaders,
        body: jsonEncode({"email": email}),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }

  // Reset password endpoint
  static Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    const endpoint = "/auth/reset-password";
    return _makeRequest(
      () => http.post(
        Uri.parse("${NetworkConfig.apiUrl}$endpoint"),
        headers: _defaultHeaders,
        body: jsonEncode({"token": token, "newPassword": newPassword}),
      ),
      (data) {
        // Handle the API response structure
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
        return data;
      },
      endpoint,
    );
  }
}
