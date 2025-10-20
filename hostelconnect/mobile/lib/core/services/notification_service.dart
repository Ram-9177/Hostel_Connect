import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../core/network/api_service.dart';

class NotificationService {
  static const String baseUrl = AppConstants.baseUrl;
  static const String apiVersion = AppConstants.apiVersion;
  
  static String get _baseApiUrl => '$baseUrl$apiVersion';

  // Headers
  static Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> _getAuthHeaders(String? token) {
    final headers = Map<String, String>.from(_defaultHeaders);
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Device Registration for Push Notifications
  static Future<Map<String, dynamic>> registerDevice({
    required String token,
    required String deviceToken,
    required String deviceType,
    String? deviceName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/devices/register'),
        headers: _getAuthHeaders(token),
        body: jsonEncode({
          'deviceToken': deviceToken,
          'deviceType': deviceType,
          'deviceName': deviceName ?? 'Mobile Device',
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Device registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Device registration error: ${e.toString()}');
    }
  }

  // Create Notice (Admin/Warden Head only)
  static Future<Map<String, dynamic>> createNotice({
    required String token,
    required String title,
    required String content,
    required String priority,
    List<String>? targetRoles,
    DateTime? expiresAt,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/notices'),
        headers: _getAuthHeaders(token),
        body: jsonEncode({
          'title': title,
          'content': content,
          'priority': priority,
          'targetRoles': targetRoles,
          'expiresAt': expiresAt?.toIso8601String(),
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Notice creation failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Notice creation error: ${e.toString()}');
    }
  }

  // Get Notices for User
  static Future<List<dynamic>> getNotices(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseApiUrl/notices'),
        headers: _getAuthHeaders(token),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get notices: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get notices error: ${e.toString()}');
    }
  }

  // Mark Notice as Read
  static Future<Map<String, dynamic>> markNoticeAsRead({
    required String token,
    required String noticeId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/notices/$noticeId/read'),
        headers: _getAuthHeaders(token),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to mark notice as read: ${response.body}');
      }
    } catch (e) {
      throw Exception('Mark notice as read error: ${e.toString()}');
    }
  }

  // Get Unread Notices Count
  static Future<Map<String, dynamic>> getUnreadCount(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseApiUrl/notices/unread-count'),
        headers: _getAuthHeaders(token),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get unread count: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get unread count error: ${e.toString()}');
    }
  }

  // Send Push Notification (Admin/Warden Head only)
  static Future<Map<String, dynamic>> sendPushNotification({
    required String token,
    required String title,
    required String body,
    required String targetRole,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseApiUrl/notifications/push'),
        headers: _getAuthHeaders(token),
        body: jsonEncode({
          'title': title,
          'body': body,
          'targetRole': targetRole,
          'data': data,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Push notification failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Push notification error: ${e.toString()}');
    }
  }

  // Get Notification History
  static Future<List<dynamic>> getNotificationHistory(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseApiUrl/notifications/history'),
        headers: _getAuthHeaders(token),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get notification history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Get notification history error: ${e.toString()}');
    }
  }
}
