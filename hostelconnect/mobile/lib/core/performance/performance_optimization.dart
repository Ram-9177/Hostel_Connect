import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/shared/widgets/ui/professional_components.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class PerformanceOptimizedPage extends ConsumerStatefulWidget {
  final Widget child;
  final String pageName;
  final bool enableCaching;
  final Duration cacheDuration;
  final VoidCallback? onRefresh;

  const PerformanceOptimizedPage({
    super.key,
    required this.child,
    required this.pageName,
    this.enableCaching = true,
    this.cacheDuration = const Duration(minutes: 5),
    this.onRefresh,
  });

  @override
  ConsumerState<PerformanceOptimizedPage> createState() => _PerformanceOptimizedPageState();
}

class _PerformanceOptimizedPageState extends ConsumerState<PerformanceOptimizedPage>
    with AutomaticKeepAliveClientMixin {
  
  DateTime? _lastCacheTime;
  bool _isRefreshing = false;

  @override
  bool get wantKeepAlive => widget.enableCaching;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: widget.child,
    );
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    
    setState(() {
      _isRefreshing = true;
    });

    try {
      widget.onRefresh?.call();
      _lastCacheTime = DateTime.now();
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  bool get _shouldRefresh {
    if (!widget.enableCaching || _lastCacheTime == null) return true;
    return DateTime.now().difference(_lastCacheTime!) > widget.cacheDuration;
  }
}

class LazyLoadingList extends StatefulWidget {
  final List<Widget> children;
  final int itemsPerPage;
  final Widget? loadingIndicator;
  final VoidCallback? onLoadMore;

  const LazyLoadingList({
    super.key,
    required this.children,
    this.itemsPerPage = 10,
    this.loadingIndicator,
    this.onLoadMore,
  });

  @override
  State<LazyLoadingList> createState() => _LazyLoadingListState();
}

class _LazyLoadingListState extends State<LazyLoadingList> {
  late List<Widget> _displayedItems;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _displayedItems = widget.children.take(widget.itemsPerPage).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._displayedItems,
        if (_displayedItems.length < widget.children.length)
          _buildLoadMoreButton(),
      ],
    );
  }

  Widget _buildLoadMoreButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: widget.loadingIndicator ?? 
        HProfessionalButton(
          text: 'Load More',
          variant: HProfessionalButtonVariant.secondary,
          onPressed: _loadMore,
        ),
    );
  }

  void _loadMore() {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          final startIndex = _displayedItems.length;
          final endIndex = (startIndex + widget.itemsPerPage).clamp(0, widget.children.length);
          _displayedItems.addAll(widget.children.sublist(startIndex, endIndex));
          _isLoading = false;
        });
        widget.onLoadMore?.call();
      }
    });
  }
}

class ImageCacheManager {
  static final Map<String, ImageProvider> _cache = {};
  static const int _maxCacheSize = 50;

  static ImageProvider getCachedImage(String url) {
    if (_cache.containsKey(url)) {
      return _cache[url]!;
    }

    final imageProvider = NetworkImage(url);
    _cacheImage(url, imageProvider);
    return imageProvider;
  }

  static void _cacheImage(String url, ImageProvider imageProvider) {
    if (_cache.length >= _maxCacheSize) {
      // Remove oldest entry
      final firstKey = _cache.keys.first;
      _cache.remove(firstKey);
    }
    _cache[url] = imageProvider;
  }

  static void clearCache() {
    _cache.clear();
  }
}

class OptimizedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final double? width;
  final double? height;

  const OptimizedNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: ImageCacheManager.getCachedImage(imageUrl),
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ?? const HProfessionalLoading();
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? const Icon(Icons.error);
      },
    );
  }
}

class PerformanceMonitor {
  static final Map<String, DateTime> _pageLoadTimes = {};
  static final Map<String, Duration> _pageLoadDurations = {};

  static void startPageLoad(String pageName) {
    _pageLoadTimes[pageName] = DateTime.now();
  }

  static void endPageLoad(String pageName) {
    final startTime = _pageLoadTimes[pageName];
    if (startTime != null) {
      _pageLoadDurations[pageName] = DateTime.now().difference(startTime);
      _pageLoadTimes.remove(pageName);
    }
  }

  static Duration? getPageLoadDuration(String pageName) {
    return _pageLoadDurations[pageName];
  }

  static Map<String, Duration> getAllPageLoadDurations() {
    return Map.from(_pageLoadDurations);
  }

  static void clearMetrics() {
    _pageLoadTimes.clear();
    _pageLoadDurations.clear();
  }
}
