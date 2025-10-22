// lib/shared/widgets/ui/dash_tile.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../core/models/dashboard_models.dart';

/// Dashboard tile widget
class DashTile extends StatelessWidget {
  final LiveDashboardTile tile;
  final VoidCallback? onTap;
  final VoidCallback? onDrillDown;

  const DashTile({
    super.key,
    required this.tile,
    this.onTap,
    this.onDrillDown,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(HTokens.radiusMd),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(HTokens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: HTokens.sm),
              _buildValue(context),
              const SizedBox(height: HTokens.sm),
              _buildTrend(context),
              if (tile.drillDowns.isNotEmpty) ...[
                const SizedBox(height: HTokens.sm),
                _buildDrillDown(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            tile.title,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: HTokens.sm,
            vertical: HTokens.xs,
          ),
          decoration: BoxDecoration(
            color: _getStatusColor(tile.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(HTokens.radiusSm),
          ),
          child: Text(
            tile.status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(tile.status),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValue(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tile.value.toStringAsFixed(1),
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: _getTypeColor(tile.type),
          ),
        ),
        const SizedBox(width: HTokens.xs),
        Text(
          tile.unit,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTrend(BuildContext context) {
    final isPositive = tile.trend >= 0;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;
    final trendColor = isPositive ? Colors.green : Colors.red;

    return Row(
      children: [
        Icon(
          trendIcon,
          size: HTokens.iconSm,
          color: trendColor,
        ),
        const SizedBox(width: HTokens.xs),
        Text(
          '${tile.trend.abs().toStringAsFixed(1)}%',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: trendColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: HTokens.xs),
        Text(
          'vs last period',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDrillDown(BuildContext context) {
    return InkWell(
      onTap: onDrillDown,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: HTokens.sm,
          vertical: HTokens.xs,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(HTokens.radiusSm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View Details',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: HTokens.xs),
            Icon(
              Icons.arrow_forward_ios,
              size: HTokens.iconSm,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
        return Colors.green;
      case 'pending':
      case 'waiting':
        return Colors.orange;
      case 'rejected':
      case 'inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'attendance':
        return Colors.blue;
      case 'occupancy':
        return Colors.purple;
      case 'meals':
        return Colors.orange;
      case 'gatepass':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

/// Dashboard grid widget
class HDashGrid extends StatelessWidget {
  final List<LiveDashboardTile> tiles;
  final Function(LiveDashboardTile)? onTileTap;
  final Function(LiveDashboardTile)? onDrillDown;

  const HDashGrid({
    super.key,
    required this.tiles,
    this.onTileTap,
    this.onDrillDown,
  });

  @override
  Widget build(BuildContext context) {
    final columns = HResponsive.responsiveColumns(context);
    
    return GridView.builder(
      padding: const EdgeInsets.all(HTokens.md),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: HTokens.md,
        mainAxisSpacing: HTokens.md,
        childAspectRatio: 1.2,
      ),
      itemCount: tiles.length,
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return DashTile(
          tile: tile,
          onTap: () => onTileTap?.call(tile),
          onDrillDown: () => onDrillDown?.call(tile),
        );
      },
    );
  }
}
