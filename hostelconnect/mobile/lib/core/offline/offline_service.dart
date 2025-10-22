// lib/core/offline/offline_service.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OfflineService {
  static const _storage = FlutterSecureStorage();
  static const String _offlineQueueKey = 'offline_queue';
  static const String _lastSyncKey = 'last_sync';

  // Offline state provider
  static final offlineStateProvider = StateNotifierProvider<OfflineNotifier, OfflineState>((ref) {
    return OfflineNotifier();
  });

  // Queue action for offline execution
  static Future<void> queueAction({
    required String type,
    required Map<String, dynamic> data,
    String? id,
  }) async {
    try {
      final queue = await _getOfflineQueue();
      final action = {
        'id': id ?? 'action_${DateTime.now().millisecondsSinceEpoch}',
        'type': type,
        'data': data,
        'timestamp': DateTime.now().toIso8601String(),
        'retryCount': 0,
      };
      
      queue.add(action);
      await _saveOfflineQueue(queue);
    } catch (e) {
      print('Error queueing offline action: $e');
    }
  }

  // Get offline queue
  static Future<List<Map<String, dynamic>>> _getOfflineQueue() async {
    try {
      final queueData = await _storage.read(key: _offlineQueueKey);
      if (queueData != null) {
        final List<dynamic> queue = jsonDecode(queueData);
        return queue.cast<Map<String, dynamic>>();
      }
    } catch (e) {
      print('Error reading offline queue: $e');
    }
    return [];
  }

  // Save offline queue
  static Future<void> _saveOfflineQueue(List<Map<String, dynamic>> queue) async {
    try {
      await _storage.write(key: _offlineQueueKey, value: jsonEncode(queue));
    } catch (e) {
      print('Error saving offline queue: $e');
    }
  }

  // Process offline queue when online
  static Future<void> processOfflineQueue() async {
    try {
      final queue = await _getOfflineQueue();
      if (queue.isEmpty) return;

      final processedActions = <String>[];
      
      for (final action in queue) {
        try {
          final success = await _executeAction(action);
          if (success) {
            processedActions.add(action['id']);
          } else {
            // Increment retry count
            action['retryCount'] = (action['retryCount'] ?? 0) + 1;
            
            // Remove if retry count exceeds limit
            if (action['retryCount'] > 3) {
              processedActions.add(action['id']);
            }
          }
        } catch (e) {
          print('Error executing offline action: $e');
          action['retryCount'] = (action['retryCount'] ?? 0) + 1;
          
          if (action['retryCount'] > 3) {
            processedActions.add(action['id']);
          }
        }
      }

      // Remove processed actions
      queue.removeWhere((action) => processedActions.contains(action['id']));
      await _saveOfflineQueue(queue);
      
      // Update last sync time
      await _storage.write(key: _lastSyncKey, value: DateTime.now().toIso8601String());
      
    } catch (e) {
      print('Error processing offline queue: $e');
    }
  }

  // Execute individual action
  static Future<bool> _executeAction(Map<String, dynamic> action) async {
    try {
      switch (action['type']) {
        case 'mark_notice_read':
          // TODO: Implement actual API call
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'register_device':
          // TODO: Implement actual API call
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'attendance_scan':
          // TODO: Implement actual API call
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'meal_booking':
          // TODO: Implement actual API call
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'gate_pass_request':
          // TODO: Implement actual API call
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        default:
          return false;
      }
    } catch (e) {
      print('Error executing action ${action['type']}: $e');
      return false;
    }
  }

  // Get queue size
  static Future<int> getQueueSize() async {
    final queue = await _getOfflineQueue();
    return queue.length;
  }

  // Clear queue
  static Future<void> clearQueue() async {
    await _storage.delete(key: _offlineQueueKey);
  }

  // Get last sync time
  static Future<DateTime?> getLastSyncTime() async {
    try {
      final lastSync = await _storage.read(key: _lastSyncKey);
      if (lastSync != null) {
        return DateTime.parse(lastSync);
      }
    } catch (e) {
      print('Error reading last sync time: $e');
    }
    return null;
  }
}

// Offline state notifier
class OfflineNotifier extends StateNotifier<OfflineState> {
  OfflineNotifier() : super(OfflineState.initial()) {
    _initializeConnectivity();
  }

  void _initializeConnectivity() async {
    // Check initial connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> results) {
    final isOnline = results.any((result) => 
        result == ConnectivityResult.mobile || 
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet);

    state = state.copyWith(
      isOnline: isOnline,
      lastChecked: DateTime.now(),
    );

    // Process offline queue when coming online
    if (isOnline && !state.wasOnline) {
      OfflineService.processOfflineQueue();
    }
  }

  Future<void> processOfflineQueue() async {
    state = state.copyWith(isProcessingQueue: true);
    
    try {
      await OfflineService.processOfflineQueue();
      final queueSize = await OfflineService.getQueueSize();
      state = state.copyWith(
        queueSize: queueSize,
        isProcessingQueue: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessingQueue: false,
        lastError: e.toString(),
      );
    }
  }

  Future<void> clearOfflineQueue() async {
    await OfflineService.clearQueue();
    state = state.copyWith(queueSize: 0);
  }

  Future<void> queueAction({
    required String type,
    required Map<String, dynamic> data,
    String? id,
  }) async {
    await OfflineService.queueAction(
      type: type,
      data: data,
      id: id,
    );
    
    final queueSize = await OfflineService.getQueueSize();
    state = state.copyWith(queueSize: queueSize);
  }
}

// Offline state
class OfflineState {
  final bool isOnline;
  final bool wasOnline;
  final DateTime lastChecked;
  final int queueSize;
  final bool isProcessingQueue;
  final String? lastError;

  const OfflineState({
    required this.isOnline,
    required this.wasOnline,
    required this.lastChecked,
    required this.queueSize,
    required this.isProcessingQueue,
    this.lastError,
  });

  factory OfflineState.initial() {
    return OfflineState(
      isOnline: true,
      wasOnline: true,
      lastChecked: DateTime.now(),
      queueSize: 0,
      isProcessingQueue: false,
    );
  }

  OfflineState copyWith({
    bool? isOnline,
    bool? wasOnline,
    DateTime? lastChecked,
    int? queueSize,
    bool? isProcessingQueue,
    String? lastError,
  }) {
    return OfflineState(
      isOnline: isOnline ?? this.isOnline,
      wasOnline: wasOnline ?? this.wasOnline,
      lastChecked: lastChecked ?? this.lastChecked,
      queueSize: queueSize ?? this.queueSize,
      isProcessingQueue: isProcessingQueue ?? this.isProcessingQueue,
      lastError: lastError ?? this.lastError,
    );
  }
}
