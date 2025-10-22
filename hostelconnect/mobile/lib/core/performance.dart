// lib/core/performance.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:developer';

class HPerformance {
  // Precache critical images
  static Future<void> precacheCriticalAssets(BuildContext context) async {
    try {
      // Precache app logo and critical images
      await precacheImage(
        AssetImage('assets/images/logo.png'),
        context,
      );
      
      // Precache common icons
      await precacheImage(
        AssetImage('assets/images/qr_scanner.png'),
        context,
      );
      
      await precacheImage(
        AssetImage('assets/images/meal_icon.png'),
        context,
      );
    } catch (e) {
      // Handle missing assets gracefully
      debugPrint('Failed to precache assets: $e');
    }
  }

  // Optimize image loading
  static Widget optimizedImage({
    required String imagePath,
    required double width,
    required double height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        );
      },
    );
  }

  // Debounce function for UI updates
  static void debounce(
    String key,
    Duration delay,
    VoidCallback callback,
  ) {
    _debounceTimers[key]?.cancel();
    _debounceTimers[key] = Timer(delay, callback);
  }

  static final Map<String, Timer> _debounceTimers = {};

  // Haptic feedback helper
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  // Performance monitoring
  static void startPerformanceTrace(String name) {
    Timeline.startSync(name);
  }

  static void finishPerformanceTrace() {
    Timeline.finishSync();
  }
}

// Repaint boundary wrapper for heavy widgets
class HRepaintBoundary extends StatelessWidget {
  final Widget child;
  final String? debugLabel;

  const HRepaintBoundary({
    super.key,
    required this.child,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: child,
    );
  }
}

// Automatic keep alive for tab bodies
class HKeepAliveWrapper extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const HKeepAliveWrapper({
    super.key,
    required this.child,
    this.keepAlive = true,
  });

  @override
  State<HKeepAliveWrapper> createState() => _HKeepAliveWrapperState();
}

class _HKeepAliveWrapperState extends State<HKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

// Optimized list view builder
class HOptimizedListView extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final bool shrinkWrap;

  const HOptimizedListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.itemExtent,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      itemExtent: itemExtent,
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: true,
      addRepaintBoundaries: true,
      addSemanticIndexes: true,
    );
  }
}

// Scrollbar with primary: false for better performance
class HScrollbar extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final bool thumbVisibility;
  final bool trackVisibility;

  const HScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thumbVisibility = true,
    this.trackVisibility = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: thumbVisibility,
      trackVisibility: trackVisibility,
      child: child,
    );
  }
}

// Memory-efficient chart container
class HChartContainer extends StatelessWidget {
  final Widget child;
  final String title;
  final double? height;
  final bool enableRepaintBoundary;

  const HChartContainer({
    super.key,
    required this.child,
    required this.title,
    this.height,
    this.enableRepaintBoundary = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget chartChild = child;
    
    if (enableRepaintBoundary) {
      chartChild = HRepaintBoundary(
        debugLabel: 'Chart: $title',
        child: child,
      );
    }

    return Container(
      height: height ?? 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Color(0x11000000),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          Expanded(child: chartChild),
        ],
      ),
    );
  }
}
