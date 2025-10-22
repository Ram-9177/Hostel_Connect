// lib/shared/widgets/accessibility/accessibility_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import '../../core/responsive.dart';

/// Accessibility utilities
class AccessibilityUtils {
  // Screen reader announcements
  static void announceToScreenReader(BuildContext context, String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
  
  // Focus management
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
  
  // Accessibility labels
  static String getAccessibilityLabel(String label, {String? hint}) {
    if (hint != null) {
      return '$label, $hint';
    }
    return label;
  }
  
  // High contrast support
  static bool isHighContrast(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }
  
  // Text scaling support
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
}

/// Accessible button widget
class AccessibleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String? semanticLabel;
  final String? tooltip;
  final bool excludeSemantics;
  
  const AccessibleButton({
    super.key,
    required this.child,
    this.onPressed,
    this.semanticLabel,
    this.tooltip,
    this.excludeSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: tooltip,
      button: true,
      enabled: onPressed != null,
      excludeSemantics: excludeSemantics,
      child: Tooltip(
        message: tooltip ?? '',
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}

/// Accessible card widget
class AccessibleCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final String? hint;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  
  const AccessibleCard({
    super.key,
    required this.child,
    this.onTap,
    this.semanticLabel,
    this.hint,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: hint,
      button: onTap != null,
      enabled: onTap != null,
      child: Card(
        margin: margin,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(HTokens.radiusMd),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(HTokens.md),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Accessible text field widget
class AccessibleTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool enabled;
  
  const AccessibleTextField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AccessibilityUtils.getAccessibilityLabel(label, hint: hint),
      textField: true,
      enabled: enabled,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(HTokens.radiusMd),
          ),
        ),
      ),
    );
  }
}

/// Accessible list tile widget
class AccessibleListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? semanticLabel;
  final String? hint;
  final bool enabled;
  
  const AccessibleListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.semanticLabel,
    this.hint,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: hint,
      button: onTap != null,
      enabled: enabled,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

/// Accessible icon button widget
class AccessibleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final String? tooltip;
  final Color? color;
  final double? iconSize;
  
  const AccessibleIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    required this.semanticLabel,
    this.tooltip,
    this.color,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: tooltip,
      button: true,
      enabled: onPressed != null,
      child: Tooltip(
        message: tooltip ?? semanticLabel,
        child: IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: color,
          iconSize: iconSize,
        ),
      ),
    );
  }
}

/// Accessible switch widget
class AccessibleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String semanticLabel;
  final String? hint;
  
  const AccessibleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    required this.semanticLabel,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AccessibilityUtils.getAccessibilityLabel(semanticLabel, hint: hint),
      toggled: value,
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// Accessible progress indicator widget
class AccessibleProgressIndicator extends StatelessWidget {
  final double? value;
  final String? semanticLabel;
  final Color? color;
  
  const AccessibleProgressIndicator({
    super.key,
    this.value,
    this.semanticLabel,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = value ?? 0.0;
    final percentage = (progress * 100).round();
    
    return Semantics(
      label: semanticLabel ?? 'Progress: $percentage%',
      value: '$percentage%',
      child: LinearProgressIndicator(
        value: value,
        color: color,
      ),
    );
  }
}

/// Focus trap widget for keyboard navigation
class FocusTrap extends StatefulWidget {
  final Widget child;
  final bool trapFocus;
  
  const FocusTrap({
    super.key,
    required this.child,
    this.trapFocus = true,
  });

  @override
  State<FocusTrap> createState() => _FocusTrapState();
}

class _FocusTrapState extends State<FocusTrap> {
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    if (widget.trapFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (widget.trapFocus && event is KeyDownEvent) {
          // Handle escape key to close modal/dialog
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: widget.child,
    );
  }
}
