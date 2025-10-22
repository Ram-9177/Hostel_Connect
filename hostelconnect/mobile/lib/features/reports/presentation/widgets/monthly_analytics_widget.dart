// lib/features/reports/presentation/widgets/monthly_analytics_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/dashboard_models.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/providers/reports_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class MonthlyAnalyticsWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final DateTime month;

  const MonthlyAnalyticsWidget({
    super.key,
    required this.hostelId,
    required this.month,
  });

  @override
  ConsumerState<MonthlyAnalyticsWidget> createState() => _MonthlyAnalyticsWidgetState();
}

class _MonthlyAnalyticsWidgetState extends ConsumerState<MonthlyAnalyticsWidget>
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
    final monthlyAnalytics = ref.watch(monthlyAnalyticsProvider((widget.hostelId, widget.month)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.trending_up,
                color: IOSGradeTheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly Analytics',
                      style: IOSGradeTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${widget.month.month}/${widget.month.year}',
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
                  ref.invalidate(monthlyAnalyticsProvider((widget.hostelId, widget.month)));
                },
                tooltip: 'Refresh Analytics',
              ),
            ],
          ),
        ),
        
        // Analytics Content
        if (monthlyAnalytics.state == LoadState.loading)
          const Center(child: CircularProgressIndicator())
        else if (monthlyAnalytics.state == LoadState.error)
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
                  'Failed to load monthly analytics',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  monthlyAnalytics.error ?? 'Unknown error',
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                IOSGradeButton(
                  text: 'Retry',
                  onPressed: () {
                    ref.invalidate(monthlyAnalyticsProvider((widget.hostelId, widget.month)));
                  },
                  icon: Icons.refresh,
                  backgroundColor: IOSGradeTheme.primary,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          )
        else if (monthlyAnalytics.data == null)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.trending_up_outlined,
                  color: IOSGradeTheme.textSecondary,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'No monthly analytics data available',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          _buildAnalyticsContent(monthlyAnalytics.data!),
      ],
    );
  }

  Widget _buildAnalyticsContent(MonthlyAnalytics analytics) {
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

  Widget _buildAttendanceTab(AttendanceTrends attendance) {
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
                  'Avg Attendance',
                  '${attendance.averageAttendance.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Trend',
                  _getTrendText(attendance.trendDirection),
                  Icons.trending_up,
                  _getTrendColor(attendance.trendDirection),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Weekly Averages
          Text(
            'Weekly Averages',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...attendance.weeklyAverages.entries.map((entry) => _buildWeeklyAverageCard(entry)).toList(),
          
          const SizedBox(height: 20),
          
          // Daily Trends
          Text(
            'Daily Trends',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...attendance.dailyTrends.map((trend) => _buildDailyTrendCard(trend)).toList(),
        ],
      ),
    );
  }

  Widget _buildGateTab(GateTrends gate) {
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
                  'Avg TAT',
                  _formatDuration(gate.averageTAT),
                  Icons.timer,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Trend',
                  _getTrendText(gate.trendDirection),
                  Icons.trending_up,
                  _getTrendColor(gate.trendDirection),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Weekly Totals
          Text(
            'Weekly Totals',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...gate.weeklyTotals.entries.map((entry) => _buildWeeklyTotalCard(entry)).toList(),
          
          const SizedBox(height: 20),
          
          // Daily Trends
          Text(
            'Daily Trends',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...gate.dailyTrends.map((trend) => _buildGateTrendCard(trend)).toList(),
        ],
      ),
    );
  }

  Widget _buildMealsTab(MealTrends meals) {
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
                  'Avg Variance',
                  '${meals.averageVariance.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  meals.averageVariance > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Trend',
                  _getTrendText(meals.trendDirection),
                  Icons.trending_up,
                  _getTrendColor(meals.trendDirection),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Weekly Variances
          Text(
            'Weekly Variances',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...meals.weeklyVariances.entries.map((entry) => _buildWeeklyVarianceCard(entry)).toList(),
          
          const SizedBox(height: 20),
          
          // Meal Type Trends
          Text(
            'Meal Type Trends',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...meals.mealTypeTrends.entries.map((entry) => _buildMealTypeTrendCard(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildOccupancyTab(OccupancyTrends occupancy) {
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
                  'Avg Occupancy',
                  '${occupancy.averageOccupancy.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Trend',
                  _getTrendText(occupancy.trendDirection),
                  Icons.trending_up,
                  _getTrendColor(occupancy.trendDirection),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Weekly Averages
          Text(
            'Weekly Averages',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...occupancy.weeklyAverages.entries.map((entry) => _buildWeeklyAverageCard(entry)).toList(),
          
          const SizedBox(height: 20),
          
          // Block Trends
          Text(
            'Block Trends',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...occupancy.blockTrends.entries.map((entry) => _buildBlockTrendCard(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildIntegrityTab(IntegrityTrends integrity) {
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
                  'Avg Integrity',
                  '${integrity.averageIntegrity.toStringAsFixed(1)}%',
                  Icons.percent,
                  IOSGradeTheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSummaryCard(
                  'Trend',
                  _getTrendText(integrity.trendDirection),
                  Icons.trending_up,
                  _getTrendColor(integrity.trendDirection),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Weekly Averages
          Text(
            'Weekly Averages',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...integrity.weeklyAverages.entries.map((entry) => _buildWeeklyAverageCard(entry)).toList(),
          
          const SizedBox(height: 20),
          
          // Check Type Trends
          Text(
            'Check Type Trends',
            style: IOSGradeTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          ...integrity.checkTypeTrends.entries.map((entry) => _buildCheckTypeTrendCard(entry)).toList(),
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

  Widget _buildWeeklyAverageCard(MapEntry<String, double> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.calendar_view_week,
                color: IOSGradeTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Week ${entry.key}',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(1)}%',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getPercentageColor(entry.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyTrendCard(DailyAttendanceTrend trend) {
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
                    Icons.calendar_today,
                    color: IOSGradeTheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${trend.date.day}/${trend.date.month}',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${trend.attendancePercentage.toStringAsFixed(1)}%',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: _getPercentageColor(trend.attendancePercentage),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Present: ${trend.presentCount}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Total: ${trend.totalStudents}',
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

  Widget _buildWeeklyTotalCard(MapEntry<String, int> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.calendar_view_week,
                color: IOSGradeTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Week ${entry.key}',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                entry.value.toString(),
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: IOSGradeTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGateTrendCard(DailyGateTrend trend) {
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
                    Icons.calendar_today,
                    color: IOSGradeTheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${trend.date.day}/${trend.date.month}',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${trend.totalPasses} passes',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: IOSGradeTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Approved: ${trend.approvedPasses}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.success,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Rejected: ${trend.rejectedPasses}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Avg TAT: ${_formatDuration(trend.averageTAT)}',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.info,
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

  Widget _buildWeeklyVarianceCard(MapEntry<String, double> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.calendar_view_week,
                color: IOSGradeTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Week ${entry.key}',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(1)}%',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: entry.value > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealTypeTrendCard(MapEntry<MealType, double> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                _getMealTypeIcon(entry.key),
                color: _getMealTypeColor(entry.key),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.key.name.toUpperCase(),
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(1)}%',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: entry.value > 0 ? IOSGradeTheme.error : IOSGradeTheme.success,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlockTrendCard(MapEntry<String, double> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.business,
                color: IOSGradeTheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.key,
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(1)}%',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getPercentageColor(entry.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckTypeTrendCard(MapEntry<IntegrityCheckType, double> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                _getIntegrityCheckTypeIcon(entry.key),
                color: _getIntegrityCheckTypeColor(entry.key),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getIntegrityCheckTypeName(entry.key),
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${entry.value.toStringAsFixed(1)}%',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getPercentageColor(entry.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper methods
  String _getTrendText(double trendDirection) {
    if (trendDirection > 0) return '↗ Up';
    if (trendDirection < 0) return '↘ Down';
    return '→ Flat';
  }

  Color _getTrendColor(double trendDirection) {
    if (trendDirection > 0) return IOSGradeTheme.success;
    if (trendDirection < 0) return IOSGradeTheme.error;
    return IOSGradeTheme.textSecondary;
  }

  Color _getPercentageColor(double percentage) {
    if (percentage >= 90) return IOSGradeTheme.success;
    if (percentage >= 70) return IOSGradeTheme.warning;
    return IOSGradeTheme.error;
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

  IconData _getIntegrityCheckTypeIcon(IntegrityCheckType type) {
    switch (type) {
      case IntegrityCheckType.dataConsistency:
        return Icons.data_usage;
      case IntegrityCheckType.permissionCheck:
        return Icons.security;
      case IntegrityCheckType.systemHealth:
        return Icons.health_and_safety;
      case IntegrityCheckType.dataValidation:
        return Icons.verified;
    }
  }

  Color _getIntegrityCheckTypeColor(IntegrityCheckType type) {
    switch (type) {
      case IntegrityCheckType.dataConsistency:
        return IOSGradeTheme.primary;
      case IntegrityCheckType.permissionCheck:
        return IOSGradeTheme.warning;
      case IntegrityCheckType.systemHealth:
        return IOSGradeTheme.success;
      case IntegrityCheckType.dataValidation:
        return IOSGradeTheme.info;
    }
  }

  String _getIntegrityCheckTypeName(IntegrityCheckType type) {
    switch (type) {
      case IntegrityCheckType.dataConsistency:
        return 'Data Consistency';
      case IntegrityCheckType.permissionCheck:
        return 'Permission Check';
      case IntegrityCheckType.systemHealth:
        return 'System Health';
      case IntegrityCheckType.dataValidation:
        return 'Data Validation';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else {
      return '${duration.inMinutes}m';
    }
  }
}
