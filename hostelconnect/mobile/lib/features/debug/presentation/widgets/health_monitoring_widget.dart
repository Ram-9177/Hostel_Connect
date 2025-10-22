import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/health_models.dart';
import 'package:hostelconnect/core/providers/offline_error_health_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// Health Monitoring Dashboard Widget
/// Displays system health status and materialized view staleness
class HealthMonitoringWidget extends ConsumerWidget {
  final bool showDetails;
  final VoidCallback? onTap;

  const HealthMonitoringWidget({
    super.key,
    this.showDetails = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final systemHealth = ref.watch(systemHealthProvider);
    final mvHealth = ref.watch(materializedViewHealthProvider);
    final areViewsStale = ref.watch(areViewsStaleProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(IOSGradeTheme.spacing8),
        padding: const EdgeInsets.all(IOSGradeTheme.spacing16),
        decoration: BoxDecoration(
          color: IOSGradeTheme.surface,
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: IOSGradeTheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.health_and_safety,
                  color: _getHealthStatusColor(systemHealth),
                  size: 20,
                ),
                const SizedBox(width: IOSGradeTheme.spacing8),
                Text(
                  'System Health',
                  style: IOSGradeTheme.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: IOSGradeTheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (areViewsStale.when(
                  data: (isStale) => isStale,
                  loading: () => false,
                  error: (_, __) => false,
                ))
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                    ),
                    child: Text(
                      'Stale Data',
                      style: IOSGradeTheme.labelSmall.copyWith(
                        color: IOSGradeTheme.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: IOSGradeTheme.spacing12),
            
            // Health Status
            systemHealth.when(
              data: (health) => _buildHealthStatus(health),
              loading: () => const IOSGradeLoadingIndicator(),
              error: (error, _) => IOSGradeErrorWidget(
                error: error.toString(),
                onRetry: () => ref.refresh(systemHealthProvider),
              ),
            ),
            
            if (showDetails) ...[
              const SizedBox(height: IOSGradeTheme.spacing16),
              
              // Component Health
              Text(
                'Components',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: IOSGradeTheme.onSurface,
                ),
              ),
              const SizedBox(height: IOSGradeTheme.spacing8),
              
              mvHealth.when(
                data: (views) => _buildComponentHealth(views),
                loading: () => const IOSGradeLoadingIndicator(),
                error: (error, _) => IOSGradeErrorWidget(
                  error: error.toString(),
                  onRetry: () => ref.refresh(materializedViewHealthProvider),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStatus(SystemHealth health) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _getHealthStatusColor(health),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: IOSGradeTheme.spacing8),
            Text(
              health.status.displayName,
              style: IOSGradeTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: IOSGradeTheme.onSurface,
              ),
            ),
            const Spacer(),
            Text(
              'Updated ${_formatTimestamp(health.timestamp)}',
              style: IOSGradeTheme.labelSmall.copyWith(
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        if (health.message != null) ...[
          const SizedBox(height: IOSGradeTheme.spacing8),
          Text(
            health.message!,
            style: IOSGradeTheme.bodySmall.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
        ],
        if (health.alerts.isNotEmpty) ...[
          const SizedBox(height: IOSGradeTheme.spacing8),
          _buildAlerts(health.alerts),
        ],
      ],
    );
  }

  Widget _buildAlerts(List<HealthAlert> alerts) {
    final activeAlerts = alerts.where((alert) => alert.isActive).toList();
    
    if (activeAlerts.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Alerts (${activeAlerts.length})',
          style: IOSGradeTheme.labelMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.onSurface,
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing4),
        ...activeAlerts.take(3).map((alert) => _buildAlertItem(alert)),
        if (activeAlerts.length > 3) ...[
          const SizedBox(height: IOSGradeTheme.spacing4),
          Text(
            '+${activeAlerts.length - 3} more alerts',
            style: IOSGradeTheme.labelSmall.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAlertItem(HealthAlert alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing4),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing8),
      decoration: BoxDecoration(
        color: _getAlertSeverityColor(alert.severity).withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(
          color: _getAlertSeverityColor(alert.severity).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _getAlertTypeIcon(alert.type),
            color: _getAlertSeverityColor(alert.severity),
            size: 16,
          ),
          const SizedBox(width: IOSGradeTheme.spacing8),
          Expanded(
            child: Text(
              alert.message,
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentHealth(List<MaterializedViewHealth> views) {
    return Column(
      children: views.map((view) => _buildComponentItem(view)).toList(),
    );
  }

  Widget _buildComponentItem(MaterializedViewHealth view) {
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing8),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing12),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _getHealthStatusColor(view.status),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  view.viewName,
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                    color: IOSGradeTheme.onSurface,
                  ),
                ),
                const SizedBox(height: IOSGradeTheme.spacing4),
                Text(
                  'Last refreshed: ${_formatTimestamp(view.lastRefreshed)}',
                  style: IOSGradeTheme.labelSmall.copyWith(
                    color: IOSGradeTheme.onSurfaceVariant,
                  ),
                ),
                if (view.stalenessSeconds > 60) ...[
                  const SizedBox(height: IOSGradeTheme.spacing4),
                  Text(
                    'Staleness: ${view.stalenessSeconds}s',
                    style: IOSGradeTheme.labelSmall.copyWith(
                      color: IOSGradeTheme.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (view.status != HealthStatus.healthy) ...[
            Icon(
              Icons.warning,
              color: IOSGradeTheme.warning,
              size: 16,
            ),
          ],
        ],
      ),
    );
  }

  Color _getHealthStatusColor(dynamic status) {
    if (status is SystemHealth) {
      switch (status.status) {
        case HealthStatus.healthy:
          return IOSGradeTheme.success;
        case HealthStatus.degraded:
          return IOSGradeTheme.warning;
        case HealthStatus.unhealthy:
          return IOSGradeTheme.error;
        case HealthStatus.unknown:
          return IOSGradeTheme.onSurfaceVariant;
      }
    } else if (status is HealthStatus) {
      switch (status) {
        case HealthStatus.healthy:
          return IOSGradeTheme.success;
        case HealthStatus.degraded:
          return IOSGradeTheme.warning;
        case HealthStatus.unhealthy:
          return IOSGradeTheme.error;
        case HealthStatus.unknown:
          return IOSGradeTheme.onSurfaceVariant;
      }
    }
    return IOSGradeTheme.onSurfaceVariant;
  }

  Color _getAlertSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.info:
        return IOSGradeTheme.info;
      case AlertSeverity.warning:
        return IOSGradeTheme.warning;
      case AlertSeverity.error:
        return IOSGradeTheme.error;
      case AlertSeverity.critical:
        return IOSGradeTheme.error;
    }
  }

  IconData _getAlertTypeIcon(AlertType type) {
    switch (type) {
      case AlertType.staleness:
        return Icons.schedule;
      case AlertType.errorRate:
        return Icons.error;
      case AlertType.responseTime:
        return Icons.timer;
      case AlertType.connection:
        return Icons.wifi;
      case AlertType.resource:
        return Icons.memory;
      case AlertType.security:
        return Icons.security;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
