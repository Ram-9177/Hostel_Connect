// lib/shared/theme/telugu_theme.dart
import 'package:flutter/material.dart';
import 'tokens.dart';

class HTeluguTheme {
  // Primary colors
  static const Color primary = HTokens.primary;
  static const Color onPrimary = HTokens.onPrimary;
  static const Color secondary = HTokens.secondary;
  static const Color onSecondary = HTokens.onSecondary;
  
  // Surface colors
  static const Color surface = HTokens.surface;
  static const Color onSurface = HTokens.onSurface;
  static const Color surfaceVariant = HTokens.surfaceVariant;
  static const Color onSurfaceVariant = HTokens.onSurfaceVariant;
  
  // Background colors
  static const Color background = HTokens.background;
  static const Color onBackground = HTokens.onBackground;
  
  // Status colors
  static const Color error = HTokens.error;
  static const Color onError = HTokens.onError;
  static const Color accent = HTokens.accent;
  static const Color success = HTokens.success;
  static const Color warning = HTokens.warning;
  static const Color info = HTokens.info;
  
  // Text colors
  static const Color textPrimary = HTokens.onSurface;
  static const Color textSecondary = HTokens.onSurfaceVariant;
  static const Color textDisabled = Color(0xFF9E9E9E);
  
  // Border colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = HTokens.primary;
  static const Color borderError = HTokens.error;
  
  // Spacing
  static const double spacingXS = HTokens.spacingXS;
  static const double spacingSM = HTokens.spacingSM;
  static const double spacingMD = HTokens.spacingMD;
  static const double spacingLG = HTokens.spacingLG;
  static const double spacingXL = HTokens.spacingXL;
  static const double spacingXXL = HTokens.spacingXXL;
  
  // Typography
  static const TextStyle heading1 = TextStyle(
    fontSize: HTokens.fontSizeHeadline,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: HTokens.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: HTokens.fontSizeXXL,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static const TextStyle titleLarge = TextStyle(
    fontSize: HTokens.fontSizeXL,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: HTokens.fontSizeLG,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: HTokens.fontSizeMD,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: HTokens.fontSizeLG,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: HTokens.fontSizeMD,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: HTokens.fontSizeSM,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
  
  static const TextStyle body1 = bodyLarge;
  static const TextStyle body2 = bodyMedium;
  
  // Button styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(HTokens.buttonRadius),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: HTokens.spacingLG,
      vertical: HTokens.spacingMD,
    ),
  );
  
  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primary,
    side: const BorderSide(color: primary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(HTokens.buttonRadius),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: HTokens.spacingLG,
      vertical: HTokens.spacingMD,
    ),
  );
  
  // Card style
  static BoxDecoration cardDecoration = BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(HTokens.cardRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: HTokens.elevationLow,
        offset: const Offset(0, 2),
      ),
    ],
  );
  
  // Input decoration
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HTokens.inputRadius),
        borderSide: const BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HTokens.inputRadius),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HTokens.inputRadius),
        borderSide: const BorderSide(color: borderFocused, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(HTokens.inputRadius),
        borderSide: const BorderSide(color: borderError),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: HTokens.spacingMD,
        vertical: HTokens.spacingMD,
      ),
    );
  }
  
  // Utility method for Telugu-English text
  static String getTeluguEnglishText(String teluguKey, String englishText) {
    // For now, return English text
    // In a real implementation, this would handle Telugu translations
    return englishText;
  }
}