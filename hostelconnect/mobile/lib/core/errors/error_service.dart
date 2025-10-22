// lib/core/errors/error_service.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ErrorService {
  static const _storage = FlutterSecureStorage();
  static const String _errorLogKey = 'error_log';
  static const int _maxErrorLogSize = 50;

  // Error state provider
  static final errorStateProvider = StateNotifierProvider<ErrorNotifier, ErrorState>((ref) {
    return ErrorNotifier();
  });

  // Log error
  static Future<void> logError({
    required String message,
    required String type,
    String? stackTrace,
    Map<String, dynamic>? context,
    bool isUserFacing = false,
  }) async {
    try {
      final error = ErrorLog(
        id: 'error_${DateTime.now().millisecondsSinceEpoch}',
        message: message,
        type: type,
        stackTrace: stackTrace,
        context: context,
        isUserFacing: isUserFacing,
        timestamp: DateTime.now(),
        isResolved: false,
      );

      final errorLogs = await _getErrorLogs();
      errorLogs.insert(0, error); // Add to beginning

      // Keep only the latest errors
      if (errorLogs.length > _maxErrorLogSize) {
        errorLogs.removeRange(_maxErrorLogSize, errorLogs.length);
      }

      await _saveErrorLogs(errorLogs);
    } catch (e) {
      print('Error logging error: $e');
    }
  }

  // Get error logs
  static Future<List<ErrorLog>> _getErrorLogs() async {
    try {
      final logsData = await _storage.read(key: _errorLogKey);
      if (logsData != null) {
        final List<dynamic> logs = jsonDecode(logsData);
        return logs.map((log) => ErrorLog.fromJson(log)).toList();
      }
    } catch (e) {
      print('Error reading error logs: $e');
    }
    return [];
  }

  // Save error logs
  static Future<void> _saveErrorLogs(List<ErrorLog> logs) async {
    try {
      await _storage.write(key: _errorLogKey, value: jsonEncode(logs));
    } catch (e) {
      print('Error saving error logs: $e');
    }
  }

  // Get recent errors
  static Future<List<ErrorLog>> getRecentErrors({int limit = 10}) async {
    final logs = await _getErrorLogs();
    return logs.take(limit).toList();
  }

  // Mark error as resolved
  static Future<void> markErrorAsResolved(String errorId) async {
    try {
      final logs = await _getErrorLogs();
      final index = logs.indexWhere((log) => log.id == errorId);
      if (index != -1) {
        logs[index] = logs[index].copyWith(isResolved: true);
        await _saveErrorLogs(logs);
      }
    } catch (e) {
      print('Error marking error as resolved: $e');
    }
  }

  // Clear error logs
  static Future<void> clearErrorLogs() async {
    await _storage.delete(key: _errorLogKey);
  }

  // Retry safe actions
  static Future<bool> retryAction(String actionType, Map<String, dynamic> data) async {
    try {
      switch (actionType) {
        case 'mark_notice_read':
          // TODO: Implement actual retry logic
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'attendance_scan':
          // TODO: Implement actual retry logic
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        case 'meal_booking':
          // TODO: Implement actual retry logic
          await Future.delayed(const Duration(milliseconds: 500));
          return true;
          
        default:
          return false;
      }
    } catch (e) {
      await logError(
        message: 'Retry failed for $actionType: ${e.toString()}',
        type: 'retry_failure',
        context: data,
      );
      return false;
    }
  }
}

// Error state notifier
class ErrorNotifier extends StateNotifier<ErrorState> {
  ErrorNotifier() : super(ErrorState.initial()) {
    _loadRecentErrors();
  }

  Future<void> _loadRecentErrors() async {
    try {
      final errors = await ErrorService.getRecentErrors(limit: 10);
      state = state.copyWith(
        recentErrors: errors,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        lastError: e.toString(),
      );
    }
  }

  Future<void> logError({
    required String message,
    required String type,
    String? stackTrace,
    Map<String, dynamic>? context,
    bool isUserFacing = false,
  }) async {
    await ErrorService.logError(
      message: message,
      type: type,
      stackTrace: stackTrace,
      context: context,
      isUserFacing: isUserFacing,
    );
    
    await _loadRecentErrors();
  }

  Future<void> markErrorAsResolved(String errorId) async {
    await ErrorService.markErrorAsResolved(errorId);
    await _loadRecentErrors();
  }

  Future<void> clearAllErrors() async {
    await ErrorService.clearErrorLogs();
    state = state.copyWith(recentErrors: []);
  }

  Future<bool> retryAction(String actionType, Map<String, dynamic> data) async {
    state = state.copyWith(isRetrying: true);
    
    try {
      final success = await ErrorService.retryAction(actionType, data);
      state = state.copyWith(isRetrying: false);
      
      if (success) {
        await _loadRecentErrors();
      }
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isRetrying: false,
        lastError: e.toString(),
      );
      return false;
    }
  }
}

// Error state
class ErrorState {
  final List<ErrorLog> recentErrors;
  final bool isLoading;
  final bool isRetrying;
  final String? lastError;

  const ErrorState({
    required this.recentErrors,
    required this.isLoading,
    required this.isRetrying,
    this.lastError,
  });

  factory ErrorState.initial() {
    return const ErrorState(
      recentErrors: [],
      isLoading: true,
      isRetrying: false,
    );
  }

  ErrorState copyWith({
    List<ErrorLog>? recentErrors,
    bool? isLoading,
    bool? isRetrying,
    String? lastError,
  }) {
    return ErrorState(
      recentErrors: recentErrors ?? this.recentErrors,
      isLoading: isLoading ?? this.isLoading,
      isRetrying: isRetrying ?? this.isRetrying,
      lastError: lastError ?? this.lastError,
    );
  }
}

// Error log model
class ErrorLog {
  final String id;
  final String message;
  final String type;
  final String? stackTrace;
  final Map<String, dynamic>? context;
  final bool isUserFacing;
  final DateTime timestamp;
  final bool isResolved;

  const ErrorLog({
    required this.id,
    required this.message,
    required this.type,
    this.stackTrace,
    this.context,
    required this.isUserFacing,
    required this.timestamp,
    required this.isResolved,
  });

  factory ErrorLog.fromJson(Map<String, dynamic> json) {
    return ErrorLog(
      id: json['id'],
      message: json['message'],
      type: json['type'],
      stackTrace: json['stackTrace'],
      context: json['context'],
      isUserFacing: json['isUserFacing'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
      isResolved: json['isResolved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'stackTrace': stackTrace,
      'context': context,
      'isUserFacing': isUserFacing,
      'timestamp': timestamp.toIso8601String(),
      'isResolved': isResolved,
    };
  }

  ErrorLog copyWith({
    String? id,
    String? message,
    String? type,
    String? stackTrace,
    Map<String, dynamic>? context,
    bool? isUserFacing,
    DateTime? timestamp,
    bool? isResolved,
  }) {
    return ErrorLog(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      stackTrace: stackTrace ?? this.stackTrace,
      context: context ?? this.context,
      isUserFacing: isUserFacing ?? this.isUserFacing,
      timestamp: timestamp ?? this.timestamp,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}
