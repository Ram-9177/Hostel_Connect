import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/features/dashboards/presentation/widgets/dash_tile.dart';
import 'package:hostelconnect/shared/widgets/ui/card.dart';
import 'package:hostelconnect/shared/widgets/ui/button.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class WardenDashboardPage extends ConsumerStatefulWidget {
  const WardenDashboardPage({super.key});

  @override
  ConsumerState<WardenDashboardPage> createState() => _WardenDashboardPageState();
}

class _WardenDashboardPageState extends ConsumerState<WardenDashboardPage>
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
                HTokens.secondary.withOpacity(0.05),
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
                                  HTokens.secondary,
                                  HTokens.secondary.withOpacity(0.8),
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
                                        Icons.admin_panel_settings_rounded,
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
                                            'Block A - Warden Dashboard',
                                            style: TextStyle(
                                              fontSize: r.isXS ? 20 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: HTokens.xs),
                                          Text(
                                            'Welcome, ${user?.firstName ?? 'Warden'}!',
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
                                        Icons.notifications_active,
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
                                    _buildStatItem('Students', '156', Colors.white, Icons.people),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildStatItem('Present', '142', Colors.white, Icons.check_circle),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildStatItem('Absent', '14', Colors.white, Icons.person_off),
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
                    _buildActionChip('Start Attendance', Icons.qr_code_scanner, HTokens.primary, () {}),
                    _buildActionChip('Gate Passes', Icons.exit_to_app, HTokens.secondary, () {}),
                    _buildActionChip('Complaints', Icons.report_problem, HTokens.warning, () {}),
                    _buildActionChip('Reports', Icons.assessment, HTokens.info, () {}),
                  ],
                ),
                
                SizedBox(height: HTokens.xl),
                
                // Enhanced Dashboard Metrics
                Text(
                  'Live Metrics',
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
                              title: 'Attendance Rate',
                              value: '91%',
                              updatedAt: '5 min ago',
                              trailing: Icon(Icons.trending_up, color: HTokens.success),
                              color: HTokens.success,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Pending Gate Passes',
                              value: '7',
                              updatedAt: '2 min ago',
                              trailing: Icon(Icons.pending_actions, color: HTokens.warning),
                              color: HTokens.warning,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Active Complaints',
                              value: '3',
                              updatedAt: '1 hour ago',
                              trailing: Icon(Icons.report_problem, color: HTokens.error),
                              color: HTokens.error,
                              onTap: () {},
                            ),
                            DashTile(
                              title: 'Resolved Issues',
                              value: '24',
                              updatedAt: 'Today',
                              trailing: Icon(Icons.check_circle, color: HTokens.success),
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
                              'John Doe marked present',
                              '2 min ago',
                              Icons.check_circle,
                              HTokens.success,
                              'Student attendance marked via QR scan',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Gate pass request from Jane',
                              '5 min ago',
                              Icons.exit_to_app,
                              HTokens.warning,
                              'Emergency gate pass request pending approval',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'Complaint resolved',
                              '1 hour ago',
                              Icons.check,
                              HTokens.success,
                              'Room maintenance complaint has been resolved',
                            ),
                            Divider(height: 1),
                            _buildActivityItem(
                              'New complaint filed',
                              '2 hours ago',
                              Icons.report_problem,
                              HTokens.error,
                              'Water leakage complaint in Room 205',
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
                                text: 'Emergency Alert',
                                variant: HButtonVariant.outline,
                                icon: Icons.warning,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: HTokens.sm),
                            Expanded(
                              child: HButton(
                                text: 'Contact Admin',
                                variant: HButtonVariant.outline,
                                icon: Icons.admin_panel_settings,
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
}