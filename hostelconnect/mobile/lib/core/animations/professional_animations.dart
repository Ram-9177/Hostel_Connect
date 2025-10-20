// Professional Animation and Transition System
import 'package:flutter/material.dart';
import '../responsive/responsive_breakpoints.dart';

/// Animation types enumeration
enum AnimationType {
  fade,
  slide,
  scale,
  rotation,
  bounce,
  elastic,
  stagger,
}

/// Animation directions
enum AnimationDirection {
  up,
  down,
  left,
  right,
  center,
}

/// Animation durations
class AnimationDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}

/// Animation curves
class AnimationCurves {
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticIn = Curves.elasticIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeInOutCubic = Curves.easeInOutCubic;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve slowMiddle = Curves.slowMiddle;
}

/// Professional animation controller
class ProfessionalAnimationController {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  AnimationType _type = AnimationType.fade;
  AnimationDirection _direction = AnimationDirection.center;
  Duration _duration = AnimationDurations.normal;
  Curve _curve = AnimationCurves.easeInOut;
  
  ProfessionalAnimationController({
    required TickerProvider vsync,
    AnimationType type = AnimationType.fade,
    AnimationDirection direction = AnimationDirection.center,
    Duration duration = AnimationDurations.normal,
    Curve curve = AnimationCurves.easeInOut,
  }) {
    _type = type;
    _direction = direction;
    _duration = duration;
    _curve = curve;
    
    _controller = AnimationController(
      duration: _duration,
      vsync: vsync,
    );
    
    _animation = _createAnimation();
  }
  
  Animation<double> _createAnimation() {
    switch (_type) {
      case AnimationType.fade:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: _curve),
        );
      case AnimationType.scale:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: _curve),
        );
      case AnimationType.rotation:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: _curve),
        );
      case AnimationType.bounce:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: AnimationCurves.bounceOut),
        );
      case AnimationType.elastic:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: AnimationCurves.elasticOut),
        );
      default:
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: _curve),
        );
    }
  }
  
  AnimationController get controller => _controller;
  Animation<double> get animation => _animation;
  
  void forward() => _controller.forward();
  void reverse() => _controller.reverse();
  void reset() => _controller.reset();
  void dispose() => _controller.dispose();
}

/// Professional fade transition
class ProfessionalFadeTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Duration duration;
  final Curve curve;

  const ProfessionalFadeTransition({
    super.key,
    required this.child,
    required this.animation,
    this.duration = AnimationDurations.normal,
    this.curve = AnimationCurves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/// Professional slide transition
class ProfessionalSlideTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final AnimationDirection direction;
  final Duration duration;
  final Curve curve;

  const ProfessionalSlideTransition({
    super.key,
    required this.child,
    required this.animation,
    this.direction = AnimationDirection.up,
    this.duration = AnimationDurations.normal,
    this.curve = AnimationCurves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    Offset begin;
    switch (direction) {
      case AnimationDirection.up:
        begin = const Offset(0.0, 1.0);
        break;
      case AnimationDirection.down:
        begin = const Offset(0.0, -1.0);
        break;
      case AnimationDirection.left:
        begin = const Offset(1.0, 0.0);
        break;
      case AnimationDirection.right:
        begin = const Offset(-1.0, 0.0);
        break;
      case AnimationDirection.center:
        begin = Offset.zero;
        break;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

/// Professional scale transition
class ProfessionalScaleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double beginScale;
  final double endScale;
  final Duration duration;
  final Curve curve;

  const ProfessionalScaleTransition({
    super.key,
    required this.child,
    required this.animation,
    this.beginScale = 0.0,
    this.endScale = 1.0,
    this.duration = AnimationDurations.normal,
    this.curve = AnimationCurves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: beginScale,
        end: endScale,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

/// Professional rotation transition
class ProfessionalRotationTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double beginAngle;
  final double endAngle;
  final Duration duration;
  final Curve curve;

  const ProfessionalRotationTransition({
    super.key,
    required this.child,
    required this.animation,
    this.beginAngle = 0.0,
    this.endAngle = 1.0,
    this.duration = AnimationDurations.normal,
    this.curve = AnimationCurves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(
        begin: beginAngle,
        end: endAngle,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

/// Staggered animation widget
class StaggeredAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final AnimationType type;
  final AnimationDirection direction;
  final Duration duration;
  final Curve curve;

  const StaggeredAnimation({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.type = AnimationType.fade,
    this.direction = AnimationDirection.up,
    this.duration = AnimationDurations.normal,
    this.curve = AnimationCurves.easeInOut,
  });

  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: widget.curve),
      );
    }).toList();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(
        Duration(milliseconds: i * widget.staggerDelay.inMilliseconds),
        () {
          if (mounted) {
            _controllers[i].forward();
          }
        },
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (index) {
        return _buildAnimatedChild(index);
      }),
    );
  }

  Widget _buildAnimatedChild(int index) {
    final child = widget.children[index];
    final animation = _animations[index];

    switch (widget.type) {
      case AnimationType.fade:
        return ProfessionalFadeTransition(
          animation: animation,
          child: child,
        );
      case AnimationType.slide:
        return ProfessionalSlideTransition(
          animation: animation,
          direction: widget.direction,
          child: child,
        );
      case AnimationType.scale:
        return ProfessionalScaleTransition(
          animation: animation,
          child: child,
        );
      case AnimationType.rotation:
        return ProfessionalRotationTransition(
          animation: animation,
          child: child,
        );
      default:
        return ProfessionalFadeTransition(
          animation: animation,
          child: child,
        );
    }
  }
}

/// Page transition animations
class PageTransitions {
  /// Slide page transition
  static Widget slideTransition({
    required Widget child,
    required Animation<double> animation,
    AnimationDirection direction = AnimationDirection.right,
  }) {
    Offset begin;
    switch (direction) {
      case AnimationDirection.right:
        begin = const Offset(1.0, 0.0);
        break;
      case AnimationDirection.left:
        begin = const Offset(-1.0, 0.0);
        break;
      case AnimationDirection.up:
        begin = const Offset(0.0, 1.0);
        break;
      case AnimationDirection.down:
        begin = const Offset(0.0, -1.0);
        break;
      case AnimationDirection.center:
        begin = Offset.zero;
        break;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: AnimationCurves.fastOutSlowIn,
      )),
      child: child,
    );
  }

  /// Fade page transition
  static Widget fadeTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  /// Scale page transition
  static Widget scaleTransition({
    required Widget child,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: AnimationCurves.fastOutSlowIn,
      )),
      child: child,
    );
  }

  /// Combined transition
  static Widget combinedTransition({
    required Widget child,
    required Animation<double> animation,
    AnimationDirection direction = AnimationDirection.right,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(
          direction == AnimationDirection.right ? 0.3 : -0.3,
          0.0,
        ),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: AnimationCurves.fastOutSlowIn,
      )),
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: AnimationCurves.fastOutSlowIn,
          )),
          child: child,
        ),
      ),
    );
  }
}

/// Interactive animation widget
class InteractiveAnimation extends StatefulWidget {
  final Widget child;
  final AnimationType type;
  final Duration duration;
  final Curve curve;
  final double scaleFactor;
  final VoidCallback? onTap;

  const InteractiveAnimation({
    super.key,
    required this.child,
    this.type = AnimationType.scale,
    this.duration = AnimationDurations.fast,
    this.curve = AnimationCurves.easeInOut,
    this.scaleFactor = 0.95,
    this.onTap,
  });

  @override
  State<InteractiveAnimation> createState() => _InteractiveAnimationState();
}

class _InteractiveAnimationState extends State<InteractiveAnimation>
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
      begin: 1.0,
      end: widget.scaleFactor,
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

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

/// Shimmer effect widget
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const ShimmerEffect({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
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
      begin: -1.0,
      end: 2.0,
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
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
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
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}
