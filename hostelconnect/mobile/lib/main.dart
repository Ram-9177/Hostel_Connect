import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/state/app_state.dart';
import 'core/storage/secure_storage.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/dashboards/presentation/pages/student_home_page.dart';
import 'features/dashboards/presentation/pages/warden_dashboard_page.dart';
import 'features/dashboards/presentation/pages/warden_head_dashboard_page.dart';
import 'features/dashboards/presentation/pages/super_admin_dashboard_page.dart';
import 'features/dashboards/presentation/pages/chef_dashboard_page.dart';
import 'shared/theme/telugu_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize secure storage
  await SecureTokenStorage.initialize();
  
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
    return MaterialApp(
      title: 'HostelConnect',
      theme: HTeluguTheme.lightTheme,
      home: const AuthWrapper(),
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
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      // Check if user has valid tokens
      final tokens = await SecureTokenStorage.getStoredTokens();
      
      if (tokens != null && tokens['accessToken'] != null) {
        // Try silent refresh
        final appState = ref.read(appStateProvider.notifier);
        await appState.silentRefresh();
      }
    } catch (e) {
      // If silent refresh fails, user will be redirected to login
      print('Silent refresh failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final appState = ref.watch(appStateProvider);
        
        // If user is logged in, show role-based home
        if (appState.user != null) {
          return _getRoleBasedHome(appState.user!.role);
        }
        
        // Otherwise show login page
        return const LoginPage();
      },
    );
  }

  Widget _getRoleBasedHome(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return const StudentHomePage();
      case 'warden':
        return const WardenDashboardPage();
      case 'warden_head':
        return const WardenHeadDashboardPage();
      case 'super_admin':
        return const SuperAdminDashboardPage();
      case 'chef':
        return const ChefDashboardPage();
      default:
        return const LoginPage();
    }
  }
}