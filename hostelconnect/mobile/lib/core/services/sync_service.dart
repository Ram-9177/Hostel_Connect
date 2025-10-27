import 'dart:convert';
import 'package:http/http.dart' as http;
import 'offline_storage_service.dart';

/// Lightweight sync service with optimized performance and error handling
class SyncService {
  static const String apiBaseUrl = 'http://10.17.134.33:3000/api/v1';
  
  // Cache for better performance
  static bool _isSyncing = false;
  static DateTime? _lastSyncAttempt;
  
  /// Sync all offline data with optimized operations
  static Future<Map<String, dynamic>> syncAllOfflineData() async {
    // Prevent concurrent syncs
    if (_isSyncing) {
      return {
        'error': 'Sync already in progress',
        'isOnline': await OfflineStorageService.isOnline(),
      };
    }

    _isSyncing = true;
    _lastSyncAttempt = DateTime.now();

    final results = {
      'gatePasses': {'success': 0, 'failed': 0},
      'emergencyRequests': {'success': 0, 'failed': 0},
      'totalSynced': 0,
      'totalFailed': 0,
    };

    try {
      // Check if online with caching
      if (!await OfflineStorageService.isOnline()) {
        return {
          ...results,
          'error': 'No internet connection available',
          'isOnline': false,
        };
      }

      // Sync gate passes and emergency requests in parallel
      final syncResults = await Future.wait([
        _syncGatePasses(),
        _syncEmergencyRequests(),
      ]);

      results['gatePasses'] = syncResults[0];
      results['emergencyRequests'] = syncResults[1];

      // Calculate totals
      results['totalSynced'] = (syncResults[0]['success'] as int) + (syncResults[1]['success'] as int);
      results['totalFailed'] = (syncResults[0]['failed'] as int) + (syncResults[1]['failed'] as int);

      // Update last sync timestamp if successful
      if ((results['totalSynced'] as int) > 0) {
        await OfflineStorageService.setLastSyncTimestamp();
      }

      // Clear offline data if all synced successfully
      if ((results['totalFailed'] as int) == 0 && (results['totalSynced'] as int) > 0) {
        await OfflineStorageService.clearOfflineData();
      }

      results['isOnline'] = true;
      return results;

    } catch (e) {
      print('Error syncing offline data: $e');
      return {
        ...results,
        'error': 'Sync failed: $e',
        'isOnline': await OfflineStorageService.isOnline(),
      };
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync gate passes with optimized HTTP operations
  static Future<Map<String, int>> _syncGatePasses() async {
    int success = 0;
    int failed = 0;

    try {
      final offlineGatePasses = (await OfflineStorageService.getOfflineGatePasses())
          .where((pass) => (pass['syncStatus'] ?? 'PENDING') != 'FAILED')
          .toList();
      
      // Process in batches for better performance
      const batchSize = 5;
      for (int i = 0; i < offlineGatePasses.length; i += batchSize) {
        final batch = offlineGatePasses.skip(i).take(batchSize);
        
        final batchResults = await Future.wait(
          batch.map((gatePass) => _syncSingleGatePass(gatePass)),
        );
        
        for (int i = 0; i < batchResults.length; i++) {
          final result = batchResults[i];
          final gatePass = batch.elementAt(i);
          if (result['success']) {
            success++;
            await OfflineStorageService.removeFromSyncQueue(gatePass['id']);
            await OfflineStorageService.markItemSynced('gate_pass', gatePass['id']);
          } else {
            failed++;
            await _handleSyncFailure(
              gatePass['id'],
              result['statusCode'],
              'gate_pass',
              errorMessage: result['error'] as String?,
            );
          }
        }
      }
    } catch (e) {
      print('Error in gate pass sync: $e');
    }

    return {'success': success, 'failed': failed};
  }

  /// Sync emergency requests with optimized HTTP operations
  static Future<Map<String, int>> _syncEmergencyRequests() async {
    int success = 0;
    int failed = 0;

    try {
      final offlineRequests = (await OfflineStorageService.getOfflineEmergencyRequests())
          .where((request) => (request['syncStatus'] ?? 'PENDING') != 'FAILED')
          .toList();
      
      // Process in batches for better performance
      const batchSize = 5;
      for (int i = 0; i < offlineRequests.length; i += batchSize) {
        final batch = offlineRequests.skip(i).take(batchSize);
        
        final batchResults = await Future.wait(
          batch.map((request) => _syncSingleEmergencyRequest(request)),
        );
        
        for (int i = 0; i < batchResults.length; i++) {
          final result = batchResults[i];
          final request = batch.elementAt(i);
          if (result['success']) {
            success++;
            await OfflineStorageService.removeFromSyncQueue(request['id']);
            await OfflineStorageService.markItemSynced('emergency_request', request['id']);
          } else {
            failed++;
            await _handleSyncFailure(
              request['id'],
              result['statusCode'],
              'emergency_request',
              errorMessage: result['error'] as String?,
            );
          }
        }
      }
    } catch (e) {
      print('Error in emergency request sync: $e');
    }

    return {'success': success, 'failed': failed};
  }

  /// Sync single gate pass with optimized error handling
  static Future<Map<String, dynamic>> _syncSingleGatePass(Map<String, dynamic> gatePass) async {
    try {
      // Remove offline-specific fields
      final cleanData = Map<String, dynamic>.from(gatePass);
      cleanData.remove('isOffline');
      cleanData.remove('id'); // Let server generate new ID
      
      final response = await http.post(
        Uri.parse('$apiBaseUrl/gate-pass-applications'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(cleanData),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 201) {
        print('Gate pass synced successfully: ${gatePass['id']}');
        return {'success': true, 'statusCode': response.statusCode};
      } else {
        print('Failed to sync gate pass: ${gatePass['id']}, Status: ${response.statusCode}');
        return {
          'success': false,
          'statusCode': response.statusCode,
          'error': response.body,
        };
      }
    } catch (e) {
      print('Error syncing gate pass ${gatePass['id']}: $e');
      return {'success': false, 'statusCode': 0, 'error': e.toString()};
    }
  }

  /// Sync single emergency request with optimized error handling
  static Future<Map<String, dynamic>> _syncSingleEmergencyRequest(Map<String, dynamic> request) async {
    try {
      // Remove offline-specific fields
      final cleanData = Map<String, dynamic>.from(request);
      cleanData.remove('isOffline');
      cleanData.remove('id'); // Let server generate new ID
      
      final response = await http.post(
        Uri.parse('$apiBaseUrl/emergency-requests'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(cleanData),
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 201) {
        print('Emergency request synced successfully: ${request['id']}');
        return {'success': true, 'statusCode': response.statusCode};
      } else {
        print('Failed to sync emergency request: ${request['id']}, Status: ${response.statusCode}');
        return {
          'success': false,
          'statusCode': response.statusCode,
          'error': response.body,
        };
      }
    } catch (e) {
      print('Error syncing emergency request ${request['id']}: $e');
      return {'success': false, 'statusCode': 0, 'error': e.toString()};
    }
  }

  /// Handle sync failure with optimized retry logic
  static Future<void> _handleSyncFailure(
    String itemId,
    int statusCode,
    String itemType, {
    String? errorMessage,
  }) async {
    try {
      final queue = await OfflineStorageService.getSyncQueue();
      final index = queue.indexWhere((item) => item['data']['id'] == itemId);
      final isClientError = statusCode >= 400 && statusCode < 500 && statusCode != 408;
      final shouldStopRetry = isClientError;

      if (index >= 0) {
        int retryCount = (queue[index]['retryCount'] ?? 0) + 1;
        if (shouldStopRetry || retryCount > 3) {
          await OfflineStorageService.removeFromSyncQueue(itemId);
          await OfflineStorageService.markItemFailed(
            type: itemType,
            itemId: itemId,
            statusCode: statusCode,
            message: errorMessage,
          );
          print('Marked $itemType $itemId as failed (status: $statusCode)');
        } else {
          await OfflineStorageService.updateRetryCount(
            itemId,
            retryCount,
            errorMessage: errorMessage ?? 'HTTP $statusCode',
          );
          print('Retry $retryCount scheduled for $itemType $itemId');
        }
      } else if (shouldStopRetry) {
        await OfflineStorageService.markItemFailed(
          type: itemType,
          itemId: itemId,
          statusCode: statusCode,
          message: errorMessage,
        );
      }
    } catch (e) {
      print('Error handling sync failure: $e');
    }
  }

  /// Manual sync trigger with optimized operations
  static Future<Map<String, dynamic>> manualSync() async {
    print('Manual sync triggered');
    return await syncAllOfflineData();
  }

  /// Get sync status with optimized operations
  static Future<Map<String, dynamic>> getSyncStatus() async {
    try {
      final results = await Future.wait([
        OfflineStorageService.isOnline(),
        OfflineStorageService.getOfflineDataCount(),
        OfflineStorageService.getLastSyncTimestamp(),
      ]);
      
      return {
        'isOnline': results[0],
        'offlineDataCount': results[1],
        'lastSync': (results[2] as DateTime?)?.toIso8601String(),
        'hasOfflineData': (results[1] as Map<String, int>)['syncQueue']! > 0,
        'isSyncing': _isSyncing,
        'lastSyncAttempt': _lastSyncAttempt?.toIso8601String(),
      };
    } catch (e) {
      print('Error getting sync status: $e');
      return {
        'isOnline': false,
        'offlineDataCount': {'gatePasses': 0, 'emergencyRequests': 0, 'syncQueue': 0},
        'lastSync': null,
        'hasOfflineData': false,
        'isSyncing': false,
        'lastSyncAttempt': null,
        'error': e.toString(),
      };
    }
  }

  /// Background sync with optimized operations
  static Future<void> backgroundSync() async {
    try {
      // Prevent too frequent sync attempts
      if (_lastSyncAttempt != null && 
          DateTime.now().difference(_lastSyncAttempt!).inMinutes < 2) {
        return;
      }

      final isOnline = await OfflineStorageService.isOnline();
      if (isOnline) {
        final dataCount = await OfflineStorageService.getOfflineDataCount();
        if (dataCount['syncQueue']! > 0) {
          print('Background sync started - ${dataCount['syncQueue']} items to sync');
          await syncAllOfflineData();
        }
      }
    } catch (e) {
      print('Background sync error: $e');
    }
  }

  /// Check if sync is in progress
  static bool get isSyncing => _isSyncing;
}