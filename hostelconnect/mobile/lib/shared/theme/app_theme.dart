import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: HTokens.primary,
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        backgroundColor: HTokens.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HTokens.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(44, 44), // Accessibility
          padding: EdgeInsets.symmetric(horizontal: HTokens.xl, vertical: HTokens.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(HTokens.cardRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: HTokens.lg, vertical: HTokens.md),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: HTokens.primary,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: HTokens.primary,
          foregroundColor: Colors.white,
          minimumSize: Size(44, 44), // Accessibility
          padding: EdgeInsets.symmetric(horizontal: HTokens.xl, vertical: HTokens.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(HTokens.cardRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(HTokens.cardRadius),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: HTokens.lg, vertical: HTokens.md),
      ),
    );
  }
}
