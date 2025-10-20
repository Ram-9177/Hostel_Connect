// lib/core/responsive.dart
import 'package:flutter/widgets.dart';

enum HSize { xs, sm, md, lg, xl }

class HResponsive extends InheritedWidget {
  final HSize size;
  final double width;
  final double height;
  final double textScale;

  const HResponsive({
    super.key,
    required super.child,
    required this.size,
    required this.width,
    required this.height,
    required this.textScale,
  });

  static HResponsive of(BuildContext c) =>
      c.dependOnInheritedWidgetOfExactType<HResponsive>()!;

  static Widget builder({required Widget Function(BuildContext, HResponsive) builder}) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final h = constraints.maxHeight;
      final ts = MediaQuery.textScaleFactorOf(context).clamp(0.8, 1.3);
      HSize s;
      if (w < 360) s = HSize.xs;
      else if (w < 480) s = HSize.sm;
      else if (w < 840) s = HSize.md;
      else if (w < 1200) s = HSize.lg;
      else s = HSize.xl;
      return HResponsive(size: s, width: w, height: h, textScale: ts, child: Builder(
        builder: (ctx) => builder(ctx, HResponsive.of(ctx)),
      ));
    });
  }

  // Responsive breakpoint properties
  bool get isXS => size == HSize.xs;
  bool get isSM => size == HSize.sm;
  bool get isMD => size == HSize.md;
  bool get isLG => size == HSize.lg;
  bool get isXL => size == HSize.xl;

  // Responsive spacing
  double get spacing => switch (size) {
    HSize.xs => HTokens.xs,
    HSize.sm => HTokens.sm,
    HSize.md => HTokens.md,
    HSize.lg => HTokens.lg,
    HSize.xl => HTokens.xl,
  };

  // Responsive radius
  double get radius => switch (size) {
    HSize.xs => HTokens.cardRadius * 0.8,
    HSize.sm => HTokens.cardRadius * 0.9,
    HSize.md => HTokens.cardRadius,
    HSize.lg => HTokens.cardRadius * 1.1,
    HSize.xl => HTokens.cardRadius * 1.2,
  };

  @override
  bool updateShouldNotify(HResponsive old) =>
      old.size != size || old.width != width || old.height != height || old.textScale != textScale;
}

// Design tokens
class HTokens {
  // Spacing scale
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  // Corner radius
  static const double cardRadius = 12;
  static const double sheetRadius = 20;

  // Shadows
  static const List<BoxShadow> cardShadow = [
    BoxShadow(blurRadius: 10, color: Color(0x11000000), offset: Offset(0, 2))
  ];
  static const List<BoxShadow> sheetShadow = [
    BoxShadow(blurRadius: 20, color: Color(0x22000000), offset: Offset(0, 4))
  ];

  // Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  static const Color onSurface = Color(0xFF000000);
  static const Color onSurfaceVariant = Color(0xFF666666);
}

// Responsive spacing helper
class HSpacing {
  static double responsive(HResponsive r, {
    double xs = 0,
    double sm = 0,
    double md = 0,
    double lg = 0,
    double xl = 0,
  }) {
    return switch (r.size) {
      HSize.xs => xs,
      HSize.sm => sm,
      HSize.md => md,
      HSize.lg => lg,
      HSize.xl => xl,
    };
  }
}

// Responsive font size helper
class HFontSize {
  static double responsive(HResponsive r, {
    required double base,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    final scale = r.textScale;
    final size = switch (r.size) {
      HSize.xs => xs ?? base * 0.9,
      HSize.sm => sm ?? base,
      HSize.md => md ?? base * 1.1,
      HSize.lg => lg ?? base * 1.2,
      HSize.xl => xl ?? base * 1.3,
    };
    return size * scale;
  }
}
