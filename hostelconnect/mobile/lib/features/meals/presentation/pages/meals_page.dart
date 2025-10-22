// lib/features/meals/presentation/pages/meals_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/meal_models.dart';
import '../../../../core/providers/meal_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../widgets/daily_meal_prompt_widget.dart';
import '../widgets/chef_board_widget.dart';
import '../widgets/meal_override_widget.dart';

class MealsPage extends ConsumerStatefulWidget {
  const MealsPage({super.key});

  @override
  ConsumerState<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends ConsumerState<MealsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1'; // TODO: Get from auth context
  String _selectedStudentId = 'student_1'; // TODO: Get from auth context

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
    final dashboardData = ref.watch(mealDashboardProvider(_selectedHostelId));
    final cutoffStatus = ref.watch(cutoffStatusProvider(_selectedHostelId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Meal Management'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(mealDashboardProvider(_selectedHostelId));
              ref.invalidate(cutoffStatusProvider(_selectedHostelId));
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'My Meals', icon: Icon(Icons.restaurant)),
            Tab(text: 'Overrides', icon: Icon(Icons.edit)),
            Tab(text: 'Chef Board', icon: Icon(Icons.dashboard)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyMealsTab(),
          _buildOverridesTab(),
          _buildChefBoardTab(),
        ],
      ),
    );
  }

  Widget _buildMyMealsTab() {
    final cutoffStatus = ref.watch(cutoffStatusProvider(_selectedHostelId));
    final todayIntents = ref.watch(todayMealIntentsProvider(_selectedStudentId));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(cutoffStatusProvider(_selectedHostelId));
        ref.invalidate(todayMealIntentsProvider(_selectedStudentId));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Daily Meal Prompt
            DailyMealPromptWidget(
              studentId: _selectedStudentId,
              hostelId: _selectedHostelId,
              date: DateTime.now(),
              onIntentsSubmitted: () {
                ref.invalidate(todayMealIntentsProvider(_selectedStudentId));
                ref.invalidate(mealDashboardProvider(_selectedHostelId));
              },
            ),
            
            // Cutoff Status
            if (cutoffStatus.data != null)
              _buildCutoffStatusCard(cutoffStatus.data!),
            
            // Today's Intents Summary
            if (todayIntents.data?.isNotEmpty == true)
              _buildIntentsSummaryCard(todayIntents.data!),
            
            // Meal Forecasts
            _buildForecastsCard(),
            
            // Meal History
            _buildMealHistoryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverridesTab() {
    final overrides = ref.watch(todayMealOverridesProvider(_selectedHostelId));
    final forecasts = ref.watch(todayMealForecastsProvider(_selectedHostelId));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(todayMealOverridesProvider(_selectedHostelId));
        ref.invalidate(todayMealForecastsProvider(_selectedHostelId));
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add Override Widget
            MealOverrideWidget(
              hostelId: _selectedHostelId,
              date: DateTime.now(),
              onOverrideAdded: () {
                ref.invalidate(todayMealOverridesProvider(_selectedHostelId));
                ref.invalidate(todayMealForecastsProvider(_selectedHostelId));
                ref.invalidate(mealDashboardProvider(_selectedHostelId));
              },
            ),
            
            // Current Overrides
            if (overrides.data?.isNotEmpty == true)
              _buildOverridesListCard(overrides.data!),
            
            // Forecast Impact
            if (forecasts.data?.isNotEmpty == true)
              _buildForecastImpactCard(forecasts.data!),
          ],
        ),
      ),
    );
  }

  Widget _buildChefBoardTab() {
    return ChefBoardWidget(
      hostelId: _selectedHostelId,
      date: DateTime.now(),
    );
  }

  Widget _buildCutoffStatusCard(Map<MealType, bool> cutoffStatus) {
    final cutoffPassed = cutoffStatus.values.any((passed) => passed);
    
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    cutoffPassed ? Icons.access_time : Icons.schedule,
                    color: cutoffPassed ? IOSGradeTheme.warning : IOSGradeTheme.success,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Cutoff Status',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (cutoffPassed) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: IOSGradeTheme.warning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: IOSGradeTheme.warning.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: IOSGradeTheme.warning,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Cutoff time (8:00 PM IST) has passed for some meals',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.warning,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: IOSGradeTheme.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: IOSGradeTheme.success.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: IOSGradeTheme.success,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'All meal intents can still be submitted',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Individual meal status
              ...cutoffStatus.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        entry.key.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          entry.key.displayName,
                          style: IOSGradeTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: entry.value 
                              ? IOSGradeTheme.warning.withOpacity(0.1)
                              : IOSGradeTheme.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: entry.value 
                                ? IOSGradeTheme.warning
                                : IOSGradeTheme.success,
                          ),
                        ),
                        child: Text(
                          entry.value ? 'Cutoff Passed' : 'Open',
                          style: IOSGradeTheme.caption1.copyWith(
                            color: entry.value 
                                ? IOSGradeTheme.warning
                                : IOSGradeTheme.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntentsSummaryCard(List<MealIntent> intents) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: IOSGradeTheme.success,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Today\'s Meal Intents',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              ...intents.map((intent) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        intent.mealType.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          intent.mealType.displayName,
                          style: IOSGradeTheme.bodyMedium,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: intent.willEat 
                              ? IOSGradeTheme.success.withOpacity(0.1)
                              : IOSGradeTheme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: intent.willEat 
                                ? IOSGradeTheme.success
                                : IOSGradeTheme.error,
                          ),
                        ),
                        child: Text(
                          intent.willEat ? 'Will Eat' : 'Won\'t Eat',
                          style: IOSGradeTheme.caption1.copyWith(
                            color: intent.willEat 
                                ? IOSGradeTheme.success
                                : IOSGradeTheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastsCard() {
    final forecasts = ref.watch(todayMealForecastsProvider(_selectedHostelId));

    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics,
                    color: IOSGradeTheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Today\'s Forecasts',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (forecasts.state == LoadState.loading)
                const Center(child: CircularProgressIndicator())
              else if (forecasts.state == LoadState.error)
                Center(
                  child: Text(
                    'Failed to load forecasts',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                )
              else if (forecasts.data?.isEmpty ?? true)
                Center(
                  child: Text(
                    'No forecasts available',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                )
              else
                ...forecasts.data!.map((forecast) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          forecast.mealType.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                forecast.mealType.displayName,
                                style: IOSGradeTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${forecast.finalCount} meals forecasted',
                                style: IOSGradeTheme.bodySmall.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${forecast.attendancePercentage.toStringAsFixed(1)}%',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealHistoryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: IOSGradeTheme.textSecondary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Recent Meal History',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Center(
                child: Text(
                  'Meal history will be displayed here',
                  style: IOSGradeTheme.bodyMedium.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverridesListCard(List<MealOverride> overrides) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: IOSGradeTheme.warning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Current Overrides',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              ...overrides.map((override) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: IOSGradeTheme.warning.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          override.mealType.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${override.mealType.displayName}: +${override.additionalCount} meals',
                                style: IOSGradeTheme.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                override.reason,
                                style: IOSGradeTheme.bodySmall.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _formatTime(override.overriddenAt),
                          style: IOSGradeTheme.caption1.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastImpactCard(List<MealForecast> forecasts) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: IOSGradeCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: IOSGradeTheme.info,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Forecast Impact',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              ...forecasts.map((forecast) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        forecast.mealType.emoji,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              forecast.mealType.displayName,
                              style: IOSGradeTheme.bodyMedium.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Final: ${forecast.finalCount} (${forecast.overrideCount} overrides)',
                              style: IOSGradeTheme.bodySmall.copyWith(
                                color: IOSGradeTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (forecast.isOverCapacity)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: IOSGradeTheme.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: IOSGradeTheme.error,
                            ),
                          ),
                          child: Text(
                            'Over Capacity',
                            style: IOSGradeTheme.caption1.copyWith(
                              color: IOSGradeTheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}