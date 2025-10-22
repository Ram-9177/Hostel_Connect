import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/navigation/app_router.dart';
import 'shared/theme/unified_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: HostelConnectApp(),
    ),
  );
}

class HostelConnectApp extends StatelessWidget {
  const HostelConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HostelConnect',
      theme: UnifiedTheme.lightTheme,
      darkTheme: UnifiedTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(AuthService.authStateProvider);
    
    // Show loading screen during initial auth check
    if (authState.isLoading) {
      return const Scaffold(
        backgroundColor: IOSGradeTheme.background,
        body: Center(
          child: CircularProgressIndicator(
            color: IOSGradeTheme.primary,
          ),
        ),
      );
    }

    // If user is logged in, show role-based home
    if (authState.isAuthenticated && authState.user != null) {
      return _getRoleBasedHome(authState.user!.role);
    }
    
          // Otherwise show login page
          return const EnhancedIOSLoginPage();
  }

  Widget _getRoleBasedHome(String role) {
    switch (role.toLowerCase()) {
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
        return const EnhancedIOSLoginPage();
    }
  }
}