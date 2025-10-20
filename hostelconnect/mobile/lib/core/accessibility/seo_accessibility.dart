import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class SEOAccessibilityWrapper extends StatelessWidget {
  final Widget child;
  final String pageTitle;
  final String pageDescription;
  final List<String> keywords;
  final String? semanticLabel;
  final bool excludeFromSemantics;

  const SEOAccessibilityWrapper({
    super.key,
    required this.child,
    required this.pageTitle,
    required this.pageDescription,
    this.keywords = const [],
    this.semanticLabel,
    this.excludeFromSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? pageTitle,
      hint: pageDescription,
      excludeSemantics: excludeFromSemantics,
      child: MetaData(
        metaData: {
          'title': pageTitle,
          'description': pageDescription,
          'keywords': keywords.join(', '),
        },
        child: child,
      ),
    );
  }
}

class AccessibleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? semanticLabel;
  final String? semanticHint;
  final ButtonStyle? style;
  final bool enabled;

  const AccessibleButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.semanticLabel,
    this.semanticHint,
    this.style,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      hint: semanticHint,
      button: true,
      enabled: enabled,
      child: ElevatedButton.icon(
        onPressed: enabled ? onPressed : null,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(text),
        style: style,
      ),
    );
  }
}

class AccessibleTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? semanticLabel;
  final String? semanticHint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AccessibleTextField({
    super.key,
    required this.label,
    this.hint,
    this.semanticLabel,
    this.semanticHint,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? label,
      hint: semanticHint ?? hint,
      textField: true,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class AccessibleCard extends StatelessWidget {
  final Widget child;
  final String? semanticLabel;
  final String? semanticHint;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;

  const AccessibleCard({
    super.key,
    required this.child,
    this.semanticLabel,
    this.semanticHint,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      hint: semanticHint,
      button: onTap != null,
      child: Card(
        margin: margin,
        elevation: elevation,
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ScreenReaderAnnouncer {
  static void announce(BuildContext context, String message) {
    SemanticsService.announce(message, TextDirection.ltr);
  }

  static void announcePageChange(BuildContext context, String pageName) {
    announce(context, 'Navigated to $pageName');
  }

  static void announceAction(BuildContext context, String action) {
    announce(context, action);
  }
}

class FocusManager {
  static void focusNext(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  static void focusPrevious(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void focusOn(BuildContext context, FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }
}

class ResponsiveAccessibility {
  static double getAccessibleFontSize(BuildContext context, double baseSize) {
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    
    // Ensure minimum readable size
    final minSize = 14.0;
    final calculatedSize = baseSize * textScaleFactor;
    
    return calculatedSize.clamp(minSize, minSize * 2.0);
  }

  static double getAccessibleSpacing(BuildContext context, double baseSpacing) {
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    
    // Scale spacing with text scale factor
    return baseSpacing * textScaleFactor;
  }

  static EdgeInsets getAccessiblePadding(BuildContext context, EdgeInsets basePadding) {
    final mediaQuery = MediaQuery.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    
    return EdgeInsets.only(
      left: basePadding.left * textScaleFactor,
      top: basePadding.top * textScaleFactor,
      right: basePadding.right * textScaleFactor,
      bottom: basePadding.bottom * textScaleFactor,
    );
  }
}

class SEOOptimizer {
  static Map<String, String> generatePageMeta(String pageName, String description, List<String> keywords) {
    return {
      'title': '$pageName - HostelConnect',
      'description': description,
      'keywords': keywords.join(', '),
      'og:title': '$pageName - HostelConnect',
      'og:description': description,
      'og:type': 'website',
      'twitter:card': 'summary',
      'twitter:title': '$pageName - HostelConnect',
      'twitter:description': description,
    };
  }

  static String generateStructuredData(String pageName, Map<String, dynamic> data) {
    final structuredData = {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      'name': pageName,
      'description': data['description'] ?? '',
      'url': data['url'] ?? '',
      'datePublished': data['datePublished'] ?? DateTime.now().toIso8601String(),
      'dateModified': data['dateModified'] ?? DateTime.now().toIso8601String(),
    };

    return structuredData.toString();
  }
}

class AccessibilityChecker {
  static bool checkColorContrast(Color foreground, Color background) {
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();
    
    final contrast = (foregroundLuminance + 0.05) / (backgroundLuminance + 0.05);
    return contrast >= 4.5; // WCAG AA standard
  }

  static Color getAccessibleColor(Color baseColor, Color backgroundColor) {
    if (checkColorContrast(baseColor, backgroundColor)) {
      return baseColor;
    }
    
    // Return a high contrast alternative
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  static bool isTextReadable(TextStyle textStyle, Color backgroundColor) {
    return checkColorContrast(textStyle.color ?? Colors.black, backgroundColor);
  }
}
