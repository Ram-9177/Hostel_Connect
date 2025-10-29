// lib/core/api/auth_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class AuthApiService {
  final HttpClient _httpClient;

  AuthApiService(this._httpClient);

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
        // Handle different backend response formats
        final data = response.data;
        
        // If the response has a 'data' wrapper, unwrap it
        if (data is Map && data.containsKey('data')) {
          return data['data'] as Map<String, dynamic>;
        }
        
        return data as Map<String, dynamic>;
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
        // Handle different backend response formats
        final data = response.data;
        
        // If the response has a 'data' wrapper, unwrap it
        if (data is Map && data.containsKey('data')) {
          return data['data'] as Map<String, dynamic>;
        }
        
        return data as Map<String, dynamic>;
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
