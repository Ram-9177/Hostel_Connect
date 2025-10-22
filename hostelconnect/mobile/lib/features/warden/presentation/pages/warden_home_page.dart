// lib/features/warden/presentation/pages/warden_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/app_state.dart';

class WardenHomePage extends ConsumerWidget {
  const WardenHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Warden Dashboard - ${user?.firstName ?? 'Warden'}'),
        backgroundColor: Colors.green,
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
              'Warden Quick Access',
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
                  'Gate Scanner',
                  Icons.qr_code_scanner,
                  Colors.blue,
                  () => context.go('/gate-pass/scanner'),
                ),
                _buildQuickAccessCard(
                  context,
                  'Attendance',
                  Icons.person_check,
                  Colors.green,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Gate Passes',
                  Icons.list_alt,
                  Colors.orange,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Reports',
                  Icons.analytics,
                  Colors.purple,
                  () => _showComingSoon(context),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Active Gate Passes
            const Text(
              'Active Gate Passes',
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
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: Text('John Student'),
                      subtitle: Text('Roll: 2024001 - Going out for medical'),
                      trailing: Text('2h ago'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.person, color: Colors.green),
                      title: Text('Jane Student'),
                      subtitle: Text('Roll: 2024002 - Library visit'),
                      trailing: Text('1h ago'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.person, color: Colors.orange),
                      title: Text('Mike Student'),
                      subtitle: Text('Roll: 2024003 - Family visit'),
                      trailing: Text('30m ago'),
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
