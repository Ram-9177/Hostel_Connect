// lib/features/reports/presentation/widgets/live_dashboard_tiles_widget.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/load_state.dart';
import '../../../../core/models/dashboard_models.dart';
import '../../../../core/providers/reports_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'drill_down_widget.dart';

class LiveDashboardTilesWidget extends ConsumerStatefulWidget {
  final String hostelId;
  final VoidCallback? onTileTap;

  const LiveDashboardTilesWidget({
    super.key,
    required this.hostelId,
    this.onTileTap,
  });

  @override
  ConsumerState<LiveDashboardTilesWidget> createState() => _LiveDashboardTilesWidgetState();
}

class _LiveDashboardTilesWidgetState extends ConsumerState<LiveDashboardTilesWidget>
    with TickerProviderStateMixin {
  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _initializeAnimations() {
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _refreshAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _refreshController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _refreshTiles();
    });
  }

  Future<void> _refreshTiles() async {
    _refreshController.forward().then((_) {
      _refreshController.reverse();
    });

    try {
      await ref.read(liveDashboardTilesProvider(widget.hostelId).notifier).refreshTiles();
    } catch (e) {
      Toast.showError(context, 'Failed to refresh tiles: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tilesData = ref.watch(liveDashboardTilesProvider(widget.hostelId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.dashboard,
                color: IOSGradeTheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Dashboard',
                      style: IOSGradeTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Real-time metrics and analytics',
                      style: IOSGradeTheme.bodyMedium.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedBuilder(
                animation: _refreshAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _refreshAnimation.value * 2 * 3.14159,
                    child: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _refreshTiles,
                      tooltip: 'Refresh Tiles',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        
        // Tiles Grid
        if (tilesData.state == LoadState.loading)
          const Center(child: CircularProgressIndicator())
        else if (tilesData.state == LoadState.error)
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
                  'Failed to load dashboard tiles',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tilesData.error ?? 'Unknown error',
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                IOSGradeButton(
                  text: 'Retry',
                  onPressed: () {
                    ref.invalidate(liveDashboardTilesProvider(widget.hostelId));
                  },
                  icon: Icons.refresh,
                  backgroundColor: IOSGradeTheme.primary,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          )
        else if (tilesData.data?.isEmpty ?? true)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.dashboard_outlined,
                  color: IOSGradeTheme.textSecondary,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'No dashboard tiles available',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          _buildTilesGrid(tilesData.data!),
      ],
    );
  }

  Widget _buildTilesGrid(List<LiveDashboardTile> tiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: tiles.length,
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return _buildTileCard(tile);
        },
      ),
    );
  }

  Widget _buildTileCard(LiveDashboardTile tile) {
    return IOSGradeCard(
      child: InkWell(
        onTap: () {
          widget.onTileTap?.call();
          _showDrillDownOptions(tile);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getTileTypeColor(tile.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getTileTypeIcon(tile.type),
                      color: _getTileTypeColor(tile.type),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tile.title,
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: tile.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getStatusIcon(tile.status),
                      color: tile.statusColor,
                      size: 12,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Value
              Text(
                tile.value,
                style: IOSGradeTheme.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getTileTypeColor(tile.type),
                ),
              ),
              
              if (tile.unit.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  tile.unit,
                  style: IOSGradeTheme.bodySmall.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
              
              const Spacer(),
              
              // Footer
              Row(
                children: [
                  // Trend
                  if (tile.trend != null) ...[
                    Icon(
                      _getTrendIcon(tile.trend!),
                      color: _getTrendColor(tile.trend!),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tile.trend!,
                      style: IOSGradeTheme.caption1.copyWith(
                        color: _getTrendColor(tile.trend!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  
                  // Freshness
                  Expanded(
                    child: Text(
                      tile.freshnessLabel,
                      style: IOSGradeTheme.caption1.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  // Drill down indicator
                  if (tile.drillDowns?.isNotEmpty ?? false)
                    Icon(
                      Icons.arrow_forward_ios,
                      color: IOSGradeTheme.textSecondary,
                      size: 12,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDrillDownOptions(LiveDashboardTile tile) {
    if (tile.drillDowns?.isEmpty ?? true) {
      Toast.showInfo(context, 'No drill-down options available for this tile');
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DrillDownWidget(
        tile: tile,
        onDrillDownSelected: (drillDown) {
          Navigator.pop(context);
          _executeDrillDown(drillDown);
        },
      ),
    );
  }

  void _executeDrillDown(DashboardDrillDown drillDown) {
    // Navigate to drill-down results page
    // This would typically open a new page with the drill-down results
    Toast.showInfo(context, 'Drill-down: ${drillDown.title}');
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

  IconData _getStatusIcon(DashboardTileStatus status) {
    switch (status) {
      case DashboardTileStatus.fresh:
        return Icons.check_circle;
      case DashboardTileStatus.stale:
        return Icons.warning;
      case DashboardTileStatus.error:
        return Icons.error;
      case DashboardTileStatus.loading:
        return Icons.hourglass_empty;
    }
  }

  IconData _getTrendIcon(String trend) {
    if (trend.toLowerCase().contains('up') || trend.contains('+')) {
      return Icons.trending_up;
    } else if (trend.toLowerCase().contains('down') || trend.contains('-')) {
      return Icons.trending_down;
    } else {
      return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    if (trend.toLowerCase().contains('up') || trend.contains('+')) {
      return Colors.green;
    } else if (trend.toLowerCase().contains('down') || trend.contains('-')) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
}
