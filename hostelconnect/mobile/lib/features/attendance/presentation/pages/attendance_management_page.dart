// lib/features/attendance/presentation/pages/attendance_management_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/attendance_models.dart';
import '../../../../core/providers/attendance_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'create_session_page.dart';
import 'attendance_summary_page.dart';
import '../widgets/qr_scanner_widget.dart';
import '../widgets/manual_attendance_widget.dart';
import '../widgets/session_list_widget.dart';

class AttendanceManagementPage extends ConsumerStatefulWidget {
  final String hostelId;

  const AttendanceManagementPage({
    super.key,
    required this.hostelId,
  });

  @override
  ConsumerState<AttendanceManagementPage> createState() => _AttendanceManagementPageState();
}

class _AttendanceManagementPageState extends ConsumerState<AttendanceManagementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isRefreshing = false;

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
    final activeSessions = ref.watch(activeSessionsProvider(widget.hostelId));
    final allSessions = ref.watch(sessionsProvider(widget.hostelId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Attendance Management'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isRefreshing ? null : _refreshData,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createNewSession,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active Sessions', icon: Icon(Icons.play_circle)),
            Tab(text: 'All Sessions', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveSessionsTab(activeSessions),
          _buildAllSessionsTab(allSessions),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createNewSession,
        icon: const Icon(Icons.add),
        label: const Text('New Session'),
        backgroundColor: IOSGradeTheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildActiveSessionsTab(LoadStateData<List<AttendanceSession>> activeSessions) {
    if (activeSessions.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeSessions.state == LoadState.error) {
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
              'Failed to load active sessions',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              activeSessions.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final sessions = activeSessions.data ?? [];

    if (sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              color: IOSGradeTheme.textSecondary,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'No Active Sessions',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a new session to start taking attendance',
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _createNewSession,
              icon: const Icon(Icons.add),
              label: const Text('Create Session'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return _buildSessionCard(session);
        },
      ),
    );
  }

  Widget _buildAllSessionsTab(LoadStateData<List<AttendanceSession>> allSessions) {
    if (allSessions.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (allSessions.state == LoadState.error) {
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
              'Failed to load sessions',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              allSessions.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final sessions = allSessions.data ?? [];

    if (sessions.isEmpty) {
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
              'No Sessions Found',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first attendance session',
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _createNewSession,
              icon: const Icon(Icons.add),
              label: const Text('Create Session'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return _buildSessionCard(session);
        },
      ),
    );
  }

  Widget _buildSessionCard(AttendanceSession session) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    session.title,
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(session.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(session.status),
                    ),
                  ),
                  child: Text(
                    session.status.name.toUpperCase(),
                    style: IOSGradeTheme.caption1.copyWith(
                      color: _getStatusColor(session.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Row(
              children: [
                Icon(
                  _getModeIcon(session.mode),
                  color: _getModeColor(session.mode),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  session.mode.displayName,
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: _getModeColor(session.mode),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  color: IOSGradeTheme.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDateTime(session.startTime),
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
            
            if (session.description != null && session.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                session.description!,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Session Statistics
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Present',
                    session.totalPresent.toString(),
                    Icons.check_circle,
                    IOSGradeTheme.success,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Absent',
                    session.totalAbsent.toString(),
                    Icons.cancel,
                    IOSGradeTheme.error,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Late',
                    session.totalLate.toString(),
                    Icons.schedule,
                    IOSGradeTheme.warning,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Total',
                    session.totalEntries.toString(),
                    Icons.people,
                    IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _viewSessionSummary(session),
                    icon: const Icon(Icons.visibility),
                    label: const Text('View Summary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOSGradeTheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                if (session.isActive) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _startQRScanner(session),
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('QR Scanner'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IOSGradeTheme.success,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _addManualEntry(session),
                      icon: const Icon(Icons.edit),
                      label: const Text('Manual Entry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: IOSGradeTheme.info,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: IOSGradeTheme.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
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
    );
  }

  Color _getStatusColor(SessionStatus status) {
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

  Color _getModeColor(AttendanceMode mode) {
    switch (mode) {
      case AttendanceMode.kiosk:
        return IOSGradeTheme.success;
      case AttendanceMode.warden:
        return IOSGradeTheme.info;
      case AttendanceMode.hybrid:
        return IOSGradeTheme.warning;
    }
  }

  IconData _getModeIcon(AttendanceMode mode) {
    switch (mode) {
      case AttendanceMode.kiosk:
        return Icons.qr_code;
      case AttendanceMode.warden:
        return Icons.person;
      case AttendanceMode.hybrid:
        return Icons.hub;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    try {
      ref.invalidate(activeSessionsProvider(widget.hostelId));
      ref.invalidate(sessionsProvider(widget.hostelId));
      
      // Wait for providers to refresh
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  Future<void> _createNewSession() async {
    final result = await Navigator.push<AttendanceSession>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSessionPage(hostelId: widget.hostelId),
      ),
    );

    if (result != null) {
      Toast.showSuccess(context, 'Session created successfully');
      _refreshData();
    }
  }

  void _viewSessionSummary(AttendanceSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceSummaryPage(sessionId: session.id),
      ),
    );
  }

  void _startQRScanner(AttendanceSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerWidget(
          sessionId: session.id,
          session: session,
          onScanSuccess: () {
            Toast.showSuccess(context, 'QR code scanned successfully');
          },
          onScanError: () {
            Toast.showError(context, 'Failed to scan QR code');
          },
        ),
      ),
    );
  }

  void _addManualEntry(AttendanceSession session) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManualAttendanceWidget(
          sessionId: session.id,
          session: session,
          onEntryAdded: () {
            Toast.showSuccess(context, 'Manual entry added successfully');
          },
        ),
      ),
    );
  }
}
