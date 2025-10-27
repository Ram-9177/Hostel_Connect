// lib/core/api/auth_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class AuthApiService {
  final HttpClient _httpClient;

  AuthApiService(this._httpClient);

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await _httpClient.post(
        Environment.authRegister,
        data: userData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Registration failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _httpClient.post(
        Environment.authLogin,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
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
}

final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthApiService(httpClient);
});
