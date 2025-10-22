import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hostelconnect/core/models/error_models.dart';
import 'package:hostelconnect/core/services/storage_service.dart';

/// Error Service
/// Handles error tracking, logging, and management
class ErrorService {
  static const String _errorsKey = 'app_errors';
  static const String _errorStatsKey = 'error_stats';
  static const int _maxStoredErrors = 50;

  final StorageService _storageService;
  final List<AppError> _errors = [];

  ErrorService({
    required StorageService storageService,
  }) : _storageService = storageService;

  /// Log an error
  Future<void> logError({
    required String message,
    String? stackTrace,
    required ErrorType type,
    required ErrorSeverity severity,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
    bool isRetryable = false,
  }) async {
    final error = AppError(
      id: _generateId(),
      message: message,
      stackTrace: stackTrace,
      type: type,
      severity: severity,
      timestamp: DateTime.now(),
      userId: userId,
      sessionId: sessionId,
      context: context,
      isRetryable: isRetryable,
    );

    _errors.add(error);
    await _saveErrors();
    await _updateStats();

    debugPrint('Error logged: ${error.type.displayName} - ${error.message}');
  }

  /// Get all errors
  Future<List<AppError>> getErrors({
    ErrorFilter? filter,
    int limit = 50,
  }) async {
    await _loadErrors();
    
    List<AppError> filteredErrors = List.from(_errors);

    if (filter != null) {
      filteredErrors = filteredErrors.where((error) {
        if (filter.type != null && error.type != filter.type) return false;
        if (filter.severity != null && error.severity != filter.severity) return false;
        if (filter.status != null && error.status != filter.status) return false;
        if (filter.userId != null && error.userId != filter.userId) return false;
        if (filter.fromDate != null && error.timestamp.isBefore(filter.fromDate!)) return false;
        if (filter.toDate != null && error.timestamp.isAfter(filter.toDate!)) return false;
        if (filter.searchQuery != null && 
            !error.message.toLowerCase().contains(filter.searchQuery!.toLowerCase())) return false;
        return true;
      }).toList();
    }

    // Sort by timestamp (newest first)
    filteredErrors.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return filteredErrors.take(limit).toList();
  }

  /// Get error statistics
  Future<ErrorStats> getErrorStats() async {
    await _loadErrors();
    
    final errorsByType = <ErrorType, int>{};
    final errorsBySeverity = <ErrorSeverity, int>{};
    
    int activeErrors = 0;
    int resolvedErrors = 0;
    int ignoredErrors = 0;
    int retryingErrors = 0;

    for (final error in _errors) {
      // Count by type
      errorsByType[error.type] = (errorsByType[error.type] ?? 0) + 1;
      
      // Count by severity
      errorsBySeverity[error.severity] = (errorsBySeverity[error.severity] ?? 0) + 1;
      
      // Count by status
      switch (error.status) {
        case ErrorStatus.active:
          activeErrors++;
          break;
        case ErrorStatus.resolved:
          resolvedErrors++;
          break;
        case ErrorStatus.ignored:
          ignoredErrors++;
          break;
        case ErrorStatus.retrying:
          retryingErrors++;
          break;
      }
    }

    return ErrorStats(
      totalErrors: _errors.length,
      activeErrors: activeErrors,
      resolvedErrors: resolvedErrors,
      ignoredErrors: ignoredErrors,
      retryingErrors: retryingErrors,
      errorsByType: errorsByType,
      errorsBySeverity: errorsBySeverity,
      lastUpdated: DateTime.now(),
    );
  }

  /// Retry a failed operation
  Future<bool> retryError(String errorId, {String? userId}) async {
    final errorIndex = _errors.indexWhere((error) => error.id == errorId);
    if (errorIndex == -1) return false;

    final error = _errors[errorIndex];
    if (!error.isRetryable) return false;

    // Update error status to retrying
    _errors[errorIndex] = error.copyWith(
      status: ErrorStatus.retrying,
      retryCount: error.retryCount + 1,
      lastRetryAt: DateTime.now(),
    );

    await _saveErrors();
    await _updateStats();

    // Here you would implement the actual retry logic
    // This would depend on the specific error type and context
    try {
      await _performRetry(error);
      
      // Mark as resolved if retry succeeds
      _errors[errorIndex] = _errors[errorIndex].copyWith(
        status: ErrorStatus.resolved,
      );
      
      await _saveErrors();
      await _updateStats();
      return true;
    } catch (e) {
      // Mark as failed if retry fails
      _errors[errorIndex] = _errors[errorIndex].copyWith(
        status: ErrorStatus.active,
      );
      
      await _saveErrors();
      await _updateStats();
      return false;
    }
  }

  /// Mark an error as resolved
  Future<void> markAsResolved(String errorId) async {
    final errorIndex = _errors.indexWhere((error) => error.id == errorId);
    if (errorIndex == -1) return;

    _errors[errorIndex] = _errors[errorIndex].copyWith(
      status: ErrorStatus.resolved,
    );

    await _saveErrors();
    await _updateStats();
  }

  /// Mark an error as ignored
  Future<void> markAsIgnored(String errorId) async {
    final errorIndex = _errors.indexWhere((error) => error.id == errorId);
    if (errorIndex == -1) return;

    _errors[errorIndex] = _errors[errorIndex].copyWith(
      status: ErrorStatus.ignored,
    );

    await _saveErrors();
    await _updateStats();
  }

  /// Clear resolved errors
  Future<void> clearResolvedErrors() async {
    _errors.removeWhere((error) => error.status == ErrorStatus.resolved);
    await _saveErrors();
    await _updateStats();
  }

  /// Clear all errors
  Future<void> clearAllErrors() async {
    _errors.clear();
    await _storageService.remove(_errorsKey);
    await _updateStats();
  }

  /// Perform retry logic based on error type
  Future<void> _performRetry(AppError error) async {
    switch (error.type) {
      case ErrorType.network:
        // Retry network operations
        await _retryNetworkOperation(error);
        break;
      case ErrorType.authentication:
        // Retry authentication
        await _retryAuthentication(error);
        break;
      case ErrorType.server:
        // Retry server operations
        await _retryServerOperation(error);
        break;
      case ErrorType.database:
        // Retry database operations
        await _retryDatabaseOperation(error);
        break;
      default:
        // Generic retry logic
        await _retryGenericOperation(error);
        break;
    }
  }

  /// Retry network operation
  Future<void> _retryNetworkOperation(AppError error) async {
    // Implement network retry logic
    debugPrint('Retrying network operation: ${error.message}');
  }

  /// Retry authentication
  Future<void> _retryAuthentication(AppError error) async {
    // Implement authentication retry logic
    debugPrint('Retrying authentication: ${error.message}');
  }

  /// Retry server operation
  Future<void> _retryServerOperation(AppError error) async {
    // Implement server retry logic
    debugPrint('Retrying server operation: ${error.message}');
  }

  /// Retry database operation
  Future<void> _retryDatabaseOperation(AppError error) async {
    // Implement database retry logic
    debugPrint('Retrying database operation: ${error.message}');
  }

  /// Retry generic operation
  Future<void> _retryGenericOperation(AppError error) async {
    // Implement generic retry logic
    debugPrint('Retrying generic operation: ${error.message}');
  }

  /// Load errors from storage
  Future<void> _loadErrors() async {
    try {
      final errorsJson = await _storageService.getString(_errorsKey);
      if (errorsJson == null) return;
      
      final List<dynamic> errorsList = jsonDecode(errorsJson);
      _errors.clear();
      _errors.addAll(errorsList.map((json) => 
        AppError.fromJson(json as Map<String, dynamic>)
      ));
    } catch (e) {
      debugPrint('Error loading errors from storage: $e');
    }
  }

  /// Save errors to storage
  Future<void> _saveErrors() async {
    try {
      // Keep only the most recent errors
      final errorsToSave = _errors.take(_maxStoredErrors).toList();
      final errorsJson = jsonEncode(errorsToSave.map((error) => error.toJson()).toList());
      await _storageService.setString(_errorsKey, errorsJson);
    } catch (e) {
      debugPrint('Error saving errors to storage: $e');
    }
  }

  /// Update error statistics
  Future<void> _updateStats() async {
    try {
      final stats = await getErrorStats();
      final statsJson = jsonEncode(stats.toJson());
      await _storageService.setString(_errorStatsKey, statsJson);
    } catch (e) {
      debugPrint('Error updating error stats: $e');
    }
  }

  /// Generate unique ID for errors
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Log network error
  Future<void> logNetworkError({
    required String message,
    String? stackTrace,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
  }) async {
    await logError(
      message: message,
      stackTrace: stackTrace,
      type: ErrorType.network,
      severity: ErrorSeverity.medium,
      userId: userId,
      sessionId: sessionId,
      context: context,
    );
  }

  /// Log authentication error
  Future<void> logAuthenticationError({
    required String message,
    String? stackTrace,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
  }) async {
    await logError(
      message: message,
      stackTrace: stackTrace,
      type: ErrorType.authentication,
      severity: ErrorSeverity.high,
      userId: userId,
      sessionId: sessionId,
      context: context,
    );
  }

  /// Log server error
  Future<void> logServerError({
    required String message,
    String? stackTrace,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
  }) async {
    await logError(
      message: message,
      stackTrace: stackTrace,
      type: ErrorType.server,
      severity: ErrorSeverity.high,
      userId: userId,
      sessionId: sessionId,
      context: context,
    );
  }

  /// Log validation error
  Future<void> logValidationError({
    required String message,
    String? stackTrace,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
  }) async {
    await logError(
      message: message,
      stackTrace: stackTrace,
      type: ErrorType.validation,
      severity: ErrorSeverity.medium,
      userId: userId,
      sessionId: sessionId,
      context: context,
    );
  }

  /// Log critical error
  Future<void> logCriticalError({
    required String message,
    String? stackTrace,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
  }) async {
    await logError(
      message: message,
      stackTrace: stackTrace,
      type: ErrorType.unknown,
      severity: ErrorSeverity.critical,
      userId: userId,
      sessionId: sessionId,
      context: context,
    );
  }
}
