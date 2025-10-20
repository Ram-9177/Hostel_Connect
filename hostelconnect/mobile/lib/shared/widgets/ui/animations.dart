import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class HAnimationController {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
}

class HSlideTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Offset begin;
  final Offset end;
  final Curve curve;

  const HSlideTransition({
    super.key,
    required this.child,
    required this.animation,
    this.begin = const Offset(0, 0.3),
    this.end = Offset.zero,
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

class HFadeTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double begin;
  final double end;
  final Curve curve;

  const HFadeTransition({
    super.key,
    required this.child,
    required this.animation,
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

class HScaleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double begin;
  final double end;
  final Curve curve;

  const HScaleTransition({
    super.key,
    required this.child,
    required this.animation,
    this.begin = 0.8,
    this.end = 1.0,
    this.curve = Curves.easeOutBack,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

class HRotationTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double begin;
  final double end;
  final Curve curve;

  const HRotationTransition({
    super.key,
    required this.child,
    required this.animation,
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }
}

class HStaggeredAnimation extends StatefulWidget {
  final List<Widget> children;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final AnimationType type;

  const HStaggeredAnimation({
    super.key,
    required this.children,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
    this.type = AnimationType.fadeSlide,
  });

  @override
  State<HStaggeredAnimation> createState() => _HStaggeredAnimationState();
}

class _HStaggeredAnimationState extends State<HStaggeredAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ));
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * widget.delay.inMilliseconds), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
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
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            switch (widget.type) {
              case AnimationType.fadeSlide:
                return HFadeTransition(
                  animation: _animations[index],
                  child: HSlideTransition(
                    animation: _animations[index],
                    child: widget.children[index],
                  ),
                );
              case AnimationType.scale:
                return HScaleTransition(
                  animation: _animations[index],
                  child: widget.children[index],
                );
              case AnimationType.fade:
                return HFadeTransition(
                  animation: _animations[index],
                  child: widget.children[index],
                );
              case AnimationType.slide:
                return HSlideTransition(
                  animation: _animations[index],
                  child: widget.children[index],
                );
            }
          },
        );
      }),
    );
  }
}

enum AnimationType {
  fadeSlide,
  scale,
  fade,
  slide,
}

class HPageTransition extends PageRouteBuilder {
  final Widget child;
  final TransitionType type;
  final Duration duration;
  final Curve curve;

  HPageTransition({
    required this.child,
    this.type = TransitionType.slideRight,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: duration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case TransitionType.slideRight:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  )),
                  child: child,
                );
              case TransitionType.slideLeft:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  )),
                  child: child,
                );
              case TransitionType.slideUp:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: curve,
                  )),
                  child: child,
                );
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              case TransitionType.rotation:
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
            }
          },
        );
}

enum TransitionType {
  slideRight,
  slideLeft,
  slideUp,
  fade,
  scale,
  rotation,
}

class HAnimatedContainer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;
  final bool animateOnTap;

  const HAnimatedContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.onTap,
    this.animateOnTap = true,
  });

  @override
  State<HAnimatedContainer> createState() => _HAnimatedContainerState();
}

class _HAnimatedContainerState extends State<HAnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
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
    if (widget.animateOnTap) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.animateOnTap) {
      _controller.reverse();
    }
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    if (widget.animateOnTap) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
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

class HShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const HShimmerEffect({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<HShimmerEffect> createState() => _HShimmerEffectState();
}

class _HShimmerEffectState extends State<HShimmerEffect>
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
