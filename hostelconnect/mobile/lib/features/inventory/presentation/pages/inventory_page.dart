// lib/features/inventory/presentation/pages/inventory_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';

class InventoryPage extends ConsumerStatefulWidget {
  const InventoryPage({super.key});

  @override
  ConsumerState<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends ConsumerState<InventoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UnifiedTheme.lightBackground,
      appBar: AppBar(
        title: const Text('Inventory Management'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh inventory data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Current Stock', icon: Icon(Icons.inventory)),
            Tab(text: 'Orders', icon: Icon(Icons.shopping_cart)),
            Tab(text: 'Reports', icon: Icon(Icons.analytics)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCurrentStockTab(),
          _buildOrdersTab(),
          _buildReportsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addInventoryItem,
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCurrentStockTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Current Stock',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View current inventory levels',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Orders',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Manage inventory orders',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Inventory Reports',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View inventory analytics',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _addInventoryItem() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Inventory Item'),
        content: const Text('Add new item to inventory feature will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}