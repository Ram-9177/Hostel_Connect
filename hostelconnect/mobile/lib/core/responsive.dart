// lib/core/responsive.dart
import 'package:flutter/material.dart';

import '../shared/theme/tokens.dart';

/// Breakpoint identifiers used across the mobile app.
enum HSize { xs, sm, md, lg, xl }

typedef HResponsiveBuilder = Widget Function(
  BuildContext context,
  HResponsiveData responsive,
);

/// Provides computed responsive metadata derived from layout constraints
/// and the surrounding [MediaQuery].
class HResponsiveData {
  HResponsiveData({
    required this.context,
    required this.constraints,
    required this.mediaQuery,
  });

  final BuildContext context;
  final BoxConstraints constraints;
  final MediaQueryData mediaQuery;

  factory HResponsiveData.fromContext(BuildContext context) {
    final mq = MediaQuery.of(context);
    return HResponsiveData(
      context: context,
      constraints: BoxConstraints.tight(mq.size),
      mediaQuery: mq,
    );
  }

  double get width => constraints.maxWidth.isFinite
      ? constraints.maxWidth
      : mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  Size get sizePX => Size(width, height);

  Orientation get orientation => mediaQuery.orientation;

  EdgeInsets get safePadding => mediaQuery.padding;

  double get textScale => mediaQuery.textScaleFactor;

  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  /// Provides the current breakpoint bucket using [HTokens] thresholds.
  HSize get size {
    if (width >= HTokens.breakpointXL) return HSize.xl;
    if (width >= HTokens.breakpointLG) return HSize.lg;
    if (width >= HTokens.breakpointMD) return HSize.md;
    if (width >= HTokens.breakpointSM) return HSize.sm;
    return HSize.xs;
  }

  bool get isMobile => size == HSize.xs;
  bool get isTablet => size == HSize.sm || size == HSize.md;
  bool get isDesktop => size == HSize.lg || size == HSize.xl;

  /// Utility to resolve a value based on the active breakpoint.
  double valueFor({
    required double xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    switch (size) {
      case HSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
      case HSize.lg:
        return lg ?? md ?? sm ?? xs;
      case HSize.md:
        return md ?? sm ?? xs;
      case HSize.sm:
        return sm ?? xs;
      case HSize.xs:
        return xs;
    }
  }
}

/// Responsive helper widget used throughout the UI and widget tests.
class HResponsive extends StatelessWidget {
  const HResponsive({
    super.key,
    required HResponsiveBuilder builder,
    this.fallback,
  }) : _builder = builder;

  final HResponsiveBuilder _builder;
  final Widget? fallback;

  static Widget builder({
    Key? key,
    required HResponsiveBuilder builder,
    Widget? fallback,
  }) {
    return HResponsive(
      key: key,
      builder: builder,
      fallback: fallback,
    );
  }

  /// Backwards-compatible helper to pick widgets by breakpoint using context.
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final data = HResponsiveData.fromContext(context);
    if (data.isDesktop && desktop != null) return desktop;
    if (data.isTablet && tablet != null) return tablet;
    return mobile;
  }

  static double responsiveDouble(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final data = HResponsiveData.fromContext(context);
    return data.valueFor(xs: mobile, sm: tablet, md: tablet, lg: desktop, xl: desktop);
  }

  static EdgeInsets responsivePadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    final data = HResponsiveData.fromContext(context);
    if (data.isDesktop && desktop != null) return desktop;
    if (data.isTablet && tablet != null) return tablet;
    return mobile;
  }

  static double responsiveSpacing(BuildContext context) {
    final data = HResponsiveData.fromContext(context);
    return data.valueFor(
      xs: HTokens.sm,
      sm: HTokens.md,
      md: HTokens.lg,
      lg: HTokens.lg,
      xl: HTokens.xl,
    );
  }

  static int responsiveColumns(BuildContext context) {
    final data = HResponsiveData.fromContext(context);
    switch (data.size) {
      case HSize.xs:
      case HSize.sm:
        return 1;
      case HSize.md:
        return 2;
      case HSize.lg:
        return 3;
      case HSize.xl:
        return 4;
    }
  }

  static bool isDesktop(BuildContext context) {
    return HResponsiveData.fromContext(context).isDesktop;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final mediaQuery = MediaQuery.maybeOf(ctx);
        if (mediaQuery == null) {
          return fallback ?? const SizedBox.shrink();
        }

        final data = HResponsiveData(
          context: ctx,
          constraints: constraints,
          mediaQuery: mediaQuery,
        );

        return _builder(ctx, data);
      },
    );
  }
}

/// Convenience helpers for spacing tokens that vary with responsive size.
class HSpacing {
  static double responsive(
    HResponsiveData responsive, {
    required double xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return responsive.valueFor(xs: xs, sm: sm, md: md, lg: lg, xl: xl);
  }
}

/// Responsive typography helpers.
class HFontSize {
  static double responsive(
    HResponsiveData responsive, {
    required double base,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return responsive.valueFor(
      xs: base,
      sm: sm,
      md: md,
      lg: lg,
      xl: xl,
    );
  }
}