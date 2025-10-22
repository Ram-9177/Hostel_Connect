// lib/features/admin/presentation/pages/admin_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/app_state.dart';

class AdminHomePage extends ConsumerWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard - ${user?.firstName ?? 'Admin'}'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Access Cards
            const Text(
              'Admin Quick Access',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildQuickAccessCard(
                  context,
                  'User Management',
                  Icons.people,
                  Colors.blue,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'System Reports',
                  Icons.analytics,
                  Colors.green,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Settings',
                  Icons.settings,
                  Colors.orange,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Gate Scanner',
                  Icons.qr_code_scanner,
                  Colors.red,
                  () => context.go('/gate-pass/scanner'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // System Overview
            const Text(
              'System Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.people, color: Colors.blue),
                      title: Text('Total Students'),
                      subtitle: Text('Active students in hostel'),
                      trailing: Text('1,250'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.orange),
                      title: Text('Active Gate Passes'),
                      subtitle: Text('Students currently outside'),
                      trailing: Text('45'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.restaurant, color: Colors.green),
                      title: Text('Meals Served Today'),
                      subtitle: Text('Breakfast, Lunch, Dinner'),
                      trailing: Text('3,750'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.report_problem, color: Colors.red),
                      title: Text('Pending Complaints'),
                      subtitle: Text('Issues requiring attention'),
                      trailing: Text('12'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _logout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authStateProvider.notifier).logout();
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
