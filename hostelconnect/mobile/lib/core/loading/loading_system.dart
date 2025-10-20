// lib/core/loading/loading_system.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive_breakpoints.dart';
import '../responsive/responsive_widgets.dart';

enum LoadingType {
  spinner,
  shimmer,
  progress,
  dots,
  pulse,
}

class LoadingOverlay extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final LoadingType type;
  final Color? backgroundColor;
  final Color? indicatorColor;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.type = LoadingType.spinner,
    this.backgroundColor,
    this.indicatorColor,
  });

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isLoading) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _animationController.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoading)
          Container(
            color: widget.backgroundColor ?? Colors.black.withOpacity(0.5),
            child: Center(
              child: ResponsivePadding(
                padding: EdgeInsets.all(ResponsiveUtils.getResponsivePadding(context)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLoadingIndicator(),
                    if (widget.message != null) ...[
                      SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
                      ResponsiveText(
                        widget.message!,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: 16),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    final color = widget.indicatorColor ?? Colors.white;
    final size = ResponsiveUtils.getResponsiveIconSize(context);

    switch (widget.type) {
      case LoadingType.spinner:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: 3,
          ),
        );
      case LoadingType.shimmer:
        return _ShimmerEffect(
          color: color,
          size: size,
        );
      case LoadingType.progress:
        return _ProgressIndicator(
          color: color,
          size: size,
        );
      case LoadingType.dots:
        return _DotsIndicator(
          color: color,
          size: size,
        );
      case LoadingType.pulse:
        return _PulseIndicator(
          color: color,
          size: size,
        );
    }
  }
}

class _ShimmerEffect extends StatelessWidget {
  final Color color;
  final double size;

  const _ShimmerEffect({
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Icon(
        Icons.auto_awesome,
        color: color,
        size: size * 0.6,
      ),
    );
  }
}

class _ProgressIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _ProgressIndicator({
    required this.color,
    required this.size,
  });

  @override
  State<_ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<_ProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
            value: _animation.value,
            color: widget.color,
            strokeWidth: 3,
          ),
        );
      },
    );
  }
}

class _DotsIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _DotsIndicator({
    required this.color,
    required this.size,
  });

  @override
  State<_DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<_DotsIndicator>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 600 + (index * 200)),
        vsync: this,
      );
      controller.repeat(reverse: true);
      return controller;
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.size * 0.1),
              width: widget.size * 0.2,
              height: widget.size * 0.2,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(_animations[index].value),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}

class _PulseIndicator extends StatefulWidget {
  final Color color;
  final double size;

  const _PulseIndicator({
    required this.color,
    required this.size,
  });

  @override
  State<_PulseIndicator> createState() => _PulseIndicatorState();
}

class _PulseIndicatorState extends State<_PulseIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: widget.size * 0.6,
              height: widget.size * 0.6,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(_animation.value),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Global loading state management
class LoadingState {
  static bool _isLoading = false;
  static String? _message;
  static LoadingType _type = LoadingType.spinner;

  static bool get isLoading => _isLoading;
  static String? get message => _message;
  static LoadingType get type => _type;

  static void show({
    String? message,
    LoadingType type = LoadingType.spinner,
  }) {
    _isLoading = true;
    _message = message;
    _type = type;
  }

  static void hide() {
    _isLoading = false;
    _message = null;
    _type = LoadingType.spinner;
  }
}
