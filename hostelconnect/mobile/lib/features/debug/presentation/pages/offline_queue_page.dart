import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/offline_models.dart';
import 'package:hostelconnect/core/providers/offline_error_health_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';
import 'package:hostelconnect/core/models/load_state.dart';

/// Offline Queue Management Page
/// Displays offline queue items and allows manual sync
class OfflineQueuePage extends ConsumerStatefulWidget {
  const OfflineQueuePage({super.key});

  @override
  ConsumerState<OfflineQueuePage> createState() => _OfflineQueuePageState();
}

class _OfflineQueuePageState extends ConsumerState<OfflineQueuePage> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(offlineQueueNotifierProvider.notifier).loadQueue();
    });
  }

  @override
  Widget build(BuildContext context) {
    final queueState = ref.watch(offlineQueueNotifierProvider);
    final statsState = ref.watch(offlineQueueStatsProvider);
    final networkStatus = ref.watch(networkStatusProvider);

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Offline Queue'),
        backgroundColor: IOSGradeTheme.surface,
        foregroundColor: IOSGradeTheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isProcessing ? null : _processQueue,
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_completed',
                child: Text('Clear Completed'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear All'),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Text('Export Queue'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Network Status
          _buildNetworkStatus(networkStatus),
          
          // Queue Statistics
          statsState.when(
            data: (stats) => _buildQueueStats(stats),
            loading: () => const IOSGradeLoadingIndicator(),
            error: (error, _) => IOSGradeErrorWidget(
              error: error.toString(),
              onRetry: () => ref.refresh(offlineQueueStatsProvider),
            ),
          ),
          
          // Queue List
          Expanded(
            child: queueState.when(
              idle: () => const Center(child: Text('No queue loaded')),
              loading: () => const Center(child: IOSGradeLoadingIndicator()),
              success: (queue) => _buildQueueList(queue),
              error: (error) => IOSGradeErrorWidget(
                error: error.toString(),
                onRetry: () => ref.read(offlineQueueNotifierProvider.notifier).loadQueue(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: networkStatus.when(
        data: (isConnected) => isConnected && !_isProcessing
            ? FloatingActionButton(
                onPressed: _processQueue,
                backgroundColor: IOSGradeTheme.primary,
                child: const Icon(Icons.sync, color: IOSGradeTheme.onPrimary),
              )
            : null,
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }

  Widget _buildNetworkStatus(AsyncValue<bool> networkStatus) {
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
      child: Row(
        children: [
          Icon(
            networkStatus.when(
              data: (isConnected) => isConnected ? Icons.wifi : Icons.wifi_off,
              loading: () => Icons.wifi,
              error: (_, __) => Icons.wifi_off,
            ),
            color: networkStatus.when(
              data: (isConnected) => isConnected ? IOSGradeTheme.success : IOSGradeTheme.error,
              loading: () => IOSGradeTheme.warning,
              error: (_, __) => IOSGradeTheme.error,
            ),
            size: 24,
          ),
          const SizedBox(width: IOSGradeTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Network Status',
                  style: IOSGradeTheme.labelMedium.copyWith(
                    color: IOSGradeTheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  networkStatus.when(
                    data: (isConnected) => isConnected ? 'Connected' : 'Offline',
                    loading: () => 'Checking...',
                    error: (_, __) => 'Error',
                  ),
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: IOSGradeTheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          if (_isProcessing) ...[
            const SizedBox(width: IOSGradeTheme.spacing8),
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQueueStats(OfflineQueueStats stats) {
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
            'Queue Statistics',
            style: IOSGradeTheme.headlineSmall.copyWith(
              color: IOSGradeTheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', stats.totalItems.toString(), IOSGradeTheme.primary),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Pending', stats.pendingItems.toString(), IOSGradeTheme.warning),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Completed', stats.completedItems.toString(), IOSGradeTheme.success),
              ),
              const SizedBox(width: IOSGradeTheme.spacing8),
              Expanded(
                child: _buildStatCard('Failed', stats.failedItems.toString(), IOSGradeTheme.error),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing12),
          Text(
            'Last Sync: ${_formatTimestamp(stats.lastSyncAt)}',
            style: IOSGradeTheme.bodySmall.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
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

  Widget _buildQueueList(List<OfflineQueueItem> queue) {
    if (queue.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_outlined,
              size: 64,
              color: IOSGradeTheme.onSurfaceVariant,
            ),
            const SizedBox(height: IOSGradeTheme.spacing16),
            Text(
              'Queue is Empty',
              style: IOSGradeTheme.headlineSmall.copyWith(
                color: IOSGradeTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing8),
            Text(
              'No offline operations pending',
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
      itemCount: queue.length,
      itemBuilder: (context, index) {
        final item = queue[index];
        return _buildQueueItem(item);
      },
    );
  }

  Widget _buildQueueItem(OfflineQueueItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing12),
      color: IOSGradeTheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        side: BorderSide(
          color: _getStatusColor(item.status).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(
              _getOperationTypeIcon(item.type),
              color: _getStatusColor(item.status),
              size: 20,
            ),
            const SizedBox(width: IOSGradeTheme.spacing8),
            Expanded(
              child: Text(
                item.type.displayName,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: IOSGradeTheme.onSurface,
                ),
              ),
            ),
            _buildStatusBadge(item.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: IOSGradeTheme.spacing4),
            Row(
              children: [
                Text(
                  'Created: ${_formatTimestamp(item.createdAt)}',
                  style: IOSGradeTheme.labelSmall.copyWith(
                    color: IOSGradeTheme.onSurfaceVariant,
                  ),
                ),
                if (item.retryCount > 0) ...[
                  const SizedBox(width: IOSGradeTheme.spacing8),
                  Text(
                    '•',
                    style: IOSGradeTheme.labelSmall.copyWith(
                      color: IOSGradeTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing8),
                  Text(
                    '${item.retryCount} retries',
                    style: IOSGradeTheme.labelSmall.copyWith(
                      color: IOSGradeTheme.warning,
                    ),
                  ),
                ],
              ],
            ),
            if (item.lastAttemptedAt != null) ...[
              const SizedBox(height: IOSGradeTheme.spacing4),
              Text(
                'Last Attempt: ${_formatTimestamp(item.lastAttemptedAt!)}',
                style: IOSGradeTheme.labelSmall.copyWith(
                  color: IOSGradeTheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operation Data',
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
                    item.data.toString(),
                    style: IOSGradeTheme.bodySmall.copyWith(
                      fontFamily: 'monospace',
                      color: IOSGradeTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (item.errorMessage != null) ...[
                  const SizedBox(height: IOSGradeTheme.spacing12),
                  Text(
                    'Error Message',
                    style: IOSGradeTheme.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: IOSGradeTheme.error,
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(IOSGradeTheme.spacing12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      border: Border.all(color: IOSGradeTheme.error.withOpacity(0.3)),
                    ),
                    child: Text(
                      item.errorMessage!,
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.error,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: IOSGradeTheme.spacing16),
                Row(
                  children: [
                    if (item.status == OfflineQueueStatus.failed) ...[
                      IOSGradeButton(
                        onPressed: () => _retryItem(item.id),
                        child: const Text('Retry'),
                        backgroundColor: IOSGradeTheme.primary,
                        foregroundColor: IOSGradeTheme.onPrimary,
                      ),
                      const SizedBox(width: IOSGradeTheme.spacing8),
                    ],
                    if (item.status == OfflineQueueStatus.pending || 
                        item.status == OfflineQueueStatus.failed) ...[
                      IOSGradeButton(
                        onPressed: () => _cancelItem(item.id),
                        child: const Text('Cancel'),
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

  Widget _buildStatusBadge(OfflineQueueStatus status) {
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

  Color _getStatusColor(OfflineQueueStatus status) {
    switch (status) {
      case OfflineQueueStatus.pending:
        return IOSGradeTheme.warning;
      case OfflineQueueStatus.processing:
        return IOSGradeTheme.info;
      case OfflineQueueStatus.completed:
        return IOSGradeTheme.success;
      case OfflineQueueStatus.failed:
        return IOSGradeTheme.error;
      case OfflineQueueStatus.cancelled:
        return IOSGradeTheme.onSurfaceVariant;
    }
  }

  IconData _getOperationTypeIcon(OfflineOperationType type) {
    switch (type) {
      case OfflineOperationType.attendanceScan:
        return Icons.qr_code_scanner;
      case OfflineOperationType.noticeRead:
        return Icons.notifications;
      case OfflineOperationType.gatePassScan:
        return Icons.door_front_door;
      case OfflineOperationType.mealIntent:
        return Icons.restaurant;
      case OfflineOperationType.userAction:
        return Icons.person;
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

  Future<void> _processQueue() async {
    if (_isProcessing) return;
    
    setState(() {
      _isProcessing = true;
    });

    try {
      await ref.read(offlineQueueNotifierProvider.notifier).processQueue();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Queue processed successfully'),
            backgroundColor: IOSGradeTheme.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Queue processing failed: $e'),
            backgroundColor: IOSGradeTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _retryItem(String itemId) async {
    // TODO: Implement individual item retry
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Individual retry coming soon'),
        ),
      );
    }
  }

  Future<void> _cancelItem(String itemId) async {
    // TODO: Implement item cancellation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item cancellation coming soon'),
        ),
      );
    }
  }

  void _handleMenuAction(String action) async {
    switch (action) {
      case 'clear_completed':
        await ref.read(offlineQueueNotifierProvider.notifier).clearCompletedItems();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Completed items cleared'),
              backgroundColor: IOSGradeTheme.success,
            ),
          );
        }
        break;
      case 'clear_all':
        await ref.read(offlineQueueNotifierProvider.notifier).clearQueue();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('All items cleared'),
              backgroundColor: IOSGradeTheme.success,
            ),
          );
        }
        break;
      case 'export':
        // TODO: Implement queue export functionality
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
