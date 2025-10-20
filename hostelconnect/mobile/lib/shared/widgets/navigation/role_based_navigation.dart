import 'package:flutter/material.dart';
import '../../../core/responsive.dart';
import '../../theme/telugu_theme.dart';
import '../../../core/state/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleBasedNavigation extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const RoleBasedNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final user = appState.user;
    
    if (user == null) return const SizedBox.shrink();

    final navItems = _getNavItems(user.role);
    
    return HResponsive.builder(builder: (ctx, r) {
      final isWide = r.size.index >= HSize.lg.index;

      if (isWide) {
        return NavigationRail(
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          labelType: r.size == HSize.xl ? NavigationRailLabelType.all : NavigationRailLabelType.selected,
          destinations: navItems.map((item) => NavigationRailDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon ?? item.icon),
            label: Text(item.label),
          )).toList(),
        );
      } else {
        return NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: onTap,
          destinations: navItems.map((item) => NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon ?? item.icon),
            label: item.label,
          )).toList(),
        );
      }
    });
  }

  List<HNavItem> _getNavItems(String role) {
    switch (role) {
      case 'STUDENT':
        return [
          HNavItem(
            icon: Icons.home,
            label: HTeluguTheme.getTeluguEnglishText('home', 'Home'),
            route: '/student/home',
          ),
          HNavItem(
            icon: Icons.qr_code_scanner,
            label: HTeluguTheme.getTeluguEnglishText('attendance', 'Attendance'),
            route: '/student/attendance',
          ),
          HNavItem(
            icon: Icons.restaurant,
            label: HTeluguTheme.getTeluguEnglishText('meals', 'Meals'),
            route: '/student/meals',
          ),
          HNavItem(
            icon: Icons.exit_to_app,
            label: HTeluguTheme.getTeluguEnglishText('gate_pass', 'Gate Pass'),
            route: '/student/gate-pass',
          ),
          HNavItem(
            icon: Icons.report_problem,
            label: HTeluguTheme.getTeluguEnglishText('complaints', 'Complaints'),
            route: '/student/complaints',
          ),
        ];
      case 'WARDEN':
        return [
          HNavItem(
            icon: Icons.dashboard,
            label: HTeluguTheme.getTeluguEnglishText('dashboard', 'Dashboard'),
            route: '/warden/dashboard',
          ),
          HNavItem(
            icon: Icons.qr_code_scanner,
            label: HTeluguTheme.getTeluguEnglishText('attendance', 'Attendance'),
            route: '/warden/attendance',
          ),
          HNavItem(
            icon: Icons.exit_to_app,
            label: HTeluguTheme.getTeluguEnglishText('gate_pass', 'Gate Pass'),
            route: '/warden/gate-pass',
          ),
          HNavItem(
            icon: Icons.report_problem,
            label: HTeluguTheme.getTeluguEnglishText('complaints', 'Complaints'),
            route: '/warden/complaints',
          ),
          HNavItem(
            icon: Icons.analytics,
            label: HTeluguTheme.getTeluguEnglishText('reports', 'Reports'),
            route: '/warden/reports',
          ),
        ];
      case 'WARDEN_HEAD':
        return [
          HNavItem(
            icon: Icons.dashboard,
            label: HTeluguTheme.getTeluguEnglishText('dashboard', 'Dashboard'),
            route: '/warden-head/dashboard',
          ),
          HNavItem(
            icon: Icons.qr_code_scanner,
            label: HTeluguTheme.getTeluguEnglishText('attendance', 'Attendance'),
            route: '/warden-head/attendance',
          ),
          HNavItem(
            icon: Icons.exit_to_app,
            label: HTeluguTheme.getTeluguEnglishText('gate_pass', 'Gate Pass'),
            route: '/warden-head/gate-pass',
          ),
          HNavItem(
            icon: Icons.report_problem,
            label: HTeluguTheme.getTeluguEnglishText('complaints', 'Complaints'),
            route: '/warden-head/complaints',
          ),
          HNavItem(
            icon: Icons.analytics,
            label: HTeluguTheme.getTeluguEnglishText('reports', 'Reports'),
            route: '/warden-head/reports',
          ),
          HNavItem(
            icon: Icons.notifications,
            label: HTeluguTheme.getTeluguEnglishText('notices', 'Notices'),
            route: '/warden-head/notices',
          ),
        ];
      case 'SUPER_ADMIN':
        return [
          HNavItem(
            icon: Icons.admin_panel_settings,
            label: HTeluguTheme.getTeluguEnglishText('admin', 'Admin'),
            route: '/admin/dashboard',
          ),
          HNavItem(
            icon: Icons.people,
            label: HTeluguTheme.getTeluguEnglishText('students', 'Students'),
            route: '/admin/students',
          ),
          HNavItem(
            icon: Icons.home_work,
            label: HTeluguTheme.getTeluguEnglishText('hostels', 'Hostels'),
            route: '/admin/hostels',
          ),
          HNavItem(
            icon: Icons.analytics,
            label: HTeluguTheme.getTeluguEnglishText('reports', 'Reports'),
            route: '/admin/reports',
          ),
          HNavItem(
            icon: Icons.settings,
            label: HTeluguTheme.getTeluguEnglishText('settings', 'Settings'),
            route: '/admin/settings',
          ),
        ];
      case 'CHEF':
        return [
          HNavItem(
            icon: Icons.restaurant_menu,
            label: HTeluguTheme.getTeluguEnglishText('menu', 'Menu'),
            route: '/chef/menu',
          ),
          HNavItem(
            icon: Icons.restaurant,
            label: HTeluguTheme.getTeluguEnglishText('meals', 'Meals'),
            route: '/chef/meals',
          ),
          HNavItem(
            icon: Icons.inventory,
            label: HTeluguTheme.getTeluguEnglishText('inventory', 'Inventory'),
            route: '/chef/inventory',
          ),
          HNavItem(
            icon: Icons.analytics,
            label: HTeluguTheme.getTeluguEnglishText('reports', 'Reports'),
            route: '/chef/reports',
          ),
        ];
      default:
        return [];
    }
  }
}

class HNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final String route;

  const HNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    required this.route,
  });
}
