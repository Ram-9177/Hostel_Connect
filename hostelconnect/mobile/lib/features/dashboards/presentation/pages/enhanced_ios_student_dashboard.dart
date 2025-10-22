// lib/features/dashboards/presentation/pages/enhanced_ios_student_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/services/meal_policy_integration_service.dart';
import '../../../policies/presentation/widgets/student_policy_summary.dart';
import '../../../../core/auth/auth_service.dart';

class EnhancedIOSStudentDashboard extends ConsumerStatefulWidget {
  const EnhancedIOSStudentDashboard({super.key});

  @override
  ConsumerState<EnhancedIOSStudentDashboard> createState() => _EnhancedIOSStudentDashboardState();
}

class _EnhancedIOSStudentDashboardState extends ConsumerState<EnhancedIOSStudentDashboard>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(AuthService.authStateProvider);
    final user = authState.user;

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    _buildAppBar(user?.email ?? 'Student'),
                    SliverPadding(
                      padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _buildWelcomeCard(user?.email ?? 'Student'),
                          const SizedBox(height: IOSGradeTheme.spacing4),
                          _buildQuickStats(),
                          const SizedBox(height: IOSGradeTheme.spacing4),
                          _buildQuickActions(),
                          const SizedBox(height: IOSGradeTheme.spacing4),
                          _buildRecentActivity(),
                          const SizedBox(height: IOSGradeTheme.spacing4),
                                 _buildUpcomingEvents(),
                                 const SizedBox(height: IOSGradeTheme.spacing4),
                                 // Policy Summary
                                 const StudentPolicySummary(
                                   hostelId: 'hostel_1',
                                   isCompact: true,
                                 ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(String userName) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: IOSGradeTheme.surface,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                IOSGradeTheme.primary.withOpacity(0.1),
                IOSGradeTheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(IOSGradeTheme.spacing4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Good ${_getGreeting()}',
                    style: IOSGradeTheme.footnote.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: IOSGradeTheme.spacing1),
                  Text(
                    userName,
                    style: IOSGradeTheme.title1.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => _showNotifications(),
        ),
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () => _showProfile(),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(String userName) {
    return IOSGradeCard(
      backgroundColor: IOSGradeTheme.primary.withOpacity(0.05),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: IOSGradeTheme.primary,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
            ),
            child: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: IOSGradeTheme.headline.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: IOSGradeTheme.spacing1),
                Text(
                  'Room 101, Block A',
                  style: IOSGradeTheme.footnote.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: IOSGradeTheme.spacing3,
              vertical: IOSGradeTheme.spacing1,
            ),
            decoration: BoxDecoration(
              color: IOSGradeTheme.success,
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Text(
              'Active',
              style: IOSGradeTheme.caption1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const IOSGradeSectionHeader(
          title: 'Today\'s Overview',
          subtitle: 'Your hostel activity summary',
        ),
        const SizedBox(height: IOSGradeTheme.spacing3),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Attendance',
                'Present',
                Icons.check_circle_outline,
                IOSGradeTheme.success,
                '95%',
              ),
            ),
            const SizedBox(width: IOSGradeTheme.spacing3),
            Expanded(
              child: _buildStatCard(
                'Meals',
                'Completed',
                Icons.restaurant_outlined,
                IOSGradeTheme.accent,
                '3/3',
              ),
            ),
            const SizedBox(width: IOSGradeTheme.spacing3),
            Expanded(
              child: _buildStatCard(
                'Gate Pass',
                'Active',
                Icons.exit_to_app_outlined,
                IOSGradeTheme.info,
                '1',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String subtitle, IconData icon, Color color, String value) {
    return IOSGradeCard(
      padding: const EdgeInsets.all(IOSGradeTheme.spacing3),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: IOSGradeTheme.spacing2),
          Text(
            value,
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing1),
          Text(
            title,
            style: IOSGradeTheme.caption1.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: IOSGradeTheme.caption2.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const IOSGradeSectionHeader(
          title: 'Quick Actions',
          subtitle: 'Common tasks',
        ),
        const SizedBox(height: IOSGradeTheme.spacing3),
        Row(
          children: [
            Expanded(
              child: IOSGradeButton(
                text: 'Gate Pass',
                icon: Icons.exit_to_app_outlined,
                onPressed: () => _requestGatePass(),
              ),
            ),
            const SizedBox(width: IOSGradeTheme.spacing3),
            Expanded(
              child: IOSGradeButton(
                text: 'Report Issue',
                icon: Icons.report_outlined,
                onPressed: () => _reportIssue(),
              ),
            ),
          ],
        ),
        const SizedBox(height: IOSGradeTheme.spacing3),
        Row(
          children: [
            Expanded(
              child: IOSGradeButton(
                text: 'View Notices',
                icon: Icons.notifications_outlined,
                onPressed: () => _viewNotices(),
              ),
            ),
            const SizedBox(width: IOSGradeTheme.spacing3),
            Expanded(
              child: IOSGradeButton(
                text: 'Meal Plan',
                icon: Icons.restaurant_outlined,
                onPressed: () => _viewMealPlan(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const IOSGradeSectionHeader(
          title: 'Recent Activity',
          subtitle: 'Your latest actions',
          action: Text(
            'View All',
            style: TextStyle(
              color: IOSGradeTheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: IOSGradeTheme.spacing3),
        ...List.generate(3, (index) => _buildActivityItem(index)),
      ],
    );
  }

  Widget _buildActivityItem(int index) {
    final activities = [
      {'title': 'Gate pass approved', 'time': '2 hours ago', 'icon': Icons.check_circle_outline, 'color': IOSGradeTheme.success},
      {'title': 'Meal completed', 'time': '4 hours ago', 'icon': Icons.restaurant_outlined, 'color': IOSGradeTheme.accent},
      {'title': 'Attendance marked', 'time': '6 hours ago', 'icon': Icons.person_outline, 'color': IOSGradeTheme.info},
    ];

    final activity = activities[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: IOSGradeTheme.spacing2),
      child: IOSGradeListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (activity['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
          ),
          child: Icon(
            activity['icon'] as IconData,
            color: activity['color'] as Color,
            size: 20,
          ),
        ),
        title: activity['title'] as String,
        subtitle: activity['time'] as String,
        trailing: const Icon(
          Icons.chevron_right,
          color: IOSGradeTheme.textSecondary,
        ),
        onTap: () => _viewActivityDetails(index),
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const IOSGradeSectionHeader(
          title: 'Upcoming Events',
          subtitle: 'Don\'t miss out',
        ),
        const SizedBox(height: IOSGradeTheme.spacing3),
        IOSGradeCard(
          backgroundColor: IOSGradeTheme.warning.withOpacity(0.05),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: IOSGradeTheme.warning,
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.event_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: IOSGradeTheme.spacing3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hostel Meeting',
                      style: IOSGradeTheme.headline.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: IOSGradeTheme.spacing1),
                    Text(
                      'Tomorrow at 6:00 PM',
                      style: IOSGradeTheme.footnote.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: IOSGradeTheme.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }

  void _showNotifications() {
    // TODO: Implement notifications
  }

  void _showProfile() {
    NavigationService.navigateToProfile(context);
  }

  void _requestGatePass() {
    NavigationService.navigateToGatePass(context);
  }

  void _reportIssue() {
    NavigationService.navigateToReportIssue(context);
  }

  void _viewNotices() {
    NavigationService.navigateToNotices(context);
  }

  void _viewMealPlan() {
    NavigationService.navigateToMeals(context);
  }

  void _viewActivityDetails(int index) {
    // TODO: Implement activity details
  }
}
