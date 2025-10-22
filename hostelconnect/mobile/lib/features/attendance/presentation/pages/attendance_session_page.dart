// lib/features/attendance/presentation/pages/attendance_session_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/auth_service.dart';
import '../../../../core/guards/role_guard.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart';
import '../../../../shared/widgets/ui/ios_grade_card.dart' as ui;
import '../../domain/entities/attendance_entities.dart';

class AttendanceSessionPage extends ConsumerStatefulWidget {
  const AttendanceSessionPage({super.key});

  @override
  ConsumerState<AttendanceSessionPage> createState() => _AttendanceSessionPageState();
}

class _AttendanceSessionPageState extends ConsumerState<AttendanceSessionPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  AttendanceSession? _currentSession;
  List<AttendanceRecord> _records = [];
  AttendanceSummary? _summary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadCurrentSession();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentSession() async {
    try {
      // Mock data for demonstration
      await Future.delayed(const Duration(milliseconds: 500));
      
      setState(() {
        _currentSession = AttendanceSession(
          id: 'session_1',
          hostelId: 'hostel_1',
          createdBy: 'warden_1',
          type: AttendanceType.evening,
          startTime: DateTime.now().subtract(const Duration(hours: 1)),
          status: AttendanceStatus.active,
          description: 'Evening attendance for hostel residents',
        );
        
        _records = [
          AttendanceRecord(
            id: 'record_1',
            sessionId: 'session_1',
            studentId: 'student_1',
            timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            method: AttendanceMethod.kiosk,
            isLate: false,
            isAdjusted: false,
          ),
          AttendanceRecord(
            id: 'record_2',
            sessionId: 'session_1',
            studentId: 'student_2',
            timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
            method: AttendanceMethod.warden,
            scannedBy: 'warden_1',
            isLate: true,
            isAdjusted: false,
          ),
        ];
        
        _summary = AttendanceSummary(
          sessionId: 'session_1',
          totalStudents: 150,
          presentCount: 142,
          absentCount: 8,
          lateCount: 12,
          adjustedCount: 2,
          attendancePercentage: 94.7,
          lastUpdated: DateTime.now(),
        );
        
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading session: ${e.toString()}'),
          backgroundColor: IOSGradeTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['warden', 'warden_head', 'super_admin'],
      child: Scaffold(
        backgroundColor: IOSGradeTheme.background,
        appBar: AppBar(
          title: const Text('Attendance Session'),
          backgroundColor: IOSGradeTheme.surface,
          elevation: 0,
          leading: const ui.BackButton(),
          actions: [
            if (_currentSession?.isActive == true)
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: _endSession,
              ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Scanner', icon: Icon(Icons.qr_code_scanner)),
              Tab(text: 'Manual', icon: Icon(Icons.edit)),
              Tab(text: 'Summary', icon: Icon(Icons.assessment)),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _currentSession == null
                ? _buildNoSessionState()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildScannerTab(),
                      _buildManualTab(),
                      _buildSummaryTab(),
                    ],
                  ),
      ),
    );
  }

  Widget _buildNoSessionState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
              decoration: BoxDecoration(
                color: IOSGradeTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusXLarge),
              ),
              child: const Icon(
                Icons.qr_code_scanner_outlined,
                size: 64,
                color: IOSGradeTheme.info,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            Text(
              'No Active Session',
              style: IOSGradeTheme.title1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: IOSGradeTheme.spacing3),
            Text(
              'Start a new attendance session to begin scanning student QR codes.',
              style: IOSGradeTheme.body.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: IOSGradeTheme.spacing6),
            ElevatedButton(
              onPressed: _startNewSession,
              child: const Text('Start New Session'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        children: [
          _buildSessionInfo(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildScannerInterface(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildRecentScans(),
        ],
      ),
    );
  }

  Widget _buildManualTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        children: [
          _buildSessionInfo(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildManualEntry(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildBulkActions(),
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    if (_summary == null) return const Center(child: Text('No summary available'));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
      child: Column(
        children: [
          _buildSessionInfo(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildAttendanceStats(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildAttendanceChart(),
          const SizedBox(height: IOSGradeTheme.spacing6),
          _buildAbsentStudents(),
        ],
      ),
    );
  }

  Widget _buildSessionInfo() {
    if (_currentSession == null) return const SizedBox.shrink();

    return IOSGradeCard(
      backgroundColor: IOSGradeTheme.primary.withOpacity(0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.schedule_outlined,
                  color: IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_currentSession!.type.toString().toUpperCase()} Attendance',
                      style: IOSGradeTheme.title2.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Started ${_formatTime(_currentSession!.startTime)}',
                      style: IOSGradeTheme.callout.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: IOSGradeTheme.spacing2,
                  vertical: IOSGradeTheme.spacing1,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(_currentSession!.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: Text(
                  _currentSession!.status.toString().toUpperCase(),
                  style: IOSGradeTheme.caption1.copyWith(
                    color: _getStatusColor(_currentSession!.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (_currentSession!.description != null) ...[
            const SizedBox(height: IOSGradeTheme.spacing3),
            Text(
              _currentSession!.description!,
              style: IOSGradeTheme.callout.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScannerInterface() {
    return IOSGradeCard(
      child: Column(
        children: [
          Text(
            'QR Code Scanner',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: IOSGradeTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              border: Border.all(color: IOSGradeTheme.border),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner_outlined,
                    size: 64,
                    color: IOSGradeTheme.textSecondary,
                  ),
                  SizedBox(height: IOSGradeTheme.spacing2),
                  Text(
                    'Point camera at student QR code',
                    style: TextStyle(color: IOSGradeTheme.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _simulateScan,
              child: const Text('Simulate Scan'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentScans() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Scans',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          if (_records.isEmpty)
            Container(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
              decoration: BoxDecoration(
                color: IOSGradeTheme.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: IOSGradeTheme.info,
                  ),
                  const SizedBox(width: IOSGradeTheme.spacing2),
                  Text(
                    'No scans recorded yet',
                    style: IOSGradeTheme.callout.copyWith(
                      color: IOSGradeTheme.info,
                    ),
                  ),
                ],
              ),
            )
          else
            ..._records.map((record) => _buildScanRecord(record)),
        ],
      ),
    );
  }

  Widget _buildScanRecord(AttendanceRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
        border: Border.all(color: IOSGradeTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
            decoration: BoxDecoration(
              color: _getMethodColor(record.method).withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Icon(
              _getMethodIcon(record.method),
              color: _getMethodColor(record.method),
              size: 20,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student ${record.studentId}',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _formatTime(record.timestamp),
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (record.isLate)
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
                'LATE',
                style: IOSGradeTheme.caption2.copyWith(
                  color: IOSGradeTheme.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildManualEntry() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manual Entry',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Student ID',
              hintText: 'Enter student ID',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Reason (Optional)',
              hintText: 'Enter reason for manual entry',
              prefixIcon: Icon(Icons.note_outlined),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addManualEntry,
              child: const Text('Add Entry'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bulk Actions',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _markAllPresent,
                  child: const Text('Mark All Present'),
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Expanded(
                child: ElevatedButton(
                  onPressed: _markAllAbsent,
                  child: const Text('Mark All Absent'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceStats() {
    if (_summary == null) return const SizedBox.shrink();

    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Statistics',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Present',
                  '${_summary!.presentCount}',
                  IOSGradeTheme.success,
                  Icons.check_circle_outline,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Absent',
                  '${_summary!.absentCount}',
                  IOSGradeTheme.error,
                  Icons.cancel_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Late',
                  '${_summary!.lateCount}',
                  IOSGradeTheme.warning,
                  Icons.schedule_outlined,
                ),
              ),
              Expanded(
                child: _buildStatCard(
                  'Total',
                  '${_summary!.totalStudents}',
                  IOSGradeTheme.info,
                  Icons.people_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendance Rate',
                  style: IOSGradeTheme.callout.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_summary!.attendancePercentage.toStringAsFixed(1)}%',
                  style: IOSGradeTheme.title2.copyWith(
                    fontWeight: FontWeight.w700,
                    color: IOSGradeTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: IOSGradeTheme.spacing2),
          Text(
            value,
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            title,
            style: IOSGradeTheme.caption1.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceChart() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Chart',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: IOSGradeTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            ),
            child: const Center(
              child: Text(
                'Chart visualization would go here',
                style: TextStyle(color: IOSGradeTheme.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsentStudents() {
    return IOSGradeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Absent Students',
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing4),
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
            decoration: BoxDecoration(
              color: IOSGradeTheme.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_outlined,
                  color: IOSGradeTheme.warning,
                ),
                const SizedBox(width: IOSGradeTheme.spacing2),
                Text(
                  '8 students marked absent',
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

  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.active:
        return IOSGradeTheme.success;
      case AttendanceStatus.completed:
        return IOSGradeTheme.info;
      case AttendanceStatus.cancelled:
        return IOSGradeTheme.error;
    }
  }

  Color _getMethodColor(AttendanceMethod method) {
    switch (method) {
      case AttendanceMethod.kiosk:
        return IOSGradeTheme.info;
      case AttendanceMethod.warden:
        return IOSGradeTheme.primary;
      case AttendanceMethod.manual:
        return IOSGradeTheme.warning;
      case AttendanceMethod.qr:
        return IOSGradeTheme.success;
    }
  }

  IconData _getMethodIcon(AttendanceMethod method) {
    switch (method) {
      case AttendanceMethod.kiosk:
        return Icons.computer_outlined;
      case AttendanceMethod.warden:
        return Icons.person_outline;
      case AttendanceMethod.manual:
        return Icons.edit_outlined;
      case AttendanceMethod.qr:
        return Icons.qr_code_outlined;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

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

  void _startNewSession() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Start new session feature coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _endSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Session'),
        content: const Text('Are you sure you want to end this attendance session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Session ended successfully'),
                  backgroundColor: IOSGradeTheme.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('End Session'),
          ),
        ],
      ),
    );
  }

  void _simulateScan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR scan simulated'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addManualEntry() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manual entry added'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _markAllPresent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All students marked present'),
        backgroundColor: IOSGradeTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _markAllAbsent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All students marked absent'),
        backgroundColor: IOSGradeTheme.warning,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
