// lib/shared/widgets/navigation/nav_components.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../core/state/app_state.dart';

/// Navigation item model
class HNavItem {
  final String label;
  final IconData icon;
  final String route;
  final List<String>? allowedRoles;

  const HNavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.allowedRoles,
  });
}

/// Bottom navigation widget
class HBottomNav extends StatelessWidget {
  final List<HNavItem> items;
  final int selectedIndex;
  final Function(int) onTap;

  const HBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey[600],
      items: items.map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon),
        label: item.label,
      )).toList(),
    );
  }
}

/// Navigation rail widget
class HNavRail extends StatelessWidget {
  final List<HNavItem> items;
  final int selectedIndex;
  final Function(int) onTap;

  const HNavRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onTap,
      labelType: NavigationRailLabelType.all,
      destinations: items.map((item) => NavigationRailDestination(
        icon: Icon(item.icon),
        label: Text(item.label),
      )).toList(),
    );
  }
}

/// Responsive navigation wrapper
class ResponsiveNavigation extends StatelessWidget {
  final List<HNavItem> items;
  final int selectedIndex;
  final Function(int) onTap;
  final Widget child;

  const ResponsiveNavigation({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (HResponsive.isWideScreen(context)) {
      return Row(
        children: [
          HNavRail(
            items: items,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
          Expanded(child: child),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(child: child),
          HBottomNav(
            items: items,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),
        ],
      );
    }
  }
}
