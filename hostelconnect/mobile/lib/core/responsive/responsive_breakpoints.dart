// Responsive Breakpoints for All Devices
import 'package:flutter/material.dart';

/// Device type enumeration
enum DeviceType {
  mobile,
  tablet,
  desktop,
  watch,
}

/// Screen size enumeration
enum ScreenSize {
  xs,    // Extra small (phones in portrait)
  sm,    // Small (phones in landscape)
  md,    // Medium (tablets in portrait)
  lg,    // Large (tablets in landscape)
  xl,    // Extra large (desktops)
  xxl,   // Extra extra large (large desktops)
}

/// Responsive breakpoints for all devices
class ResponsiveBreakpoints {
  // Mobile breakpoints
  static const double mobileXS = 320;   // Small phones
  static const double mobileSM = 375;   // Standard phones
  static const double mobileMD = 414;   // Large phones
  
  // Tablet breakpoints
  static const double tabletSM = 768;  // Small tablets
  static const double tabletMD = 834;  // Standard tablets
  static const double tabletLG = 1024; // Large tablets
  
  // Desktop breakpoints
  static const double desktopSM = 1280; // Small desktops
  static const double desktopMD = 1440; // Standard desktops
  static const double desktopLG = 1920; // Large desktops
  static const double desktopXL = 2560; // Extra large desktops
  
  // Watch breakpoints
  static const double watchSM = 200;   // Small watches
  static const double watchMD = 300;   // Standard watches
  static const double watchLG = 400;   // Large watches
}

/// Responsive utilities for all devices
class ResponsiveUtils {
  /// Get device type based on screen width
  static DeviceType getDeviceType(double width) {
    if (width < ResponsiveBreakpoints.tabletSM) {
      return DeviceType.mobile;
    } else if (width < ResponsiveBreakpoints.desktopSM) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
  
  /// Get screen size based on width
  static ScreenSize getScreenSize(double width) {
    if (width < ResponsiveBreakpoints.mobileSM) {
      return ScreenSize.xs;
    } else if (width < ResponsiveBreakpoints.mobileMD) {
      return ScreenSize.sm;
    } else if (width < ResponsiveBreakpoints.tabletSM) {
      return ScreenSize.md;
    } else if (width < ResponsiveBreakpoints.tabletLG) {
      return ScreenSize.lg;
    } else if (width < ResponsiveBreakpoints.desktopMD) {
      return ScreenSize.xl;
    } else {
      return ScreenSize.xxl;
    }
  }
  
  /// Get responsive value based on screen size
  static T responsive<T>(
    BuildContext context, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final width = MediaQuery.of(context).size.width;
    final screenSize = getScreenSize(width);
    
    switch (screenSize) {
      case ScreenSize.xs:
        return xs;
      case ScreenSize.sm:
        return sm ?? xs;
      case ScreenSize.md:
        return md ?? sm ?? xs;
      case ScreenSize.lg:
        return lg ?? md ?? sm ?? xs;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
      case ScreenSize.xxl:
        return xxl ?? xl ?? lg ?? md ?? sm ?? xs;
    }
  }
  
  /// Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: responsive(
        context,
        xs: 16.0,
        sm: 20.0,
        md: 24.0,
        lg: 32.0,
        xl: 40.0,
        xxl: 48.0,
      ),
      vertical: responsive(
        context,
        xs: 12.0,
        sm: 16.0,
        md: 20.0,
        lg: 24.0,
        xl: 32.0,
        xxl: 40.0,
      ),
    );
  }
  
  /// Get responsive font size
  static double responsiveFontSize(BuildContext context, {
    required double base,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return responsive(
      context,
      xs: xs ?? base * 0.8,
      sm: sm ?? base * 0.9,
      md: md ?? base,
      lg: lg ?? base * 1.1,
      xl: xl ?? base * 1.2,
      xxl: xxl ?? base * 1.3,
    );
  }
  
  /// Get responsive spacing
  static double responsiveSpacing(BuildContext context, {
    required double base,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return responsive(
      context,
      xs: xs ?? base * 0.5,
      sm: sm ?? base * 0.75,
      md: md ?? base,
      lg: lg ?? base * 1.25,
      xl: xl ?? base * 1.5,
      xxl: xxl ?? base * 2.0,
    );
  }
  
  /// Get responsive grid columns
  static int responsiveColumns(BuildContext context) {
    return responsive(
      context,
      xs: 1,
      sm: 1,
      md: 2,
      lg: 3,
      xl: 4,
      xxl: 5,
    );
  }
  
  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return getDeviceType(MediaQuery.of(context).size.width) == DeviceType.mobile;
  }
  
  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return getDeviceType(MediaQuery.of(context).size.width) == DeviceType.tablet;
  }
  
  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return getDeviceType(MediaQuery.of(context).size.width) == DeviceType.desktop;
  }
  
  /// Get responsive card width
  static double responsiveCardWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return width * 0.9;
      case DeviceType.tablet:
        return width * 0.7;
      case DeviceType.desktop:
        return width * 0.5;
      case DeviceType.watch:
        return width * 0.95;
    }
  }
  
  /// Get responsive dialog width
  static double responsiveDialogWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return width * 0.95;
      case DeviceType.tablet:
        return width * 0.6;
      case DeviceType.desktop:
        return width * 0.4;
      case DeviceType.watch:
        return width * 0.9;
    }
  }
}
