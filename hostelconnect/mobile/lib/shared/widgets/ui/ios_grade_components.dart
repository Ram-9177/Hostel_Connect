// lib/shared/widgets/ui/ios_grade_components.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/ios_grade_theme.dart';

/// iOS-grade button with haptic feedback and smooth animations
class IOSGradeButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDestructive;
  final IconData? icon;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const IOSGradeButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isDestructive = false,
    this.icon,
    this.width,
    this.padding,
  });

  @override
  State<IOSGradeButton> createState() => _IOSGradeButtonState();
}

class _IOSGradeButtonState extends State<IOSGradeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      HapticFeedback.lightImpact();
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDestructive
        ? IOSGradeTheme.error
        : widget.onPressed != null
            ? IOSGradeTheme.primary
            : IOSGradeTheme.textSecondary.withOpacity(0.3);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.onPressed != null && !widget.isLoading
                ? () {
                    HapticFeedback.mediumImpact();
                    widget.onPressed!();
                  }
                : null,
            child: Container(
              width: widget.width,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(
                    horizontal: IOSGradeTheme.spacing6,
                    vertical: IOSGradeTheme.spacing3,
                  ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                boxShadow: IOSGradeTheme.cardShadow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          widget.isDestructive
                              ? Colors.white
                              : Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: IOSGradeTheme.spacing2),
                  ] else if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: IOSGradeTheme.spacing2),
                  ],
                  Text(
                    widget.text,
                    style: IOSGradeTheme.headline.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// iOS-grade input field with floating labels and smooth animations
class IOSGradeInputField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final bool readOnly;

  const IOSGradeInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<IOSGradeInputField> createState() => _IOSGradeInputFieldState();
}

class _IOSGradeInputFieldState extends State<IOSGradeInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _labelAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _labelAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (_isFocused) {
        _animationController.forward();
        HapticFeedback.lightImpact();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller?.text.isNotEmpty ?? false;
    final shouldShowLabel = _isFocused || hasText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          AnimatedBuilder(
            animation: _labelAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, shouldShowLabel ? 0 : 20),
                child: Opacity(
                  opacity: shouldShowLabel ? 1.0 : 0.7,
                  child: Text(
                    widget.label!,
                    style: IOSGradeTheme.footnote.copyWith(
                      color: shouldShowLabel
                          ? IOSGradeTheme.primary
                          : IOSGradeTheme.textSecondary,
                      fontWeight: shouldShowLabel
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: IOSGradeTheme.spacing2),
        ],
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: IOSGradeTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              border: Border.all(
                color: _isFocused
                    ? IOSGradeTheme.primary
                    : IOSGradeTheme.border,
                width: _isFocused ? 2 : 1,
              ),
            ),
            child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              readOnly: widget.readOnly,
              style: IOSGradeTheme.body,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: IOSGradeTheme.body.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: IOSGradeTheme.spacing4,
                  vertical: IOSGradeTheme.spacing3,
                ),
                counterText: '',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// iOS-grade card with subtle shadows and smooth animations
class IOSGradeCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;

  const IOSGradeCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
  });

  @override
  State<IOSGradeCard> createState() => _IOSGradeCardState();
}

class _IOSGradeCardState extends State<IOSGradeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      HapticFeedback.lightImpact();
      _animationController.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.onTap != null
                ? () {
                    HapticFeedback.lightImpact();
                    widget.onTap!();
                  }
                : null,
            child: Container(
              margin: widget.margin ?? const EdgeInsets.all(IOSGradeTheme.spacing2),
              padding: widget.padding ?? const EdgeInsets.all(IOSGradeTheme.spacing4),
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? IOSGradeTheme.cardBackground,
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                boxShadow: widget.elevation != null && widget.elevation! > 0
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: widget.elevation! * 2,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : IOSGradeTheme.cardShadow,
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

/// iOS-grade list tile with smooth animations
class IOSGradeListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const IOSGradeListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      backgroundColor: backgroundColor,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: IOSGradeTheme.spacing4,
        vertical: IOSGradeTheme.spacing3,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: IOSGradeTheme.spacing3),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: IOSGradeTheme.headline,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: IOSGradeTheme.spacing1),
                  Text(
                    subtitle!,
                    style: IOSGradeTheme.footnote.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: IOSGradeTheme.spacing3),
            trailing!,
          ],
        ],
      ),
    );
  }
}

/// iOS-grade loading indicator
class IOSGradeLoadingIndicator extends StatefulWidget {
  final String? message;
  final double size;

  const IOSGradeLoadingIndicator({
    super.key,
    this.message,
    this.size = 24.0,
  });

  @override
  State<IOSGradeLoadingIndicator> createState() => _IOSGradeLoadingIndicatorState();
}

class _IOSGradeLoadingIndicatorState extends State<IOSGradeLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  IOSGradeTheme.primary,
                ),
              );
            },
          ),
        ),
        if (widget.message != null) ...[
          const SizedBox(height: IOSGradeTheme.spacing3),
          Text(
            widget.message!,
            style: IOSGradeTheme.footnote.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

/// iOS-grade section header
class IOSGradeSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const IOSGradeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: IOSGradeTheme.spacing4,
        vertical: IOSGradeTheme.spacing2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: IOSGradeTheme.title3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: IOSGradeTheme.spacing1),
                  Text(
                    subtitle!,
                    style: IOSGradeTheme.footnote.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}
