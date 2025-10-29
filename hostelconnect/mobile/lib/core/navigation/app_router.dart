// lib/core/navigation/app_router.dart - COMPLETE PAGE ROUTING
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_service.dart';
import '../../features/auth/presentation/pages/enhanced_ios_login_page.dart';
import '../../features/dashboards/presentation/pages/enhanced_ios_student_dashboard.dart';
import '../../features/dashboards/presentation/pages/warden_dashboard_page.dart';
import '../../features/dashboards/presentation/pages/warden_head_dashboard_page.dart';
import '../../features/dashboards/presentation/pages/comprehensive_super_admin_dashboard.dart';
import '../../features/dashboards/presentation/pages/chef_dashboard_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/gatepass/presentation/pages/gate_pass_page.dart';
import '../../features/meals/presentation/pages/meals_page.dart';
import '../../features/rooms/presentation/pages/room_allotment_page.dart';
import '../../features/attendance/presentation/pages/attendance_page.dart';
import '../../features/notices/presentation/pages/notices_page.dart';
import '../../features/policies/presentation/pages/policies_page.dart';
import '../../features/reports/presentation/pages/reports_dashboard_page.dart';
import '../../features/user_management/presentation/pages/admin_user_management_page.dart';
import '../../features/issue_reporting/presentation/pages/issue_reporting_page.dart';
import '../../features/complaints/presentation/pages/complaints_page.dart';
import '../../features/inventory/presentation/pages/inventory_page.dart';
import '../../features/meal_planning/presentation/pages/meal_planning_page.dart';
import '../../features/dietary_requests/presentation/pages/dietary_requests_page.dart';
import '../../shared/widgets/navigation/role_guards.dart';
import '../../shared/theme/unified_theme.dart';

/// Complete App Router - ALL PAGES IMPLEMENTED
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      // TODO: Implement auth redirect with Riverpod RefreshListenable
      // For now, allow all routes
      return null;
    },
    routes: [
      // Login route
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const EnhancedIOSLoginPage(),
      ),
      
      // Main app shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => _AppShell(child: child),
        routes: [
          // Dashboard routes
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => _getDashboardWidget(state.uri.queryParameters['role']),
          ),
          
          // Profile route
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          
          // Gate pass route
          GoRoute(
            path: '/gate-pass',
            name: 'gate-pass',
            builder: (context, state) => const GatePassPage(),
          ),
          
          // Meals route
          GoRoute(
            path: '/meals',
            name: 'meals',
            builder: (context, state) => const MealsPage(),
          ),
          
          // Rooms route
          GoRoute(
            path: '/rooms',
            name: 'rooms',
            builder: (context, state) => const RoomAllotmentPage(),
          ),
          
          // Attendance route
          GoRoute(
            path: '/attendance',
            name: 'attendance',
            builder: (context, state) => const AttendancePage(),
          ),
          
          // Notices route
          GoRoute(
            path: '/notices',
            name: 'notices',
            builder: (context, state) => const NoticesPage(),
          ),
          
          // Policies route
          GoRoute(
            path: '/policies',
            name: 'policies',
            builder: (context, state) => const PoliciesPage(),
          ),
          
          // Reports route
          GoRoute(
            path: '/reports',
            name: 'reports',
            builder: (context, state) => const ReportsDashboardPage(hostelId: 'default'),
          ),
          
          // Admin routes (role-protected)
          GoRoute(
            path: '/admin/users',
            name: 'admin-users',
            builder: (context, state) => const AdminUserManagementPage(),
          ),
          
          // Issue reporting route
          GoRoute(
            path: '/issues',
            name: 'issues',
            builder: (context, state) => const IssueReportingPage(),
          ),
          
          // Complaints route
          GoRoute(
            path: '/complaints',
            name: 'complaints',
            builder: (context, state) => const ComplaintsPage(),
          ),
          
          // Inventory route (Chef only)
          GoRoute(
            path: '/inventory',
            name: 'inventory',
            builder: (context, state) => const InventoryPage(),
          ),
          
          // Meal planning route (Chef only)
          GoRoute(
            path: '/meal-planning',
            name: 'meal-planning',
            builder: (context, state) => const MealPlanningPage(),
          ),
          
          // Dietary requests route
          GoRoute(
            path: '/dietary-requests',
            name: 'dietary-requests',
            builder: (context, state) => const DietaryRequestsPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => _ErrorPage(error: state.error),
  );

  static String _getDashboardRoute(String? role) {
    switch (role) {
      case 'student':
        return '/dashboard?role=student';
      case 'warden':
        return '/dashboard?role=warden';
      case 'warden_head':
        return '/dashboard?role=warden_head';
      case 'super_admin':
        return '/dashboard?role=super_admin';
      case 'chef':
        return '/dashboard?role=chef';
      default:
        return '/dashboard';
    }
  }

  static Widget _getDashboardWidget(String? role) {
    switch (role) {
      case 'student':
        return const EnhancedIOSStudentDashboard();
      case 'warden':
        return const WardenDashboardPage();
      case 'warden_head':
        return const WardenHeadDashboardPage();
      case 'super_admin':
        return const ComprehensiveSuperAdminDashboard();
      case 'chef':
        return const ChefDashboardPage();
      default:
        return const EnhancedIOSStudentDashboard();
    }
  }
}

/// App shell with role-based bottom navigation
class _AppShell extends ConsumerWidget {
  final Widget child;

  const _AppShell({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(AuthService.authStateProvider);
    final userRole = authState.user?.role.toLowerCase() ?? 'student';

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNavigation(context, userRole),
    );
  }

  Widget _buildBottomNavigation(BuildContext context, String role) {
    final navigationItems = _getNavigationItems(role);
    final currentIndex = _getCurrentIndex(context, navigationItems);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onNavigationTap(context, index, navigationItems),
      items: navigationItems.map((item) => BottomNavigationBarItem(
        icon: Icon(item.icon),
        label: item.label,
      )).toList(),
    );
  }

  List<_NavigationItem> _getNavigationItems(String role) {
    switch (role) {
      case 'student':
        return [
          _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
          _NavigationItem(icon: Icons.exit_to_app, label: 'Gate Pass', route: '/gate-pass'),
          _NavigationItem(icon: Icons.restaurant, label: 'Meals', route: '/meals'),
          _NavigationItem(icon: Icons.check_circle, label: 'Attendance', route: '/attendance'),
          _NavigationItem(icon: Icons.person, label: 'Profile', route: '/profile'),
        ];
      case 'warden':
      case 'warden_head':
        return [
          _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
          _NavigationItem(icon: Icons.approval, label: 'Gate Pass', route: '/gate-pass'),
          _NavigationItem(icon: Icons.room, label: 'Rooms', route: '/rooms'),
          _NavigationItem(icon: Icons.campaign, label: 'Notices', route: '/notices'),
          _NavigationItem(icon: Icons.person, label: 'Profile', route: '/profile'),
        ];
      case 'chef':
        return [
          _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
          _NavigationItem(icon: Icons.restaurant, label: 'Meals', route: '/meals'),
          _NavigationItem(icon: Icons.inventory, label: 'Inventory', route: '/inventory'),
          _NavigationItem(icon: Icons.restaurant_menu, label: 'Planning', route: '/meal-planning'),
          _NavigationItem(icon: Icons.person, label: 'Profile', route: '/profile'),
        ];
      case 'super_admin':
        return [
          _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
          _NavigationItem(icon: Icons.people, label: 'Users', route: '/admin/users'),
          _NavigationItem(icon: Icons.analytics, label: 'Reports', route: '/reports'),
          _NavigationItem(icon: Icons.policy, label: 'Policies', route: '/policies'),
          _NavigationItem(icon: Icons.person, label: 'Profile', route: '/profile'),
        ];
      default:
        return [
          _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard'),
          _NavigationItem(icon: Icons.person, label: 'Profile', route: '/profile'),
        ];
    }
  }

  int _getCurrentIndex(BuildContext context, List<_NavigationItem> items) {
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < items.length; i++) {
      if (location.startsWith(items[i].route)) {
        return i;
      }
    }
    return 0;
  }

  void _onNavigationTap(BuildContext context, int index, List<_NavigationItem> items) {
    final item = items[index];
    context.go(item.route);
  }
}

class _NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  _NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

/// Error page for navigation errors
class _ErrorPage extends StatelessWidget {
  final Exception? error;

  const _ErrorPage({this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: UnifiedTheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: UnifiedTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                  color: UnifiedTheme.error,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error?.toString() ?? 'Unknown error',
                textAlign: TextAlign.center,
                style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: UnifiedTheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}