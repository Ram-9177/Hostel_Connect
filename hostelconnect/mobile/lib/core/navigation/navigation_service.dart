import 'package:flutter/material.dart';

/// Navigation Service
/// Centralized navigation service for HostelConnect
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  static void goBack() {
    navigator.pop();
  }

  static void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigator.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushAndRemoveUntil(String routeName, {Object? arguments}) {
    navigator.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  static void navigateWithRoleGuard(
    BuildContext context,
    Widget page,
    List<String> allowedRoles,
  ) {
    // TODO: Implement role guard logic
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}