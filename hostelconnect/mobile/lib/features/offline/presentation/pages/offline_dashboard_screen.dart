import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hostelconnect/core/services/background_sync_service.dart';
import 'package:hostelconnect/core/services/offline_storage_service.dart';
import 'package:hostelconnect/core/services/sync_service.dart';

class OfflineDashboardScreen extends StatefulWidget {
  const OfflineDashboardScreen({Key? key}) : super(key: key);

  @override
  State<OfflineDashboardScreen> createState() => _OfflineDashboardScreenState();
}

class _OfflineDashboardScreenState extends State<OfflineDashboardScreen> {
  bool _isOnline = true;
  Map<String, int> _offlineDataCount = {};
  DateTime? _lastSync;
  bool _isLoading = false;
  List<Map<String, dynamic>> _offlineGatePasses = [];
  List<Map<String, dynamic>> _offlineEmergencyRequests = [];
  List<Map<String, dynamic>> _syncQueueItems = [];

  static final DateFormat _timestampFormat = DateFormat('MMM d, yyyy • h:mm a');

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final isOnline = await OfflineStorageService.isOnline();
      final offlineDataCount =
          await OfflineStorageService.getOfflineDataCount();
      final lastSync = await OfflineStorageService.getLastSyncTimestamp();
      final gatePasses = await OfflineStorageService.getOfflineGatePasses();
      final emergencyRequests =
          await OfflineStorageService.getOfflineEmergencyRequests();
      final syncQueue = await OfflineStorageService.getSyncQueue();

      if (!mounted) return;

      setState(() {
        _isOnline = isOnline;
        _offlineDataCount = offlineDataCount;
        _lastSync = lastSync;
        _offlineGatePasses =
            gatePasses.map((item) => Map<String, dynamic>.from(item)).toList();
        _offlineEmergencyRequests = emergencyRequests
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        _syncQueueItems =
            syncQueue.map((item) => Map<String, dynamic>.from(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading offline data: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _manualSync() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final result = await SyncService.manualSync();

      if (result['isOnline'] == true) {
        if (result['totalSynced'] > 0) {
          _showSnackBar('Synced ${result['totalSynced']} items successfully!',
              Colors.green);
        } else if (result['totalFailed'] > 0) {
          _showSnackBar(
              'Failed to sync ${result['totalFailed']} items. Will retry later.',
              Colors.orange);
        } else {
          _showSnackBar('No offline data to sync.', Colors.blue);
        }
      } else {
        _showSnackBar('No internet connection available for sync.', Colors.red);
      }

      await _loadData();
    } catch (e) {
      _showSnackBar('Sync failed: $e', Colors.red);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Dashboard'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Connection Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _isOnline ? Icons.wifi : Icons.wifi_off,
                                color: _isOnline ? Colors.green : Colors.red,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isOnline ? 'Online' : 'Offline',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _isOnline ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isOnline
                                ? 'You are connected to the internet'
                                : 'You are currently offline. Data will be synced when connection is restored.',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Offline Data Count Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Offline Data',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildDataItem(
                                'Gate Passes',
                                _offlineDataCount['gatePasses'] ?? 0,
                                Icons.door_front_door,
                                Colors.blue,
                              ),
                              _buildDataItem(
                                'Emergency Requests',
                                _offlineDataCount['emergencyRequests'] ?? 0,
                                Icons.emergency,
                                Colors.red,
                              ),
                              _buildDataItem(
                                'Pending Sync',
                                _offlineDataCount['syncQueue'] ?? 0,
                                Icons.sync,
                                Colors.orange,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (_offlineGatePasses.isNotEmpty)
                    _buildOfflineItemsCard(
                      title: 'Gate Pass Drafts',
                      type: 'gate_pass',
                      items: _offlineGatePasses,
                    ),

                  if (_offlineGatePasses.isNotEmpty) const SizedBox(height: 16),

                  if (_offlineEmergencyRequests.isNotEmpty)
                    _buildOfflineItemsCard(
                      title: 'Emergency Requests Awaiting Sync',
                      type: 'emergency_request',
                      items: _offlineEmergencyRequests,
                    ),

                  if (_offlineEmergencyRequests.isNotEmpty)
                    const SizedBox(height: 16),

                  if (_syncQueueItems.isNotEmpty) _buildSyncQueueCard(),

                  if (_syncQueueItems.isNotEmpty) const SizedBox(height: 16),

                  // Last Sync Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Sync',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _lastSync != null
                                ? _timestampFormat.format(_lastSync!.toLocal())
                                : 'Never synced',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Background Sync Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                BackgroundSyncService.isActive
                                    ? Icons.sync
                                    : Icons.sync_disabled,
                                color: BackgroundSyncService.isActive
                                    ? Colors.green
                                    : Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Background Sync',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            BackgroundSyncService.isActive
                                ? 'Background sync is active. WorkManager will schedule sync roughly every 15 minutes and whenever connectivity is restored.'
                                : 'Background sync is disabled.',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sync Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _manualSync,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.sync),
                                const SizedBox(width: 8),
                                Text(
                                  'Manual Sync',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'How Offline Mode Works',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Your applications and requests are saved locally when offline\n'
                            '• Data is automatically synced when internet connection is restored\n'
                            '• Background sync runs approximately every 15 minutes when online\n'
                            '• You can manually sync anytime using the sync button\n'
                            '• Failed syncs are retried up to 3 times',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDataItem(String label, int count, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Card _buildOfflineItemsCard({
    required String title,
    required String type,
    required List<Map<String, dynamic>> items,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < items.length; i++) ...[
              _buildOfflineItemTile(type, items[i]),
              if (i < items.length - 1) const Divider(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Card _buildSyncQueueCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sync Queue',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < _syncQueueItems.length; i++) ...[
              _buildQueueItemTile(_syncQueueItems[i]),
              if (i < _syncQueueItems.length - 1) const Divider(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineItemTile(String type, Map<String, dynamic> item) {
    final String status =
        (item['syncStatus'] as String?)?.toUpperCase() ?? 'PENDING';
    final Color statusColor = _resolveStatusColor(status);
    final String? createdLabel = _formatCreatedAt(item['createdAt'] as String?);
    final String? lastError = (item['lastError'] as String?)?.trim();
    final String title = _resolveOfflineTitle(type, item);
    final IconData leadingIcon = type == 'gate_pass'
        ? Icons.door_sliding_outlined
        : Icons.emergency_share;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(leadingIcon, color: statusColor, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    label: Text(status),
                    backgroundColor: statusColor.withOpacity(0.12),
                    labelStyle: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  if ((item['id'] as String?)?.isNotEmpty == true)
                    Text(
                      'ID: ${item['id']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  if (createdLabel != null)
                    Text(
                      'Saved $createdLabel',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              if (lastError != null && lastError.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  lastError,
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQueueItemTile(Map<String, dynamic> item) {
    final String type = item['type'] as String? ?? 'unknown';
    final Map<String, dynamic> data =
        Map<String, dynamic>.from(item['data'] as Map<String, dynamic>);
    final String status =
        (data['syncStatus'] as String?)?.toUpperCase() ?? 'PENDING';
    final int retryCount = (item['retryCount'] as int?) ?? 0;
    final String? lastError = (item['lastError'] as String?)?.trim();
    final String? timestamp = _formatCreatedAt(item['timestamp'] as String?);
    final Color statusColor = _resolveStatusColor(status);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.sync_problem, color: statusColor, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _resolveOfflineTitle(type, data),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    label: Text('$status · Retry $retryCount'),
                    backgroundColor: statusColor.withOpacity(0.12),
                    labelStyle: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Text(
                    type.replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  if ((data['id'] as String?)?.isNotEmpty == true)
                    Text(
                      'ID: ${data['id']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  if (timestamp != null)
                    Text(
                      'Queued $timestamp',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              if (lastError != null && lastError.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  lastError,
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _resolveOfflineTitle(String type, Map<String, dynamic> item) {
    final titleCandidates = [
      item['title'],
      item['purpose'],
      item['reason'],
      item['subject'],
      item['category'],
      item['studentName'],
    ];

    for (final candidate in titleCandidates) {
      if (candidate is String && candidate.trim().isNotEmpty) {
        return candidate.trim();
      }
    }

    switch (type) {
      case 'gate_pass':
        return 'Offline gate pass';
      case 'emergency_request':
        return 'Offline emergency request';
      default:
        return 'Offline item';
    }
  }

  String? _formatCreatedAt(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return null;
    }

    final parsed = DateTime.tryParse(timestamp);
    if (parsed == null) {
      return null;
    }

    return _timestampFormat.format(parsed.toLocal());
  }

  Color _resolveStatusColor(String status) {
    switch (status) {
      case 'FAILED':
        return Colors.red[600] ?? Colors.red;
      case 'SYNCED':
      case 'COMPLETED':
      case 'SUCCESS':
        return Colors.green[600] ?? Colors.green;
      default:
        return Colors.orange[600] ?? Colors.orange;
    }
  }
}
