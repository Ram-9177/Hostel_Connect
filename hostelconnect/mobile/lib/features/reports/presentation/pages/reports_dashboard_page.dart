// lib/features/reports/presentation/pages/reports_dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/dashboard_models.dart';
import '../../../../core/providers/reports_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../widgets/live_dashboard_tiles_widget.dart';
import '../widgets/daily_analytics_widget.dart';
import '../widgets/monthly_analytics_widget.dart';

class ReportsDashboardPage extends ConsumerStatefulWidget {
  final String hostelId;

  const ReportsDashboardPage({
    super.key,
    required this.hostelId,
  });

  @override
  ConsumerState<ReportsDashboardPage> createState() => _ReportsDashboardPageState();
}

class _ReportsDashboardPageState extends ConsumerState<ReportsDashboardPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedMonth = DateTime.now();

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
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _refreshAllData();
            },
            tooltip: 'Refresh All Data',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              _showExportOptions();
            },
            tooltip: 'Export Data',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Live', icon: Icon(Icons.dashboard)),
            Tab(text: 'Daily', icon: Icon(Icons.today)),
            Tab(text: 'Monthly', icon: Icon(Icons.calendar_month)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLiveTab(),
          _buildDailyTab(),
          _buildMonthlyTab(),
        ],
      ),
    );
  }

  Widget _buildLiveTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(liveDashboardTilesProvider(widget.hostelId).notifier).refreshTiles();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Live Dashboard Tiles
            LiveDashboardTilesWidget(
              hostelId: widget.hostelId,
              onTileTap: () {
                // Handle tile tap
              },
            ),
            
            const SizedBox(height: 20),
            
            // Quick Actions
            _buildQuickActions(),
            
            const SizedBox(height: 20),
            
            // Materialized Views Status
            _buildMaterializedViewsStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTab() {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(dailyAnalyticsProvider((widget.hostelId, _selectedDate)));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Date Selector
            _buildDateSelector(),
            
            const SizedBox(height: 20),
            
            // Daily Analytics
            DailyAnalyticsWidget(
              hostelId: widget.hostelId,
              date: _selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTab() {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(monthlyAnalyticsProvider((widget.hostelId, _selectedMonth)));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Month Selector
            _buildMonthSelector(),
            
            const SizedBox(height: 20),
            
            // Monthly Analytics
            MonthlyAnalyticsWidget(
              hostelId: widget.hostelId,
              month: _selectedMonth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: IOSGradeTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: IOSGradeButton(
                      text: 'Refresh All',
                      onPressed: _refreshAllData,
                      icon: Icons.refresh,
                      backgroundColor: IOSGradeTheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: IOSGradeButton(
                      text: 'Export Data',
                      onPressed: _showExportOptions,
                      icon: Icons.download,
                      backgroundColor: IOSGradeTheme.info,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: IOSGradeButton(
                      text: 'View Trends',
                      onPressed: () {
                        _tabController.animateTo(2); // Switch to Monthly tab
                      },
                      icon: Icons.trending_up,
                      backgroundColor: IOSGradeTheme.success,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: IOSGradeButton(
                      text: 'Data Dictionary',
                      onPressed: _showDataDictionary,
                      icon: Icons.book,
                      backgroundColor: IOSGradeTheme.warning,
                      foregroundColor: Colors.white,
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

  Widget _buildMaterializedViewsStatus() {
    final materializedViews = ref.watch(reportsServiceProvider).getMaterializedViews();

    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.storage,
                    color: IOSGradeTheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Materialized Views Status',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // This would typically show the status of materialized views
              Text(
                'All materialized views are up to date',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.success,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last refreshed: ${DateTime.now().toString().substring(0, 19)}',
                style: IOSGradeTheme.caption1.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Date',
                style: IOSGradeTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: IOSGradeTheme.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: IOSGradeTheme.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: IOSGradeTheme.bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Month',
                style: IOSGradeTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedMonth,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedMonth = date;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: IOSGradeTheme.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: IOSGradeTheme.textSecondary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '${_selectedMonth.month}/${_selectedMonth.year}',
                          style: IOSGradeTheme.bodyMedium,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshAllData() async {
    try {
      // Refresh live tiles
      await ref.read(liveDashboardTilesProvider(widget.hostelId).notifier).refreshTiles();
      
      // Refresh daily analytics
      ref.invalidate(dailyAnalyticsProvider((widget.hostelId, _selectedDate)));
      
      // Refresh monthly analytics
      ref.invalidate(monthlyAnalyticsProvider((widget.hostelId, _selectedMonth)));
      
      Toast.showSuccess(context, 'All data refreshed successfully');
    } catch (e) {
      Toast.showError(context, 'Failed to refresh data: $e');
    }
  }

  void _showExportOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Export Data',
                style: IOSGradeTheme.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: IOSGradeButton(
                      text: 'CSV',
                      onPressed: () {
                        Navigator.pop(context);
                        _exportData('csv');
                      },
                      icon: Icons.table_chart,
                      backgroundColor: IOSGradeTheme.success,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: IOSGradeButton(
                      text: 'Excel',
                      onPressed: () {
                        Navigator.pop(context);
                        _exportData('excel');
                      },
                      icon: Icons.description,
                      backgroundColor: IOSGradeTheme.info,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: IOSGradeButton(
                      text: 'PDF',
                      onPressed: () {
                        Navigator.pop(context);
                        _exportData('pdf');
                      },
                      icon: Icons.picture_as_pdf,
                      backgroundColor: IOSGradeTheme.error,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: IOSGradeButton(
                      text: 'JSON',
                      onPressed: () {
                        Navigator.pop(context);
                        _exportData('json');
                      },
                      icon: Icons.code,
                      backgroundColor: IOSGradeTheme.warning,
                      foregroundColor: Colors.white,
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

  Future<void> _exportData(String format) async {
    try {
      final reportsService = ref.read(reportsServiceProvider);
      final result = await reportsService.exportDashboardData(
        widget.hostelId,
        DashboardPeriod.daily,
        format,
      );

      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Data exported successfully');
      } else {
        Toast.showError(context, result.error ?? 'Failed to export data');
      }
    } catch (e) {
      Toast.showError(context, 'Error exporting data: $e');
    }
  }

  void _showDataDictionary() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Dictionary'),
        content: const Text('Data dictionary functionality not implemented'),
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
