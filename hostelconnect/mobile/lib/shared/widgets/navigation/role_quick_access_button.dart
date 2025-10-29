import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_provider.dart';

class RoleQuickAccessButton extends ConsumerWidget {
  const RoleQuickAccessButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).role?.toLowerCase() ?? 'student';
    return FloatingActionButton.extended(
      onPressed: () => _showQuickAccess(context, role),
      icon: const Icon(Icons.grid_view_rounded),
      label: const Text('Quick Access'),
    );
  }

  void _showQuickAccess(BuildContext context, String role) {
    final items = _itemsForRole(role);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: items.map((e) => _QuickTile(item: e)).toList(),
        ),
      ),
    );
  }

  List<_QuickItem> _itemsForRole(String role) {
    switch (role) {
      case 'super_admin':
      case 'admin':
        return [
          _QuickItem(Icons.people, 'Users', '/users'),
          _QuickItem(Icons.dashboard, 'Dashboards', '/admin'),
          _QuickItem(Icons.restaurant_menu, 'Kitchen', '/kitchen'),
          _QuickItem(Icons.campaign, 'Broadcast', '/broadcast'),
          _QuickItem(Icons.receipt_long, 'Reports', '/reports'),
        ];
      case 'warden_head':
      case 'warden':
        return [
          _QuickItem(Icons.badge, 'Gate Pass', '/gate-pass/scanner'),
          _QuickItem(Icons.analytics, 'Reports', '/reports'),
          _QuickItem(Icons.restaurant_menu, 'Meal Overrides', '/meal-overrides'),
        ];
      case 'chef':
      case 'kitchen_incharge':
        return [
          _QuickItem(Icons.dashboard, 'Kitchen', '/kitchen'),
          _QuickItem(Icons.analytics, 'Reports', '/reports'),
        ];
      default:
        return [
          _QuickItem(Icons.restaurant, 'Meals', '/student'),
          _QuickItem(Icons.notifications, 'Notices', '/notices'),
          _QuickItem(Icons.lock_clock, 'Gate Pass', '/gate-pass/request'),
        ];
    }
  }
}

class _QuickItem {
  final IconData icon;
  final String label;
  final String route;
  const _QuickItem(this.icon, this.label, this.route);
}

class _QuickTile extends StatelessWidget {
  final _QuickItem item;
  const _QuickTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, item.route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon),
            const SizedBox(height: 8),
            Text(item.label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}


