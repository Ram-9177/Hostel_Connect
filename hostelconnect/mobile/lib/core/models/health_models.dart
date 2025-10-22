/// Health Monitoring Models
/// Models for system health monitoring and staleness detection

class SystemHealth {
  final String id;
  final HealthStatus status;
  final DateTime timestamp;
  final Map<String, ComponentHealth> components;
  final SystemMetrics metrics;
  final List<HealthAlert> alerts;
  final String? message;

  const SystemHealth({
    required this.id,
    required this.status,
    required this.timestamp,
    required this.components,
    required this.metrics,
    required this.alerts,
    this.message,
  });

  factory SystemHealth.fromJson(Map<String, dynamic> json) {
    return SystemHealth(
      id: json['id'] as String,
      status: HealthStatus.values.firstWhere((e) => e.name == json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      components: (json['components'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          ComponentHealth.fromJson(value as Map<String, dynamic>),
        ),
      ),
      metrics: SystemMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      alerts: (json['alerts'] as List).map(
        (e) => HealthAlert.fromJson(e as Map<String, dynamic>),
      ).toList(),
      message: json['message'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'components': components.map((key, value) => MapEntry(key, value.toJson())),
      'metrics': metrics.toJson(),
      'alerts': alerts.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class ComponentHealth {
  final String name;
  final HealthStatus status;
  final DateTime lastChecked;
  final int responseTimeMs;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;

  const ComponentHealth({
    required this.name,
    required this.status,
    required this.lastChecked,
    required this.responseTimeMs,
    this.errorMessage,
    this.metadata,
  });

  factory ComponentHealth.fromJson(Map<String, dynamic> json) {
    return ComponentHealth(
      name: json['name'] as String,
      status: HealthStatus.values.firstWhere((e) => e.name == json['status']),
      lastChecked: DateTime.parse(json['lastChecked'] as String),
      responseTimeMs: json['responseTimeMs'] as int,
      errorMessage: json['errorMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status.name,
      'lastChecked': lastChecked.toIso8601String(),
      'responseTimeMs': responseTimeMs,
      'errorMessage': errorMessage,
      'metadata': metadata,
    };
  }
}

class SystemMetrics {
  final int activeUsers;
  final int totalRequests;
  final int errorRate;
  final double averageResponseTime;
  final int databaseConnections;
  final int cacheHitRate;
  final DateTime lastUpdated;

  const SystemMetrics({
    required this.activeUsers,
    required this.totalRequests,
    required this.errorRate,
    required this.averageResponseTime,
    required this.databaseConnections,
    required this.cacheHitRate,
    required this.lastUpdated,
  });

  factory SystemMetrics.fromJson(Map<String, dynamic> json) {
    return SystemMetrics(
      activeUsers: json['activeUsers'] as int,
      totalRequests: json['totalRequests'] as int,
      errorRate: json['errorRate'] as int,
      averageResponseTime: (json['averageResponseTime'] as num).toDouble(),
      databaseConnections: json['databaseConnections'] as int,
      cacheHitRate: json['cacheHitRate'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'activeUsers': activeUsers,
      'totalRequests': totalRequests,
      'errorRate': errorRate,
      'averageResponseTime': averageResponseTime,
      'databaseConnections': databaseConnections,
      'cacheHitRate': cacheHitRate,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class HealthAlert {
  final String id;
  final AlertType type;
  final AlertSeverity severity;
  final String message;
  final DateTime timestamp;
  final String? component;
  final Map<String, dynamic>? context;
  final bool isActive;

  const HealthAlert({
    required this.id,
    required this.type,
    required this.severity,
    required this.message,
    required this.timestamp,
    this.component,
    this.context,
    this.isActive = true,
  });

  factory HealthAlert.fromJson(Map<String, dynamic> json) {
    return HealthAlert(
      id: json['id'] as String,
      type: AlertType.values.firstWhere((e) => e.name == json['type']),
      severity: AlertSeverity.values.firstWhere((e) => e.name == json['severity']),
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      component: json['component'] as String?,
      context: json['context'] as Map<String, dynamic>?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'severity': severity.name,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'component': component,
      'context': context,
      'isActive': isActive,
    };
  }
}

class MaterializedViewHealth {
  final String viewName;
  final DateTime lastRefreshed;
  final int stalenessSeconds;
  final HealthStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;

  const MaterializedViewHealth({
    required this.viewName,
    required this.lastRefreshed,
    required this.stalenessSeconds,
    required this.status,
    this.errorMessage,
    this.metadata,
  });

  factory MaterializedViewHealth.fromJson(Map<String, dynamic> json) {
    return MaterializedViewHealth(
      viewName: json['viewName'] as String,
      lastRefreshed: DateTime.parse(json['lastRefreshed'] as String),
      stalenessSeconds: json['stalenessSeconds'] as int,
      status: HealthStatus.values.firstWhere((e) => e.name == json['status']),
      errorMessage: json['errorMessage'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'viewName': viewName,
      'lastRefreshed': lastRefreshed.toIso8601String(),
      'stalenessSeconds': stalenessSeconds,
      'status': status.name,
      'errorMessage': errorMessage,
      'metadata': metadata,
    };
  }
}

enum HealthStatus {
  healthy,
  degraded,
  unhealthy,
  unknown,
}

enum AlertType {
  staleness,
  errorRate,
  responseTime,
  connection,
  resource,
  security,
}

enum AlertSeverity {
  info,
  warning,
  error,
  critical,
}

class HealthCheckRequest {
  final String component;
  final Map<String, dynamic>? parameters;
  final DateTime requestedAt;

  const HealthCheckRequest({
    required this.component,
    this.parameters,
    required this.requestedAt,
  });

  factory HealthCheckRequest.fromJson(Map<String, dynamic> json) {
    return HealthCheckRequest(
      component: json['component'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'component': component,
      'parameters': parameters,
      'requestedAt': requestedAt.toIso8601String(),
    };
  }
}

class HealthCheckResponse {
  final String component;
  final HealthStatus status;
  final DateTime checkedAt;
  final int responseTimeMs;
  final String? message;
  final Map<String, dynamic>? data;

  const HealthCheckResponse({
    required this.component,
    required this.status,
    required this.checkedAt,
    required this.responseTimeMs,
    this.message,
    this.data,
  });

  factory HealthCheckResponse.fromJson(Map<String, dynamic> json) {
    return HealthCheckResponse(
      component: json['component'] as String,
      status: HealthStatus.values.firstWhere((e) => e.name == json['status']),
      checkedAt: DateTime.parse(json['checkedAt'] as String),
      responseTimeMs: json['responseTimeMs'] as int,
      message: json['message'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'component': component,
      'status': status.name,
      'checkedAt': checkedAt.toIso8601String(),
      'responseTimeMs': responseTimeMs,
      'message': message,
      'data': data,
    };
  }
}

/// Extension methods for HealthStatus
extension HealthStatusExtension on HealthStatus {
  String get displayName {
    switch (this) {
      case HealthStatus.healthy:
        return 'Healthy';
      case HealthStatus.degraded:
        return 'Degraded';
      case HealthStatus.unhealthy:
        return 'Unhealthy';
      case HealthStatus.unknown:
        return 'Unknown';
    }
  }

  String get description {
    switch (this) {
      case HealthStatus.healthy:
        return 'System is operating normally';
      case HealthStatus.degraded:
        return 'System is experiencing minor issues';
      case HealthStatus.unhealthy:
        return 'System is experiencing major issues';
      case HealthStatus.unknown:
        return 'System status cannot be determined';
    }
  }
}

/// Extension methods for AlertType
extension AlertTypeExtension on AlertType {
  String get displayName {
    switch (this) {
      case AlertType.staleness:
        return 'Data Staleness';
      case AlertType.errorRate:
        return 'Error Rate';
      case AlertType.responseTime:
        return 'Response Time';
      case AlertType.connection:
        return 'Connection';
      case AlertType.resource:
        return 'Resource';
      case AlertType.security:
        return 'Security';
    }
  }

  String get description {
    switch (this) {
      case AlertType.staleness:
        return 'Data is becoming stale';
      case AlertType.errorRate:
        return 'Error rate is high';
      case AlertType.responseTime:
        return 'Response time is slow';
      case AlertType.connection:
        return 'Connection issues detected';
      case AlertType.resource:
        return 'Resource usage is high';
      case AlertType.security:
        return 'Security issues detected';
    }
  }
}

/// Extension methods for AlertSeverity
extension AlertSeverityExtension on AlertSeverity {
  String get displayName {
    switch (this) {
      case AlertSeverity.info:
        return 'Info';
      case AlertSeverity.warning:
        return 'Warning';
      case AlertSeverity.error:
        return 'Error';
      case AlertSeverity.critical:
        return 'Critical';
    }
  }

  String get description {
    switch (this) {
      case AlertSeverity.info:
        return 'Informational message';
      case AlertSeverity.warning:
        return 'Warning condition';
      case AlertSeverity.error:
        return 'Error condition';
      case AlertSeverity.critical:
        return 'Critical condition';
    }
  }
}