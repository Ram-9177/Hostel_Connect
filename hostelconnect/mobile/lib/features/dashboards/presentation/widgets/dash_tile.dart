// lib/features/dashboards/presentation/widgets/dash_tile.dart
import 'package:flutter/material.dart';
import '../../../../core/responsive.dart';
import '../../../../shared/theme/tokens.dart';

class DashTile extends StatelessWidget {
  final String title;
  final String value;
  final String updatedAt;
  final Widget? trailing;
  final Color? color;
  final VoidCallback? onTap;

  const DashTile({
    super.key,
    required this.title,
    required this.value,
    required this.updatedAt,
    this.trailing,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final isWide = r.size.index >= HSize.lg.index;
      final valueStyle = TextStyle(
        fontSize: HFontSize.responsive(r, base: isWide ? 36 : 28),
        fontWeight: FontWeight.w700,
        color: color ?? HTokens.onSurface,
      );

      return Material(
        color: HTokens.surface,
        borderRadius: BorderRadius.circular(HTokens.cardRadius),
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
          child: Container(
            padding: EdgeInsets.all(HSpacing.responsive(r,
              xs: HTokens.sm,
              sm: HTokens.md,
              md: HTokens.lg,
              lg: HTokens.lg,
              xl: HTokens.xl,
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(HTokens.cardRadius),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: HFontSize.responsive(r, base: isWide ? 16 : 14),
                          fontWeight: FontWeight.w600,
                          color: HTokens.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: HSpacing.responsive(r,
                        xs: HTokens.xs,
                        sm: HTokens.sm,
                        md: HTokens.sm,
                        lg: HTokens.sm,
                        xl: HTokens.sm,
                      )),
                      Text(
                        value,
                        style: valueStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: HTokens.xs),
                      Text(
                        'Updated $updatedAt IST',
                        style: TextStyle(
                          fontSize: HFontSize.responsive(r, base: 12),
                          color: HTokens.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: HTokens.sm),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Responsive dashboard grid
class HDashGrid extends StatelessWidget {
  final List<DashTile> tiles;
  final int? maxColumns;

  const HDashGrid({
    super.key,
    required this.tiles,
    this.maxColumns,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      int columns;
      switch (r.size) {
        case HSize.xs:
        case HSize.sm:
          columns = 1;
          break;
        case HSize.md:
          columns = 2;
          break;
        case HSize.lg:
          columns = 3;
          break;
        case HSize.xl:
          columns = 4;
          break;
      }
      
      if (maxColumns != null && columns > maxColumns!) {
        columns = maxColumns!;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: HTokens.md,
          mainAxisSpacing: HTokens.md,
          childAspectRatio: r.size.index >= HSize.lg.index ? 1.5 : 1.2,
        ),
        itemCount: tiles.length,
        itemBuilder: (context, index) => tiles[index],
      );
    });
  }
}

// Responsive chart container
class HChartContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final double? height;

  const HChartContainer({
    super.key,
    required this.child,
    required this.title,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final chartHeight = height ?? HSpacing.responsive(r,
        xs: 200,
        sm: 250,
        md: 300,
        lg: 350,
        xl: 400,
      );

      return Container(
        height: chartHeight,
        padding: EdgeInsets.all(HSpacing.responsive(r,
          xs: HTokens.sm,
          sm: HTokens.md,
          md: HTokens.lg,
          lg: HTokens.lg,
          xl: HTokens.xl,
        )),
        decoration: BoxDecoration(
          color: HTokens.surface,
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
          boxShadow: HTokens.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: HFontSize.responsive(r, base: 18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: HTokens.md),
            Expanded(
              child: RepaintBoundary(child: child),
            ),
          ],
        ),
      );
    });
  }
}
