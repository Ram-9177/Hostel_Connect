// lib/features/chef/presentation/pages/chef_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/app_state.dart';

class ChefHomePage extends ConsumerWidget {
  const ChefHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Dashboard - ${user?.firstName ?? 'Chef'}'),
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
              'Chef Quick Access',
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
                  'Meal Planning',
                  Icons.restaurant_menu,
                  Colors.orange,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Inventory',
                  Icons.inventory,
                  Colors.blue,
                  () => _showComingSoon(context),
                ),
                _buildQuickAccessCard(
                  context,
                  'Orders',
                  Icons.shopping_cart,
                  Colors.green,
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
            
            // Today's Menu
            const Text(
              'Today\'s Menu',
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
                      leading: Icon(Icons.wb_sunny, color: Colors.orange),
                      title: Text('Breakfast'),
                      subtitle: Text('8:00 AM - 9:30 AM'),
                      trailing: Text('1,250 served'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.wb_sunny_outlined, color: Colors.yellow),
                      title: Text('Lunch'),
                      subtitle: Text('12:30 PM - 2:00 PM'),
                      trailing: Text('1,200 served'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.nightlight_round, color: Colors.indigo),
                      title: Text('Dinner'),
                      subtitle: Text('7:30 PM - 9:00 PM'),
                      trailing: Text('1,180 served'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Meal Statistics
            const Text(
              'Meal Statistics',
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
                      leading: Icon(Icons.trending_up, color: Colors.green),
                      title: Text('Total Meals Today'),
                      subtitle: Text('Breakfast + Lunch + Dinner'),
                      trailing: Text('3,630'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.people, color: Colors.blue),
                      title: Text('Opt-outs'),
                      subtitle: Text('Students who skipped meals'),
                      trailing: Text('45'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.warning, color: Colors.orange),
                      title: Text('Special Requests'),
                      subtitle: Text('Dietary requirements'),
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
