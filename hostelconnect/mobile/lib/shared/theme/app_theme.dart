// lib/shared/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'telugu_theme.dart';

class AppTheme {
  // Colors
  static const Color primary = HTeluguTheme.primary;
  static const Color secondary = HTeluguTheme.secondary;
  static const Color success = HTeluguTheme.success;
  static const Color warning = HTeluguTheme.warning;
  static const Color error = HTeluguTheme.error;
  static const Color accent = HTeluguTheme.accent;
  static const Color background = HTeluguTheme.background;
  static const Color surface = HTeluguTheme.surface;
  static const Color textPrimary = HTeluguTheme.textPrimary;
  static const Color textSecondary = HTeluguTheme.textSecondary;

  // Typography
  static const TextStyle headlineLarge = HTeluguTheme.heading1;
  static const TextStyle titleLarge = HTeluguTheme.titleLarge;
  static const TextStyle titleMedium = HTeluguTheme.titleMedium;
  static const TextStyle titleSmall = HTeluguTheme.titleSmall;
  static const TextStyle bodyLarge = HTeluguTheme.bodyLarge;
  static const TextStyle bodyMedium = HTeluguTheme.bodyMedium;
  static const TextStyle bodySmall = HTeluguTheme.bodySmall;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: HTeluguTheme.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: HTeluguTheme.onPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: HTeluguTheme.primaryButtonStyle,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: HTeluguTheme.secondaryButtonStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: HTeluguTheme.primary,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}