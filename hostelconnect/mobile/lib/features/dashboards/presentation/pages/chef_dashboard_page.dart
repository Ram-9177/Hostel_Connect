import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/core/navigation/navigation_service.dart';
import 'package:hostelconnect/features/dashboards/presentation/widgets/dash_tile.dart';
import 'package:hostelconnect/shared/widgets/ui/card.dart';
import 'package:hostelconnect/shared/widgets/ui/button.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class ChefDashboardPage extends ConsumerStatefulWidget {
  const ChefDashboardPage({super.key});

  @override
  ConsumerState<ChefDashboardPage> createState() => _ChefDashboardPageState();
}

class _ChefDashboardPageState extends ConsumerState<ChefDashboardPage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _metricsController;
  late AnimationController _activityController;
  
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _metricsFadeAnimation;
  late Animation<Offset> _metricsSlideAnimation;
  late Animation<double> _activityFadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Header animations
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    ));
    
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));
    
    // Metrics animations
    _metricsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _metricsFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _metricsController,
      curve: Curves.easeOut,
    ));
    
    _metricsSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _metricsController,
      curve: Curves.easeOutCubic,
    ));
    
    // Activity animations
    _activityController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _activityFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _activityController,
      curve: Curves.easeOut,
    ));
    
    // Start animations
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _metricsController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _activityController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _metricsController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final user = appState.user;
    
    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HTokens.warning.withOpacity(0.05),
                Colors.transparent,
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 1.0],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(HTokens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced Header Stats
                AnimatedBuilder(
                  animation: _headerController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _headerFadeAnimation,
                      child: SlideTransition(
                        position: _headerSlideAnimation,
                        child: HCard(
                          backgroundColor: Colors.white,
                          elevation: 8,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(HTokens.xl),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  HTokens.warning,
                                  HTokens.warning.withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(HTokens.md),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.restaurant_menu_rounded,
                                        color: Colors.white,
                                        size: r.isXS ? 24 : 28,
                                      ),
                                    ),
                                    SizedBox(width: HTokens.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Kitchen Dashboard',
                                            style: TextStyle(
                                              fontSize: r.isXS ? 20 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: HTokens.xs),
                                          Text(
                                            'Welcome, ${user?.firstName ?? 'Chef'}!',
                                            style: TextStyle(
                                              fontSize: r.isXS ? 14 : 16,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(HTokens.sm),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.schedule,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: HTokens.lg),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildStatItem('Breakfast', '142', Colors.white, Icons.free_breakfast),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildStatItem('Lunch', '156', Colors.white, Icons.lunch_dining),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildStatItem('Dinner', '134', Colors.white, Icons.dinner_dining),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Quick Actions
                HCard(
                  backgroundColor: HTokens.warning.withOpacity(0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.restaurant_menu, color: HTokens.warning),
                          SizedBox(width: HTokens.sm),
                          Text(
                            'Kitchen Actions',
                            style: TextStyle(
                              fontSize: r.isXS ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: HTokens.warning,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: HTokens.md),
                      Row(
                        children: [
                          Expanded(
                            child: HButton(
                              text: 'Meal Planning',
                              variant: HButtonVariant.primary,
                              icon: Icons.menu_book,
                              onPressed: () {
                                NavigationService.navigateToMealPlanningWithGuard(context);
                              },
                            ),
                          ),
                          SizedBox(width: HTokens.sm),
                          Expanded(
                            child: HButton(
                              text: 'Inventory',
                              variant: HButtonVariant.outline,
                              icon: Icons.inventory,
                              onPressed: () {
                                NavigationService.navigateToInventoryWithGuard(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: HTokens.sm),
                      Row(
                        children: [
                          Expanded(
                            child: HButton(
                              text: 'Dietary Requests',
                              variant: HButtonVariant.outline,
                              icon: Icons.healing,
                              onPressed: () {
                                NavigationService.navigateToDietaryRequests(context);
                              },
                            ),
                          ),
                          SizedBox(width: HTokens.sm),
                          Expanded(
                            child: HButton(
                              text: 'Reports',
                              variant: HButtonVariant.outline,
                              icon: Icons.assessment,
                              onPressed: () {
                                NavigationService.navigateToReports(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Enhanced Dashboard Metrics
                Text(
                  'Meal Statistics',
                  style: TextStyle(
                    fontSize: r.isXS ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: HTokens.onSurface,
                  ),
                ),
                SizedBox(height: HTokens.md),
                
                AnimatedBuilder(
                  animation: _metricsController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _metricsFadeAnimation,
                      child: SlideTransition(
                        position: _metricsSlideAnimation,
                        child: HDashGrid(
                          tiles: [
                            DashTile(
                              title: 'Today\'s Meals',
                              value: '432',
                              updatedAt: 'Live',
                              trailing: Icon(Icons.restaurant, color: HTokens.success),
                              color: HTokens.success,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Dietary Requests',
                              value: '12',
                              updatedAt: '2 min ago',
                              trailing: Icon(Icons.healing, color: HTokens.warning),
                              color: HTokens.warning,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Inventory Low',
                              value: '5',
                              updatedAt: '1 hour ago',
                              trailing: Icon(Icons.warning, color: HTokens.error),
                              color: HTokens.error,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Satisfaction Rate',
                              value: '94%',
                              updatedAt: 'Today',
                              trailing: Icon(Icons.thumb_up, color: HTokens.success),
                              color: HTokens.success,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Enhanced Recent Activity
                Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: r.isXS ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: HTokens.onSurface,
                  ),
                ),
                SizedBox(height: HTokens.md),
                
                AnimatedBuilder(
                  animation: _activityController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _activityFadeAnimation,
                      child: HCard(
                        child: Column(
                          children: [
                            _buildActivityItem(
                              'Breakfast service completed',
                              '2 hours ago',
                              Icons.check_circle,
                              HTokens.success,
                              'All 142 students served breakfast successfully',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'New dietary request',
                              '30 min ago',
                              Icons.healing,
                              HTokens.warning,
                              'Student requested gluten-free meal for lunch',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Inventory alert',
                              '1 hour ago',
                              Icons.warning,
                              HTokens.error,
                              'Rice stock running low - need to reorder',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Lunch preparation started',
                              '3 hours ago',
                              Icons.restaurant,
                              HTokens.info,
                              'Preparing lunch for 156 students',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Meal Schedule
                HCard(
                  backgroundColor: HTokens.info.withOpacity(0.05),
                  child: Padding(
                    padding: EdgeInsets.all(HTokens.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.schedule, color: HTokens.info),
                            SizedBox(width: HTokens.sm),
                            Text(
                              'Today\'s Meal Schedule',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HTokens.info,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: HTokens.md),
                        _buildScheduleItem('Breakfast', '7:00 AM - 9:00 AM', 'Completed', HTokens.success),
                        SizedBox(height: HTokens.sm),
                        _buildScheduleItem('Lunch', '12:00 PM - 2:00 PM', 'In Progress', HTokens.warning),
                        SizedBox(height: HTokens.sm),
                        _buildScheduleItem('Snacks', '4:00 PM - 5:00 PM', 'Upcoming', HTokens.info),
                        SizedBox(height: HTokens.sm),
                        _buildScheduleItem('Dinner', '7:00 PM - 9:00 PM', 'Upcoming', HTokens.info),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(height: HTokens.xs),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(HTokens.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HTokens.cardRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: HTokens.md, vertical: HTokens.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              SizedBox(width: HTokens.xs),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: HTokens.md),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(HTokens.sm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: HTokens.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: HTokens.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: HTokens.xs),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: HTokens.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String meal, String time, String status, Color statusColor) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            meal,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: HTokens.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: HTokens.sm, vertical: HTokens.xs),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: statusColor,
            ),
          ),
        ),
      ],
    );
  }
}
