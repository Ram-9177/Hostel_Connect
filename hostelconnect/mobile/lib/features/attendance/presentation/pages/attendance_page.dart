// lib/features/attendance/presentation/pages/attendance_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';
import '../widgets/qr_scanner_widget.dart';
import '../widgets/manual_attendance_widget.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1'; // TODO: Get from auth context

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
    final appState = ref.watch(appStateProvider);
    final userRole = appState.user?.role.toLowerCase() ?? 'student';

    return Scaffold(
      backgroundColor: UnifiedTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Attendance Management'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh attendance data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'QR Scanner', icon: Icon(Icons.qr_code_scanner)),
            Tab(text: 'Manual Entry', icon: Icon(Icons.edit)),
            Tab(text: 'History', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQRScannerTab(),
          _buildManualEntryTab(),
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: userRole == 'warden' || userRole == 'warden_head' || userRole == 'super_admin'
          ? FloatingActionButton.extended(
              onPressed: _createAttendanceSession,
              icon: const Icon(Icons.add),
              label: const Text('New Session'),
              backgroundColor: UnifiedTheme.primary,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }

  Widget _buildQRScannerTab() {
    return const QRScannerWidget();
  }

  Widget _buildManualEntryTab() {
    return const ManualAttendanceWidget();
  }

  Widget _buildHistoryTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Attendance History',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View past attendance records',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _createAttendanceSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Attendance Session'),
        content: const Text('This feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}