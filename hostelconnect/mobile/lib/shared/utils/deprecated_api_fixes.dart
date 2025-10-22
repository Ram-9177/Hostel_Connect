// lib/shared/utils/deprecated_api_fixes.dart
import 'package:flutter/material.dart';

/// Utility class for fixing deprecated API usage
class DeprecatedApiFixes {
  /// Replace withOpacity with withValues
  static Color withValues({
    required Color color,
    double? alpha,
    double? red,
    double? green,
    double? blue,
  }) {
    return color.withValues(
      alpha: alpha,
      red: red,
      green: green,
      blue: blue,
    );
  }
  
  /// Replace activeColor with activeThumbColor for Switch
  static SwitchThemeData createSwitchTheme({
    Color? activeThumbColor,
    Color? inactiveThumbColor,
    Color? activeTrackColor,
    Color? inactiveTrackColor,
  }) {
    return SwitchThemeData(
      activeThumbColor: activeThumbColor,
      inactiveThumbColor: inactiveThumbColor,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
    );
  }
  
  /// Replace value with initialValue for TextFormField
  static TextFormField createTextFormField({
    String? initialValue,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    bool obscureText = false,
    int? maxLines = 1,
    bool enabled = true,
  }) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: decoration,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
    );
  }
  
  /// Create modern button style
  static ButtonStyle createButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    double? elevation,
    BorderRadius? borderRadius,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
  
  /// Create modern card theme
  static CardTheme createCardTheme({
    Color? color,
    double? elevation,
    EdgeInsetsGeometry? margin,
    ShapeBorder? shape,
  }) {
    return CardTheme(
      color: color,
      elevation: elevation ?? 2.0,
      margin: margin,
      shape: shape ?? RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
  
  /// Create modern input decoration
  static InputDecoration createInputDecoration({
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    double? borderRadius,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: fillColor != null,
      fillColor: fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        borderSide: BorderSide(color: focusedBorderColor ?? Colors.blue, width: 2),
      ),
    );
  }
}

/// Modern color extensions
extension ModernColor on Color {
  /// Modern way to create colors with alpha
  Color withAlpha(double alpha) {
    return withValues(alpha: alpha);
  }
  
  /// Modern way to create colors with opacity
  Color withOpacityModern(double opacity) {
    return withValues(alpha: opacity);
  }
  
  /// Create lighter version of color
  Color lighter([double amount = 0.1]) {
    return Color.lerp(this, Colors.white, amount) ?? this;
  }
  
  /// Create darker version of color
  Color darker([double amount = 0.1]) {
    return Color.lerp(this, Colors.black, amount) ?? this;
  }
}

/// Modern theme extensions
extension ModernTheme on ThemeData {
  /// Get modern color scheme
  ColorScheme get modernColorScheme {
    return colorScheme;
  }
  
  /// Get modern text theme
  TextTheme get modernTextTheme {
    return textTheme;
  }
  
  /// Get modern button theme
  ElevatedButtonThemeData get modernElevatedButtonTheme {
    return elevatedButtonTheme ?? const ElevatedButtonThemeData();
  }
  
  /// Get modern card theme
  CardTheme get modernCardTheme {
    return cardTheme ?? const CardTheme();
  }
  
  /// Get modern input decoration theme
  InputDecorationTheme get modernInputDecorationTheme {
    return inputDecorationTheme;
  }
}
