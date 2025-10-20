import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/responsive.dart';
import '../../../../core/state/app_state.dart';
import '../../../../shared/widgets/ui/professional_components.dart';
import '../../../../shared/theme/telugu_theme.dart';
import '../widgets/dash_tile.dart';

class SuperAdminDashboardPage extends ConsumerStatefulWidget {
  const SuperAdminDashboardPage({super.key});

  @override
  ConsumerState<SuperAdminDashboardPage> createState() => _SuperAdminDashboardPageState();
}

class _SuperAdminDashboardPageState extends ConsumerState<SuperAdminDashboardPage>
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
    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));

    // Metrics animations
    _metricsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _metricsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _metricsController, curve: Curves.easeOut),
    );
    _metricsSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _metricsController, curve: Curves.easeOut));

    // Activity animations
    _activityController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _activityFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _activityController, curve: Curves.easeOut),
    );

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
      return SingleChildScrollView(
        padding: EdgeInsets.all(HTokens.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            SlideTransition(
              position: _headerSlideAnimation,
              child: FadeTransition(
                opacity: _headerFadeAnimation,
                child: HProfessionalCard(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          HTeluguTheme.error,
                          HTeluguTheme.error.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(HTokens.lg),
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
                                Icons.admin_panel_settings,
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
                                    'Super Admin Dashboard',
                                    style: TextStyle(
                                      fontSize: r.isXS ? 20 : 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: HTokens.xs),
                                  Text(
                                    'System Overview & Management',
                                    style: TextStyle(
                                      fontSize: r.isXS ? 14 : 16,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: HTokens.lg),
                        Row(
                          children: [
                            _buildStatItem('Total Hostels', '8', Icons.business, r),
                            SizedBox(width: HTokens.lg),
                            _buildStatItem('Active Users', '2,450', Icons.people, r),
                            SizedBox(width: HTokens.lg),
                            _buildStatItem('System Uptime', '99.9%', Icons.trending_up, r),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: HTokens.lg),

            // Quick Actions
            SlideTransition(
              position: _metricsSlideAnimation,
              child: FadeTransition(
                opacity: _metricsFadeAnimation,
                child: HProfessionalCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System Management',
                        style: TextStyle(
                          fontSize: r.isXS ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: HTeluguTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: HTokens.md),
                      Wrap(
                        spacing: HTokens.sm,
                        runSpacing: HTokens.sm,
                        children: [
                          _buildActionChip('User Management', Icons.people, HTeluguTheme.primary, () {}),
                          _buildActionChip('System Analytics', Icons.analytics, HTeluguTheme.success, () {}),
                          _buildActionChip('Database Backup', Icons.backup, HTeluguTheme.accent, () {}),
                          _buildActionChip('Security Audit', Icons.security, HTeluguTheme.error, () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: HTokens.lg),

            // Dashboard Metrics
            SlideTransition(
              position: _metricsSlideAnimation,
              child: FadeTransition(
                opacity: _metricsFadeAnimation,
                child: HDashGrid(
                  tiles: [
                    DashTile(
                      title: 'Monthly Reports',
                      value: '12',
                      updatedAt: '2 min ago',
                      color: HTeluguTheme.success,
                      onTap: () {},
                    ),
                    DashTile(
                      title: 'System Alerts',
                      value: '3',
                      updatedAt: '5 min ago',
                      color: HTeluguTheme.warning,
                      onTap: () {},
                    ),
                    DashTile(
                      title: 'Data Usage',
                      value: '2.4TB',
                      updatedAt: '1 min ago',
                      color: HTeluguTheme.info,
                      onTap: () {},
                    ),
                    DashTile(
                      title: 'API Calls',
                      value: '1.2M',
                      updatedAt: '3 min ago',
                      color: HTeluguTheme.primary,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: HTokens.lg),

            // System Status
            FadeTransition(
              opacity: _activityFadeAnimation,
              child: HProfessionalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Status',
                      style: TextStyle(
                        fontSize: r.isXS ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: HTeluguTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: HTokens.md),
                    ...List.generate(4, (index) => _buildSystemStatusItem(index)),
                  ],
                ),
              ),
            ),

            SizedBox(height: HTokens.lg),

            // Critical Actions
            FadeTransition(
              opacity: _activityFadeAnimation,
              child: HProfessionalCard(
                backgroundColor: HTeluguTheme.error.withOpacity(0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.admin_panel_settings,
                          color: HTeluguTheme.error,
                          size: r.isXS ? 20 : 24,
                        ),
                        SizedBox(width: HTokens.sm),
                        Text(
                          'Critical Actions',
                          style: TextStyle(
                            fontSize: r.isXS ? 18 : 20,
                            fontWeight: FontWeight.bold,
                            color: HTeluguTheme.error,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: HTokens.md),
                    Row(
                      children: [
                        Expanded(
                          child: HProfessionalButton(
                            text: 'System Backup',
                            onPressed: () {},
                            variant: HProfessionalButtonVariant.danger,
                            icon: Icons.backup,
                            isFullWidth: true,
                          ),
                        ),
                        SizedBox(width: HTokens.md),
                        Expanded(
                          child: HProfessionalButton(
                            text: 'Security Scan',
                            onPressed: () {},
                            variant: HProfessionalButtonVariant.outline,
                            icon: Icons.security,
                            isFullWidth: true,
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
      );
    });
  }

  Widget _buildStatItem(String label, String value, IconData icon, HResponsive r) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(HTokens.md),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: r.isXS ? 20 : 24),
            SizedBox(height: HTokens.xs),
            Text(
              value,
              style: TextStyle(
                fontSize: r.isXS ? 18 : 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: r.isXS ? 12 : 14,
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(String label, IconData icon, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: HTokens.md,
            vertical: HTokens.sm,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 16),
              SizedBox(width: HTokens.xs),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemStatusItem(int index) {
    final statuses = [
      {'title': 'Database Server', 'status': 'Online', 'color': HTeluguTheme.success},
      {'title': 'API Gateway', 'status': 'Online', 'color': HTeluguTheme.success},
      {'title': 'File Storage', 'status': 'Warning', 'color': HTeluguTheme.warning},
      {'title': 'Backup System', 'status': 'Online', 'color': HTeluguTheme.success},
    ];

    final status = statuses[index % statuses.length];

    return Padding(
      padding: EdgeInsets.only(bottom: HTokens.md),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: status['color'] as Color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: HTokens.md),
          Expanded(
            child: Text(
              status['title'] as String,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: HTeluguTheme.textPrimary,
              ),
            ),
          ),
          Text(
            status['status'] as String,
            style: TextStyle(
              fontSize: 12,
              color: status['color'] as Color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}