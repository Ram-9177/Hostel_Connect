// lib/features/debug/presentation/pages/error_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/error_service.dart';
import '../../../../core/offline/offline_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;

class ErrorPage extends ConsumerStatefulWidget {
  const ErrorPage({super.key});

  @override
  ConsumerState<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends ConsumerState<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    final errorState = ref.watch(ErrorService.errorStateProvider);
    final offlineState = ref.watch(OfflineService.offlineStateProvider);

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Error Logs & Debug'),
        backgroundColor: IOSGradeTheme.surface,
        elevation: 0,
        leading: const ui.BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(ErrorService.errorStateProvider.notifier)._loadRecentErrors();
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              _showClearConfirmation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSystemStatus(offlineState),
            const SizedBox(height: IOSGradeTheme.spacing6),
            _buildErrorLogs(errorState),
            const SizedBox(height: IOSGradeTheme.spacing6),
            _buildOfflineQueue(offlineState),
            const SizedBox(height: IOSGradeTheme.spacing6),
            _buildDebugActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatus(OfflineState offlineState) {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Status',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  'Connection',
                  offlineState.isOnline ? 'Online' : 'Offline',
                  offlineState.isOnline ? IOSGradeTheme.success : IOSGradeTheme.error,
                  offlineState.isOnline ? Icons.wifi : Icons.wifi_off,
                ),
              ),
              Expanded(
                child: _buildStatusItem(
                  'Last Check',
                  _formatTime(offlineState.lastChecked),
                  IOSGradeTheme.info,
                  Icons.access_time,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  'Queue Size',
                  '${offlineState.queueSize}',
                  offlineState.queueSize > 0 ? IOSGradeTheme.warning : IOSGradeTheme.success,
                  Icons.queue_outlined,
                ),
              ),
              Expanded(
                child: _buildStatusItem(
                  'Processing',
                  offlineState.isProcessingQueue ? 'Yes' : 'No',
                  offlineState.isProcessingQueue ? IOSGradeTheme.warning : IOSGradeTheme.success,
                  Icons.sync,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: IOSGradeTheme.spacing1),
          Text(
            value,
            style: IOSGradeTheme.callout.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: IOSGradeTheme.caption1.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorLogs(ErrorState errorState) {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recent Errors',
                style: IOSGradeTheme.title2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (errorState.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          if (errorState.recentErrors.isEmpty)
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
              decoration: BoxDecoration(
                color: IOSGradeTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: IOSGradeTheme.success,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text(
                    'No errors logged',
                    style: IOSGradeTheme.callout.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                ],
              ),
            )
          else
            ...errorState.recentErrors.map((error) => _buildErrorItem(error)),
        ],
      ),
    );
  }

  Widget _buildErrorItem(ErrorLog error) {
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: error.isResolved 
            ? IOSGradeTheme.success.withOpacity(0.1)
            : IOSGradeTheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(
          color: error.isResolved 
              ? IOSGradeTheme.success.withOpacity(0.3)
              : IOSGradeTheme.error.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                error.isResolved ? Icons.check_circle : Icons.error_outline,
                color: error.isResolved ? IOSGradeTheme.success : IOSGradeTheme.error,
                size: 16,
              ),
              const SizedBox(width: IOSGradeTheme.spacing2),
              Expanded(
                child: Text(
                  error.message,
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (!error.isResolved)
                IconButton(
                  icon: const Icon(Icons.refresh, size: 16),
                  onPressed: () => _retryError(error),
                ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing2),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: IOSGradeTheme.spacing1,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: _getErrorTypeColor(error.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  error.type.toUpperCase(),
                  style: IOSGradeTheme.caption2.copyWith(
                    color: _getErrorTypeColor(error.type),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing2),
              Text(
                _formatTime(error.timestamp),
                style: IOSGradeTheme.caption2.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
              const Spacer(),
              if (error.isUserFacing)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: IOSGradeTheme.spacing1,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: IOSGradeTheme.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'USER FACING',
                    style: IOSGradeTheme.caption2.copyWith(
                      color: IOSGradeTheme.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineQueue(OfflineState offlineState) {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Offline Queue',
                style: IOSGradeTheme.title2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (offlineState.queueSize > 0)
                ElevatedButton(
                  onPressed: offlineState.isProcessingQueue 
                      ? null 
                      : () => ref.read(OfflineService.offlineStateProvider.notifier).processOfflineQueue(),
                  child: offlineState.isProcessingQueue
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Process Queue'),
                ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          if (offlineState.queueSize == 0)
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
              decoration: BoxDecoration(
                color: IOSGradeTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: IOSGradeTheme.success,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text(
                    'No pending actions',
                    style: IOSGradeTheme.callout.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
              decoration: BoxDecoration(
                color: IOSGradeTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.queue_outlined,
                    color: IOSGradeTheme.warning,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text(
                    '${offlineState.queueSize} actions pending',
                    style: IOSGradeTheme.callout.copyWith(
                      color: IOSGradeTheme.warning,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDebugActions() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Debug Actions',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Wrap(
            spacing: IOSGradeTheme.spacing2,
            runSpacing: IOSGradeTheme.spacing2,
            children: [
              ElevatedButton(
                onPressed: () => _simulateError(),
                child: const Text('Simulate Error'),
              ),
              ElevatedButton(
                onPressed: () => _simulateOfflineAction(),
                child: const Text('Simulate Offline Action'),
              ),
              ElevatedButton(
                onPressed: () => _clearAllData(),
                child: const Text('Clear All Data'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getErrorTypeColor(String type) {
    switch (type) {
      case 'network':
        return IOSGradeTheme.error;
      case 'auth':
        return IOSGradeTheme.warning;
      case 'validation':
        return IOSGradeTheme.info;
      case 'retry_failure':
        return IOSGradeTheme.error;
      default:
        return IOSGradeTheme.textSecondary;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Errors'),
        content: const Text('Are you sure you want to clear all error logs? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(ErrorService.errorStateProvider.notifier).clearAllErrors();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: IOSGradeTheme.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _retryError(ErrorLog error) {
    if (error.context != null) {
      ref.read(ErrorService.errorStateProvider.notifier).retryAction(
        error.type,
        error.context!,
      );
    }
  }

  void _simulateError() {
    ref.read(ErrorService.errorStateProvider.notifier).logError(
      message: 'Simulated error for testing',
      type: 'test',
      context: {'simulated': true},
      isUserFacing: true,
    );
  }

  void _simulateOfflineAction() {
    ref.read(OfflineService.offlineStateProvider.notifier).queueAction(
      type: 'test_action',
      data: {'simulated': true},
    );
  }

  void _clearAllData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text('This will clear all error logs and offline queue. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(ErrorService.errorStateProvider.notifier).clearAllErrors();
              ref.read(OfflineService.offlineStateProvider.notifier).clearOfflineQueue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: IOSGradeTheme.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
