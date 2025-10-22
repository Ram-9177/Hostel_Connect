import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../storage/secure_storage.dart';
import '../network/api_service.dart';

// Performance monitoring
class PerformanceMonitor {
  static final Map<String, DateTime> _startTimes = {};
  static final List<PerformanceMetric> _metrics = [];
  
  static void startTimer(String operation) {
    _startTimes[operation] = DateTime.now();
  }
  
  static void endTimer(String operation) {
    final startTime = _startTimes.remove(operation);
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      _metrics.add(PerformanceMetric(
        operation: operation,
        duration: duration,
        timestamp: DateTime.now(),
      ));
      
      if (kDebugMode) {
        print('Performance: $operation took ${duration.inMilliseconds}ms');
      }
    }
  }
  
  static List<PerformanceMetric> getMetrics() => List.from(_metrics);
  static void clearMetrics() => _metrics.clear();
}

class PerformanceMetric {
  final String operation;
  final Duration duration;
  final DateTime timestamp;
  
  PerformanceMetric({
    required this.operation,
    required this.duration,
    required this.timestamp,
  });
}

// Offline queue management
class OfflineQueue {
  static const String _queueKey = 'offline_queue';
  static const String _maxQueueSize = 'max_queue_size';
  
  static Future<void> addToQueue(OfflineAction action) async {
    final queue = await getQueue();
    queue.add(action);
    
    // Limit queue size to prevent memory issues
    if (queue.length > 100) {
      queue.removeRange(0, queue.length - 100);
    }
    
    await _saveQueue(queue);
  }
  
  static Future<List<OfflineAction>> getQueue() async {
    try {
      final queueData = await SecureTokenStorage.getStoredData(_queueKey);
      if (queueData != null) {
        final List<dynamic> jsonList = jsonDecode(queueData);
        return jsonList.map((json) => OfflineAction.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading offline queue: $e');
    }
    return [];
  }
  
  static Future<void> _saveQueue(List<OfflineAction> queue) async {
    try {
      final jsonList = queue.map((action) => action.toJson()).toList();
      await SecureTokenStorage.storeData(_queueKey, jsonEncode(jsonList));
    } catch (e) {
      print('Error saving offline queue: $e');
    }
  }
  
  static Future<void> processQueue() async {
    final hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) return;
    
    final queue = await getQueue();
    final List<OfflineAction> failedActions = [];
    
    for (final action in queue) {
      try {
        await _executeAction(action);
      } catch (e) {
        print('Failed to execute offline action: $e');
        failedActions.add(action);
      }
    }
    
    // Keep only failed actions
    await _saveQueue(failedActions);
  }
  
  static Future<void> _executeAction(OfflineAction action) async {
    switch (action.type) {
      case 'scan_attendance':
        // TODO: Implement attendance recording
        print('Recording attendance for student: ${action.data['studentId']}');
        break;
      case 'mark_notice_read':
        await ApiService.markNoticeAsRead(action.data['noticeId']);
        break;
      case 'meal_intent':
        // TODO: Implement meal intent setting
        print('Setting meal intent: ${action.data['intendsToEat']}');
        break;
      default:
        throw Exception('Unknown action type: ${action.type}');
    }
  }
  
  static Future<void> clearQueue() async {
    await SecureTokenStorage.deleteData(_queueKey);
  }
}

class OfflineAction {
  final String type;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final int retryCount;
  
  OfflineAction({
    required this.type,
    required this.data,
    required this.timestamp,
    this.retryCount = 0,
  });
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'data': data,
    'timestamp': timestamp.toIso8601String(),
    'retryCount': retryCount,
  };
  
  factory OfflineAction.fromJson(Map<String, dynamic> json) => OfflineAction(
    type: json['type'],
    data: Map<String, dynamic>.from(json['data']),
    timestamp: DateTime.parse(json['timestamp']),
    retryCount: json['retryCount'] ?? 0,
  );
}

// Error handling and recovery
class ErrorHandler {
  static final List<AppError> _errors = [];
  static const int maxErrors = 50;
  
  static void logError(String message, {
    String? details,
    String? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final error = AppError(
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
      timestamp: DateTime.now(),
    );
    
    _errors.add(error);
    
    // Keep only recent errors
    if (_errors.length > maxErrors) {
      _errors.removeRange(0, _errors.length - maxErrors);
    }
    
    if (kDebugMode) {
      print('Error logged: $message');
      if (details != null) print('Details: $details');
    }
  }
  
  static List<AppError> getErrors() => List.from(_errors);
  static void clearErrors() => _errors.clear();
  
  static Future<void> retrySafeActions() async {
    final safeActions = _errors.where((error) => 
      error.context?['isRetryable'] == true
    ).toList();
    
    for (final error in safeActions) {
      try {
        await _retryAction(error);
        _errors.remove(error);
      } catch (e) {
        print('Retry failed for error: ${error.message}');
      }
    }
  }
  
  static Future<void> _retryAction(AppError error) async {
    // Implement retry logic based on error context
    final actionType = error.context?['actionType'] as String?;
    
    switch (actionType) {
      case 'api_call':
        // Retry API calls
        break;
      case 'offline_sync':
        // Retry offline sync
        await OfflineQueue.processQueue();
        break;
      default:
        // Generic retry
        break;
    }
  }
}

class AppError {
  final String message;
  final String? details;
  final String? stackTrace;
  final Map<String, dynamic>? context;
  final DateTime timestamp;
  
  AppError({
    required this.message,
    this.details,
    this.stackTrace,
    this.context,
    required this.timestamp,
  });
}

// Health monitoring
class HealthMonitor {
  static DateTime? _lastApiCheck;
  static bool _isHealthy = true;
  static String? _lastError;
  
  static Future<bool> checkApiHealth() async {
    try {
      PerformanceMonitor.startTimer('api_health_check');
      
      final response = await ApiService.getHealth();
      _isHealthy = response['success'] == true;
      _lastApiCheck = DateTime.now();
      _lastError = null;
      
      PerformanceMonitor.endTimer('api_health_check');
      return _isHealthy;
    } catch (e) {
      _isHealthy = false;
      _lastError = e.toString();
      _lastApiCheck = DateTime.now();
      
      ErrorHandler.logError(
        'API health check failed',
        details: e.toString(),
        context: {'isRetryable': true, 'actionType': 'api_call'},
      );
      
      PerformanceMonitor.endTimer('api_health_check');
      return false;
    }
  }
  
  static bool get isHealthy => _isHealthy;
  static String? get lastError => _lastError;
  static DateTime? get lastCheck => _lastApiCheck;
  
  static Duration? get timeSinceLastCheck {
    if (_lastApiCheck == null) return null;
    return DateTime.now().difference(_lastApiCheck!);
  }
  
  static bool get needsHealthCheck {
    if (_lastApiCheck == null) return true;
    return DateTime.now().difference(_lastApiCheck!).inMinutes > 5;
  }
}

// Connectivity monitoring
class ConnectivityMonitor {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static bool _isConnected = true;
  static List<ConnectivityResult> _connectionTypes = [];
  
  static void startMonitoring() {
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      _connectionTypes = results;
      _isConnected = results.isNotEmpty && 
        !results.contains(ConnectivityResult.none);
      
      if (_isConnected) {
        // Process offline queue when connection is restored
        OfflineQueue.processQueue();
        // Retry failed actions
        ErrorHandler.retrySafeActions();
      }
    });
  }
  
  static void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }
  
  static bool get isConnected => _isConnected;
  static List<ConnectivityResult> get connectionTypes => _connectionTypes;
  
  static String get connectionTypeString {
    if (_connectionTypes.contains(ConnectivityResult.wifi)) {
      return 'WiFi';
    } else if (_connectionTypes.contains(ConnectivityResult.mobile)) {
      return 'Mobile';
    } else if (_connectionTypes.contains(ConnectivityResult.ethernet)) {
      return 'Ethernet';
    } else {
      return 'None';
    }
  }
}

// MV (Materialized View) freshness monitoring
class MVFreshnessMonitor {
  static final Map<String, DateTime> _lastUpdates = {};
  static const Duration maxStaleness = Duration(minutes: 30);
  
  static void markUpdated(String mvName) {
    _lastUpdates[mvName] = DateTime.now();
  }
  
  static bool isStale(String mvName) {
    final lastUpdate = _lastUpdates[mvName];
    if (lastUpdate == null) return true;
    
    return DateTime.now().difference(lastUpdate) > maxStaleness;
  }
  
  static Duration? getStaleness(String mvName) {
    final lastUpdate = _lastUpdates[mvName];
    if (lastUpdate == null) return null;
    
    return DateTime.now().difference(lastUpdate);
  }
  
  static Map<String, Duration> getAllStaleness() {
    final Map<String, Duration> staleness = {};
    
    for (final entry in _lastUpdates.entries) {
      staleness[entry.key] = DateTime.now().difference(entry.value);
    }
    
    return staleness;
  }
}