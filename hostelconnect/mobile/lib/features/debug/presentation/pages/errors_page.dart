import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/performance/performance_optimization.dart';
import '../../shared/theme/telugu_theme.dart';

class ErrorsPage extends ConsumerStatefulWidget {
  const ErrorsPage({super.key});

  @override
  ConsumerState<ErrorsPage> createState() => _ErrorsPageState();
}

class _ErrorsPageState extends ConsumerState<ErrorsPage> {
  @override
  void initState() {
    super.initState();
    // Start monitoring when page loads
    ConnectivityMonitor.startMonitoring();
  }

  @override
  void dispose() {
    ConnectivityMonitor.stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      appBar: AppBar(
        title: const Text('Debug & Errors'),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: HTeluguTheme.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHealthStatus(),
            const SizedBox(height: 16),
            _buildConnectivityStatus(),
            const SizedBox(height: 16),
            _buildPerformanceMetrics(),
            const SizedBox(height: 16),
            _buildErrorLog(),
            const SizedBox(height: 16),
            _buildOfflineQueue(),
            const SizedBox(height: 16),
            _buildMVFreshness(),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  HealthMonitor.isHealthy ? Icons.check_circle : Icons.error,
                  color: HealthMonitor.isHealthy ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'API Health',
                  style: HTeluguTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              HealthMonitor.isHealthy ? 'Healthy' : 'Unhealthy',
              style: TextStyle(
                color: HealthMonitor.isHealthy ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (HealthMonitor.lastError != null) ...[
              const SizedBox(height: 4),
              Text(
                'Last Error: ${HealthMonitor.lastError}',
                style: HTeluguTheme.bodySmall.copyWith(color: Colors.red),
              ),
            ],
            if (HealthMonitor.timeSinceLastCheck != null) ...[
              const SizedBox(height: 4),
              Text(
                'Last Check: ${HealthMonitor.timeSinceLastCheck!.inMinutes}m ago',
                style: HTeluguTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConnectivityStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  ConnectivityMonitor.isConnected ? Icons.wifi : Icons.wifi_off,
                  color: ConnectivityMonitor.isConnected ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  'Connectivity',
                  style: HTeluguTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ConnectivityMonitor.isConnected ? 'Connected' : 'Disconnected',
              style: TextStyle(
                color: ConnectivityMonitor.isConnected ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Type: ${ConnectivityMonitor.connectionTypeString}',
              style: HTeluguTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    final metrics = PerformanceMonitor.getMetrics();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.speed),
                const SizedBox(width: 8),
                Text(
                  'Performance Metrics',
                  style: HTeluguTheme.headlineSmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    PerformanceMonitor.clearMetrics();
                    setState(() {});
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (metrics.isEmpty)
              Text(
                'No metrics recorded',
                style: HTeluguTheme.bodySmall.copyWith(color: Colors.grey),
              )
            else
              ...metrics.take(10).map((metric) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        metric.operation,
                        style: HTeluguTheme.bodySmall,
                      ),
                    ),
                    Text(
                      '${metric.duration.inMilliseconds}ms',
                      style: HTeluguTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: metric.duration.inMilliseconds > 300 
                            ? Colors.red 
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorLog() {
    final errors = ErrorHandler.getErrors();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error_outline),
                const SizedBox(width: 8),
                Text(
                  'Error Log',
                  style: HTeluguTheme.headlineSmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ErrorHandler.clearErrors();
                    setState(() {});
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (errors.isEmpty)
              Text(
                'No errors recorded',
                style: HTeluguTheme.bodySmall.copyWith(color: Colors.grey),
              )
            else
              ...errors.take(10).map((error) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      error.message,
                      style: HTeluguTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    if (error.details != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        error.details!,
                        style: HTeluguTheme.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    Text(
                      '${error.timestamp.hour}:${error.timestamp.minute.toString().padLeft(2, '0')}',
                      style: HTeluguTheme.bodySmall.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineQueue() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.queue),
                const SizedBox(width: 8),
                Text(
                  'Offline Queue',
                  style: HTeluguTheme.headlineSmall,
                ),
                const Spacer(),
                FutureBuilder<List<OfflineAction>>(
                  future: OfflineQueue.getQueue(),
                  builder: (context, snapshot) {
                    final count = snapshot.data?.length ?? 0;
                    return Text(
                      '$count items',
                      style: HTeluguTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: count > 0 ? Colors.orange : Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await OfflineQueue.processQueue();
                    setState(() {});
                  },
                  child: const Text('Process Queue'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    await OfflineQueue.clearQueue();
                    setState(() {});
                  },
                  child: const Text('Clear Queue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMVFreshness() {
    final staleness = MVFreshnessMonitor.getAllStaleness();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.update),
                const SizedBox(width: 8),
                Text(
                  'Data Freshness',
                  style: HTeluguTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (staleness.isEmpty)
              Text(
                'No data views tracked',
                style: HTeluguTheme.bodySmall.copyWith(color: Colors.grey),
              )
            else
              ...staleness.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: HTeluguTheme.bodySmall,
                      ),
                    ),
                    Text(
                      '${entry.value.inMinutes}m',
                      style: HTeluguTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: entry.value.inMinutes > 30 
                            ? Colors.red 
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: HTeluguTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await HealthMonitor.checkApiHealth();
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Check Health'),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await ErrorHandler.retrySafeActions();
                    setState(() {});
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Retry Actions'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    PerformanceMonitor.clearMetrics();
                    ErrorHandler.clearErrors();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
