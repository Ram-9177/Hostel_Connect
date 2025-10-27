import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Lightweight offline storage service with optimized performance
class OfflineStorageService {
  static const String _gatePassesKey = 'offline_gate_passes';
  static const String _emergencyRequestsKey = 'offline_emergency_requests';
  static const String _syncQueueKey = 'sync_queue';
  static const String _lastSyncKey = 'last_sync_timestamp';
  
  // Cache for better performance
  static SharedPreferences? _prefs;
  static bool? _isOnlineCache;
  static DateTime? _lastConnectivityCheck;

  /// Get SharedPreferences instance with caching
  static Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Optimized connectivity check with caching
  static Future<bool> isOnline() async {
    final now = DateTime.now();
    
    // Use cache if checked within last 5 seconds
    if (_isOnlineCache != null && 
        _lastConnectivityCheck != null && 
        now.difference(_lastConnectivityCheck!).inSeconds < 5) {
      return _isOnlineCache!;
    }

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      _isOnlineCache = connectivityResult != ConnectivityResult.none;
      _lastConnectivityCheck = now;
      return _isOnlineCache!;
    } catch (e) {
      _isOnlineCache = false;
      _lastConnectivityCheck = now;
      return false;
    }
  }

  /// Store gate pass application offline with optimized JSON handling
  static Future<void> storeGatePassOffline(Map<String, dynamic> gatePass) async {
    try {
      final prefs = await _prefsInstance;
      final existingData = prefs.getString(_gatePassesKey) ?? '[]';
      
      // Parse existing data
        final List<dynamic> gatePasses = jsonDecode(existingData);
      
      // Add offline metadata
        final Map<String, dynamic> offlineEntry = {
          ...gatePass,
          'id': 'offline_${DateTime.now().millisecondsSinceEpoch}',
          'isOffline': true,
          'createdAt': DateTime.now().toIso8601String(),
          'syncStatus': 'PENDING',
          'lastError': null,
        };
      
        gatePasses.add(offlineEntry);
      
      // Store with compression consideration
      await prefs.setString(_gatePassesKey, jsonEncode(gatePasses));
      
      // Add to sync queue
        await _addToSyncQueue('gate_pass', offlineEntry);
      
    } catch (e) {
      print('Error storing gate pass offline: $e');
    }
  }

  /// Store emergency request offline with optimized JSON handling
  static Future<void> storeEmergencyRequestOffline(Map<String, dynamic> request) async {
    try {
      final prefs = await _prefsInstance;
      final existingData = prefs.getString(_emergencyRequestsKey) ?? '[]';
      
      // Parse existing data
        final List<dynamic> requests = jsonDecode(existingData);
      
        // Add offline metadata
        final Map<String, dynamic> offlineEntry = {
          ...request,
          'id': 'offline_${DateTime.now().millisecondsSinceEpoch}',
          'isOffline': true,
          'createdAt': DateTime.now().toIso8601String(),
          'syncStatus': 'PENDING',
          'lastError': null,
        };
      
        requests.add(offlineEntry);
      
      // Store with compression consideration
      await prefs.setString(_emergencyRequestsKey, jsonEncode(requests));
      
      // Add to sync queue
        await _addToSyncQueue('emergency_request', offlineEntry);
      
    } catch (e) {
      print('Error storing emergency request offline: $e');
    }
  }

  /// Get offline gate passes with caching
  static Future<List<Map<String, dynamic>>> getOfflineGatePasses() async {
    try {
      final prefs = await _prefsInstance;
      final data = prefs.getString(_gatePassesKey) ?? '[]';
        final List<dynamic> gatePasses = jsonDecode(data);
        return gatePasses
            .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
            .toList();
    } catch (e) {
      print('Error getting offline gate passes: $e');
      return [];
    }
  }

  /// Get offline emergency requests with caching
  static Future<List<Map<String, dynamic>>> getOfflineEmergencyRequests() async {
    try {
      final prefs = await _prefsInstance;
      final data = prefs.getString(_emergencyRequestsKey) ?? '[]';
        final List<dynamic> requests = jsonDecode(data);
        return requests
            .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
            .toList();
    } catch (e) {
      print('Error getting offline emergency requests: $e');
      return [];
    }
  }

  /// Add item to sync queue with optimized storage
  static Future<void> _addToSyncQueue(String type, Map<String, dynamic> data) async {
    try {
      final prefs = await _prefsInstance;
      final existingQueue = prefs.getString(_syncQueueKey) ?? '[]';
      final List<dynamic> queue = jsonDecode(existingQueue);
      
        queue.add({
          'type': type,
          'data': data,
          'timestamp': DateTime.now().toIso8601String(),
          'retryCount': 0,
          'lastError': null,
        });
      
      await prefs.setString(_syncQueueKey, jsonEncode(queue));
    } catch (e) {
      print('Error adding to sync queue: $e');
    }
  }

  /// Get sync queue with optimized parsing
  static Future<List<Map<String, dynamic>>> getSyncQueue() async {
    try {
      final prefs = await _prefsInstance;
      final data = prefs.getString(_syncQueueKey) ?? '[]';
      final List<dynamic> queue = jsonDecode(data);
      return queue.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error getting sync queue: $e');
      return [];
    }
  }

  /// Remove item from sync queue with optimized operations
  static Future<void> removeFromSyncQueue(String itemId) async {
    try {
      final prefs = await _prefsInstance;
      final existingQueue = prefs.getString(_syncQueueKey) ?? '[]';
      final List<dynamic> queue = jsonDecode(existingQueue);
      
      // Use removeWhere for better performance
      queue.removeWhere((item) => item['data']['id'] == itemId);
      
      await prefs.setString(_syncQueueKey, jsonEncode(queue));
    } catch (e) {
      print('Error removing from sync queue: $e');
    }
  }

  /// Update retry count with optimized operations
  static Future<void> updateRetryCount(String itemId, int retryCount, {String? errorMessage}) async {
    try {
      final prefs = await _prefsInstance;
      final existingQueue = prefs.getString(_syncQueueKey) ?? '[]';
      final List<dynamic> queue = jsonDecode(existingQueue);
      
      // Find and update item
      for (int i = 0; i < queue.length; i++) {
        if (queue[i]['data']['id'] == itemId) {
          queue[i]['retryCount'] = retryCount;
          queue[i]['lastError'] = errorMessage;
          break;
        }
      }
      
      await prefs.setString(_syncQueueKey, jsonEncode(queue));
    } catch (e) {
      print('Error updating retry count: $e');
    }
  }

    static Future<void> markItemSynced(String type, String itemId) async {
      final key = _storageKeyForType(type);
      if (key == null) return;

      try {
        final prefs = await _prefsInstance;
        final existingData = prefs.getString(key) ?? '[]';
        final List<dynamic> items = jsonDecode(existingData);
        items.removeWhere((item) => item['id'] == itemId);
        await prefs.setString(key, jsonEncode(items));
      } catch (e) {
        print('Error marking $type item synced: $e');
      }
    }

    static Future<void> markItemFailed({
      required String type,
      required String itemId,
      required int statusCode,
      String? message,
    }) async {
      final key = _storageKeyForType(type);
      if (key == null) return;

      try {
        final prefs = await _prefsInstance;
        final existingData = prefs.getString(key) ?? '[]';
        final List<dynamic> items = jsonDecode(existingData);

        for (int i = 0; i < items.length; i++) {
          final item = Map<String, dynamic>.from(items[i]);
          if (item['id'] == itemId) {
            item['syncStatus'] = 'FAILED';
            item['lastError'] = message ?? 'HTTP $statusCode';
            item['failedAt'] = DateTime.now().toIso8601String();
            items[i] = item;
            break;
          }
        }

        await prefs.setString(key, jsonEncode(items));
      } catch (e) {
        print('Error marking $type item failed: $e');
      }
    }

    static Future<void> resetFailureState(String type, String itemId) async {
      final key = _storageKeyForType(type);
      if (key == null) return;

      try {
        final prefs = await _prefsInstance;
        final existingData = prefs.getString(key) ?? '[]';
        final List<dynamic> items = jsonDecode(existingData);

        for (int i = 0; i < items.length; i++) {
          final item = Map<String, dynamic>.from(items[i]);
          if (item['id'] == itemId) {
            item['syncStatus'] = 'PENDING';
            item['lastError'] = null;
            item.remove('failedAt');
            items[i] = item;
            break;
          }
        }

        await prefs.setString(key, jsonEncode(items));
      } catch (e) {
        print('Error resetting failure state for $type: $e');
      }
    }

    static String? _storageKeyForType(String type) {
      switch (type) {
        case 'gate_pass':
          return _gatePassesKey;
        case 'emergency_request':
          return _emergencyRequestsKey;
        default:
          return null;
      }
    }

  /// Get connectivity stream with optimized handling
  static Stream<ConnectivityResult> get connectivityStream {
    return Connectivity().onConnectivityChanged;
  }

  /// Set last sync timestamp with optimized storage
  static Future<void> setLastSyncTimestamp() async {
    try {
      final prefs = await _prefsInstance;
      await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());
    } catch (e) {
      print('Error setting last sync timestamp: $e');
    }
  }

  /// Get last sync timestamp with optimized parsing
  static Future<DateTime?> getLastSyncTimestamp() async {
    try {
      final prefs = await _prefsInstance;
      final timestamp = prefs.getString(_lastSyncKey);
      return timestamp != null ? DateTime.parse(timestamp) : null;
    } catch (e) {
      print('Error getting last sync timestamp: $e');
      return null;
    }
  }

  /// Clear offline data with optimized operations
  static Future<void> clearOfflineData() async {
    try {
      final prefs = await _prefsInstance;
      await Future.wait([
        prefs.remove(_gatePassesKey),
        prefs.remove(_emergencyRequestsKey),
        prefs.remove(_syncQueueKey),
      ]);
      print('Offline data cleared after successful sync');
    } catch (e) {
      print('Error clearing offline data: $e');
    }
  }

  /// Get offline data count with optimized operations
  static Future<Map<String, int>> getOfflineDataCount() async {
    try {
      final results = await Future.wait([
        getOfflineGatePasses(),
        getOfflineEmergencyRequests(),
        getSyncQueue(),
      ]);
      
      return {
        'gatePasses': results[0].length,
        'emergencyRequests': results[1].length,
        'syncQueue': results[2].length,
      };
    } catch (e) {
      print('Error getting offline data count: $e');
      return {'gatePasses': 0, 'emergencyRequests': 0, 'syncQueue': 0};
    }
  }

  /// Clear cache for memory optimization
  static void clearCache() {
    _prefs = null;
    _isOnlineCache = null;
    _lastConnectivityCheck = null;
  }
}