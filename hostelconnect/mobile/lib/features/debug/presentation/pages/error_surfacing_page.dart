import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/error_models.dart';
import 'package:hostelconnect/core/providers/offline_error_health_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';
import 'package:hostelconnect/core/models/load_state.dart';

/// Error Surfacing Page
/// Displays last 50 errors with retry functionality and timestamps
class ErrorSurfacingPage extends ConsumerStatefulWidget {
  const ErrorSurfacingPage({super.key});

  @override
  ConsumerState<ErrorSurfacingPage> createState() => _ErrorSurfacingPageState();
}

class _ErrorSurfacingPageState extends ConsumerState<ErrorSurfacingPage> {
  ErrorFilter? _currentFilter;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(errorNotifierProvider.notifier).loadErrors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final errorState = ref.watch(errorNotifierProvider);
    final errorStats = ref.watch(errorStatsProvider);

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Error Debug'),
        backgroundColor: IOSGradeTheme.surface,
        foregroundColor: IOSGradeTheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list : Icons.filter_list_outlined),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_resolved',
                child: Text('Clear Resolved'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear All'),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Text('Export Errors'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Error Statistics
          errorStats.when(
            data: (stats) => _buildErrorStats(stats),
            loading: () => const IOSGradeLoadingIndicator(),
            error: (error, _) => IOSGradeErrorWidget(
              error: error.toString(),
              onRetry: () => ref.refresh(errorStatsProvider),
            ),
          ),
          
          // Filters
          if (_showFilters) _buildFilters(),
          
          // Error List
          Expanded(
            child: errorState.when(
              idle: () => const Center(child: Text('No errors loaded')),
              loading: () => const Center(child: IOSGradeLoadingIndicator()),
              success: (errors) => _buildErrorList(errors),
              error: (error) => IOSGradeErrorWidget(
                error: error.toString(),
                onRetry: () => ref.read(errorNotifierProvider.notifier).loadErrors(filter: _currentFilter),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorStats(ErrorStats stats) {
    return Container(
      margin: const EdgeInsets.all(IOSGradeTheme.spacing16),
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
          Text(
            'Error Statistics',
            style: IOSGradeTheme.headlineSmall.copyWith(
              color: IOSGradeTheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', stats.totalErrors.toString(), IOSGradeTheme.primary),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Active', stats.activeErrors.toString(), IOSGradeTheme.error),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Resolved', stats.resolvedErrors.toString(), IOSGradeTheme.success),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Ignored', stats.ignoredErrors.toString(), IOSGradeTheme.warning),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: IOSGradeTheme.headlineMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Text(
            label,
            style: IOSGradeTheme.labelSmall.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: IOSGradeTheme.spacing16),
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
          Text(
            'Filters',
            style: IOSGradeTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: IOSGradeTheme.onSurface,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<ErrorType>(
                  value: _currentFilter?.type,
                  hint: const Text('Error Type'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.outline),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.outline),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.primary),
                    ),
                    filled: true,
                    fillColor: IOSGradeTheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: IOSGradeTheme.spacing16,
                      vertical: IOSGradeTheme.spacing12,
                    ),
                  ),
                  items: ErrorType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = ErrorFilter(
                        type: value,
                        severity: _currentFilter?.severity,
                        status: _currentFilter?.status,
                        fromDate: _currentFilter?.fromDate,
                        toDate: _currentFilter?.toDate,
                        userId: _currentFilter?.userId,
                        searchQuery: _currentFilter?.searchQuery,
                      );
                    });
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: DropdownButtonFormField<ErrorSeverity>(
                  value: _currentFilter?.severity,
                  hint: const Text('Severity'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.outline),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.outline),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                      borderSide: BorderSide(color: IOSGradeTheme.primary),
                    ),
                    filled: true,
                    fillColor: IOSGradeTheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: IOSGradeTheme.spacing16,
                      vertical: IOSGradeTheme.spacing12,
                    ),
                  ),
                  items: ErrorSeverity.values.map((severity) {
                    return DropdownMenuItem(
                      value: severity,
                      child: Text(severity.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFilter = ErrorFilter(
                        type: _currentFilter?.type,
                        severity: value,
                        status: _currentFilter?.status,
                        fromDate: _currentFilter?.fromDate,
                        toDate: _currentFilter?.toDate,
                        userId: _currentFilter?.userId,
                        searchQuery: _currentFilter?.searchQuery,
                      );
                    });
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing12),
          Row(
            children: [
              Expanded(
                child: IOSGradeButton(
                  onPressed: _clearFilters,
                  child: const Text('Clear Filters'),
                  backgroundColor: IOSGradeTheme.surfaceVariant,
                  foregroundColor: IOSGradeTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: IOSGradeButton(
                  onPressed: _applyFilters,
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorList(List<AppError> errors) {
    if (errors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: IOSGradeTheme.success,
            ),
            const SizedBox(height: IOSGradeTheme.spacing16),
            Text(
              'No Errors Found',
              style: IOSGradeTheme.headlineSmall.copyWith(
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing8),
            Text(
              'All systems are running smoothly',
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing16),
      itemCount: errors.length,
      itemBuilder: (context, index) {
        final error = errors[index];
        return _buildErrorItem(error);
      },
    );
  }

  Widget _buildErrorItem(AppError error) {
    return Card(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing12),
      color: IOSGradeTheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        side: BorderSide(
          color: _getSeverityColor(error.severity).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(
              _getErrorTypeIcon(error.type),
              color: _getSeverityColor(error.severity),
              size: 20,
            ),
            const SizedBox(width: IOSGradeTheme.spacing8),
            Expanded(
              child: Text(
                error.message,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: IOSGradeTheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildStatusBadge(error.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: IOSGradeTheme.spacing4),
            Row(
              children: [
                Text(
                  error.type.displayName,
                  style: IOSGradeTheme.labelSmall.copyWith(
                    color: _getSeverityColor(error.severity),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: IOSGradeTheme.spacing8),
                Text(
                  '•',
                  style: IOSGradeTheme.labelSmall.copyWith(
                    color: IOSGradeTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: IOSGradeTheme.spacing8),
                Text(
                  _formatTimestamp(error.timestamp),
                  style: IOSGradeTheme.labelSmall.copyWith(
                    color: IOSGradeTheme.onSurfaceVariant,
                  ),
                ),
                if (error.retryCount > 0) ...[
                  const SizedBox(width: IOSGradeTheme.spacing8),
                  Text(
                    '•',
                    style: IOSGradeTheme.labelSmall.copyWith(
                      color: IOSGradeTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing8),
                  Text(
                    '${error.retryCount} retries',
                    style: IOSGradeTheme.labelSmall.copyWith(
                      color: IOSGradeTheme.warning,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (error.stackTrace != null) ...[
                  Text(
                    'Stack Trace',
                    style: IOSGradeTheme.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: IOSGradeTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                    ),
                    child: Text(
                      error.stackTrace!,
                      style: IOSGradeTheme.bodySmall.copyWith(
                        fontFamily: 'monospace',
                        color: IOSGradeTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing16),
                ],
                if (error.context != null) ...[
                  Text(
                    'Context',
                    style: IOSGradeTheme.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: IOSGradeTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                    ),
                    child: Text(
                      error.context.toString(),
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing16),
                ],
                Row(
                  children: [
                    if (error.isRetryable && error.status == ErrorStatus.active) ...[
                      IOSGradeButton(
                        onPressed: () => _retryError(error.id),
                        child: const Text('Retry'),
                        backgroundColor: IOSGradeTheme.primary,
                        foregroundColor: IOSGradeTheme.onPrimary,
                      ),
                      const SizedBox(width: IOSGradeTheme.spacing8),
                    ],
                    if (error.status == ErrorStatus.active) ...[
                      IOSGradeButton(
                        onPressed: () => _markAsResolved(error.id),
                        child: const Text('Mark Resolved'),
                        backgroundColor: IOSGradeTheme.success,
                        foregroundColor: IOSGradeTheme.onPrimary,
                      ),
                      const SizedBox(width: IOSGradeTheme.spacing8),
                      IOSGradeButton(
                        onPressed: () => _markAsIgnored(error.id),
                        child: const Text('Ignore'),
                        backgroundColor: IOSGradeTheme.warning,
                        foregroundColor: IOSGradeTheme.onPrimary,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ErrorStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Text(
        status.displayName,
        style: IOSGradeTheme.labelSmall.copyWith(
          color: _getStatusColor(status),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getSeverityColor(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.low:
        return IOSGradeTheme.info;
      case ErrorSeverity.medium:
        return IOSGradeTheme.warning;
      case ErrorSeverity.high:
        return IOSGradeTheme.error;
      case ErrorSeverity.critical:
        return IOSGradeTheme.error;
    }
  }

  Color _getStatusColor(ErrorStatus status) {
    switch (status) {
      case ErrorStatus.active:
        return IOSGradeTheme.error;
      case ErrorStatus.resolved:
        return IOSGradeTheme.success;
      case ErrorStatus.ignored:
        return IOSGradeTheme.warning;
      case ErrorStatus.retrying:
        return IOSGradeTheme.info;
    }
  }

  IconData _getErrorTypeIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.authentication:
        return Icons.lock;
      case ErrorType.authorization:
        return Icons.security;
      case ErrorType.validation:
        return Icons.check_circle_outline;
      case ErrorType.server:
        return Icons.dns;
      case ErrorType.database:
        return Icons.storage;
      case ErrorType.fileSystem:
        return Icons.folder;
      case ErrorType.permission:
        return Icons.block;
      case ErrorType.timeout:
        return Icons.timer;
      case ErrorType.unknown:
        return Icons.help_outline;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _applyFilters() {
    ref.read(errorNotifierProvider.notifier).loadErrors(filter: _currentFilter);
  }

  void _clearFilters() {
    setState(() {
      _currentFilter = null;
    });
    _applyFilters();
  }

  void _retryError(String errorId) async {
    final success = await ref.read(errorNotifierProvider.notifier).retryError(errorId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Error retry successful' : 'Error retry failed'),
          backgroundColor: success ? IOSGradeTheme.success : IOSGradeTheme.error,
        ),
      );
    }
  }

  void _markAsResolved(String errorId) async {
    await ref.read(errorNotifierProvider.notifier).markAsResolved(errorId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error marked as resolved'),
          backgroundColor: IOSGradeTheme.success,
        ),
      );
    }
  }

  void _markAsIgnored(String errorId) async {
    await ref.read(errorNotifierProvider.notifier).markAsIgnored(errorId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error marked as ignored'),
          backgroundColor: IOSGradeTheme.warning,
        ),
      );
    }
  }

  void _handleMenuAction(String action) async {
    switch (action) {
      case 'clear_resolved':
        await ref.read(errorNotifierProvider.notifier).clearResolvedErrors();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Resolved errors cleared'),
              backgroundColor: IOSGradeTheme.success,
            ),
          );
        }
        break;
      case 'clear_all':
        await ref.read(errorNotifierProvider.notifier).clearAllErrors();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('All errors cleared'),
              backgroundColor: IOSGradeTheme.success,
            ),
          );
        }
        break;
      case 'export':
        // TODO: Implement error export functionality
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Export functionality coming soon'),
            ),
          );
        }
        break;
    }
  }
}
