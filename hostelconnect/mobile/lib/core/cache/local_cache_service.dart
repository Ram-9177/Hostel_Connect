// lib/core/cache/local_cache_service.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../state/load_state.dart';

// Local cache service provider
final localCacheServiceProvider = Provider<LocalCacheService>((ref) {
  return LocalCacheService();
});

class LocalCacheService {
  static const String _cachePrefix = 'hostelconnect_cache_';
  static const Duration _defaultExpiry = Duration(hours: 24);

  // Cache a data object with optional expiry
  Future<void> cacheData<T>(
    String key,
    T data, {
    Duration? expiry,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheData = CacheData<T>(
        data: data,
        timestamp: DateTime.now(),
        expiry: expiry ?? _defaultExpiry,
      );
      
      final jsonString = jsonEncode(cacheData.toJson());
      await prefs.setString('$_cachePrefix$key', jsonString);
    } catch (e) {
      print('Failed to cache data for key $key: $e');
    }
  }

  // Retrieve cached data
  Future<T?> getCachedData<T>(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('$_cachePrefix$key');
      
      if (jsonString == null) return null;
      
      final cacheData = CacheData<T>.fromJson(jsonDecode(jsonString));
      
      // Check if data is expired
      if (cacheData.isExpired) {
        await removeCachedData(key);
        return null;
      }
      
      return cacheData.data;
    } catch (e) {
      print('Failed to get cached data for key $key: $e');
      return null;
    }
  }

  // Remove cached data
  Future<void> removeCachedData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('$_cachePrefix$key');
    } catch (e) {
      print('Failed to remove cached data for key $key: $e');
    }
  }

  // Clear all cached data
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
      
      for (final key in keys) {
        await prefs.remove(key);
      }
    } catch (e) {
      print('Failed to clear all cache: $e');
    }
  }

  // Get cache size info
  Future<CacheInfo> getCacheInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
      
      int totalItems = 0;
      int expiredItems = 0;
      int totalSize = 0;
      
      for (final key in keys) {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          totalItems++;
          totalSize += jsonString.length;
          
          try {
            final cacheData = CacheData.fromJson(jsonDecode(jsonString));
            if (cacheData.isExpired) {
              expiredItems++;
            }
          } catch (e) {
            // Invalid cache data
            expiredItems++;
          }
        }
      }
      
      return CacheInfo(
        totalItems: totalItems,
        expiredItems: expiredItems,
        totalSize: totalSize,
      );
    } catch (e) {
      print('Failed to get cache info: $e');
      return CacheInfo(totalItems: 0, expiredItems: 0, totalSize: 0);
    }
  }

  // Clean expired cache entries
  Future<void> cleanExpiredCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
      
      for (final key in keys) {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          try {
            final cacheData = CacheData.fromJson(jsonDecode(jsonString));
            if (cacheData.isExpired) {
              await prefs.remove(key);
            }
          } catch (e) {
            // Invalid cache data, remove it
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      print('Failed to clean expired cache: $e');
    }
  }
}

// Cache data wrapper
class CacheData<T> {
  final T data;
  final DateTime timestamp;
  final Duration expiry;

  const CacheData({
    required this.data,
    required this.timestamp,
    required this.expiry,
  });

  bool get isExpired {
    return DateTime.now().difference(timestamp) > expiry;
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'expiry': expiry.inMilliseconds,
    };
  }

  factory CacheData.fromJson(Map<String, dynamic> json) {
    return CacheData<T>(
      data: json['data'],
      timestamp: DateTime.parse(json['timestamp']),
      expiry: Duration(milliseconds: json['expiry']),
    );
  }
}

// Cache info
class CacheInfo {
  final int totalItems;
  final int expiredItems;
  final int totalSize;

  const CacheInfo({
    required this.totalItems,
    required this.expiredItems,
    required this.totalSize,
  });

  int get validItems => totalItems - expiredItems;
  String get formattedSize {
    if (totalSize < 1024) return '${totalSize}B';
    if (totalSize < 1024 * 1024) return '${(totalSize / 1024).toStringAsFixed(1)}KB';
    return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}

// Cache keys constants
class CacheKeys {
  static const String userProfile = 'user_profile';
  static const String notices = 'notices';
  static const String gatepasses = 'gatepasses';
  static const String attendances = 'attendances';
  static const String meals = 'meals';
  static const String hostels = 'hostels';
  static const String blocks = 'blocks';
  static const String rooms = 'rooms';
  static const String reports = 'reports';
  static const String attendanceStats = 'attendance_stats';
  static const String mealPlan = 'meal_plan';
  static const String roomMap = 'room_map';
  static const String reportStats = 'report_stats';
}

// Cache expiry constants
class CacheExpiry {
  static const Duration userProfile = Duration(hours: 24);
  static const Duration notices = Duration(hours: 1);
  static const Duration gatepasses = Duration(minutes: 30);
  static const Duration attendances = Duration(hours: 2);
  static const Duration meals = Duration(hours: 1);
  static const Duration hostels = Duration(hours: 12);
  static const Duration blocks = Duration(hours: 6);
  static const Duration rooms = Duration(hours: 2);
  static const Duration reports = Duration(hours: 24);
  static const Duration stats = Duration(hours: 1);
  static const Duration roomMap = Duration(hours: 4);
}
