import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/features/dashboards/presentation/widgets/dash_tile.dart';
import 'package:hostelconnect/shared/widgets/ui/card.dart';
import 'package:hostelconnect/shared/widgets/ui/button.dart';
import 'package:hostelconnect/shared/widgets/ui/professional_components.dart';

class StudentHomePage extends ConsumerStatefulWidget {
  const StudentHomePage({super.key});

  @override
  ConsumerState<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends ConsumerState<StudentHomePage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _tilesController;
  late AnimationController _activityController;
  
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _tilesFadeAnimation;
  late Animation<Offset> _tilesSlideAnimation;
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
    
    // Tiles animations
    _tilesController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _tilesFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _tilesController,
      curve: Curves.easeOut,
    ));
    
    _tilesSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _tilesController,
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
      _tilesController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _activityController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _tilesController.dispose();
    _activityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final user = appState.user;

    if (user == null) {
      return const Center(
        child: Text('User not found'),
      );
    }

    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HTokens.primary.withOpacity(0.05),
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
                // Enhanced Welcome Section
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
                                  HTokens.primary,
                                  HTokens.primary.withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Icons.home_work_rounded,
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
                                            'Welcome back, ${user?.firstName ?? 'Student'}!',
                                            style: TextStyle(
                                              fontSize: r.isXS ? 20 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: HTokens.xs),
                                          Text(
                                            'Room ${user?.roomId ?? '101'} • Block A',
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
                                      child: Text(
                                        DateTime.now().hour < 12 ? '🌅' : 
                                        DateTime.now().hour < 17 ? '☀️' : '🌙',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: HTokens.lg),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildQuickStat('Today', '${DateTime.now().day}', '${_getMonthName(DateTime.now().month)}'),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    Expanded(
                                      child: _buildQuickStat('Week', '${_getWeekNumber()}', 'of 52'),
                                    ),
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
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: r.isXS ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: HTokens.onSurface,
                  ),
                ),
                SizedBox(height: HTokens.md),
                
                Wrap(
                  spacing: HTokens.sm,
                  runSpacing: HTokens.sm,
                  children: [
                    _buildActionChip('Gate Pass', Icons.exit_to_app, HTokens.primary, () {}),
                    _buildActionChip('Meals', Icons.restaurant, HTokens.secondary, () {}),
                    _buildActionChip('Complaints', Icons.report_problem, HTokens.warning, () {}),
                    _buildActionChip('Profile', Icons.person, HTokens.info, () {}),
                  ],
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Enhanced Dashboard Tiles
                Text(
                  'Today\'s Overview',
                  style: TextStyle(
                    fontSize: r.isXS ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: HTokens.onSurface,
                  ),
                ),
                SizedBox(height: HTokens.md),
                
                AnimatedBuilder(
                  animation: _tilesController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _tilesFadeAnimation,
                      child: SlideTransition(
                        position: _tilesSlideAnimation,
                        child: HDashGrid(
                          tiles: [
                            DashTile(
                              title: 'Gate Pass Status',
                              value: 'Active',
                              updatedAt: '2 min ago',
                              trailing: Icon(Icons.check_circle, color: HTokens.success),
                              color: HTokens.success,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Meals Today',
                              value: '3/4',
                              updatedAt: '1 hour ago',
                              trailing: Icon(Icons.restaurant, color: HTokens.info),
                              color: HTokens.info,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Attendance',
                              value: 'Present',
                              updatedAt: '30 min ago',
                              trailing: Icon(Icons.person_pin_circle, color: HTokens.success),
                              color: HTokens.success,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Complaints',
                              value: '0',
                              updatedAt: 'Today',
                              trailing: Icon(Icons.check_circle_outline, color: HTokens.success),
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
                              'Gate pass approved',
                              '2 hours ago',
                              Icons.check_circle,
                              HTokens.success,
                              'Your gate pass request has been approved by the warden.',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Lunch meal taken',
                              '4 hours ago',
                              Icons.restaurant,
                              HTokens.info,
                              'You have successfully taken your lunch meal.',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Night attendance marked',
                              'Yesterday',
                              Icons.nightlight_round,
                              HTokens.success,
                              'Your night attendance has been marked as present.',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Emergency Actions
                HCard(
                  backgroundColor: HTokens.error.withOpacity(0.05),
                  child: Padding(
                    padding: EdgeInsets.all(HTokens.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: HTokens.error),
                            SizedBox(width: HTokens.sm),
                            Text(
                              'Emergency Actions',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: HTokens.error,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: HTokens.md),
                        Row(
                          children: [
                            Expanded(
                              child: HButton(
                                text: 'Emergency Contact',
                                variant: HButtonVariant.outline,
                                icon: Icons.phone,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: HTokens.sm),
                            Expanded(
                              child: HButton(
                                text: 'Report Issue',
                                variant: HButtonVariant.outline,
                                icon: Icons.report,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildQuickStat(String label, String value, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        SizedBox(height: HTokens.xs),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
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

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  int _getWeekNumber() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    final daysSinceStart = now.difference(startOfYear).inDays;
    return (daysSinceStart / 7).ceil();
  }
}