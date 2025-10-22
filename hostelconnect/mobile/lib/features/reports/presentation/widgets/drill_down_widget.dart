// lib/features/reports/presentation/widgets/drill_down_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/dashboard_models.dart';
import '../../../../core/models/load_state_data.dart';
import '../../../../core/models/load_state.dart';
import '../../../../core/providers/reports_providers.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

/// Drill down request model
class DrillDownRequest {
  final String tileId;
  final String drillDownId;
  final Map<String, String>? parameters;

  const DrillDownRequest({
    required this.tileId,
    required this.drillDownId,
    this.parameters,
  });
}

class DrillDownWidget extends ConsumerStatefulWidget {
  final LiveDashboardTile tile;
  final Function(DashboardDrillDown) onDrillDownSelected;

  const DrillDownWidget({
    super.key,
    required this.tile,
    required this.onDrillDownSelected,
  });

  @override
  ConsumerState<DrillDownWidget> createState() => _DrillDownWidgetState();
}

class _DrillDownWidgetState extends ConsumerState<DrillDownWidget>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  DashboardDrillDown? _selectedDrillDown;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _slideController.forward();
  }

  Future<void> _executeDrillDown(DashboardDrillDown drillDown) async {
    setState(() {
      _selectedDrillDown = drillDown;
    });

    try {
      final request = DrillDownRequest(
        tileId: widget.tile.id,
        drillDownId: drillDown.id,
        parameters: drillDown.parameters,
      );

      final result = await ref.read(reportsServiceProvider).executeDrillDown(request);

      if (result.state == LoadState.success) {
        // Show results in a new page or modal
        _showDrillDownResults(drillDown, result.data!);
      } else {
        Toast.showError(context, result.error ?? 'Failed to execute drill-down');
      }
    } catch (e) {
      Toast.showError(context, 'Error executing drill-down: $e');
    } finally {
      setState(() {
        _selectedDrillDown = null;
      });
    }
  }

  void _showDrillDownResults(DashboardDrillDown drillDown, List<Map<String, dynamic>> results) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrillDownResultsPage(
          drillDown: drillDown,
          results: results,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTileTypeColor(widget.tile.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTileTypeIcon(widget.tile.type),
                      color: _getTileTypeColor(widget.tile.type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tile.title,
                          style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Drill-down Options',
                          style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            
            // Drill-down Options
            if (widget.tile.drillDowns?.isEmpty ?? true)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        color: IOSGradeTheme.textSecondary,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No drill-down options available',
                        style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This tile does not have any drill-down options configured.',
                        style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.tile.drillDowns!.length,
                itemBuilder: (context, index) {
                  final drillDown = widget.tile.drillDowns![index];
                  return _buildDrillDownOption(drillDown);
                },
              ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrillDownOption(DashboardDrillDown drillDown) {
    final isSelected = _selectedDrillDown?.id == drillDown.id;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: IOSGradeCard(
        child: InkWell(
          onTap: isSelected ? null : () => _executeDrillDown(drillDown),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getDrillDownTypeColor(drillDown.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getDrillDownTypeIcon(drillDown.type),
                    color: _getDrillDownTypeColor(drillDown.type),
                    size: 20,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drillDown.title,
                        style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (drillDown.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          drillDown.description!,
                          style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                if (isSelected)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios,
                    color: IOSGradeTheme.textSecondary,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTileTypeColor(DashboardTileType type) {
    switch (type) {
      case DashboardTileType.attendance:
        return Colors.blue;
      case DashboardTileType.gate:
        return Colors.green;
      case DashboardTileType.meals:
        return Colors.orange;
      case DashboardTileType.occupancy:
        return Colors.purple;
      case DashboardTileType.integrity:
        return Colors.red;
      case DashboardTileType.custom:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  IconData _getTileTypeIcon(DashboardTileType type) {
    switch (type) {
      case DashboardTileType.attendance:
        return Icons.people;
      case DashboardTileType.gate:
        return Icons.door_front_door;
      case DashboardTileType.meals:
        return Icons.restaurant;
      case DashboardTileType.occupancy:
        return Icons.bed;
      case DashboardTileType.integrity:
        return Icons.security;
      case DashboardTileType.custom:
        return Icons.analytics;
      default:
        return Icons.info;
    }
  }

  Color _getDrillDownTypeColor(DrillDownType type) {
    switch (type) {
      case DrillDownType.list:
        return Colors.blue;
      case DrillDownType.chart:
        return Colors.green;
      case DrillDownType.table:
        return Colors.orange;
      case DrillDownType.export:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getDrillDownTypeIcon(DrillDownType type) {
    switch (type) {
      case DrillDownType.list:
        return Icons.list;
      case DrillDownType.chart:
        return Icons.bar_chart;
      case DrillDownType.table:
        return Icons.table_chart;
      case DrillDownType.export:
        return Icons.download;
      default:
        return Icons.list;
    }
  }
}

class DrillDownResultsPage extends StatelessWidget {
  final DashboardDrillDown drillDown;
  final List<Map<String, dynamic>> results;

  const DrillDownResultsPage({
    super.key,
    required this.drillDown,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: Text(drillDown.title),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement export functionality
              Toast.showInfo(context, 'Export functionality not implemented');
            },
            tooltip: 'Export Results',
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary
          Container(
            margin: const EdgeInsets.all(16),
            child: IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      _getDrillDownTypeIcon(drillDown.type),
                      color: _getDrillDownTypeColor(drillDown.type),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${results.length} results found',
                            style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (drillDown.description != null)
                            Text(
                              drillDown.description!,
                              style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                color: UnifiedTheme.lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Results
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          color: IOSGradeTheme.textSecondary,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildResultsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    switch (drillDown.type) {
      case DrillDownType.list:
        return _buildListResults();
      case DrillDownType.table:
        return _buildTableResults();
      case DrillDownType.chart:
        return _buildChartResults();
      case DrillDownType.export:
        return _buildExportResults();
    }
  }

  Widget _buildListResults() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: result.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            entry.key,
                            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: UnifiedTheme.lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            entry.value?.toString() ?? 'N/A',
                            style: IOSGradeTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableResults() {
    if (results.isEmpty) return const SizedBox.shrink();
    
    final columns = results.first.keys.toList();
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((column) => DataColumn(
          label: Text(
            column,
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        )).toList(),
        rows: results.map((result) => DataRow(
          cells: columns.map((column) => DataCell(
            Text(result[column]?.toString() ?? 'N/A'),
          )).toList(),
        )).toList(),
      ),
    );
  }

  Widget _buildChartResults() {
    // TODO: Implement chart visualization
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            color: IOSGradeTheme.textSecondary,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Chart visualization not implemented',
            style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.download,
            color: IOSGradeTheme.textSecondary,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Export functionality not implemented',
            style: UnifiedTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDrillDownTypeColor(DrillDownType type) {
    switch (type) {
      case DrillDownType.list:
        return Colors.blue;
      case DrillDownType.chart:
        return Colors.green;
      case DrillDownType.table:
        return Colors.orange;
      case DrillDownType.export:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getDrillDownTypeIcon(DrillDownType type) {
    switch (type) {
      case DrillDownType.list:
        return Icons.list;
      case DrillDownType.chart:
        return Icons.bar_chart;
      case DrillDownType.table:
        return Icons.table_chart;
      case DrillDownType.export:
        return Icons.download;
      default:
        return Icons.list;
    }
  }
}
