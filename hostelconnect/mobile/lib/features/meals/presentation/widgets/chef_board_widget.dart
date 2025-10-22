// lib/features/meals/presentation/widgets/chef_board_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/providers/meal_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class ChefBoardWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final DateTime date;

  const ChefBoardWidget({
    super.key,
    required this.hostelId,
    required this.date,
  });

  @override
  ConsumerState<ChefBoardWidget> createState() => _ChefBoardWidgetState();
}

class _ChefBoardWidgetState extends ConsumerState<ChefBoardWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLocking = false;
  bool _isExporting = false;

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

  Future<void> _lockChefBoard() async {
    if (_isLocking) return;

    setState(() {
      _isLocking = true;
    });

    try {
      final chefBoardNotifier = ref.read(chefBoardProvider(widget.hostelId).notifier);
      await chefBoardNotifier.lockChefBoard();
      
      Toast.showSuccess(context, 'Chef board locked successfully');
    } catch (e) {
      Toast.showError(context, 'Failed to lock chef board: $e');
    } finally {
      setState(() {
        _isLocking = false;
      });
    }
  }

  Future<void> _exportToCSV() async {
    if (_isExporting) return;

    setState(() {
      _isExporting = true;
    });

    try {
      final mealService = ref.read(mealServiceProvider);
      final result = await mealService.exportToCSV(
        widget.hostelId,
        widget.date,
        MealType.values,
      );

      if (result.state == LoadState.success && result.data != null) {
        // TODO: Implement file download/save functionality
        Toast.showSuccess(context, 'CSV export completed');
      } else {
        Toast.showError(context, result.error ?? 'Failed to export CSV');
      }
    } catch (e) {
      Toast.showError(context, 'Error exporting CSV: $e');
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chefBoard = ref.watch(chefBoardProvider(widget.hostelId));
    final forecasts = ref.watch(todayMealForecastsProvider(widget.hostelId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: Text('Chef Board - ${_formatDate(widget.date)}'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (chefBoard.data?.isLocked != true)
            IconButton(
              icon: const Icon(Icons.lock),
              onPressed: _isLocking ? null : _lockChefBoard,
              tooltip: 'Lock Board',
            ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _isExporting ? null : _exportToCSV,
            tooltip: 'Export CSV',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(chefBoardProvider(widget.hostelId));
              ref.invalidate(todayMealForecastsProvider(widget.hostelId));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Forecasts', icon: Icon(Icons.analytics)),
            Tab(text: 'Details', icon: Icon(Icons.list)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildForecastsTab(chefBoard, forecasts),
          _buildDetailsTab(chefBoard, forecasts),
        ],
      ),
    );
  }

  Widget _buildForecastsTab(LoadStateData<ChefBoard> chefBoard, LoadStateData<List<MealForecast>> forecasts) {
    if (chefBoard.state == LoadState.loading || forecasts.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (chefBoard.state == LoadState.error || forecasts.state == LoadState.error) {
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
              'Failed to load chef board',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              chefBoard.error ?? forecasts.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(chefBoardProvider(widget.hostelId));
                ref.invalidate(todayMealForecastsProvider(widget.hostelId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final board = chefBoard.data;
    final forecastList = forecasts.data ?? [];

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(chefBoardProvider(widget.hostelId));
        ref.invalidate(todayMealForecastsProvider(widget.hostelId));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Board Status
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      board?.isLocked == true ? Icons.lock : Icons.lock_open,
                      color: board?.isLocked == true ? IOSGradeTheme.error : IOSGradeTheme.success,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            board?.isLocked == true ? 'Board Locked' : 'Board Active',
                            style: IOSGradeTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: board?.isLocked == true ? IOSGradeTheme.error : IOSGradeTheme.success,
                            ),
                          ),
                          Text(
                            board?.isLocked == true 
                                ? 'Locked at ${_formatTime(board!.lockedAt)}'
                                : 'Ready for meal preparation',
                            style: IOSGradeTheme.bodyMedium.copyWith(
                              color: IOSGradeTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (board?.isLocked != true)
                      ElevatedButton.icon(
                        onPressed: _isLocking ? null : _lockChefBoard,
                        icon: _isLocking 
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.lock),
                        label: Text(_isLocking ? 'Locking...' : 'Lock Board'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IOSGradeTheme.error,
                          foregroundColor: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Meal Forecasts
            Text(
              'Meal Forecasts',
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            ...forecastList.map((forecast) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildForecastCard(forecast, board),
              );
            }).toList(),
            
            const SizedBox(height: 16),
            
            // Summary Stats
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Total Forecast',
                            forecastList.fold(0, (sum, f) => sum + f.finalCount).toString(),
                            Icons.analytics,
                            IOSGradeTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSummaryCard(
                            'Confirmed',
                            forecastList.fold(0, (sum, f) => sum + f.confirmedCount).toString(),
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
                            'Buffer',
                            forecastList.fold(0, (sum, f) => sum + f.bufferCount).toString(),
                            Icons.add_circle,
                            IOSGradeTheme.info,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildSummaryCard(
                            'Overrides',
                            forecastList.fold(0, (sum, f) => sum + f.overrideCount).toString(),
                            Icons.edit,
                            IOSGradeTheme.warning,
                          ),
                        ),
                      ],
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

  Widget _buildDetailsTab(LoadStateData<ChefBoard> chefBoard, LoadStateData<List<MealForecast>> forecasts) {
    if (chefBoard.state == LoadState.loading || forecasts.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final board = chefBoard.data;
    final forecastList = forecasts.data ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Export Actions
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export Options',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isExporting ? null : _exportToCSV,
                          icon: _isExporting 
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.file_download),
                          label: Text(_isExporting ? 'Exporting...' : 'Export CSV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: IOSGradeTheme.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement PDF export
                            Toast.showInfo(context, 'PDF export not implemented');
                          },
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text('Export PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: IOSGradeTheme.error,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Detailed Forecasts
          Text(
            'Detailed Forecasts',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          ...forecastList.map((forecast) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildDetailedForecastCard(forecast),
            );
          }).toList(),
          
          const SizedBox(height: 16),
          
          // Board Information
          if (board != null)
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Board Information',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildInfoRow('Board ID', board.id),
                    _buildInfoRow('Hostel ID', board.hostelId),
                    _buildInfoRow('Date', _formatDate(board.date)),
                    _buildInfoRow('Status', board.isLocked ? 'Locked' : 'Active'),
                    if (board.isLocked) ...[
                      _buildInfoRow('Locked At', _formatTime(board.lockedAt)),
                      _buildInfoRow('Locked By', board.lockedBy),
                    ],
                    _buildInfoRow('Total Forecasts', board.forecasts.length.toString()),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForecastCard(MealForecast forecast, ChefBoard? board) {
    final isLocked = board?.isLocked == true;
    
    return IOSGradeCard(
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
                    color: _getMealTypeColor(forecast.mealType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    forecast.mealType.emoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forecast.mealType.displayName,
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        forecast.mealType.description,
                        style: IOSGradeTheme.bodySmall.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLocked)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: IOSGradeTheme.error,
                      ),
                    ),
                    child: Text(
                      'LOCKED',
                      style: IOSGradeTheme.caption1.copyWith(
                        color: IOSGradeTheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Forecast Numbers
            Row(
              children: [
                Expanded(
                  child: _buildForecastNumber(
                    'Confirmed',
                    forecast.confirmedCount.toString(),
                    IOSGradeTheme.success,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildForecastNumber(
                    'Buffer',
                    forecast.bufferCount.toString(),
                    IOSGradeTheme.info,
                    Icons.add_circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildForecastNumber(
                    'Overrides',
                    forecast.overrideCount.toString(),
                    IOSGradeTheme.warning,
                    Icons.edit,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildForecastNumber(
                    'Final',
                    forecast.finalCount.toString(),
                    IOSGradeTheme.primary,
                    Icons.restaurant,
                    isHighlighted: true,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Progress Bar
            LinearProgressIndicator(
              value: forecast.totalStudents > 0 ? forecast.finalCount / forecast.totalStudents : 0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                forecast.isOverCapacity ? IOSGradeTheme.error : IOSGradeTheme.primary,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${forecast.attendancePercentage.toStringAsFixed(1)}% attendance',
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
                if (forecast.isOverCapacity)
                  Text(
                    '+${forecast.excessCount} over capacity',
                    style: IOSGradeTheme.bodySmall.copyWith(
                      color: IOSGradeTheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedForecastCard(MealForecast forecast) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  forecast.mealType.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    forecast.mealType.displayName,
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${forecast.finalCount} meals',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: IOSGradeTheme.primary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Breakdown
            _buildBreakdownRow('Total Students', forecast.totalStudents.toString()),
            _buildBreakdownRow('Confirmed Intents', forecast.confirmedCount.toString()),
            _buildBreakdownRow('Buffer Count', '${forecast.bufferCount} (${forecast.bufferPercentage.toStringAsFixed(1)}%)'),
            _buildBreakdownRow('Override Count', forecast.overrideCount.toString()),
            _buildBreakdownRow('Final Count', forecast.finalCount.toString()),
            
            const SizedBox(height: 12),
            
            // Calculated Info
            Text(
              'Calculated at ${_formatTime(forecast.calculatedAt)} by ${forecast.calculatedBy}',
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastNumber(String label, String value, Color color, IconData icon, {bool isHighlighted = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted ? color : Colors.grey[200]!,
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Column(
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
              color: isHighlighted ? color : IOSGradeTheme.textPrimary,
            ),
          ),
          Text(
            label,
            style: IOSGradeTheme.caption1.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
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
            style: IOSGradeTheme.bodySmall.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: IOSGradeTheme.bodyMedium,
          ),
          Text(
            value,
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: IOSGradeTheme.bodyMedium.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: IOSGradeTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Colors.orange;
      case MealType.lunch:
        return Colors.blue;
      case MealType.snacks:
        return Colors.purple;
      case MealType.dinner:
        return Colors.green;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
