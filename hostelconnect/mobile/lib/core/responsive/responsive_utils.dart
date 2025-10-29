// lib/core/responsive/responsive_utils.dart

import 'package:flutter/material.dart';

/// Utility class for responsive design helpers
class ResponsiveUtils {
  /// Check if device is mobile (width < 600)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  /// Check if device is tablet (width >= 600 && width < 900)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 900;
  }

  /// Check if device is desktop (width >= 900)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }

  /// Get responsive padding based on screen size
  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0;
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, {required double base}) {
    if (isMobile(context)) return base;
    if (isTablet(context)) return base * 1.1;
    return base * 1.2;
  }

  /// Get responsive icon size
  static double getResponsiveIconSize(BuildContext context, {required double base}) {
    if (isMobile(context)) return base;
    if (isTablet(context)) return base * 1.15;
    return base * 1.3;
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context, {required double base}) {
    if (isMobile(context)) return base;
    if (isTablet(context)) return base * 1.2;
    return base * 1.5;
  }

  /// Alias for getResponsiveSpacing
  static double responsiveSpacing(BuildContext context, {required double base}) {
    return getResponsiveSpacing(context, base: base);
  }

  /// Alias for getResponsivePadding
  static EdgeInsets responsivePadding(BuildContext context) {
    return getResponsivePadding(context);
  }

  /// Get responsive width based on percentage
  static double getResponsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  /// Get responsive height based on percentage
  static double getResponsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  /// Get text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  /// Get screen orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// Check if screen is in landscape mode
  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  /// Check if screen is in portrait mode
  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  /// Get safe area insets
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get device pixel ratio
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }
}

/// Responsive Text Widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final double baseFontSize;
  final double? fontSize; // Alias for baseFontSize
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    Key? key,
    this.baseFontSize = 14.0,
    this.fontSize, // Optional alternative parameter name
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveFontSize = fontSize ?? baseFontSize;
    return Text(
      text,
      style: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: effectiveFontSize),
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive Button Widget
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Made nullable to match usage
  final double basePadding;
  final double? fontSize; // Added fontSize parameter
  final Color? backgroundColor;
  final Color? textColor;
  final bool isFullWidth;

  const ResponsiveButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.basePadding = 16.0,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final effectiveFontSize = fontSize ?? 16.0;
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding * 0.75,
          ),
          backgroundColor: backgroundColor,
        ),
        child: ResponsiveText(
          text,
          baseFontSize: effectiveFontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
