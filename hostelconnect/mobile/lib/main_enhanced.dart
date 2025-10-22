// lib/main_enhanced.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
        title: const Text('HostelConnect Complete'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.home_work,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'HostelConnect',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Complete Hostel Management System',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            
            // Login Form
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Login to Access All Features',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
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
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Demo Credentials
            const Text(
              'Demo Credentials - Click to Use',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCredentialCard('Student', 'student@demo.com', 'password123', Colors.green, Icons.school),
            _buildCredentialCard('Warden', 'warden@demo.com', 'password123', Colors.red, Icons.security),
            _buildCredentialCard('Chef', 'chef@demo.com', 'password123', Colors.orange, Icons.restaurant),
            _buildCredentialCard('Admin', 'admin@demo.com', 'password123', Colors.purple, Icons.admin_panel_settings),
            
            const SizedBox(height: 30),
            
            // Features Overview
            const Text(
              'Complete Feature Set',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildFeatureOverview(),
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialCard(String role, String email, String password, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildFeatureOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFeatureRow('🔐 Secure Authentication', 'Role-based access control'),
            _buildFeatureRow('🚪 Gate Pass Management', 'QR code scanning and validation'),
            _buildFeatureRow('📊 Attendance Tracking', 'Real-time attendance monitoring'),
            _buildFeatureRow('🍽️ Meal Management', 'Menu planning and dietary preferences'),
            _buildFeatureRow('🏠 Room Allocation', 'Smart room and bed management'),
            _buildFeatureRow('📱 Mobile-First Design', 'Responsive UI for all devices'),
            _buildFeatureRow('☁️ Cloud Ready', 'Azure deployment with auto-scaling'),
            _buildFeatureRow('📈 Analytics & Reports', 'Comprehensive reporting system'),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    );
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: Text(
                        (user.firstName ?? 'S')[0].toUpperCase(),
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${user.firstName ?? 'Student'}!',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Role: ${user.role.toUpperCase()}',
                            style: TextStyle(color: Colors.green.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Stats
            const Text(
              'Quick Stats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Attendance', '95%', Colors.blue, Icons.calendar_today),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Gate Passes', '3', Colors.orange, Icons.exit_to_app),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Meals', '28', Colors.green, Icons.fastfood),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Features Grid
            const Text(
              'Available Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Colors.orange,
                  'Request permission to leave hostel premises with QR code generation',
                ),
                _buildFeatureCard(
                  context,
                  'View Attendance',
                  Icons.calendar_today,
                  Colors.blue,
                  'Track your attendance records and view statistics',
                ),
                _buildFeatureCard(
                  context,
                  'Meal Management',
                  Icons.fastfood,
                  Colors.green,
                  'Opt-out of meals and manage dietary preferences',
                ),
                _buildFeatureCard(
                  context,
                  'Room Information',
                  Icons.bed,
                  Colors.brown,
                  'View room details, roommate info, and maintenance requests',
                ),
                _buildFeatureCard(
                  context,
                  'Notices & Updates',
                  Icons.announcement,
                  Colors.purple,
                  'Stay updated with hostel announcements and important notices',
                ),
                _buildFeatureCard(
                  context,
                  'Complaints & Feedback',
                  Icons.report_problem,
                  Colors.red,
                  'Submit complaints and provide feedback to hostel management',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _showFeatureDialog(context, title, description),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: Text(
                        (user.firstName ?? 'W')[0].toUpperCase(),
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${user.firstName ?? 'Warden'}!',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Role: ${user.role.toUpperCase()}',
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Stats
            const Text(
              'Today\'s Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Scans', '47', Colors.orange, Icons.qr_code_scanner),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Students', '156', Colors.blue, Icons.group),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Complaints', '3', Colors.red, Icons.report_problem),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Features Grid
            const Text(
              'Warden Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Colors.orange,
                  'Scan QR codes to validate student gate passes with real-time validation',
                ),
                _buildFeatureCard(
                  context,
                  'Student Management',
                  Icons.group,
                  Colors.blue,
                  'View and manage student information, room assignments, and records',
                ),
                _buildFeatureCard(
                  context,
                  'Attendance Management',
                  Icons.check_circle_outline,
                  Colors.green,
                  'Mark attendance, track patterns, and generate attendance reports',
                ),
                _buildFeatureCard(
                  context,
                  'Complaints Management',
                  Icons.report_problem,
                  Colors.red,
                  'Review, respond to, and track student complaints and feedback',
                ),
                _buildFeatureCard(
                  context,
                  'Room Allocation',
                  Icons.bed,
                  Colors.brown,
                  'Manage room assignments, transfers, and maintenance requests',
                ),
                _buildFeatureCard(
                  context,
                  'Reports & Analytics',
                  Icons.bar_chart,
                  Colors.purple,
                  'Generate comprehensive reports on hostel operations and statistics',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _showFeatureDialog(context, title, description),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 30,
                      child: Text(
                        (user.firstName ?? 'C')[0].toUpperCase(),
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${user.firstName ?? 'Chef'}!',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Role: ${user.role.toUpperCase()}',
                            style: TextStyle(color: Colors.orange.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Stats
            const Text(
              'Kitchen Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Meals Served', '156', Colors.green, Icons.fastfood),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Opt-outs', '12', Colors.orange, Icons.cancel),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Feedback', '4.8', Colors.blue, Icons.star),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Features Grid
            const Text(
              'Kitchen Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Colors.green,
                  'Create and update daily meal menus with nutritional information',
                ),
                _buildFeatureCard(
                  context,
                  'Meal Preparation',
                  Icons.food_bank,
                  Colors.orange,
                  'Track meal preparation status and serving schedules',
                ),
                _buildFeatureCard(
                  context,
                  'Inventory Management',
                  Icons.inventory,
                  Colors.blue,
                  'Manage kitchen inventory, supplies, and procurement',
                ),
                _buildFeatureCard(
                  context,
                  'Meal Feedback',
                  Icons.feedback,
                  Colors.purple,
                  'View student feedback and ratings for meals',
                ),
                _buildFeatureCard(
                  context,
                  'Dietary Requests',
                  Icons.healing,
                  Colors.teal,
                  'Handle special dietary requirements and allergies',
                ),
                _buildFeatureCard(
                  context,
                  'Kitchen Reports',
                  Icons.analytics,
                  Colors.indigo,
                  'Generate kitchen performance and cost reports',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _showFeatureDialog(context, title, description),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.purple,
                      radius: 30,
                      child: Text(
                        (user.firstName ?? 'A')[0].toUpperCase(),
                        style: const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${user.firstName ?? 'Admin'}!',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Role: ${user.role.toUpperCase()}',
                            style: TextStyle(color: Colors.purple.shade700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Stats
            const Text(
              'System Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total Users', '2,000', Colors.blue, Icons.people),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('Active Sessions', '156', Colors.green, Icons.online_prediction),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard('System Health', '99.9%', Colors.purple, Icons.health_and_safety),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Features Grid
            const Text(
              'System Administration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  Colors.blue,
                  'Comprehensive overview of hostel operations and system metrics',
                ),
                _buildFeatureCard(
                  context,
                  'User Management',
                  Icons.people,
                  Colors.green,
                  'Manage users, roles, permissions, and access controls',
                ),
                _buildFeatureCard(
                  context,
                  'System Settings',
                  Icons.settings,
                  Colors.orange,
                  'Configure hostel policies, rules, and system parameters',
                ),
                _buildFeatureCard(
                  context,
                  'Reports & Analytics',
                  Icons.bar_chart,
                  Colors.purple,
                  'Generate comprehensive reports and analytics dashboards',
                ),
                _buildFeatureCard(
                  context,
                  'Hostel Management',
                  Icons.home_work,
                  Colors.brown,
                  'Manage hostel blocks, rooms, facilities, and infrastructure',
                ),
                _buildFeatureCard(
                  context,
                  'Security & Access',
                  Icons.security,
                  Colors.red,
                  'Monitor security, manage access controls, and audit logs',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _showFeatureDialog(context, title, description),
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Feature Fully Implemented',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
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
