// lib/core/animations/animation_system.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive_breakpoints.dart';
import '../responsive/responsive_widgets.dart';

class AnimationSystem {
  static const Duration _defaultDuration = Duration(milliseconds: 300);
  static const Curve _defaultCurve = Curves.easeInOut;

  // Fade animations
  static Widget fadeIn({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return _FadeInAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  static Widget fadeOut({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    double begin = 1.0,
    double end = 0.0,
  }) {
    return _FadeOutAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  // Slide animations
  static Widget slideIn({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
  }) {
    return _SlideInAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  static Widget slideOut({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    Offset begin = Offset.zero,
    Offset end = const Offset(0, -1),
  }) {
    return _SlideOutAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  // Scale animations
  static Widget scaleIn({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return _ScaleInAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  static Widget scaleOut({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    double begin = 1.0,
    double end = 0.0,
  }) {
    return _ScaleOutAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  // Rotation animations
  static Widget rotateIn({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    double begin = -0.5,
    double end = 0.0,
  }) {
    return _RotateInAnimation(
      duration: duration,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  // Staggered animations
  static Widget staggered({
    required List<Widget> children,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    Duration staggerDelay = const Duration(milliseconds: 100),
  }) {
    return _StaggeredAnimation(
      duration: duration,
      curve: curve,
      staggerDelay: staggerDelay,
      children: children,
    );
  }

  // Page transitions
  static Widget pageTransition({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    PageTransitionType type = PageTransitionType.slide,
  }) {
    return _PageTransition(
      duration: duration,
      curve: curve,
      type: type,
      child: child,
    );
  }

  // Interactive animations
  static Widget interactive({
    required Widget child,
    Duration duration = _defaultDuration,
    Curve curve = _defaultCurve,
    InteractiveAnimationType type = InteractiveAnimationType.scale,
  }) {
    return _InteractiveAnimation(
      duration: duration,
      curve: curve,
      type: type,
      child: child,
    );
  }

  // Shimmer effect
  static Widget shimmer({
    required Widget child,
    Duration duration = const Duration(milliseconds: 1500),
    Color baseColor = Colors.grey,
    Color highlightColor = Colors.white,
  }) {
    return _ShimmerEffect(
      duration: duration,
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}

enum PageTransitionType {
  slide,
  fade,
  scale,
  rotation,
  slideUp,
  slideDown,
  slideLeft,
  slideRight,
}

enum InteractiveAnimationType {
  scale,
  bounce,
  pulse,
  shake,
  wiggle,
}

// Fade In Animation
class _FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;

  const _FadeInAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<_FadeInAnimation>
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
      begin: widget.begin,
      end: widget.end,
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

// Fade Out Animation
class _FadeOutAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;

  const _FadeOutAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_FadeOutAnimation> createState() => _FadeOutAnimationState();
}

class _FadeOutAnimationState extends State<_FadeOutAnimation>
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
      begin: widget.begin,
      end: widget.end,
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

// Slide In Animation
class _SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset begin;
  final Offset end;

  const _SlideInAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<_SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
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
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

// Slide Out Animation
class _SlideOutAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset begin;
  final Offset end;

  const _SlideOutAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_SlideOutAnimation> createState() => _SlideOutAnimationState();
}

class _SlideOutAnimationState extends State<_SlideOutAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
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
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

// Scale In Animation
class _ScaleInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;

  const _ScaleInAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_ScaleInAnimation> createState() => _ScaleInAnimationState();
}

class _ScaleInAnimationState extends State<_ScaleInAnimation>
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
      begin: widget.begin,
      end: widget.end,
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
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

// Scale Out Animation
class _ScaleOutAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;

  const _ScaleOutAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_ScaleOutAnimation> createState() => _ScaleOutAnimationState();
}

class _ScaleOutAnimationState extends State<_ScaleOutAnimation>
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
      begin: widget.begin,
      end: widget.end,
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
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

// Rotate In Animation
class _RotateInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double begin;
  final double end;

  const _RotateInAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.begin,
    required this.end,
  });

  @override
  State<_RotateInAnimation> createState() => _RotateInAnimationState();
}

class _RotateInAnimationState extends State<_RotateInAnimation>
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
      begin: widget.begin,
      end: widget.end,
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
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}

// Staggered Animation
class _StaggeredAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration duration;
  final Curve curve;
  final Duration staggerDelay;

  const _StaggeredAnimation({
    required this.children,
    required this.duration,
    required this.curve,
    required this.staggerDelay,
  });

  @override
  State<_StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<_StaggeredAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.children.length, (index) {
      final controller = AnimationController(
        duration: widget.duration,
        vsync: this,
      );
      controller.forward();
      return controller;
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
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
    return Column(
      children: List.generate(widget.children.length, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return FadeTransition(
              opacity: _animations[index],
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(_animations[index]),
                child: widget.children[index],
              ),
            );
          },
        );
      }),
    );
  }
}

// Page Transition
class _PageTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final PageTransitionType type;

  const _PageTransition({
    required this.child,
    required this.duration,
    required this.curve,
    required this.type,
  });

  @override
  State<_PageTransition> createState() => _PageTransitionState();
}

class _PageTransitionState extends State<_PageTransition>
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
      animation: _animation,
      builder: (context, child) {
        switch (widget.type) {
          case PageTransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(_animation),
              child: widget.child,
            );
          case PageTransitionType.fade:
            return FadeTransition(
              opacity: _animation,
              child: widget.child,
            );
          case PageTransitionType.scale:
            return ScaleTransition(
              scale: _animation,
              child: widget.child,
            );
          case PageTransitionType.rotation:
            return RotationTransition(
              turns: _animation,
              child: widget.child,
            );
          case PageTransitionType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(_animation),
              child: widget.child,
            );
          case PageTransitionType.slideDown:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(_animation),
              child: widget.child,
            );
          case PageTransitionType.slideLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(_animation),
              child: widget.child,
            );
          case PageTransitionType.slideRight:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(_animation),
              child: widget.child,
            );
        }
      },
    );
  }
}

// Interactive Animation
class _InteractiveAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final InteractiveAnimationType type;

  const _InteractiveAnimation({
    required this.child,
    required this.duration,
    required this.curve,
    required this.type,
  });

  @override
  State<_InteractiveAnimation> createState() => _InteractiveAnimationState();
}

class _InteractiveAnimationState extends State<_InteractiveAnimation>
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
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    switch (widget.type) {
      case InteractiveAnimationType.scale:
        _controller.forward().then((_) => _controller.reverse());
        break;
      case InteractiveAnimationType.bounce:
        _controller.forward().then((_) => _controller.reverse());
        break;
      case InteractiveAnimationType.pulse:
        _controller.repeat();
        break;
      case InteractiveAnimationType.shake:
        _controller.forward().then((_) => _controller.reverse());
        break;
      case InteractiveAnimationType.wiggle:
        _controller.forward().then((_) => _controller.reverse());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          switch (widget.type) {
            case InteractiveAnimationType.scale:
              return ScaleTransition(
                scale: _animation,
                child: widget.child,
              );
            case InteractiveAnimationType.bounce:
              return ScaleTransition(
                scale: _animation,
                child: widget.child,
              );
            case InteractiveAnimationType.pulse:
              return ScaleTransition(
                scale: _animation,
                child: widget.child,
              );
            case InteractiveAnimationType.shake:
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0.1, 0),
                ).animate(_animation),
                child: widget.child,
              );
            case InteractiveAnimationType.wiggle:
              return RotationTransition(
                turns: _animation,
                child: widget.child,
              );
          }
        },
      ),
    );
  }
}

// Shimmer Effect
class _ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color baseColor;
  final Color highlightColor;

  const _ShimmerEffect({
    required this.child,
    required this.duration,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
