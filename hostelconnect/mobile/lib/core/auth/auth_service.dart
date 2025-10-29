import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../api/auth_api_service.dart';
import '../config/environment.dart';
import '../state/app_state.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _deviceIdKey = 'device_id';

  // Auth state provider
  static final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
    return AuthNotifier(ref);
  });

  // Register new user - PRODUCTION READY
  static Future<AuthResult> register(Map<String, dynamic> userData, AuthApiService? apiService) async {
    try {
      // Validate input parameters
      if (userData['email']?.isEmpty ?? true || userData['password']?.isEmpty ?? true) {
        return AuthResult.error('Email and password are required');
      }
      
      if (!_isValidEmail(userData['email'])) {
        return AuthResult.error('Please enter a valid email address');
      }
      
      if (apiService == null) {
        return AuthResult.error('Authentication service unavailable. Please try again later.');
      }
      
      // Call real API - NO MOCK DATA IN PRODUCTION
      final response = await apiService.register(userData);
      
      if (response == null || response.isEmpty) {
        return AuthResult.error('Invalid response from server');
      }
      
      // Handle normalized API response format
      if (!response.containsKey('user') || !response.containsKey('accessToken')) {
        return AuthResult.error('Invalid server response format');
      }
      
      // Create tokens from normalized response
      final tokens = AuthTokens(
        accessToken: response['accessToken']?.toString() ?? '',
        refreshToken: response['refreshToken']?.toString() ?? '',
        expiresIn: response['expiresIn']?.toInt() ?? 3600,
      );
      
      // Create user from normalized response
      final user = User.fromJson(response['user']);
      
      // Store tokens securely
      await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
      await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
      await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
      
      return AuthResult.success(user);
    } catch (e) {
      return AuthResult.error('Registration failed: ${e.toString()}');
    }
  }

  // Login with credentials - PRODUCTION READY
  static Future<AuthResult> login(String email, String password, AuthApiService? apiService) async {
    try {
      // Validate input parameters
      if (email.isEmpty || password.isEmpty) {
        return AuthResult.error('Email and password are required');
      }
      
      if (!_isValidEmail(email)) {
        return AuthResult.error('Please enter a valid email address');
      }
      
      if (apiService == null) {
        return AuthResult.error('Authentication service unavailable. Please try again later.');
      }
      
      // Call real API - NO MOCK DATA IN PRODUCTION
      final response = await apiService.login(email, password);
      
      if (response == null || response.isEmpty) {
        return AuthResult.error('Invalid response from server');
      }
      
      // Handle normalized API response format
      if (!response.containsKey('user') || !response.containsKey('accessToken')) {
        return AuthResult.error('Invalid server response format');
      }
      
      // Create tokens from normalized response
      final tokens = AuthTokens(
        accessToken: response['accessToken']?.toString() ?? '',
        refreshToken: response['refreshToken']?.toString() ?? '',
        expiresIn: response['expiresIn'] ?? 3600,
      );
      
      // Create user from normalized response
      final userData = response['user'];
      final user = User(
        id: userData['id']?.toString() ?? '',
        email: userData['email']?.toString() ?? '',
        role: userData['role']?.toString() ?? 'student',
        hostelId: userData['hostelId']?.toString() ?? 'default-hostel',
        firstName: userData['name']?.toString() ?? userData['firstName']?.toString() ?? '',
        lastName: userData['lastName']?.toString() ?? '',
        phone: userData['phone']?.toString(),
        isActive: userData['isActive'] ?? true,
        createdAt: userData['createdAt'] != null ? DateTime.tryParse(userData['createdAt'].toString()) : null,
        updatedAt: userData['updatedAt'] != null ? DateTime.tryParse(userData['updatedAt'].toString()) : null,
        roomId: userData['roomId']?.toString(),
        bedNumber: userData['bedNumber']?.toString(),
      );
      
      final deviceId = response['deviceId'] ?? 'device_${DateTime.now().millisecondsSinceEpoch}';
      
      // Validate tokens
      if (tokens.accessToken.isEmpty || tokens.refreshToken.isEmpty) {
        return AuthResult.error('Invalid authentication tokens received');
      }
      
      await _storeAuthData(tokens, user, deviceId);
      
      return AuthResult.success(user);
    } catch (e) {
      // Log error for debugging but don't expose sensitive information
      print('Login error: ${e.toString()}');
      return AuthResult.error('Login failed. Please check your credentials and try again.');
    }
  }

  // Update tokens method for AuthNotifier
  static Future<void> updateTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Silent refresh
  static Future<AuthResult> silentRefresh([AuthApiService? apiService]) async {
    try {
      final refreshToken = await _storage.read(key: _refreshTokenKey);
      if (refreshToken == null) {
        return AuthResult.error('No refresh token');
      }

      if (Environment.enableMockData) {
        // Use mock data for development
        await Future.delayed(const Duration(milliseconds: 500));
        
        final tokens = AuthTokens(
          accessToken: 'refreshed_access_token_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'refreshed_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
          expiresIn: 3600,
        );
        
        final userData = await _storage.read(key: _userKey);
        if (userData == null) {
          return AuthResult.error('No user data');
        }
        
        final user = User.fromJson(jsonDecode(userData));
        await _storeTokens(tokens);
        
        return AuthResult.success(user);
      } else {
        // Use real API
        if (apiService == null) {
          throw Exception('API service not available');
        }
        
        final response = await apiService.refreshToken(refreshToken);
        
        final tokens = AuthTokens.fromJson(response['tokens']);
        await _storeTokens(tokens);
        
        final userData = await _storage.read(key: _userKey);
        if (userData == null) {
          return AuthResult.error('No user data');
        }
        
        final user = User.fromJson(jsonDecode(userData));
        
        return AuthResult.success(user);
      }
    } catch (e) {
      return AuthResult.error('Refresh failed: ${e.toString()}');
    }
  }

  // Logout
  static Future<void> logout() async {
    try {
      final deviceId = await _storage.read(key: _deviceIdKey);
      
      // TODO: Call logout API to revoke device token
      if (deviceId != null) {
        // await apiService.logout(deviceId);
      }
      
      // Clear all stored data
      await _storage.deleteAll();
    } catch (e) {
      // Continue with logout even if API call fails
    }
  }

  // Check if user is authenticated
  static Future<bool> isAuthenticated() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    return accessToken != null && refreshToken != null;
  }

  // Get current user
  static Future<User?> getCurrentUser() async {
    try {
      final userData = await _storage.read(key: _userKey);
      if (userData == null) return null;
      return User.fromJson(jsonDecode(userData));
    } catch (e) {
      return null;
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Store auth data
  static Future<void> _storeAuthData(AuthTokens tokens, User user, String deviceId) async {
    await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()));
    await _storage.write(key: _deviceIdKey, value: deviceId);
  }

  // Store tokens only
  static Future<void> _storeTokens(AuthTokens tokens) async {
    await _storage.write(key: _accessTokenKey, value: tokens.accessToken);
    await _storage.write(key: _refreshTokenKey, value: tokens.refreshToken);
  }

  // Email validation helper
  static bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
  
  // Password validation helper
  static bool _isValidPassword(String password) {
    return password.length >= 8;
  }
  
  // Validate user permissions
  static bool _hasPermission(User user, String requiredRole) {
    // Role hierarchy: super_admin > warden_head > warden > chef > student
    final roleHierarchy = {
      'super_admin': 5,
      'warden_head': 4,
      'warden': 3,
      'chef': 2,
      'student': 1,
    };
    
    final userLevel = roleHierarchy[user.role] ?? 0;
    final requiredLevel = roleHierarchy[requiredRole] ?? 0;
    
    return userLevel >= requiredLevel;
  }
}

// Auth state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  
  AuthNotifier(this._ref) : super(AuthState.initial()) {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    final isAuth = await AuthService.isAuthenticated();
    if (isAuth) {
      final apiService = _ref.read(authApiServiceProvider);
      final result = await AuthService.silentRefresh(apiService);
      if (result.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: result.user,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: result.error,
        );
      }
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final apiService = _ref.read(authApiServiceProvider);
    final result = await AuthService.login(email, password, apiService);
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: result.user,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: result.error,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await AuthService.logout();
    state = AuthState.initial();
  }

  Future<void> refresh() async {
    final apiService = _ref.read(authApiServiceProvider);
    final result = await AuthService.silentRefresh(apiService);
    if (result.isSuccess) {
      state = state.copyWith(user: result.user);
    } else {
      // If refresh fails, logout
      await logout();
    }
  }
}

// Data models
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final User? user;
  final String? error;

  const AuthState({
    required this.isLoading,
    required this.isAuthenticated,
    this.user,
    this.error,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: true,
      isAuthenticated: false,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    User? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthResult {
  final bool isSuccess;
  final User? user;
  final String? error;

  const AuthResult._({
    required this.isSuccess,
    this.user,
    this.error,
  });

  factory AuthResult.success(User user) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.error(String error) {
    return AuthResult._(isSuccess: false, error: error);
  }
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'] ?? json['access_token'],
      refreshToken: json['refreshToken'] ?? json['refresh_token'],
      expiresIn: json['expiresIn'] ?? json['expires_in'] ?? 3600,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }
}

// User class is now imported from app_state.dart
