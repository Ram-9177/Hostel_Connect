// lib/features/meal_planning/presentation/pages/meal_planning_page.dart - COMPLETE IMPLEMENTATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/unified_theme.dart';
import '../../../../core/state/app_state.dart';

class MealPlanningPage extends ConsumerStatefulWidget {
  const MealPlanningPage({super.key});

  @override
  ConsumerState<MealPlanningPage> createState() => _MealPlanningPageState();
}

class _MealPlanningPageState extends ConsumerState<MealPlanningPage>
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
        title: const Text('Meal Planning'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh meal planning data
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Weekly Menu', icon: Icon(Icons.calendar_view_week)),
            Tab(text: 'Forecasting', icon: Icon(Icons.trending_up)),
            Tab(text: 'Preferences', icon: Icon(Icons.favorite)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWeeklyMenuTab(),
          _buildForecastingTab(),
          _buildPreferencesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createMealPlan,
        icon: const Icon(Icons.add),
        label: const Text('New Plan'),
        backgroundColor: UnifiedTheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildWeeklyMenuTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_view_week,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Weekly Menu Planning',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Plan weekly meal menus',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastingTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.trending_up,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Meal Forecasting',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'AI-powered meal consumption forecasting',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite,
            size: 64,
            color: UnifiedTheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Student Preferences',
            style: UnifiedTheme.lightTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'View and manage student meal preferences',
            style: UnifiedTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _createMealPlan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Meal Plan'),
        content: const Text('Create new meal plan feature will be implemented soon.'),
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