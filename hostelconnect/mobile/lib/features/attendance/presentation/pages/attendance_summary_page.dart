// lib/features/attendance/presentation/pages/attendance_summary_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/attendance_models.dart';
import '../../../../core/providers/attendance_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import '../widgets/attendance_entry_list_widget.dart';
import '../widgets/attendance_statistics_widget.dart';

class AttendanceSummaryPage extends ConsumerStatefulWidget {
  final String sessionId;

  const AttendanceSummaryPage({
    super.key,
    required this.sessionId,
  });

  @override
  ConsumerState<AttendanceSummaryPage> createState() => _AttendanceSummaryPageState();
}

class _AttendanceSummaryPageState extends ConsumerState<AttendanceSummaryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isClosing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionSummary = ref.watch(sessionSummaryProvider(widget.sessionId));
    final sessionEntries = ref.watch(sessionEntriesProvider(widget.sessionId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Attendance Summary'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (sessionSummary.data?.status == SessionStatus.active)
            IconButton(
              icon: const Icon(Icons.close_fullscreen),
              onPressed: _isClosing ? null : _closeSession,
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Entries', icon: Icon(Icons.list)),
            Tab(text: 'Statistics', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(sessionSummary, sessionEntries),
          _buildEntriesTab(sessionEntries),
          _buildStatisticsTab(sessionSummary),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(LoadStateData<AttendanceSummary> summary, LoadStateData<List<AttendanceEntry>> entries) {
    if (summary.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (summary.state == LoadState.error) {
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
              'Failed to load summary',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              summary.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(sessionSummaryProvider(widget.sessionId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final summaryData = summary.data!;
    final entriesData = entries.data ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Session Header
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          summaryData.sessionTitle,
                          style: IOSGradeTheme.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(summaryData.mode).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _getStatusColor(summaryData.mode),
                          ),
                        ),
                        child: Text(
                          summaryData.mode.displayName,
                          style: IOSGradeTheme.bodySmall.copyWith(
                            color: _getStatusColor(summaryData.mode),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${_formatDate(summaryData.sessionDate)}',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                  Text(
                    'Time: ${_formatTime(summaryData.sessionDate)}',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Attendance Statistics Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Present',
                  summaryData.presentCount.toString(),
                  Icons.check_circle,
                  IOSGradeTheme.success,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Absent',
                  summaryData.absentCount.toString(),
                  Icons.cancel,
                  IOSGradeTheme.error,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Late',
                  summaryData.lateCount.toString(),
                  Icons.schedule,
                  IOSGradeTheme.warning,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Adjusted',
                  summaryData.adjustedCount.toString(),
                  Icons.edit,
                  IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Attendance Percentage
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Attendance Percentage',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  CircularProgressIndicator(
                    value: summaryData.attendancePercentage / 100,
                    strokeWidth: 8,
                    backgroundColor: IOSGradeTheme.border,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getAttendanceColor(summaryData.attendancePercentage),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    '${summaryData.attendancePercentage.toStringAsFixed(1)}%',
                    style: IOSGradeTheme.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getAttendanceColor(summaryData.attendancePercentage),
                    ),
                  ),
                  
                  Text(
                    '${summaryData.presentCount} of ${summaryData.totalStudents} students',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Recent Entries Preview
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Recent Entries',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  if (entriesData.isEmpty)
                    Center(
                      child: Text(
                        'No entries yet',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    )
                  else
                    ...entriesData.take(5).map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              _getStatusIcon(entry.status),
                              color: _getStatusColor(entry.status),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                entry.studentName,
                                style: IOSGradeTheme.bodyMedium,
                              ),
                            ),
                            Text(
                              _formatTime(entry.timestamp),
                              style: IOSGradeTheme.bodySmall.copyWith(
                                color: IOSGradeTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          if (summaryData.mode != SessionStatus.closed) ...[
            Row(
              children: [
                Expanded(
                  child: IOSGradeButton(
                    text: 'View All Entries',
                    onPressed: () {
                      _tabController.animateTo(1);
                    },
                    icon: Icons.list,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: IOSGradeButton(
                    text: 'View Statistics',
                    onPressed: () {
                      _tabController.animateTo(2);
                    },
                    icon: Icons.analytics,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEntriesTab(LoadStateData<List<AttendanceEntry>> entries) {
    return AttendanceEntryListWidget(
      sessionId: widget.sessionId,
      entries: entries.data ?? [],
      isLoading: entries.state == LoadState.loading,
      error: entries.error,
      onRefresh: () {
        ref.invalidate(sessionEntriesProvider(widget.sessionId));
      },
    );
  }

  Widget _buildStatisticsTab(LoadStateData<AttendanceSummary> summary) {
    if (summary.data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AttendanceStatisticsWidget(
      sessionId: widget.sessionId,
      summary: summary.data!,
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
              style: IOSGradeTheme.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(dynamic status) {
    if (status is AttendanceMode) {
      switch (status) {
        case AttendanceMode.kiosk:
          return IOSGradeTheme.success;
        case AttendanceMode.warden:
          return IOSGradeTheme.info;
        case AttendanceMode.hybrid:
          return IOSGradeTheme.warning;
      }
    }
    
    if (status is AttendanceStatus) {
      switch (status) {
        case AttendanceStatus.present:
          return IOSGradeTheme.success;
        case AttendanceStatus.absent:
          return IOSGradeTheme.error;
        case AttendanceStatus.late:
          return IOSGradeTheme.warning;
        case AttendanceStatus.excused:
          return IOSGradeTheme.info;
      }
    }
    
    if (status is SessionStatus) {
      switch (status) {
        case SessionStatus.active:
          return IOSGradeTheme.success;
        case SessionStatus.paused:
          return IOSGradeTheme.warning;
        case SessionStatus.closed:
          return IOSGradeTheme.textSecondary;
        case SessionStatus.cancelled:
          return IOSGradeTheme.error;
      }
    }
    
    return IOSGradeTheme.textSecondary;
  }

  IconData _getStatusIcon(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return Icons.check_circle;
      case AttendanceStatus.absent:
        return Icons.cancel;
      case AttendanceStatus.late:
        return Icons.schedule;
      case AttendanceStatus.excused:
        return Icons.info;
    }
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return IOSGradeTheme.success;
    if (percentage >= 75) return IOSGradeTheme.warning;
    return IOSGradeTheme.error;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _closeSession() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Close Session'),
        content: const Text('Are you sure you want to close this attendance session? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: IOSGradeTheme.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Close Session'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isClosing = true;
      });

      try {
        final request = CloseSessionRequest(
          sessionId: widget.sessionId,
          reason: 'Closed by warden',
        );

        final attendanceService = ref.read(attendanceServiceProvider);
        final result = await attendanceService.closeSession(request);

        if (result.state == LoadState.success) {
          Toast.showSuccess(context, 'Session closed successfully');
          ref.invalidate(sessionSummaryProvider(widget.sessionId));
        } else {
          Toast.showError(context, result.error ?? 'Failed to close session');
        }
      } catch (e) {
        Toast.showError(context, 'Error closing session: $e');
      } finally {
        setState(() {
          _isClosing = false;
        });
      }
    }
  }
}
