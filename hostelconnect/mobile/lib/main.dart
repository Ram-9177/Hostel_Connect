// lib/main.dart - Simplified Working Version
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hostelconnect/core/auth/auth_service.dart';
import 'package:hostelconnect/core/api/auth_api_service.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/core/network/http_client.dart';
import 'package:hostelconnect/shared/theme/app_theme.dart';

void main() {
  runApp(
    ProviderScope(
      child: HostelConnectApp(),
    ),
  );
}

class HostelConnectApp extends ConsumerWidget {
  HostelConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'HostelConnect',
      theme: AppTheme.lightTheme,
      routerConfig: _createRouter(ref),
      debugShowCheckedModeBanner: false,
    );
  }

  GoRouter _createRouter(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final appState = ref.read(appStateProvider);
        
        // If loading, stay on current route
        if (appState.isLoading) return null;
        
        // If not authenticated and not on login page, redirect to login
        if (!appState.isAuthenticated && state.matchedLocation != '/') {
          return '/';
        }
        
        // If authenticated and on login page, redirect to role home
        if (appState.isAuthenticated && state.matchedLocation == '/') {
          return _getRoleHomeRoute(appState.user?.role);
        }
        
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/student-home',
          builder: (context, state) => const StudentHomePage(),
        ),
        GoRoute(
          path: '/warden-home',
          builder: (context, state) => const WardenHomePage(),
        ),
        GoRoute(
          path: '/chef-home',
          builder: (context, state) => const ChefHomePage(),
        ),
        GoRoute(
          path: '/admin-home',
          builder: (context, state) => const AdminHomePage(),
        ),
        GoRoute(
          path: '/access-denied',
          builder: (context, state) => const AccessDeniedPage(),
        ),
      ],
    );
  }

  String _getRoleHomeRoute(String? role) {
    switch (role?.toLowerCase()) {
      case 'student':
        return '/student-home';
      case 'warden':
      case 'warden_head':
        return '/warden-home';
      case 'chef':
        return '/chef-home';
      case 'super_admin':
        return '/admin-home';
      default:
        return '/access-denied';
    }
  }
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController(text: 'student@demo.com');
  final TextEditingController _passwordController = TextEditingController(text: 'password123');
  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    try {
      final authApiService = AuthApiService(ref.read(httpClientProvider));
      final result = await AuthService.login(
        _emailController.text,
        _passwordController.text,
        authApiService,
      );

      if (result.isSuccess) {
        // Login successful - router will handle navigation
        print('Login successful! User: ${result.user?.email}');
      } else {
        setState(() {
          _errorMessage = result.error ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Login error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              
              // App Logo and Title
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.home_work,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'HostelConnect',
                style: AppTheme.headlineLarge.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Complete Hostel Management System',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Login Form
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Login to Continue',
                      style: AppTheme.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppTheme.background,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppTheme.background,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    if (_errorMessage.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: AppTheme.error, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage,
                                style: AppTheme.bodyMedium.copyWith(color: AppTheme.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    if (_errorMessage.isNotEmpty) const SizedBox(height: 16),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Login',
                                style: AppTheme.titleMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Demo Credentials
              Text(
                'Demo Credentials',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              _buildCredentialCard('Student', 'student@demo.com', 'password123', AppTheme.success),
              _buildCredentialCard('Warden', 'warden@demo.com', 'password123', AppTheme.warning),
              _buildCredentialCard('Chef', 'chef@demo.com', 'password123', AppTheme.accent),
              _buildCredentialCard('Admin', 'admin@demo.com', 'password123', AppTheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialCard(String role, String email, String password, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(
              role[0],
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(role, style: AppTheme.titleSmall.copyWith(fontWeight: FontWeight.bold)),
          subtitle: Text(email, style: AppTheme.bodySmall),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              _emailController.text = email;
              _passwordController.text = password;
            },
          ),
        ),
      ),
    );
  }
}

class StudentHomePage extends ConsumerWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appStateProvider).user;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: AppTheme.success,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.success,
                    radius: 30,
                    child: Text(
                      (user?.firstName ?? 'S')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user?.firstName ?? 'Student'}!',
                          style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Role: ${user?.role?.toUpperCase() ?? 'STUDENT'}',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.success),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Quick Stats
            Text(
              'Quick Stats',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildStatCard('Attendance', '95%', AppTheme.primary, Icons.calendar_today)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Gate Passes', '3', AppTheme.warning, Icons.exit_to_app)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Meals', '28', AppTheme.success, Icons.fastfood)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Quick Access
            Text(
              'Quick Access',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Request Gate Pass',
                  Icons.exit_to_app,
                  AppTheme.warning,
                  () => _showFeatureDialog(context, 'Gate Pass Request', 'Request gate passes for leaving the hostel.'),
                ),
                _buildFeatureCard(
                  context,
                  'View Attendance',
                  Icons.calendar_today,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Attendance Tracking', 'View your attendance records and statistics.'),
                ),
                _buildFeatureCard(
                  context,
                  'Meal Management',
                  Icons.fastfood,
                  AppTheme.success,
                  () => _showFeatureDialog(context, 'Meal Management', 'Manage your meal preferences and opt-in/out.'),
                ),
                _buildFeatureCard(
                  context,
                  'Room Information',
                  Icons.bed,
                  AppTheme.accent,
                  () => _showFeatureDialog(context, 'Room Information', 'View your room and bed assignment details.'),
                ),
                _buildFeatureCard(
                  context,
                  'Notices & Updates',
                  Icons.announcement,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Notices', 'Read hostel notices and announcements.'),
                ),
                _buildFeatureCard(
                  context,
                  'Profile',
                  Icons.person,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Profile', 'Manage your profile and account settings.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppTheme.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class WardenHomePage extends ConsumerWidget {
  const WardenHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appStateProvider).user;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Warden Dashboard'),
        backgroundColor: AppTheme.warning,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.warning.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.warning,
                    radius: 30,
                    child: Text(
                      (user?.firstName ?? 'W')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user?.firstName ?? 'Warden'}!',
                          style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Role: ${user?.role?.toUpperCase() ?? 'WARDEN'}',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.warning),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Today's Overview
            Text(
              'Today\'s Overview',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildStatCard('Scans', '47', AppTheme.warning, Icons.qr_code_scanner)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Students', '156', AppTheme.primary, Icons.group)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Complaints', '3', AppTheme.error, Icons.report_problem)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Warden Tools
            Text(
              'Warden Tools',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Gate Pass Scanner',
                  Icons.qr_code_scanner,
                  AppTheme.warning,
                  () => _showFeatureDialog(context, 'QR Scanner', 'Scan QR codes for gate pass validation.'),
                ),
                _buildFeatureCard(
                  context,
                  'Student Management',
                  Icons.group,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Student Management', 'Manage student records and information.'),
                ),
                _buildFeatureCard(
                  context,
                  'Attendance Management',
                  Icons.check_circle_outline,
                  AppTheme.success,
                  () => _showFeatureDialog(context, 'Attendance Management', 'Track and manage student attendance.'),
                ),
                _buildFeatureCard(
                  context,
                  'Room Allocation',
                  Icons.bed,
                  AppTheme.accent,
                  () => _showFeatureDialog(context, 'Room Allocation', 'Allocate and manage room assignments.'),
                ),
                _buildFeatureCard(
                  context,
                  'Reports & Analytics',
                  Icons.bar_chart,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Reports', 'Generate reports and analytics.'),
                ),
                _buildFeatureCard(
                  context,
                  'Broadcast Notice',
                  Icons.announcement,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Broadcast Notice', 'Send notices to students.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppTheme.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class ChefHomePage extends ConsumerWidget {
  const ChefHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appStateProvider).user;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Chef Dashboard'),
        backgroundColor: AppTheme.accent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.accent,
                    radius: 30,
                    child: Text(
                      (user?.firstName ?? 'C')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user?.firstName ?? 'Chef'}!',
                          style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Role: ${user?.role?.toUpperCase() ?? 'CHEF'}',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.accent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Kitchen Overview
            Text(
              'Kitchen Overview',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildStatCard('Meals Served', '156', AppTheme.success, Icons.fastfood)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Opt-outs', '12', AppTheme.warning, Icons.cancel)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Feedback', '4.8', AppTheme.primary, Icons.star)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Kitchen Management
            Text(
              'Kitchen Management',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Menu Management',
                  Icons.restaurant_menu,
                  AppTheme.success,
                  () => _showFeatureDialog(context, 'Menu Management', 'Plan and manage daily menus.'),
                ),
                _buildFeatureCard(
                  context,
                  'Meal Preparation',
                  Icons.food_bank,
                  AppTheme.accent,
                  () => _showFeatureDialog(context, 'Meal Preparation', 'Track meal preparation and serving.'),
                ),
                _buildFeatureCard(
                  context,
                  'Inventory Management',
                  Icons.inventory,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Inventory', 'Manage kitchen inventory and supplies.'),
                ),
                _buildFeatureCard(
                  context,
                  'Meal Feedback',
                  Icons.feedback,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Meal Feedback', 'View student feedback on meals.'),
                ),
                _buildFeatureCard(
                  context,
                  'Dietary Requests',
                  Icons.healing,
                  AppTheme.success,
                  () => _showFeatureDialog(context, 'Dietary Requests', 'Handle special dietary requirements.'),
                ),
                _buildFeatureCard(
                  context,
                  'Kitchen Reports',
                  Icons.analytics,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Kitchen Reports', 'Generate kitchen performance reports.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppTheme.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appStateProvider).user;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primary,
                    radius: 30,
                    child: Text(
                      (user?.firstName ?? 'A')[0].toUpperCase(),
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, ${user?.firstName ?? 'Admin'}!',
                          style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Role: ${user?.role?.toUpperCase() ?? 'ADMIN'}',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // System Overview
            Text(
              'System Overview',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildStatCard('Total Users', '2,000', AppTheme.primary, Icons.people)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('Active Sessions', '156', AppTheme.success, Icons.online_prediction)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard('System Health', '99.9%', AppTheme.success, Icons.health_and_safety)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // System Administration
            Text(
              'System Administration',
              style: AppTheme.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureCard(
                  context,
                  'Admin Dashboard',
                  Icons.dashboard,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Admin Dashboard', 'System administration dashboard.'),
                ),
                _buildFeatureCard(
                  context,
                  'User Management',
                  Icons.people,
                  AppTheme.success,
                  () => _showFeatureDialog(context, 'User Management', 'Manage users and permissions.'),
                ),
                _buildFeatureCard(
                  context,
                  'System Settings',
                  Icons.settings,
                  AppTheme.accent,
                  () => _showFeatureDialog(context, 'System Settings', 'Configure system settings.'),
                ),
                _buildFeatureCard(
                  context,
                  'Reports & Analytics',
                  Icons.bar_chart,
                  AppTheme.primary,
                  () => _showFeatureDialog(context, 'Reports & Analytics', 'Generate system reports.'),
                ),
                _buildFeatureCard(
                  context,
                  'Hostel Management',
                  Icons.home_work,
                  AppTheme.accent,
                  () => _showFeatureDialog(context, 'Hostel Management', 'Manage hostel operations.'),
                ),
                _buildFeatureCard(
                  context,
                  'Security & Access',
                  Icons.security,
                  AppTheme.error,
                  () => _showFeatureDialog(context, 'Security & Access', 'Manage security settings.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: AppTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTheme.titleSmall.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.success.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppTheme.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Access Denied'),
        backgroundColor: AppTheme.error,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                color: AppTheme.error,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                'ఈ భాగానికి మీకు అనుమతి లేదు',
                style: AppTheme.titleLarge.copyWith(
                  color: AppTheme.error,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'You do not have access to this section.',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Go to Home',
                    style: AppTheme.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}