# HostelConnect Mobile App - Error Playbook

## Overview
This document provides comprehensive error handling strategies, troubleshooting guides, and recovery procedures for the HostelConnect Mobile App system.

## Error Handling Architecture

### Error Hierarchy
```
AppError (Base)
├── NetworkError
├── AuthenticationError
├── ValidationError
├── PermissionError
├── SystemError
└── UnknownError
```

### Error Severity Levels
- **Critical**: System crashes, data loss
- **High**: Feature failures, security issues
- **Medium**: User experience degradation
- **Low**: Minor UI issues, warnings

## Error Categories and Handling

### 1. Network Errors

#### Common Network Errors
- **Connection Timeout**: Network request exceeds timeout
- **No Internet**: Device has no network connectivity
- **Server Unavailable**: Backend service is down
- **DNS Resolution Failed**: Cannot resolve server address

#### Handling Strategy
```dart
class NetworkErrorHandler {
  static Future<T> handleNetworkCall<T>(
    Future<T> Function() apiCall,
    {int maxRetries = 3}
  ) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await apiCall();
      } on DioException catch (e) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          if (attempt < maxRetries) {
            await Future.delayed(Duration(seconds: attempt * 2));
            continue;
          }
        }
        throw NetworkError.fromDioException(e);
      }
    }
    throw NetworkError('Max retries exceeded');
  }
}
```

#### Recovery Actions
- **Automatic Retry**: Exponential backoff for transient errors
- **Offline Queue**: Queue operations for later sync
- **User Notification**: Toast message with retry option
- **Fallback Data**: Show cached data when available

### 2. Authentication Errors

#### Common Auth Errors
- **Token Expired**: JWT access token has expired
- **Invalid Credentials**: Login credentials are incorrect
- **Account Locked**: User account is temporarily locked
- **Session Expired**: User session has timed out

#### Handling Strategy
```dart
class AuthErrorHandler {
  static Future<void> handleAuthError(AuthError error) async {
    switch (error.type) {
      case AuthErrorType.tokenExpired:
        await _attemptTokenRefresh();
        break;
      case AuthErrorType.invalidCredentials:
        await _showLoginPage();
        break;
      case AuthErrorType.accountLocked:
        await _showAccountLockedMessage();
        break;
      case AuthErrorType.sessionExpired:
        await _logoutAndRedirect();
        break;
    }
  }
}
```

#### Recovery Actions
- **Silent Refresh**: Automatically refresh expired tokens
- **Re-login**: Redirect to login page for invalid credentials
- **Account Recovery**: Provide account unlock options
- **Session Cleanup**: Clear all stored data on logout

### 3. Validation Errors

#### Common Validation Errors
- **Required Field Missing**: Mandatory form field is empty
- **Invalid Format**: Data format doesn't match requirements
- **Length Exceeded**: Input exceeds maximum length
- **Duplicate Entry**: Data already exists in system

#### Handling Strategy
```dart
class ValidationErrorHandler {
  static void handleValidationError(ValidationError error) {
    // Show field-specific error messages
    error.fieldErrors.forEach((field, message) {
      _showFieldError(field, message);
    });
    
    // Focus on first error field
    if (error.fieldErrors.isNotEmpty) {
      _focusField(error.fieldErrors.keys.first);
    }
  }
}
```

#### Recovery Actions
- **Field Highlighting**: Highlight invalid fields
- **Error Messages**: Show specific validation messages
- **Auto-focus**: Focus on first error field
- **Real-time Validation**: Validate as user types

### 4. Permission Errors

#### Common Permission Errors
- **Role Insufficient**: User role lacks required permissions
- **Feature Restricted**: Feature is disabled for user
- **Resource Access Denied**: Cannot access specific resource
- **Action Not Allowed**: Operation not permitted

#### Handling Strategy
```dart
class PermissionErrorHandler {
  static Widget handlePermissionError(PermissionError error) {
    return PermissionDeniedPage(
      requiredRole: error.requiredRole,
      currentRole: error.currentRole,
      feature: error.feature,
      onBack: () => NavigationService.goBack(),
    );
  }
}
```

#### Recovery Actions
- **Role Upgrade**: Suggest role upgrade if applicable
- **Alternative Access**: Provide alternative ways to access data
- **Contact Admin**: Provide contact information for admin
- **Graceful Degradation**: Hide restricted features

### 5. System Errors

#### Common System Errors
- **Database Connection Failed**: Cannot connect to database
- **Memory Exhaustion**: Insufficient memory available
- **File System Error**: Cannot read/write files
- **Third-party Service Down**: External service unavailable

#### Handling Strategy
```dart
class SystemErrorHandler {
  static Future<void> handleSystemError(SystemError error) async {
    // Log error for debugging
    await ErrorService.logError(error);
    
    // Show user-friendly message
    await ToastService.showError(
      'System temporarily unavailable. Please try again later.'
    );
    
    // Attempt recovery if possible
    if (error.isRecoverable) {
      await _attemptRecovery(error);
    }
  }
}
```

#### Recovery Actions
- **Service Restart**: Restart affected services
- **Cache Clear**: Clear corrupted cache data
- **Fallback Mode**: Switch to offline mode
- **Admin Notification**: Alert administrators

## Error Boundaries

### Page Error Boundary
```dart
class PageErrorBoundary extends StatefulWidget {
  final Widget child;
  final String pageName;
  
  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      onError: (error, stackTrace) {
        ErrorService.logError(
          AppError.system(
            message: 'Page error in $pageName',
            details: error.toString(),
            stackTrace: stackTrace,
          ),
        );
      },
      child: child,
    );
  }
}
```

### Widget Error Boundary
```dart
class WidgetErrorBoundary extends StatelessWidget {
  final Widget child;
  final String widgetName;
  
  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      onError: (error, stackTrace) {
        ErrorService.logError(
          AppError.system(
            message: 'Widget error in $widgetName',
            details: error.toString(),
            stackTrace: stackTrace,
          ),
        );
      },
      child: child,
    );
  }
}
```

### Global Error Handler
```dart
class GlobalErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      ErrorService.logError(
        AppError.system(
          message: 'Flutter framework error',
          details: details.exception.toString(),
          stackTrace: details.stack,
        ),
      );
    };
    
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      ErrorService.logError(
        AppError.system(
          message: 'Platform error',
          details: error.toString(),
          stackTrace: stackTrace,
        ),
      );
      return true;
    };
  }
}
```

## Error Recovery Strategies

### 1. Automatic Recovery

#### Retry Logic
```dart
class RetryManager {
  static Future<T> withRetry<T>(
    Future<T> Function() operation,
    {int maxRetries = 3, Duration delay = const Duration(seconds: 1)}
  ) async {
    for (int i = 0; i < maxRetries; i++) {
      try {
        return await operation();
      } catch (e) {
        if (i == maxRetries - 1) rethrow;
        await Future.delayed(delay * (i + 1));
      }
    }
    throw Exception('Max retries exceeded');
  }
}
```

#### Circuit Breaker
```dart
class CircuitBreaker {
  static const int failureThreshold = 5;
  static const Duration timeout = Duration(minutes: 1);
  
  static bool _isOpen = false;
  static int _failureCount = 0;
  static DateTime? _lastFailureTime;
  
  static Future<T> execute<T>(Future<T> Function() operation) async {
    if (_isOpen) {
      if (DateTime.now().difference(_lastFailureTime!) > timeout) {
        _isOpen = false;
        _failureCount = 0;
      } else {
        throw CircuitBreakerOpenException();
      }
    }
    
    try {
      final result = await operation();
      _failureCount = 0;
      return result;
    } catch (e) {
      _failureCount++;
      _lastFailureTime = DateTime.now();
      
      if (_failureCount >= failureThreshold) {
        _isOpen = true;
      }
      
      rethrow;
    }
  }
}
```

### 2. User-Initiated Recovery

#### Retry Button
```dart
class RetryButton extends StatelessWidget {
  final VoidCallback onRetry;
  final String? errorMessage;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (errorMessage != null)
          Text(errorMessage!, style: TextStyle(color: Colors.red)),
        ElevatedButton(
          onPressed: onRetry,
          child: Text('Retry'),
        ),
      ],
    );
  }
}
```

#### Refresh Action
```dart
class RefreshAction extends StatelessWidget {
  final VoidCallback onRefresh;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: onRefresh,
    );
  }
}
```

### 3. Offline Recovery

#### Offline Queue Management
```dart
class OfflineQueueManager {
  static Future<void> processOfflineQueue() async {
    final queue = await OfflineQueueService.getPendingItems();
    
    for (final item in queue) {
      try {
        await _processQueueItem(item);
        await OfflineQueueService.markCompleted(item.id);
      } catch (e) {
        await OfflineQueueService.markFailed(item.id, e.toString());
      }
    }
  }
  
  static Future<void> _processQueueItem(OfflineQueueItem item) async {
    switch (item.type) {
      case OfflineOperationType.attendanceScan:
        await AttendanceService.submitScan(item.data);
        break;
      case OfflineOperationType.noticeRead:
        await NoticeService.markAsRead(item.data['noticeId']);
        break;
      case OfflineOperationType.gatePassScan:
        await GatePassService.recordScan(item.data);
        break;
      case OfflineOperationType.mealIntent:
        await MealService.submitIntent(item.data);
        break;
    }
  }
}
```

## Error Monitoring and Logging

### Error Logging Service
```dart
class ErrorService {
  static Future<void> logError(AppError error) async {
    // Log to local storage
    await _logToLocal(error);
    
    // Log to remote service if online
    if (await NetworkService.isOnline()) {
      await _logToRemote(error);
    }
    
    // Update error statistics
    await _updateErrorStats(error);
  }
  
  static Future<void> _logToLocal(AppError error) async {
    final errorLog = ErrorLog(
      id: Uuid().v4(),
      error: error,
      timestamp: DateTime.now(),
      deviceInfo: await DeviceInfo.getDeviceInfo(),
      userInfo: await UserService.getCurrentUser(),
    );
    
    await LocalStorage.saveErrorLog(errorLog);
  }
  
  static Future<void> _logToRemote(AppError error) async {
    try {
      await ApiService.logError(error);
    } catch (e) {
      // If remote logging fails, queue for later
      await OfflineQueueService.queueErrorLog(error);
    }
  }
}
```

### Error Statistics
```dart
class ErrorStats {
  final Map<ErrorType, int> errorCounts;
  final Map<String, int> errorByFeature;
  final Map<ErrorSeverity, int> errorBySeverity;
  final DateTime lastUpdated;
  
  static Future<ErrorStats> getCurrentStats() async {
    final logs = await LocalStorage.getAllErrorLogs();
    
    return ErrorStats(
      errorCounts: _countByType(logs),
      errorByFeature: _countByFeature(logs),
      errorBySeverity: _countBySeverity(logs),
      lastUpdated: DateTime.now(),
    );
  }
}
```

## Error Surfacing and Debugging

### Error Surfacing Page
```dart
class ErrorSurfacingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorState = ref.watch(errorProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Error Logs')),
      body: errorState.when(
        idle: () => Text('No errors'),
        loading: () => CircularProgressIndicator(),
        success: (errors) => ListView.builder(
          itemCount: errors.length,
          itemBuilder: (context, index) {
            final error = errors[index];
            return ErrorListItem(
              error: error,
              onRetry: () => _retryError(error),
              onViewDetails: () => _viewErrorDetails(error),
            );
          },
        ),
        error: (error) => Text('Failed to load errors: $error'),
      ),
    );
  }
}
```

### Debug Information
```dart
class DebugInfo {
  static Map<String, dynamic> getSystemInfo() {
    return {
      'appVersion': PackageInfo.version,
      'buildNumber': PackageInfo.buildNumber,
      'platform': Platform.operatingSystem,
      'deviceModel': DeviceInfo.model,
      'memoryUsage': _getMemoryUsage(),
      'storageUsage': _getStorageUsage(),
      'networkStatus': NetworkService.connectionStatus,
      'lastSyncTime': OfflineQueueService.lastSyncTime,
    };
  }
}
```

## Troubleshooting Guides

### Common Issues and Solutions

#### 1. App Crashes on Startup
**Symptoms**: App closes immediately after launch
**Causes**: 
- Corrupted local data
- Invalid authentication tokens
- Missing required permissions

**Solutions**:
1. Clear app data and cache
2. Reinstall the app
3. Check device permissions
4. Verify network connectivity

#### 2. Login Issues
**Symptoms**: Cannot log in despite correct credentials
**Causes**:
- Server connectivity issues
- Invalid token format
- Account locked or suspended

**Solutions**:
1. Check internet connection
2. Verify server status
3. Try password reset
4. Contact administrator

#### 3. Data Not Syncing
**Symptoms**: Changes not reflected across devices
**Causes**:
- Network connectivity issues
- Server synchronization problems
- Offline queue not processing

**Solutions**:
1. Check network connection
2. Force refresh data
3. Clear offline queue
4. Restart app

#### 4. Performance Issues
**Symptoms**: Slow loading, laggy interface
**Causes**:
- Memory leaks
- Large data sets
- Inefficient queries

**Solutions**:
1. Restart app
2. Clear cache
3. Update to latest version
4. Check device storage

### Push Notifications Troubleshooting

#### Notifications Not Arriving
**Symptoms**: No push notifications received
**Causes**:
- Device token not registered
- FCM service issues
- Notification permissions denied

**Solutions**:
1. Check notification permissions
2. Re-register device token
3. Verify FCM configuration
4. Test with admin panel

#### Notifications Delayed
**Symptoms**: Notifications arrive late
**Causes**:
- Network delays
- Server processing issues
- Device power management

**Solutions**:
1. Check network connection
2. Disable battery optimization
3. Verify server logs
4. Test notification timing

### Offline Queue Troubleshooting

#### Queue Not Processing
**Symptoms**: Offline actions not syncing
**Causes**:
- Network connectivity issues
- Server unavailability
- Queue corruption

**Solutions**:
1. Check network connection
2. Force queue processing
3. Clear corrupted items
4. Restart sync service

#### Duplicate Operations
**Symptoms**: Same action performed multiple times
**Causes**:
- Retry logic issues
- Server processing delays
- Race conditions

**Solutions**:
1. Implement deduplication
2. Add operation IDs
3. Server-side validation
4. Optimize retry logic

## Health Monitoring

### System Health Checks
```dart
class HealthMonitor {
  static Future<SystemHealth> checkSystemHealth() async {
    return SystemHealth(
      database: await _checkDatabase(),
      api: await _checkApi(),
      storage: await _checkStorage(),
      network: await _checkNetwork(),
      memory: await _checkMemory(),
      lastChecked: DateTime.now(),
    );
  }
  
  static Future<ComponentHealth> _checkDatabase() async {
    try {
      await DatabaseService.ping();
      return ComponentHealth.healthy;
    } catch (e) {
      return ComponentHealth.unhealthy(e.toString());
    }
  }
  
  static Future<ComponentHealth> _checkApi() async {
    try {
      await ApiService.healthCheck();
      return ComponentHealth.healthy;
    } catch (e) {
      return ComponentHealth.unhealthy(e.toString());
    }
  }
}
```

### Health Alerts
```dart
class HealthAlertManager {
  static Future<void> checkHealthAlerts() async {
    final health = await HealthMonitor.checkSystemHealth();
    
    for (final component in health.components) {
      if (component.status == HealthStatus.unhealthy) {
        await _sendHealthAlert(component);
      }
    }
  }
  
  static Future<void> _sendHealthAlert(ComponentHealth component) async {
    await NotificationService.sendAlert(
      'System Health Alert',
      '${component.name} is unhealthy: ${component.error}',
      severity: AlertSeverity.high,
    );
  }
}
```

## Error Prevention

### Input Validation
```dart
class InputValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}
```

### Defensive Programming
```dart
class DefensiveUtils {
  static T? safeCast<T>(dynamic value) {
    try {
      return value as T;
    } catch (e) {
      return null;
    }
  }
  
  static String safeString(dynamic value) {
    return value?.toString() ?? '';
  }
  
  static int safeInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
```

## Conclusion

This error playbook provides comprehensive strategies for handling, recovering from, and preventing errors in the HostelConnect Mobile App. By following these guidelines, the system can maintain high reliability and provide excellent user experience even when errors occur.

The multi-layered approach ensures that errors are caught at appropriate levels, users are informed appropriately, and recovery mechanisms are in place to restore normal operation as quickly as possible.

---

**Last Updated**: December 2024  
**Version**: 1.0.0  
**Status**: Production Ready