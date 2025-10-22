// lib/features/reports/presentation/widgets/daily_analytics_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/dashboard_models.dart';
import '../../../../core/providers/reports_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class DailyAnalyticsWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final DateTime date;

  const DailyAnalyticsWidget({
    super.key,
    required this.hostelId,
    required this.date,
  });

  @override
  ConsumerState<DailyAnalyticsWidget> createState() => _DailyAnalyticsWidgetState();
}

class _DailyAnalyticsWidgetState extends ConsumerState<DailyAnalyticsWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dailyAnalytics = ref.watch(dailyAnalyticsProvider((widget.hostelId, widget.date)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.analytics,
                color: IOSGradeTheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Analytics',
                      style: IOSGradeTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                      style: IOSGradeTheme.bodyMedium.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.invalidate(dailyAnalyticsProvider((widget.hostelId, widget.date)));
                },
                tooltip: 'Refresh Analytics',
              ),
            ],
          ),
        ),
        
        // Analytics Content
        if (dailyAnalytics.state == LoadState.loading)
          const Center(child: CircularProgressIndicator())
        else if (dailyAnalytics.state == LoadState.error)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.error_outline,
                  color: IOSGradeTheme.error,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load daily analytics',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dailyAnalytics.error ?? 'Unknown error',
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                IOSGradeButton(
                  text: 'Retry',
                  onPressed: () {
                    ref.invalidate(dailyAnalyticsProvider((widget.hostelId, widget.date)));
                  },
                  icon: Icons.refresh,
                  backgroundColor: IOSGradeTheme.primary,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          )
        else if (dailyAnalytics.data == null)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: IOSGradeTheme.textSecondary,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'No analytics data available',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          _buildAnalyticsContent(dailyAnalytics.data!),
      ],
    );
  }

  Widget _buildAnalyticsContent(DailyAnalytics analytics) {
    return Column(
      children: [
        // Tab Bar
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Attendance', icon: Icon(Icons.people)),
            Tab(text: 'Gate', icon: Icon(Icons.door_front_door)),
            Tab(text: 'Meals', icon: Icon(Icons.restaurant)),
            Tab(text: 'Occupancy', icon: Icon(Icons.bed)),
            Tab(text: 'Integrity', icon: Icon(Icons.security)),
          ],
        ),
        
        // Tab Content
        SizedBox(
          height: 600,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildAttendanceTab(analytics.attendance),
              _buildGateTab(analytics.gate),
              _buildMealsTab(analytics.meals),
              _buildOccupancyTab(analytics.occupancy),
              _buildIntegrityTab(analytics.integrity),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceTab(AttendanceAnalytics attendance) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Students',
                  attendance.totalStudents.toString(),
                  Icons.people,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Present',
                  attendance.presentCount.toString(),
                  Icons.check_circle,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Absent',
                  attendance.absentCount.toString(),
                  Icons.cancel,
                  IOSGradeTheme.error,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Attendance %',
                  '${attendance.attendancePercentage.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Sessions
          Text(
            'Attendance Sessions',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...attendance.sessions.map((session) => _buildSessionCard(session)).toList(),
          
          const SizedBox(height: 20),
          
          // Manual Entries
          Text(
            'Manual Entries',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: IOSGradeTheme.warning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manual Entries',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${attendance.manualEntries} entries (${attendance.manualPercentage.toStringAsFixed(1)}%)',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGateTab(GateAnalytics gate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Out Passes',
                  gate.totalOutPasses.toString(),
                  Icons.exit_to_app,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'In Passes',
                  gate.totalInPasses.toString(),
                  Icons.login,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Pending',
                  gate.pendingPasses.toString(),
                  Icons.pending,
                  IOSGradeTheme.warning,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Avg TAT',
                  _formatDuration(gate.averageTAT),
                  Icons.timer,
                  IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Recent Passes
          Text(
            'Recent Gate Passes',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...gate.recentPasses.map((pass) => _buildGatePassCard(pass)).toList(),
        ],
      ),
    );
  }

  Widget _buildMealsTab(MealAnalytics meals) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Forecasted',
                  meals.totalForecasted.toString(),
                  Icons.forecast,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Actual',
                  meals.totalActual.toString(),
                  Icons.restaurant,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Variance',
                  '${meals.variancePercentage.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  meals.variancePercentage > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Meal Types',
                  meals.mealTypes.length.toString(),
                  Icons.category,
                  IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Meal Types
          Text(
            'Meal Type Breakdown',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...meals.mealTypes.entries.map((entry) => _buildMealTypeCard(entry.value)).toList(),
        ],
      ),
    );
  }

  Widget _buildOccupancyTab(OccupancyAnalytics occupancy) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Rooms',
                  occupancy.totalRooms.toString(),
                  Icons.room,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Occupied',
                  occupancy.occupiedRooms.toString(),
                  Icons.bed,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Room %',
                  '${occupancy.roomOccupancyPercentage.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.info,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Bed %',
                  '${occupancy.bedOccupancyPercentage.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.warning,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Room Details
          Text(
            'Room Details',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...occupancy.roomDetails.map((room) => _buildRoomCard(room)).toList(),
        ],
      ),
    );
  }

  Widget _buildIntegrityTab(IntegrityAnalytics integrity) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Checks',
                  integrity.totalChecks.toString(),
                  Icons.security,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Passed',
                  integrity.passedChecks.toString(),
                  Icons.check_circle,
                  IOSGradeTheme.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Failed',
                  integrity.failedChecks.toString(),
                  Icons.error,
                  IOSGradeTheme.error,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Integrity %',
                  '${integrity.integrityPercentage.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.info,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Integrity Checks
          Text(
            'Integrity Checks',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...integrity.checks.map((check) => _buildIntegrityCheckCard(check)).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildSessionCard(AttendanceSessionSummary session) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getSessionModeIcon(session.mode),
                    color: _getSessionModeColor(session.mode),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      session.name,
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${session.attendancePercentage.toStringAsFixed(1)}%',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getAttendanceColor(session.attendancePercentage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Present: ${session.presentCount}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Absent: ${session.absentCount}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Total: ${session.totalStudents}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGatePassCard(GatePassSummary pass) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getGatePassStatusIcon(pass.status),
                    color: _getGatePassStatusColor(pass.status),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pass.studentName,
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    pass.status.name.toUpperCase(),
                    style: IOSGradeTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getGatePassStatusColor(pass.status),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Reason: ${pass.reason}',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Out: ${_formatDateTime(pass.outTime)}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.primary,
                    ),
                  ),
                  if (pass.inTime != null) ...[
                    const SizedBox(width: 16),
                    Text(
                      'In: ${_formatDateTime(pass.inTime!)}',
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.success,
                      ),
                    ),
                  ],
                  if (pass.duration != null) ...[
                    const SizedBox(width: 16),
                    Text(
                      'Duration: ${_formatDuration(pass.duration!)}',
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.info,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealTypeCard(MealTypeAnalytics mealType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getMealTypeIcon(mealType.mealType),
                    color: _getMealTypeColor(mealType.mealType),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      mealType.mealType.name.toUpperCase(),
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${mealType.variancePercentage.toStringAsFixed(1)}%',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: mealType.variancePercentage > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Forecasted: ${mealType.forecasted}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Actual: ${mealType.actual}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Variance: ${mealType.variance}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: mealType.variance > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(OccupancySummary room) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.room,
                    color: IOSGradeTheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${room.blockName} - ${room.roomNumber}',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${room.occupancyPercentage.toStringAsFixed(1)}%',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getOccupancyColor(room.occupancyPercentage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Floor: ${room.floorName}',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Occupied: ${room.occupiedBeds}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Total: ${room.totalBeds}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntegrityCheckCard(IntegrityCheck check) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getIntegrityCheckStatusIcon(check.status),
                    color: _getIntegrityCheckStatusColor(check.status),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      check.name,
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    check.status.name.toUpperCase(),
                    style: IOSGradeTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getIntegrityCheckStatusColor(check.status),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                check.description,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
              if (check.errorMessage != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Error: ${check.errorMessage}',
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods for icons and colors
  IconData _getSessionModeIcon(AttendanceMode mode) {
    switch (mode) {
      case AttendanceMode.kiosk:
        return Icons.kiosk;
      case AttendanceMode.warden:
        return Icons.person;
      case AttendanceMode.hybrid:
        return Icons.merge;
    }
  }

  Color _getSessionModeColor(AttendanceMode mode) {
    switch (mode) {
      case AttendanceMode.kiosk:
        return IOSGradeTheme.primary;
      case AttendanceMode.warden:
        return IOSGradeTheme.success;
      case AttendanceMode.hybrid:
        return IOSGradeTheme.info;
    }
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return IOSGradeTheme.success;
    if (percentage >= 70) return IOSGradeTheme.warning;
    return IOSGradeTheme.error;
  }

  IconData _getGatePassStatusIcon(GatePassStatus status) {
    switch (status) {
      case GatePassStatus.pending:
        return Icons.pending;
      case GatePassStatus.approved:
        return Icons.check_circle;
      case GatePassStatus.rejected:
        return Icons.cancel;
      case GatePassStatus.expired:
        return Icons.schedule;
    }
  }

  Color _getGatePassStatusColor(GatePassStatus status) {
    switch (status) {
      case GatePassStatus.pending:
        return IOSGradeTheme.warning;
      case GatePassStatus.approved:
        return IOSGradeTheme.success;
      case GatePassStatus.rejected:
        return IOSGradeTheme.error;
      case GatePassStatus.expired:
        return IOSGradeTheme.textSecondary;
    }
  }

  IconData _getMealTypeIcon(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.snacks:
        return Icons.cookie;
      case MealType.dinner:
        return Icons.dinner_dining;
    }
  }

  Color _getMealTypeColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Colors.orange;
      case MealType.lunch:
        return Colors.green;
      case MealType.snacks:
        return Colors.brown;
      case MealType.dinner:
        return Colors.purple;
    }
  }

  Color _getOccupancyColor(double percentage) {
    if (percentage >= 90) return IOSGradeTheme.error;
    if (percentage >= 70) return IOSGradeTheme.warning;
    return IOSGradeTheme.success;
  }

  IconData _getIntegrityCheckStatusIcon(IntegrityCheckStatus status) {
    switch (status) {
      case IntegrityCheckStatus.passed:
        return Icons.check_circle;
      case IntegrityCheckStatus.failed:
        return Icons.error;
      case IntegrityCheckStatus.warning:
        return Icons.warning;
      case IntegrityCheckStatus.pending:
        return Icons.pending;
    }
  }

  Color _getIntegrityCheckStatusColor(IntegrityCheckStatus status) {
    switch (status) {
      case IntegrityCheckStatus.passed:
        return IOSGradeTheme.success;
      case IntegrityCheckStatus.failed:
        return IOSGradeTheme.error;
      case IntegrityCheckStatus.warning:
        return IOSGradeTheme.warning;
      case IntegrityCheckStatus.pending:
        return IOSGradeTheme.textSecondary;
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
