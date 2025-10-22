/// Error Models
/// Models for error tracking, surfacing, and management

class AppError {
  final String id;
  final String message;
  final String? stackTrace;
  final ErrorType type;
  final ErrorSeverity severity;
  final DateTime timestamp;
  final String? userId;
  final String? sessionId;
  final Map<String, dynamic>? context;
  final bool isRetryable;
  final int retryCount;
  final DateTime? lastRetryAt;
  final ErrorStatus status;

  const AppError({
    required this.id,
    required this.message,
    this.stackTrace,
    required this.type,
    required this.severity,
    required this.timestamp,
    this.userId,
    this.sessionId,
    this.context,
    this.isRetryable = false,
    this.retryCount = 0,
    this.lastRetryAt,
    this.status = ErrorStatus.active,
  });

  factory AppError.fromJson(Map<String, dynamic> json) {
    return AppError(
      id: json['id'] as String,
      message: json['message'] as String,
      stackTrace: json['stackTrace'] as String?,
      type: ErrorType.values.firstWhere((e) => e.name == json['type']),
      severity: ErrorSeverity.values.firstWhere((e) => e.name == json['severity']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String?,
      sessionId: json['sessionId'] as String?,
      context: json['context'] as Map<String, dynamic>?,
      isRetryable: json['isRetryable'] as bool? ?? false,
      retryCount: json['retryCount'] as int? ?? 0,
      lastRetryAt: json['lastRetryAt'] != null 
          ? DateTime.parse(json['lastRetryAt'] as String) 
          : null,
      status: ErrorStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'stackTrace': stackTrace,
      'type': type.name,
      'severity': severity.name,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
      'sessionId': sessionId,
      'context': context,
      'isRetryable': isRetryable,
      'retryCount': retryCount,
      'lastRetryAt': lastRetryAt?.toIso8601String(),
      'status': status.name,
    };
  }

  AppError copyWith({
    String? id,
    String? message,
    String? stackTrace,
    ErrorType? type,
    ErrorSeverity? severity,
    DateTime? timestamp,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
    bool? isRetryable,
    int? retryCount,
    DateTime? lastRetryAt,
    ErrorStatus? status,
  }) {
    return AppError(
      id: id ?? this.id,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
      context: context ?? this.context,
      isRetryable: isRetryable ?? this.isRetryable,
      retryCount: retryCount ?? this.retryCount,
      lastRetryAt: lastRetryAt ?? this.lastRetryAt,
      status: status ?? this.status,
    );
  }
}

enum ErrorType {
  network,
  authentication,
  authorization,
  validation,
  server,
  database,
  fileSystem,
  permission,
  timeout,
  unknown,
}

enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

enum ErrorStatus {
  active,
  resolved,
  ignored,
  retrying,
}

class ErrorRetryRequest {
  final String errorId;
  final String? userId;
  final Map<String, dynamic>? context;
  final DateTime requestedAt;

  const ErrorRetryRequest({
    required this.errorId,
    this.userId,
    this.context,
    required this.requestedAt,
  });

  factory ErrorRetryRequest.fromJson(Map<String, dynamic> json) {
    return ErrorRetryRequest(
      errorId: json['errorId'] as String,
      userId: json['userId'] as String?,
      context: json['context'] as Map<String, dynamic>?,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'errorId': errorId,
      'userId': userId,
      'context': context,
      'requestedAt': requestedAt.toIso8601String(),
    };
  }
}

class ErrorStats {
  final int totalErrors;
  final int activeErrors;
  final int resolvedErrors;
  final int ignoredErrors;
  final int retryingErrors;
  final Map<ErrorType, int> errorsByType;
  final Map<ErrorSeverity, int> errorsBySeverity;
  final DateTime lastUpdated;

  const ErrorStats({
    required this.totalErrors,
    required this.activeErrors,
    required this.resolvedErrors,
    required this.ignoredErrors,
    required this.retryingErrors,
    required this.errorsByType,
    required this.errorsBySeverity,
    required this.lastUpdated,
  });

  factory ErrorStats.fromJson(Map<String, dynamic> json) {
    return ErrorStats(
      totalErrors: json['totalErrors'] as int,
      activeErrors: json['activeErrors'] as int,
      resolvedErrors: json['resolvedErrors'] as int,
      ignoredErrors: json['ignoredErrors'] as int,
      retryingErrors: json['retryingErrors'] as int,
      errorsByType: (json['errorsByType'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          ErrorType.values.firstWhere((e) => e.name == key),
          value as int,
        ),
      ),
      errorsBySeverity: (json['errorsBySeverity'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          ErrorSeverity.values.firstWhere((e) => e.name == key),
          value as int,
        ),
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalErrors': totalErrors,
      'activeErrors': activeErrors,
      'resolvedErrors': resolvedErrors,
      'ignoredErrors': ignoredErrors,
      'retryingErrors': retryingErrors,
      'errorsByType': errorsByType.map((key, value) => MapEntry(key.name, value)),
      'errorsBySeverity': errorsBySeverity.map((key, value) => MapEntry(key.name, value)),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class ErrorFilter {
  final ErrorType? type;
  final ErrorSeverity? severity;
  final ErrorStatus? status;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? userId;
  final String? searchQuery;

  const ErrorFilter({
    this.type,
    this.severity,
    this.status,
    this.fromDate,
    this.toDate,
    this.userId,
    this.searchQuery,
  });

  factory ErrorFilter.fromJson(Map<String, dynamic> json) {
    return ErrorFilter(
      type: json['type'] != null 
          ? ErrorType.values.firstWhere((e) => e.name == json['type'])
          : null,
      severity: json['severity'] != null 
          ? ErrorSeverity.values.firstWhere((e) => e.name == json['severity'])
          : null,
      status: json['status'] != null 
          ? ErrorStatus.values.firstWhere((e) => e.name == json['status'])
          : null,
      fromDate: json['fromDate'] != null 
          ? DateTime.parse(json['fromDate'] as String)
          : null,
      toDate: json['toDate'] != null 
          ? DateTime.parse(json['toDate'] as String)
          : null,
      userId: json['userId'] as String?,
      searchQuery: json['searchQuery'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'type': type?.name,
      'severity': severity?.name,
      'status': status?.name,
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'userId': userId,
      'searchQuery': searchQuery,
    };
  }
}

/// Extension methods for ErrorType
extension ErrorTypeExtension on ErrorType {
  String get displayName {
    switch (this) {
      case ErrorType.network:
        return 'Network Error';
      case ErrorType.authentication:
        return 'Authentication Error';
      case ErrorType.authorization:
        return 'Authorization Error';
      case ErrorType.validation:
        return 'Validation Error';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.database:
        return 'Database Error';
      case ErrorType.fileSystem:
        return 'File System Error';
      case ErrorType.permission:
        return 'Permission Error';
      case ErrorType.timeout:
        return 'Timeout Error';
      case ErrorType.unknown:
        return 'Unknown Error';
    }
  }

  String get description {
    switch (this) {
      case ErrorType.network:
        return 'Network connectivity issues';
      case ErrorType.authentication:
        return 'User authentication problems';
      case ErrorType.authorization:
        return 'Access permission issues';
      case ErrorType.validation:
        return 'Data validation failures';
      case ErrorType.server:
        return 'Server-side errors';
      case ErrorType.database:
        return 'Database operation failures';
      case ErrorType.fileSystem:
        return 'File system access issues';
      case ErrorType.permission:
        return 'Permission denied errors';
      case ErrorType.timeout:
        return 'Operation timeout errors';
      case ErrorType.unknown:
        return 'Unclassified errors';
    }
  }
}

/// Extension methods for ErrorSeverity
extension ErrorSeverityExtension on ErrorSeverity {
  String get displayName {
    switch (this) {
      case ErrorSeverity.low:
        return 'Low';
      case ErrorSeverity.medium:
        return 'Medium';
      case ErrorSeverity.high:
        return 'High';
      case ErrorSeverity.critical:
        return 'Critical';
    }
  }

  String get description {
    switch (this) {
      case ErrorSeverity.low:
        return 'Minor issue, minimal impact';
      case ErrorSeverity.medium:
        return 'Moderate issue, some impact';
      case ErrorSeverity.high:
        return 'Significant issue, major impact';
      case ErrorSeverity.critical:
        return 'Critical issue, system failure';
    }
  }
}

/// Extension methods for ErrorStatus
extension ErrorStatusExtension on ErrorStatus {
  String get displayName {
    switch (this) {
      case ErrorStatus.active:
        return 'Active';
      case ErrorStatus.resolved:
        return 'Resolved';
      case ErrorStatus.ignored:
        return 'Ignored';
      case ErrorStatus.retrying:
        return 'Retrying';
    }
  }

  String get description {
    switch (this) {
      case ErrorStatus.active:
        return 'Error is currently active';
      case ErrorStatus.resolved:
        return 'Error has been resolved';
      case ErrorStatus.ignored:
        return 'Error has been ignored';
      case ErrorStatus.retrying:
        return 'Error is being retried';
    }
  }
}