// lib/features/gatepass/presentation/widgets/gate_scan_history_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/gatepass_models.dart';
import '../../../../core/providers/gatepass_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';

class GateScanHistoryWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final String? studentId;
  final DateTime? from;
  final DateTime? to;

  const GateScanHistoryWidget({
    super.key,
    required this.hostelId,
    this.studentId,
    this.from,
    this.to,
  });

  @override
  ConsumerState<GateScanHistoryWidget> createState() => _GateScanHistoryWidgetState();
}

class _GateScanHistoryWidgetState extends ConsumerState<GateScanHistoryWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';
  String _selectedTimeRange = 'today';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanHistory = widget.studentId != null
        ? ref.watch(studentScanHistoryProvider(widget.studentId!))
        : ref.watch(gateScanHistoryProvider(widget.hostelId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: Text(widget.studentId != null ? 'Student Scan History' : 'Gate Scan History'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (widget.studentId != null) {
                ref.invalidate(studentScanHistoryProvider(widget.studentId!));
              } else {
                ref.invalidate(gateScanHistoryProvider(widget.hostelId));
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Scans', icon: Icon(Icons.history)),
            Tab(text: 'Statistics', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildScanHistoryTab(scanHistory),
          _buildStatisticsTab(),
        ],
      ),
    );
  }

  Widget _buildScanHistoryTab(LoadStateData<List<GateScanEvent>> scanHistory) {
    if (scanHistory.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (scanHistory.state == LoadState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: IOSGradeTheme.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load scan history',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              scanHistory.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.studentId != null) {
                  ref.invalidate(studentScanHistoryProvider(widget.studentId!));
                } else {
                  ref.invalidate(gateScanHistoryProvider(widget.hostelId));
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final scans = scanHistory.data ?? [];
    final filteredScans = _filterScans(scans);

    if (filteredScans.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              color: IOSGradeTheme.textSecondary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No Scan History',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No gate scans found for the selected criteria',
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (widget.studentId != null) {
          ref.invalidate(studentScanHistoryProvider(widget.studentId!));
        } else {
          ref.invalidate(gateScanHistoryProvider(widget.hostelId));
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredScans.length,
        itemBuilder: (context, index) {
          final scan = filteredScans[index];
          return _buildScanCard(scan);
        },
      ),
    );
  }

  Widget _buildScanCard(GateScanEvent scan) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getScanTypeColor(scan.scanType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getScanTypeIcon(scan.scanType),
                    color: _getScanTypeColor(scan.scanType),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scan.studentName,
                        style: IOSGradeTheme.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        scan.gateLocation,
                        style: IOSGradeTheme.bodySmall.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getScanTypeColor(scan.scanType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getScanTypeColor(scan.scanType),
                    ),
                  ),
                  child: Text(
                    scan.scanType.name.toUpperCase(),
                    style: IOSGradeTheme.caption1.copyWith(
                      color: _getScanTypeColor(scan.scanType),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: IOSGradeTheme.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDateTime(scan.scanTime),
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.person,
                  color: IOSGradeTheme.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  scan.scannedByName,
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
            
            if (scan.isEmergencyBypass == true) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: IOSGradeTheme.warning.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: IOSGradeTheme.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Emergency Bypass: ${scan.emergencyReason ?? 'No reason provided'}',
                        style: IOSGradeTheme.bodySmall.copyWith(
                          color: IOSGradeTheme.warning,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            if (scan.notes != null && scan.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Notes: ${scan.notes}',
                style: IOSGradeTheme.bodySmall.copyWith(
                  color: IOSGradeTheme.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Quick Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total Scans',
                  '0', // TODO: Calculate from scan history
                  Icons.qr_code_scanner,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Departures',
                  '0', // TODO: Calculate from scan history
                  Icons.exit_to_app,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Returns',
                  '0', // TODO: Calculate from scan history
                  Icons.login,
                  IOSGradeTheme.info,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Emergency',
                  '0', // TODO: Calculate from scan history
                  Icons.warning,
                  IOSGradeTheme.warning,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Scan Trends Chart Placeholder
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan Trends',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Chart Placeholder\nScan trends over time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Peak Hours Analysis
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peak Hours Analysis',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPeakHourItem('Morning', '6:00 AM - 10:00 AM', '45%'),
                  _buildPeakHourItem('Afternoon', '12:00 PM - 4:00 PM', '30%'),
                  _buildPeakHourItem('Evening', '6:00 PM - 10:00 PM', '25%'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeakHourItem(String period, String timeRange, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  period,
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  timeRange,
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            percentage,
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  List<GateScanEvent> _filterScans(List<GateScanEvent> scans) {
    List<GateScanEvent> filtered = scans;

    // Filter by scan type
    if (_selectedFilter != 'all') {
      filtered = filtered.where((scan) {
        switch (_selectedFilter) {
          case 'departure':
            return scan.isDeparture;
          case 'return':
            return scan.isReturn;
          case 'emergency':
            return scan.isEmergency;
          default:
            return true;
        }
      }).toList();
    }

    // Filter by time range
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case 'today':
        filtered = filtered.where((scan) {
          return scan.scanTime.day == now.day &&
                 scan.scanTime.month == now.month &&
                 scan.scanTime.year == now.year;
        }).toList();
        break;
      case 'week':
        final weekAgo = now.subtract(const Duration(days: 7));
        filtered = filtered.where((scan) => scan.scanTime.isAfter(weekAgo)).toList();
        break;
      case 'month':
        final monthAgo = now.subtract(const Duration(days: 30));
        filtered = filtered.where((scan) => scan.scanTime.isAfter(monthAgo)).toList();
        break;
    }

    return filtered;
  }

  Color _getScanTypeColor(GateScanType scanType) {
    switch (scanType) {
      case GateScanType.departure:
        return IOSGradeTheme.success;
      case GateScanType.return_:
        return IOSGradeTheme.info;
      case GateScanType.emergencyDeparture:
        return IOSGradeTheme.warning;
      case GateScanType.emergencyReturn:
        return IOSGradeTheme.error;
    }
  }

  IconData _getScanTypeIcon(GateScanType scanType) {
    switch (scanType) {
      case GateScanType.departure:
        return Icons.exit_to_app;
      case GateScanType.return_:
        return Icons.login;
      case GateScanType.emergencyDeparture:
        return Icons.warning;
      case GateScanType.emergencyReturn:
        return Icons.warning;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showFilterDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Scans'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Scan Type Filter
            const Text('Scan Type:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('All'),
              value: 'all',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Departures'),
              value: 'departure',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Returns'),
              value: 'return',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Emergency'),
              value: 'emergency',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
            
            const SizedBox(height: 16),
            
            // Time Range Filter
            const Text('Time Range:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Today'),
              value: 'today',
              groupValue: _selectedTimeRange,
              onChanged: (value) {
                setState(() {
                  _selectedTimeRange = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('This Week'),
              value: 'week',
              groupValue: _selectedTimeRange,
              onChanged: (value) {
                setState(() {
                  _selectedTimeRange = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('This Month'),
              value: 'month',
              groupValue: _selectedTimeRange,
              onChanged: (value) {
                setState(() {
                  _selectedTimeRange = value!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
