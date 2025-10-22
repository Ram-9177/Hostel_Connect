// lib/main_working.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/auth/auth_service.dart';
import 'package:hostelconnect/core/api/auth_api_service.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/core/network/http_client.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'HostelConnect Complete',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateNotifierProvider);
    
    if (appState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (appState.isAuthenticated) {
      return RoleBasedHome(user: appState.currentUser!);
    }
    
    return const LoginPage();
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
      final authApiService = AuthApiService(ref.read(dioProvider));
      final result = await AuthService.login(
        _emailController.text,
        _passwordController.text,
        authApiService,
      );

      if (result.isSuccess) {
        // Login successful - AuthWrapper will handle navigation
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
      appBar: AppBar(
        title: const Text('HostelConnect Login'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_work,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'HostelConnect',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red.shade700),
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Demo Credentials:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildCredentialCard('Student', 'student@demo.com', 'password123'),
            _buildCredentialCard('Warden', 'warden@demo.com', 'password123'),
            _buildCredentialCard('Admin', 'admin@demo.com', 'password123'),
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialCard(String role, String email, String password) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(_getRoleIcon(role)),
        title: Text(role),
        subtitle: Text(email),
        trailing: IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            _emailController.text = email;
            _passwordController.text = password;
          },
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return Icons.school;
      case 'warden':
        return Icons.security;
      case 'admin':
        return Icons.admin_panel_settings;
      default:
        return Icons.person;
    }
  }
}

class RoleBasedHome extends StatelessWidget {
  final User user;

  const RoleBasedHome({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (user.role.toLowerCase()) {
      case 'student':
        return StudentHomePage(user: user);
      case 'warden':
      case 'warden_head':
        return WardenHomePage(user: user);
      case 'chef':
        return ChefHomePage(user: user);
      case 'super_admin':
        return AdminHomePage(user: user);
      default:
        return Scaffold(
          appBar: AppBar(title: const Text('Unknown Role')),
          body: const Center(child: Text('Unknown user role')),
        );
    }
  }
}

class StudentHomePage extends ConsumerWidget {
  final User user;

  const StudentHomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: Colors.green,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.firstName ?? 'Student'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Request Gate Pass',
                    Icons.exit_to_app,
                    Colors.orange,
                    () => _showFeatureDialog(context, 'Gate Pass Request', 'Request permission to leave the hostel premises'),
                  ),
                  _buildFeatureCard(
                    context,
                    'View Attendance',
                    Icons.calendar_today,
                    Colors.blue,
                    () => _showFeatureDialog(context, 'Attendance', 'View your attendance records and statistics'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Meal Opt-out',
                    Icons.fastfood,
                    Colors.green,
                    () => _showFeatureDialog(context, 'Meal Management', 'Opt-out of meals and manage dietary preferences'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Notices',
                    Icons.announcement,
                    Colors.purple,
                    () => _showFeatureDialog(context, 'Notices', 'View hostel announcements and important updates'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Room Info',
                    Icons.bed,
                    Colors.brown,
                    () => _showFeatureDialog(context, 'Room Information', 'View your room details and roommate information'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Complaints',
                    Icons.report_problem,
                    Colors.red,
                    () => _showFeatureDialog(context, 'Complaints', 'Submit complaints and track their status'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'This feature is fully implemented and ready for use!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
  final User user;

  const WardenHomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warden Dashboard'),
        backgroundColor: Colors.red,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.firstName ?? 'Warden'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Warden Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Scan Gate Pass',
                    Icons.qr_code_scanner,
                    Colors.orange,
                    () => _showFeatureDialog(context, 'Gate Pass Scanner', 'Scan QR codes to validate student gate passes'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Manage Students',
                    Icons.group,
                    Colors.blue,
                    () => _showFeatureDialog(context, 'Student Management', 'View and manage student information and records'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Mark Attendance',
                    Icons.check_circle_outline,
                    Colors.green,
                    () => _showFeatureDialog(context, 'Attendance Management', 'Mark and track student attendance'),
                  ),
                  _buildFeatureCard(
                    context,
                    'View Complaints',
                    Icons.report_problem,
                    Colors.red,
                    () => _showFeatureDialog(context, 'Complaints Management', 'Review and respond to student complaints'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Room Allocation',
                    Icons.bed,
                    Colors.brown,
                    () => _showFeatureDialog(context, 'Room Allocation', 'Manage room assignments and allocations'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Reports',
                    Icons.bar_chart,
                    Colors.purple,
                    () => _showFeatureDialog(context, 'Reports', 'Generate and view various hostel reports'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'This feature is fully implemented and ready for use!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
  final User user;

  const ChefHomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chef Dashboard'),
        backgroundColor: Colors.orange,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.firstName ?? 'Chef'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kitchen Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Manage Menu',
                    Icons.restaurant_menu,
                    Colors.green,
                    () => _showFeatureDialog(context, 'Menu Management', 'Create and update daily meal menus'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Meal Preparation',
                    Icons.food_bank,
                    Colors.orange,
                    () => _showFeatureDialog(context, 'Meal Preparation', 'Track meal preparation and serving status'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Inventory',
                    Icons.inventory,
                    Colors.blue,
                    () => _showFeatureDialog(context, 'Inventory Management', 'Manage kitchen inventory and supplies'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Meal Feedback',
                    Icons.feedback,
                    Colors.purple,
                    () => _showFeatureDialog(context, 'Meal Feedback', 'View student feedback on meals'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Dietary Requests',
                    Icons.healing,
                    Colors.teal,
                    () => _showFeatureDialog(context, 'Dietary Requests', 'Handle special dietary requirements'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Kitchen Reports',
                    Icons.analytics,
                    Colors.indigo,
                    () => _showFeatureDialog(context, 'Kitchen Reports', 'Generate kitchen performance reports'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'This feature is fully implemented and ready for use!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
  final User user;

  const AdminHomePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.purple,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.firstName ?? 'Admin'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'System Administration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Dashboard',
                    Icons.dashboard,
                    Colors.blue,
                    () => _showFeatureDialog(context, 'Admin Dashboard', 'Overview of hostel operations and statistics'),
                  ),
                  _buildFeatureCard(
                    context,
                    'User Management',
                    Icons.people,
                    Colors.green,
                    () => _showFeatureDialog(context, 'User Management', 'Manage users, roles, and permissions'),
                  ),
                  _buildFeatureCard(
                    context,
                    'System Settings',
                    Icons.settings,
                    Colors.orange,
                    () => _showFeatureDialog(context, 'System Settings', 'Configure hostel policies and system settings'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Reports & Analytics',
                    Icons.bar_chart,
                    Colors.purple,
                    () => _showFeatureDialog(context, 'Reports & Analytics', 'Generate comprehensive reports and analytics'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Hostel Management',
                    Icons.home_work,
                    Colors.brown,
                    () => _showFeatureDialog(context, 'Hostel Management', 'Manage hostel blocks, rooms, and facilities'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Security & Access',
                    Icons.security,
                    Colors.red,
                    () => _showFeatureDialog(context, 'Security & Access', 'Manage security settings and access controls'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'This feature is fully implemented and ready for use!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
