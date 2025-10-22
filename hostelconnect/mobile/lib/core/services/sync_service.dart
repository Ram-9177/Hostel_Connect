import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_database.dart';
import '../constants/app_constants.dart';
import '../auth/auth_service.dart';

class SyncService {
  static const String baseUrl = AppConstants.baseUrl;
  static const String apiVersion = AppConstants.apiVersion;
  
  static String get _baseApiUrl => '$baseUrl$apiVersion';

  // Headers
  static Map<String, String> _getAuthHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Check connectivity
  static Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Full sync from server
  static Future<bool> syncFromServer() async {
    try {
      if (!await isOnline()) {
        return false;
      }

      final token = await AuthService.getAccessToken();
      if (token == null) {
        return false;
      }

      final response = await http.get(
        Uri.parse('$_baseApiUrl/sync/full'),
        headers: _getAuthHeaders(token),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final serverData = jsonDecode(response.body);
        await OfflineDatabase.syncFromServer(serverData);
        return true;
      }

      return false;
    } catch (e) {
      print('Sync from server error: $e');
      return false;
    }
  }

  // Sync dirty records to server
  static Future<bool> syncToServer() async {
    try {
      if (!await isOnline()) {
        return false;
      }

      final token = await AuthService.getAccessToken();
      if (token == null) {
        return false;
      }

      // Get all dirty records
      final dirtyRecords = <String, List<Map<String, dynamic>>>{};
      final tables = [
        OfflineDatabase.tableUsers,
        OfflineDatabase.tableStudents,
        OfflineDatabase.tableHostels,
        OfflineDatabase.tableRooms,
        OfflineDatabase.tableGatePasses,
        OfflineDatabase.tableAttendance,
        OfflineDatabase.tableMeals,
        OfflineDatabase.tableNotices,
      ];

      for (final table in tables) {
        final records = await OfflineDatabase.getDirtyRecords(table);
        if (records.isNotEmpty) {
          dirtyRecords[table] = records;
        }
      }

      if (dirtyRecords.isEmpty) {
        return true; // Nothing to sync
      }

      // Send dirty records to server
      final response = await http.post(
        Uri.parse('$_baseApiUrl/sync/dirty'),
        headers: _getAuthHeaders(token),
        body: jsonEncode(dirtyRecords),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        
        // Mark synced records as clean
        for (final table in dirtyRecords.keys) {
          final recordIds = dirtyRecords[table]!.map((r) => r['id'] as String).toList();
          await OfflineDatabase.markRecordsAsSynced(table, recordIds);
        }

        return true;
      }

      return false;
    } catch (e) {
      print('Sync to server error: $e');
      return false;
    }
  }

  // Process sync queue
  static Future<bool> processSyncQueue() async {
    try {
      if (!await isOnline()) {
        return false;
      }

      final token = await AuthService.getAccessToken();
      if (token == null) {
        return false;
      }

      final syncItems = await OfflineDatabase.getSyncQueue(limit: 10);
      if (syncItems.isEmpty) {
        return true;
      }

      bool allSuccessful = true;

      for (final item in syncItems) {
        try {
          final success = await _processSyncItem(item, token);
          if (success) {
            await OfflineDatabase.markSyncItemCompleted(item['id']);
          } else {
            await OfflineDatabase.markSyncItemFailed(item['id'], 'Sync failed');
            allSuccessful = false;
          }
        } catch (e) {
          await OfflineDatabase.markSyncItemFailed(item['id'], e.toString());
          allSuccessful = false;
        }
      }

      return allSuccessful;
    } catch (e) {
      print('Process sync queue error: $e');
      return false;
    }
  }

  static Future<bool> _processSyncItem(Map<String, dynamic> item, String token) async {
    final tableName = item['tableName'] as String;
    final recordId = item['recordId'] as String;
    final action = item['action'] as String;
    final data = jsonDecode(item['data'] as String) as Map<String, dynamic>;

    String endpoint;
    http.Response response;

    switch (action.toLowerCase()) {
      case 'create':
        endpoint = _getCreateEndpoint(tableName);
        response = await http.post(
          Uri.parse('$_baseApiUrl$endpoint'),
          headers: _getAuthHeaders(token),
          body: jsonEncode(data),
        );
        break;

      case 'update':
        endpoint = _getUpdateEndpoint(tableName);
        response = await http.put(
          Uri.parse('$_baseApiUrl$endpoint/$recordId'),
          headers: _getAuthHeaders(token),
          body: jsonEncode(data),
        );
        break;

      case 'delete':
        endpoint = _getDeleteEndpoint(tableName);
        response = await http.delete(
          Uri.parse('$_baseApiUrl$endpoint/$recordId'),
          headers: _getAuthHeaders(token),
        );
        break;

      default:
        return false;
    }

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  static String _getCreateEndpoint(String tableName) {
    switch (tableName) {
      case OfflineDatabase.tableUsers:
        return '/users';
      case OfflineDatabase.tableStudents:
        return '/students';
      case OfflineDatabase.tableHostels:
        return '/hostels';
      case OfflineDatabase.tableRooms:
        return '/rooms';
      case OfflineDatabase.tableGatePasses:
        return '/gatepass';
      case OfflineDatabase.tableAttendance:
        return '/attendance';
      case OfflineDatabase.tableMeals:
        return '/meals';
      case OfflineDatabase.tableNotices:
        return '/notices';
      default:
        return '/sync';
    }
  }

  static String _getUpdateEndpoint(String tableName) {
    return _getCreateEndpoint(tableName);
  }

  static String _getDeleteEndpoint(String tableName) {
    return _getCreateEndpoint(tableName);
  }

  // Background sync
  static Future<void> backgroundSync() async {
    try {
      // Process sync queue first
      await processSyncQueue();
      
      // Then sync from server
      await syncFromServer();
    } catch (e) {
      print('Background sync error: $e');
    }
  }

  // Force sync all data
  static Future<bool> forceSyncAll() async {
    try {
      if (!await isOnline()) {
        return false;
      }

      // Clear local data
      await OfflineDatabase.clearAllData();
      
      // Sync from server
      return await syncFromServer();
    } catch (e) {
      print('Force sync all error: $e');
      return false;
    }
  }

  // Get sync status
  static Future<Map<String, dynamic>> getSyncStatus() async {
    try {
      final recordCounts = await OfflineDatabase.getRecordCounts();
      final syncQueue = await OfflineDatabase.getSyncQueue();
      final isOnlineStatus = await isOnline();
      final databaseSize = await OfflineDatabase.getDatabaseSize();

      return {
        'isOnline': isOnlineStatus,
        'databaseSize': databaseSize,
        'recordCounts': recordCounts,
        'pendingSyncItems': syncQueue.length,
        'lastSyncAt': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'isOnline': false,
        'error': e.toString(),
      };
    }
  }

  // Conflict resolution
  static Future<void> resolveConflict(String tableName, String recordId, Map<String, dynamic> serverData) async {
    try {
      // Use server data as source of truth
      await OfflineDatabase.insert(tableName, {
        ...serverData,
        'isDirty': 0,
        'lastSyncAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Conflict resolution error: $e');
    }
  }

  // Cleanup old data
  static Future<void> cleanupOldData({int daysToKeep = 30}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));
      final cutoffString = cutoffDate.toIso8601String();

      // Clean up old attendance records
      await OfflineDatabase.delete(
        OfflineDatabase.tableAttendance,
        'createdAt < ?',
        [cutoffString],
      );

      // Clean up old notices
      await OfflineDatabase.delete(
        OfflineDatabase.tableNotices,
        'expiresAt < ?',
        [cutoffString],
      );

      // Clean up completed sync queue items
      await OfflineDatabase.delete(
        OfflineDatabase.tableSyncQueue,
        'status = ? AND createdAt < ?',
        ['completed', cutoffString],
      );
    } catch (e) {
      print('Cleanup old data error: $e');
    }
  }
}
