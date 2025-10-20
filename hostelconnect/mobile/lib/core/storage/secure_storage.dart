import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SecureTokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';
  static const String _deviceIdKey = 'device_id';

  // Store tokens and user data
  static Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> userData,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _userDataKey, value: jsonEncode(userData)),
    ]);
  }

  // Get stored tokens
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final userDataString = await _storage.read(key: _userDataKey);
    if (userDataString != null) {
      try {
        return jsonDecode(userDataString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Update access token (for refresh)
  static Future<void> updateAccessToken(String newAccessToken) async {
    await _storage.write(key: _accessTokenKey, value: newAccessToken);
  }

  // Store device ID for push notifications
  static Future<void> storeDeviceId(String deviceId) async {
    await _storage.write(key: _deviceIdKey, value: deviceId);
  }

  static Future<String?> getDeviceId() async {
    return await _storage.read(key: _deviceIdKey);
  }

  // Clear all stored data (logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final userData = await getUserData();
    
    return accessToken != null && refreshToken != null && userData != null;
  }

  // Get user role
  static Future<String?> getUserRole() async {
    final userData = await getUserData();
    return userData?['role'];
  }

  // Get user ID
  static Future<String?> getUserId() async {
    final userData = await getUserData();
    return userData?['id'];
  }

  // Initialize storage (placeholder for future use)
  static Future<void> initialize() async {
    // Storage is automatically initialized
  }

  // Get all stored tokens as a map
  static Future<Map<String, dynamic>?> getStoredTokens() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final userData = await getUserData();
    
    if (accessToken != null && refreshToken != null && userData != null) {
      return {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'userData': userData,
      };
    }
    return null;
  }

  // Generic data storage methods
  static Future<void> storeData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getStoredData(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }
}
