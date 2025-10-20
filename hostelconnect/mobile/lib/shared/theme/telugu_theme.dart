import 'package:flutter/material.dart';

class HTeluguTheme {
  // Solid/Light Color Palette
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color accent = Color(0xFFFFB300);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color shadow = Color(0x1A000000);
  
  // Material 3 Colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSurface = textPrimary;
  static const Color onSurfaceVariant = textSecondary;
  static const Color secondary = accent;
  
  // Text styles for direct access
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.3,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textSecondary,
    height: 1.5,
  );

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        background: background,
        error: error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: onPrimary,
        ),
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 2,
        shadowColor: shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 2,
          shadowColor: shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          minimumSize: const Size(44, 44), // Accessibility requirement
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          minimumSize: const Size(44, 44), // Accessibility requirement
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          minimumSize: const Size(44, 44), // Accessibility requirement
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          height: 1.2,
        ),
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          height: 1.3,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          height: 1.3,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          height: 1.3,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: textSecondary,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Telugu Labels for Key Surfaces
  static const Map<String, String> teluguLabels = {
    // Dashboard tiles
    'present': 'హాజరు',
    'outpass': 'బయట అనుమతి',
    'manual_percentage': 'మాన్యువల్ శాతం',
    'kiosk_scans': 'కియోస్క్ స్కాన్',
    'warden_scans': 'వార్డెన్ స్కాన్',
    
    // Primary buttons
    'approve': 'అంగీకరించు',
    'reject': 'తిరస్కరించు',
    'save': 'సేవ్ చెయ్యి',
    'scan_now': 'ఇప్పుడే స్కాన్ చేయి',
    
    // Meals
    'breakfast': 'ఉదయం భోజనం',
    'lunch': 'మధ్యాహ్న భోజనం',
    'snacks': 'తినుబండారాలు',
    'dinner': 'రాత్రి భోజనం',
    'all_yes': 'అన్నీ అవును',
    'all_no': 'అన్నీ కాదు',
    'same_as_yesterday': 'నిన్న లావు',
    
    // Headings
    'notices': 'ప్రకటనలు',
    'dashboard': 'హాస్టల్ డ్యాష్‌బోర్డ్',
  };

  // Get Telugu label with English fallback
  static String getTeluguLabel(String key, {String? englishFallback}) {
    return teluguLabels[key] ?? englishFallback ?? key;
  }

  // Accessibility helpers
  static bool isAccessibleContrast(Color foreground, Color background) {
    // Calculate contrast ratio (simplified)
    final foregroundLuminance = foreground.computeLuminance();
    final backgroundLuminance = background.computeLuminance();
    
    final lighter = foregroundLuminance > backgroundLuminance 
        ? foregroundLuminance 
        : backgroundLuminance;
    final darker = foregroundLuminance > backgroundLuminance 
        ? backgroundLuminance 
        : foregroundLuminance;
    
    final contrast = (lighter + 0.05) / (darker + 0.05);
    return contrast >= 4.5; // WCAG AA standard
  }

  // Responsive spacing
  static const double spacingXS = 4;
  static const double spacingSM = 8;
  static const double spacingMD = 16;
  static const double spacingLG = 24;
  static const double spacingXL = 32;
  static const double spacingXXL = 40;

  // Border radius
  static const double radiusSM = 4;
  static const double radiusMD = 8;
  static const double radiusLG = 12;
  static const double radiusXL = 16;
}