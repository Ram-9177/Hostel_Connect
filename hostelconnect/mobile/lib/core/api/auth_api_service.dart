// lib/core/api/auth_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class AuthApiService {
  final HttpClient _httpClient;

  AuthApiService(this._httpClient);

  // Helpers
  Map<String, dynamic> _ensureMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data as Map);
    throw Exception('Unexpected response format');
  }

  // Unwrap common API envelope and surface backend-declared failures
  Map<String, dynamic> _unwrapOrThrow(dynamic raw) {
    final map = _ensureMap(raw);

    // Some endpoints return { success, message, data }
    if (map.containsKey('success') && map['success'] == false) {
      final msg = (map['message'] ?? 'Request failed') as String;
      throw Exception(msg);
    }

    // Prefer nested data when present
    if (map.containsKey('data') && map['data'] is Map) {
      return Map<String, dynamic>.from(map['data'] as Map);
    }

    return map;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      // Normalize email
      if (userData['email'] != null) {
        userData['email'] = userData['email'].toString().trim().toLowerCase();
      }
      
      final response = await _httpClient.post(
        Environment.authRegister,
        data: userData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return _unwrapOrThrow(response.data);
      } else {
        // Extract error message from response
        final errorMsg = response.data is Map && response.data['message'] != null
            ? response.data['message']
            : 'Registration failed. Please try again.';
        throw Exception(errorMsg);
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('Connection')) {
        throw Exception('Cannot connect to server. Please check your internet connection.');
      }
      // Re-throw the exception with user-friendly message
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _httpClient.post(
        Environment.authLogin,
        data: {
          'email': email.trim().toLowerCase(),
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = _unwrapOrThrow(response.data);

        // Accept multiple token shapes
        final Map<String, dynamic> tokens = {
          'accessToken': data['accessToken'] ?? data['token'] ?? data['access_token'],
          'refreshToken': data['refreshToken'] ?? data['refresh_token'],
          'expiresIn': data['expiresIn'] ?? data['expires_in'],
        };

        // Some backends wrap tokens
        if (tokens['accessToken'] == null && data['tokens'] is Map) {
          final t = Map<String, dynamic>.from(data['tokens'] as Map);
          tokens['accessToken'] = t['accessToken'] ?? t['token'] ?? t['access_token'];
          tokens['refreshToken'] = t['refreshToken'] ?? t['refresh_token'];
          tokens['expiresIn'] = t['expiresIn'] ?? t['expires_in'];
        }

        if (tokens['accessToken'] == null) {
          final msg = (data['message'] ?? 'Login failed. No access token returned.') as String;
          throw Exception(msg);
        }

        // Merge original data and normalized tokens
        return {
          ...data,
          ...tokens,
        };
      } else {
        // Extract error message from response
        final errorMsg = response.data is Map && response.data['message'] != null
            ? response.data['message']
            : 'Invalid credentials. Please try again.';
        throw Exception(errorMsg);
      }
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('Connection')) {
        throw Exception('Cannot connect to server. Please check your internet connection.');
      }
      // Re-throw the exception with user-friendly message
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await _httpClient.post(
        Environment.authRefresh,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Token refresh failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _httpClient.get(Environment.authProfile);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get profile: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }


  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await _httpClient.post(
        Environment.authForgotPassword,
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Forgot password failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Forgot password failed: $e');
    }
  }

  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    try {
      final response = await _httpClient.post(
        Environment.authResetPassword,
        data: {
          'token': token,
          'password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Password reset failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    try {
      final response = await _httpClient.post(
        '/api/v1/auth/resend-verification',
        data: {'email': email},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to resend verification: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to resend verification: $e');
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String token) async {
    try {
      final response = await _httpClient.post(
        '/api/v1/auth/verify-email',
        data: {'token': token},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Email verification failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }
}

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthApiService(httpClient);
});
