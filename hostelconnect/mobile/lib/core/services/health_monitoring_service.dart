import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hostelconnect/core/models/health_models.dart';
import 'package:hostelconnect/core/services/storage_service.dart';
import 'package:hostelconnect/core/services/network_service.dart';

/// Health Monitoring Service
/// Monitors system health and materialized view staleness
class HealthMonitoringService {
  static const String _healthKey = 'system_health';
  static const String _mvHealthKey = 'mv_health';
  static const Duration _stalenessThreshold = Duration(seconds: 60);
  static const Duration _healthCheckInterval = Duration(minutes: 1);

  final StorageService _storageService;
  final NetworkService _networkService;
  SystemHealth? _lastHealth;
  List<MaterializedViewHealth> _mvHealth = [];

  HealthMonitoringService({
    required StorageService storageService,
    required NetworkService networkService,
  }) : _storageService = storageService,
       _networkService = networkService;

  /// Get current system health
  Future<SystemHealth> getSystemHealth() async {
    try {
      final health = await _performHealthCheck();
      _lastHealth = health;
      await _saveHealth(health);
      return health;
    } catch (e) {
      debugPrint('Error getting system health: $e');
      return _getDefaultHealth();
    }
  }

  /// Get materialized view health
  Future<List<MaterializedViewHealth>> getMaterializedViewHealth() async {
    try {
      final mvHealth = await _checkMaterializedViews();
      _mvHealth = mvHealth;
      await _saveMVHealth(mvHealth);
      return mvHealth;
    } catch (e) {
      debugPrint('Error getting MV health: $e');
      return [];
    }
  }

  /// Check if system is healthy
  Future<bool> isSystemHealthy() async {
    final health = await getSystemHealth();
    return health.status == HealthStatus.healthy;
  }

  /// Check if materialized views are stale
  Future<bool> areViewsStale() async {
    final mvHealth = await getMaterializedViewHealth();
    return mvHealth.any((view) => view.stalenessSeconds > _stalenessThreshold.inSeconds);
  }

  /// Get health alerts
  Future<List<HealthAlert>> getHealthAlerts() async {
    final health = await getSystemHealth();
    return health.alerts.where((alert) => alert.isActive).toList();
  }

  /// Perform comprehensive health check
  Future<SystemHealth> _performHealthCheck() async {
    final startTime = DateTime.now();
    final components = <String, ComponentHealth>{};
    final alerts = <HealthAlert>[];

    // Check network connectivity
    final networkHealth = await _checkNetworkHealth();
    components['network'] = networkHealth;

    // Check database connectivity
    final dbHealth = await _checkDatabaseHealth();
    components['database'] = dbHealth;

    // Check API endpoints
    final apiHealth = await _checkApiHealth();
    components['api'] = apiHealth;

    // Check materialized views
    final mvHealth = await getMaterializedViewHealth();
    for (final view in mvHealth) {
      components['mv_${view.viewName}'] = ComponentHealth(
        name: view.viewName,
        status: view.status,
        lastChecked: DateTime.now(),
        responseTimeMs: 0,
        errorMessage: view.errorMessage,
        metadata: view.metadata,
      );

      // Check for staleness alerts
      if (view.stalenessSeconds > _stalenessThreshold.inSeconds) {
        alerts.add(HealthAlert(
          id: _generateId(),
          type: AlertType.staleness,
          severity: AlertSeverity.warning,
          message: '${view.viewName} is stale (${view.stalenessSeconds}s)',
          timestamp: DateTime.now(),
          component: view.viewName,
          context: {'stalenessSeconds': view.stalenessSeconds},
        ));
      }
    }

    // Check error rates
    final errorRate = await _checkErrorRate();
    if (errorRate > 10) {
      alerts.add(HealthAlert(
        id: _generateId(),
        type: AlertType.errorRate,
        severity: AlertSeverity.error,
        message: 'High error rate detected: $errorRate%',
        timestamp: DateTime.now(),
        context: {'errorRate': errorRate},
      ));
    }

    // Check response times
    final responseTime = await _checkResponseTime();
    if (responseTime > 5000) {
      alerts.add(HealthAlert(
        id: _generateId(),
        type: AlertType.responseTime,
        severity: AlertSeverity.warning,
        message: 'Slow response time: ${responseTime}ms',
        timestamp: DateTime.now(),
        context: {'responseTime': responseTime},
      ));
    }

    // Determine overall health status
    final overallStatus = _determineOverallStatus(components, alerts);

    // Get system metrics
    final metrics = await _getSystemMetrics();

    return SystemHealth(
      id: _generateId(),
      status: overallStatus,
      timestamp: DateTime.now(),
      components: components,
      metrics: metrics,
      alerts: alerts,
      message: _getHealthMessage(overallStatus),
    );
  }

  /// Check network health
  Future<ComponentHealth> _checkNetworkHealth() async {
    final startTime = DateTime.now();
    try {
      final isConnected = await _networkService.isConnected();
      final responseTime = DateTime.now().difference(startTime).inMilliseconds;
      
      return ComponentHealth(
        name: 'network',
        status: isConnected ? HealthStatus.healthy : HealthStatus.unhealthy,
        lastChecked: DateTime.now(),
        responseTimeMs: responseTime,
        errorMessage: isConnected ? null : 'No network connection',
      );
    } catch (e) {
      return ComponentHealth(
        name: 'network',
        status: HealthStatus.unhealthy,
        lastChecked: DateTime.now(),
        responseTimeMs: DateTime.now().difference(startTime).inMilliseconds,
        errorMessage: e.toString(),
      );
    }
  }

  /// Check database health
  Future<ComponentHealth> _checkDatabaseHealth() async {
    final startTime = DateTime.now();
    try {
      // Simulate database health check
      await Future.delayed(const Duration(milliseconds: 100));
      final responseTime = DateTime.now().difference(startTime).inMilliseconds;
      
      return ComponentHealth(
        name: 'database',
        status: HealthStatus.healthy,
        lastChecked: DateTime.now(),
        responseTimeMs: responseTime,
      );
    } catch (e) {
      return ComponentHealth(
        name: 'database',
        status: HealthStatus.unhealthy,
        lastChecked: DateTime.now(),
        responseTimeMs: DateTime.now().difference(startTime).inMilliseconds,
        errorMessage: e.toString(),
      );
    }
  }

  /// Check API health
  Future<ComponentHealth> _checkApiHealth() async {
    final startTime = DateTime.now();
    try {
      // Simulate API health check
      await Future.delayed(const Duration(milliseconds: 200));
      final responseTime = DateTime.now().difference(startTime).inMilliseconds;
      
      return ComponentHealth(
        name: 'api',
        status: HealthStatus.healthy,
        lastChecked: DateTime.now(),
        responseTimeMs: responseTime,
      );
    } catch (e) {
      return ComponentHealth(
        name: 'api',
        status: HealthStatus.unhealthy,
        lastChecked: DateTime.now(),
        responseTimeMs: DateTime.now().difference(startTime).inMilliseconds,
        errorMessage: e.toString(),
      );
    }
  }

  /// Check materialized views
  Future<List<MaterializedViewHealth>> _checkMaterializedViews() async {
    try {
      // Simulate MV health check
      final views = [
        'attendance_summary',
        'gate_pass_stats',
        'meal_forecasts',
        'user_activity',
        'room_occupancy',
      ];

      final mvHealth = <MaterializedViewHealth>[];
      for (final viewName in views) {
        final lastRefreshed = DateTime.now().subtract(Duration(seconds: 30 + (views.indexOf(viewName) * 20)));
        final stalenessSeconds = DateTime.now().difference(lastRefreshed).inSeconds;
        
        mvHealth.add(MaterializedViewHealth(
          viewName: viewName,
          lastRefreshed: lastRefreshed,
          stalenessSeconds: stalenessSeconds,
          status: stalenessSeconds > _stalenessThreshold.inSeconds 
              ? HealthStatus.degraded 
              : HealthStatus.healthy,
          metadata: {'refreshInterval': 60},
        ));
      }

      return mvHealth;
    } catch (e) {
      debugPrint('Error checking materialized views: $e');
      return [];
    }
  }

  /// Check error rate
  Future<int> _checkErrorRate() async {
    try {
      // Simulate error rate calculation
      return 5; // 5% error rate
    } catch (e) {
      return 0;
    }
  }

  /// Check response time
  Future<int> _checkResponseTime() async {
    try {
      // Simulate response time calculation
      return 1200; // 1.2 seconds
    } catch (e) {
      return 0;
    }
  }

  /// Get system metrics
  Future<SystemMetrics> _getSystemMetrics() async {
    try {
      return SystemMetrics(
        activeUsers: 150,
        totalRequests: 1250,
        errorRate: 5,
        averageResponseTime: 1200.0,
        databaseConnections: 25,
        cacheHitRate: 85,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      return SystemMetrics(
        activeUsers: 0,
        totalRequests: 0,
        errorRate: 0,
        averageResponseTime: 0.0,
        databaseConnections: 0,
        cacheHitRate: 0,
        lastUpdated: DateTime.now(),
      );
    }
  }

  /// Determine overall health status
  HealthStatus _determineOverallStatus(
    Map<String, ComponentHealth> components,
    List<HealthAlert> alerts,
  ) {
    final criticalAlerts = alerts.where((alert) => 
      alert.severity == AlertSeverity.critical
    ).length;

    final errorAlerts = alerts.where((alert) => 
      alert.severity == AlertSeverity.error
    ).length;

    final warningAlerts = alerts.where((alert) => 
      alert.severity == AlertSeverity.warning
    ).length;

    if (criticalAlerts > 0) return HealthStatus.unhealthy;
    if (errorAlerts > 2) return HealthStatus.unhealthy;
    if (errorAlerts > 0 || warningAlerts > 5) return HealthStatus.degraded;
    
    final unhealthyComponents = components.values.where((component) => 
      component.status == HealthStatus.unhealthy
    ).length;

    if (unhealthyComponents > 0) return HealthStatus.degraded;
    return HealthStatus.healthy;
  }

  /// Get health message
  String _getHealthMessage(HealthStatus status) {
    switch (status) {
      case HealthStatus.healthy:
        return 'All systems operational';
      case HealthStatus.degraded:
        return 'Some systems experiencing issues';
      case HealthStatus.unhealthy:
        return 'Multiple systems experiencing issues';
      case HealthStatus.unknown:
        return 'System status unknown';
    }
  }

  /// Get default health when checks fail
  SystemHealth _getDefaultHealth() {
    return SystemHealth(
      id: _generateId(),
      status: HealthStatus.unknown,
      timestamp: DateTime.now(),
      components: {},
      metrics: SystemMetrics(
        activeUsers: 0,
        totalRequests: 0,
        errorRate: 0,
        averageResponseTime: 0.0,
        databaseConnections: 0,
        cacheHitRate: 0,
        lastUpdated: DateTime.now(),
      ),
      alerts: [],
      message: 'Unable to determine system health',
    );
  }

  /// Save health to storage
  Future<void> _saveHealth(SystemHealth health) async {
    try {
      final healthJson = jsonEncode(health.toJson());
      await _storageService.setString(_healthKey, healthJson);
    } catch (e) {
      debugPrint('Error saving health to storage: $e');
    }
  }

  /// Save MV health to storage
  Future<void> _saveMVHealth(List<MaterializedViewHealth> mvHealth) async {
    try {
      final mvHealthJson = jsonEncode(mvHealth.map((mv) => mv.toJson()).toList());
      await _storageService.setString(_mvHealthKey, mvHealthJson);
    } catch (e) {
      debugPrint('Error saving MV health to storage: $e');
    }
  }

  /// Generate unique ID
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Start health monitoring
  Future<void> startMonitoring() async {
    // Perform initial health check
    await getSystemHealth();
    
    // Schedule periodic health checks
    // In a real implementation, this would use a timer or background task
    debugPrint('Health monitoring started');
  }

  /// Stop health monitoring
  Future<void> stopMonitoring() async {
    debugPrint('Health monitoring stopped');
  }
}
