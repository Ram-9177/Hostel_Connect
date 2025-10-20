// lib/core/accessibility/accessibility_system.dart
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive_breakpoints.dart';
import '../responsive/responsive_widgets.dart';

enum AccessibilityLevel {
  basic,
  enhanced,
  full,
}

class AccessibilitySystem {
  static AccessibilityLevel _level = AccessibilityLevel.enhanced;
  static bool _isEnabled = true;

  static AccessibilityLevel get level => _level;
  static bool get isEnabled => _isEnabled;

  static void setLevel(AccessibilityLevel level) {
    _level = level;
  }

  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  // Text scaling
  static double getTextScale(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.textScaleFactor.clamp(0.8, 2.0);
  }

  // Minimum touch target size
  static double getMinTouchTargetSize(BuildContext context) {
    return 44.0; // Standard minimum touch target size
  }

  // High contrast mode
  static bool isHighContrast(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.highContrast;
  }

  // Screen reader support
  static bool isScreenReaderEnabled(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.accessibleNavigation;
  }

  // Reduced motion
  static bool isReducedMotion(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.disableAnimations;
  }
}

class AccessibleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? semanticsLabel;
  final bool excludeSemantics;

  const AccessibleText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.semanticsLabel,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleText = Semantics(
      label: semanticsLabel ?? text,
      excludeSemantics: excludeSemantics,
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );

    return accessibleText;
  }
}

class AccessibleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final ButtonStyle? style;

  const AccessibleButton({
    super.key,
    required this.child,
    this.onPressed,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleButton = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      button: true,
      enabled: onPressed != null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );

    return accessibleButton;
  }
}

class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final Color? color;
  final double? size;

  const AccessibleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleButton = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      button: true,
      enabled: onPressed != null,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );

    return accessibleButton;
  }
}

class AccessibleTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;

  const AccessibleTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleTextField = Semantics(
      label: semanticsLabel ?? label,
      hint: semanticsHint ?? hintText,
      excludeSemantics: excludeSemantics,
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: enabled,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          helperText: helperText,
          errorText: errorText,
        ),
      ),
    );

    return accessibleTextField;
  }
}

class AccessibleCard extends StatelessWidget {
  final Widget child;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final Color? color;
  final double? elevation;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AccessibleCard({
    super.key,
    required this.child,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.color,
    this.elevation,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleCard = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: Card(
        color: color,
        elevation: elevation,
        margin: margin,
        child: Padding(
          padding: padding ?? EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );

    return accessibleCard;
  }
}

class AccessibleListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final bool enabled;

  const AccessibleListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleListTile = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      button: onTap != null,
      enabled: enabled,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        enabled: enabled,
      ),
    );

    return accessibleListTile;
  }
}

class AccessibleBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const AccessibleBottomNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleBottomNav = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
      ),
    );

    return accessibleBottomNav;
  }
}

class AccessibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  const AccessibleAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleAppBar = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: AppBar(
        title: title,
        actions: actions,
        leading: leading,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      ),
    );

    return accessibleAppBar;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AccessibleDialog extends StatelessWidget {
  final Widget child;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final bool barrierDismissible;
  final Color? barrierColor;

  const AccessibleDialog({
    super.key,
    required this.child,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.barrierDismissible = true,
    this.barrierColor,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleDialog = Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: Dialog(
        child: child,
      ),
    );

    return accessibleDialog;
  }
}

class AccessibleSnackBar extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? semanticsLabel;
  final String? semanticsHint;
  final bool excludeSemantics;
  final Color? backgroundColor;
  final Color? actionColor;

  const AccessibleSnackBar({
    super.key,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
    this.backgroundColor,
    this.actionColor,
  });

  @override
  Widget build(BuildContext context) {
    final accessibleSnackBar = Semantics(
      label: semanticsLabel ?? message,
      hint: semanticsHint,
      excludeSemantics: excludeSemantics,
      child: SnackBar(
        content: Text(message),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel!,
                onPressed: onAction!,
                textColor: actionColor,
              )
            : null,
        backgroundColor: backgroundColor,
      ),
    );

    return accessibleSnackBar;
  }
}

// Accessibility utilities
class AccessibilityUtils {
  // Announce text to screen readers
  static void announce(BuildContext context, String text) {
    SemanticsService.announce(text, TextDirection.ltr);
  }

  // Focus management
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // Haptic feedback
  static void provideHapticFeedback(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
    }
  }

  // Color contrast ratio
  static double getContrastRatio(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  // Check if colors meet WCAG contrast requirements
  static bool meetsContrastRequirements(Color color1, Color color2, {double ratio = 4.5}) {
    return getContrastRatio(color1, color2) >= ratio;
  }
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}