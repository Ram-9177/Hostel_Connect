// lib/core/routing/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/app_state.dart';
import '../auth/auth_service.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/student/presentation/pages/student_home_page.dart';
import '../../features/warden/presentation/pages/warden_home_page.dart';
import '../../features/admin/presentation/pages/admin_home_page.dart';
import '../../features/chef/presentation/pages/chef_home_page.dart';
import '../../features/gate_pass/presentation/pages/gate_scanner_page.dart';
import '../../features/gate_pass/presentation/pages/gate_pass_request_page.dart';
import '../../shared/widgets/ui/access_denied_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      
      // If not logged in and not on login page, redirect to login
      if (!authState.isAuthenticated && state.location != '/login') {
        return '/login';
      }
      
      // If logged in and on login page, redirect to appropriate home
      if (authState.isAuthenticated && state.location == '/login') {
        return _getHomeRouteForRole(authState.user?.role ?? 'student');
      }
      
      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      
      // Role-based home routes
      GoRoute(
        path: '/student',
        builder: (context, state) => const StudentHomePage(),
      ),
      GoRoute(
        path: '/warden',
        builder: (context, state) => const WardenHomePage(),
      ),
      GoRoute(
        path: '/warden-head',
        builder: (context, state) => const WardenHomePage(), // Same as warden for now
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminHomePage(),
      ),
      GoRoute(
        path: '/chef',
        builder: (context, state) => const ChefHomePage(),
      ),
      
      // Gate Pass routes
      GoRoute(
        path: '/gate-pass/request',
        builder: (context, state) => const GatePassRequestPage(),
      ),
      GoRoute(
        path: '/gate-pass/scanner',
        builder: (context, state) => const GateScannerPage(),
      ),
      
      // Access denied route
      GoRoute(
        path: '/access-denied',
        builder: (context, state) => const AccessDeniedPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('The requested page could not be found.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/login'),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    ),
  );
});

String _getHomeRouteForRole(String role) {
  switch (role.toLowerCase()) {
    case 'student':
      return '/student';
    case 'warden':
      return '/warden';
    case 'warden_head':
      return '/warden-head';
    case 'super_admin':
    case 'admin':
      return '/admin';
    case 'chef':
      return '/chef';
    default:
      return '/student';
  }
}

// Route guard helper
class RouteGuard {
  static bool canAccessRoute(String route, String userRole) {
    switch (route) {
      case '/gate-pass/scanner':
        return ['warden', 'warden_head', 'super_admin'].contains(userRole.toLowerCase());
      case '/admin':
        return ['super_admin', 'admin'].contains(userRole.toLowerCase());
      case '/warden':
      case '/warden-head':
        return ['warden', 'warden_head', 'super_admin'].contains(userRole.toLowerCase());
      case '/chef':
        return ['chef', 'super_admin'].contains(userRole.toLowerCase());
      case '/student':
      case '/gate-pass/request':
        return true; // All roles can access
      default:
        return true;
    }
  }
  
  static String getAccessDeniedMessage(String route, String userRole) {
    // Telugu messages
    const teluguMessages = {
      '/gate-pass/scanner': 'ఈ స్కానర్‌ను వార్డెన్ లేదా అడ్మిన్ మాత్రమే ఉపయోగించవచ్చు',
      '/admin': 'ఈ భాగానికి మీకు అనుమతి లేదు',
      '/warden': 'ఈ భాగానికి మీకు అనుమతి లేదు',
      '/chef': 'ఈ భాగానికి మీకు అనుమతి లేదు',
    };
    
    // English messages
    const englishMessages = {
      '/gate-pass/scanner': 'This scanner can only be used by wardens or administrators',
      '/admin': 'You do not have access to this section',
      '/warden': 'You do not have access to this section',
      '/chef': 'You do not have access to this section',
    };
    
    return teluguMessages[route] ?? englishMessages[route] ?? 'Access denied';
  }
}
