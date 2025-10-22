// lib/shared/widgets/animations/smooth_animations.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';

/// Smooth animation utilities
class SmoothAnimations {
  // Animation durations
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  // Animation curves
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve bounce = Curves.bounceOut;
  
  // Fade in animation
  static Widget fadeIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeInOut,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
  
  // Slide in animation
  static Widget slideIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeOut,
    Offset offset = const Offset(0, 0.1),
  }) {
    return TweenAnimationBuilder<Offset>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: offset, end: Offset.zero),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            value.dx * MediaQuery.of(context).size.width,
            value.dy * MediaQuery.of(context).size.height,
          ),
          child: child,
        );
      },
      child: child,
    );
  }
  
  // Scale animation
  static Widget scaleIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = bounce,
    double scale = 0.8,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: scale, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
  
  // Rotation animation
  static Widget rotateIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeOut,
    double angle = 0.1,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: angle, end: 0.0),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value,
          child: child,
        );
      },
      child: child,
    );
  }
  
  // Combined animation
  static Widget combinedIn({
    required Widget child,
    Duration duration = normal,
    Curve curve = easeOut,
    bool fade = true,
    bool slide = true,
    bool scale = false,
    bool rotate = false,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        Widget animatedChild = child!;
        
        if (fade) {
          animatedChild = Opacity(
            opacity: value,
            child: animatedChild,
          );
        }
        
        if (slide) {
          animatedChild = Transform.translate(
            offset: Offset(
              0,
              (1 - value) * 20,
            ),
            child: animatedChild,
          );
        }
        
        if (scale) {
          animatedChild = Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: animatedChild,
          );
        }
        
        if (rotate) {
          animatedChild = Transform.rotate(
            angle: (1 - value) * 0.1,
            child: animatedChild,
          );
        }
        
        return animatedChild;
      },
      child: child,
    );
  }
}

/// Animated button widget
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  final Curve curve;
  final double scale;
  
  const AnimatedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.duration = SmoothAnimations.fast,
    this.curve = SmoothAnimations.easeOut,
    this.scale = 0.95,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      } : null,
      onTapUp: widget.onPressed != null ? (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onPressed?.call();
      } : null,
      onTapCancel: widget.onPressed != null ? () {
        setState(() => _isPressed = false);
        _controller.reverse();
      } : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

/// Animated card widget
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  
  const AnimatedCard({
    super.key,
    required this.child,
    this.duration = SmoothAnimations.normal,
    this.curve = SmoothAnimations.easeOut,
    this.elevation = 2.0,
    this.margin,
    this.padding,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Card(
              elevation: widget.elevation,
              margin: widget.margin,
              child: Padding(
                padding: widget.padding ?? const EdgeInsets.all(HTokens.md),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Loading animation widget
class LoadingAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final Duration duration;
  
  const LoadingAnimation({
    super.key,
    this.size = 24.0,
    this.color = Colors.blue,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
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
        return Transform.rotate(
          angle: _animation.value * 2 * 3.14159,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              strokeWidth: 2.0,
            ),
          ),
        );
      },
    );
  }
}
