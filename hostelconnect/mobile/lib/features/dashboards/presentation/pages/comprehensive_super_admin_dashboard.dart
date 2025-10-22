// lib/features/dashboards/presentation/pages/comprehensive_super_admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../shared/theme/modern_theme.dart';
import '../../../../shared/widgets/ui/modern_card.dart';
import '../../../../core/responsive.dart';

class ComprehensiveSuperAdminDashboard extends ConsumerStatefulWidget {
  const ComprehensiveSuperAdminDashboard({super.key});

  @override
  ConsumerState<ComprehensiveSuperAdminDashboard> createState() => _ComprehensiveSuperAdminDashboardState();
}

class _ComprehensiveSuperAdminDashboardState extends ConsumerState<ComprehensiveSuperAdminDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernTheme.background,
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        backgroundColor: ModernTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) => setState(() => _selectedIndex = index),
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard_outlined)),
            Tab(text: 'Management', icon: Icon(Icons.admin_panel_settings_outlined)),
            Tab(text: 'Analytics', icon: Icon(Icons.analytics_outlined)),
            Tab(text: 'System', icon: Icon(Icons.settings_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildManagementTab(),
          _buildAnalyticsTab(),
          _buildSystemTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildQuickStats(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildQuickActions(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return ModernCard(
      backgroundColor: ModernTheme.primary.withOpacity(0.05),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Super Admin!',
                  style: ModernTheme.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: ModernTheme.spacing8),
                Text(
                  'Manage your hostel system with comprehensive tools and analytics.',
                  style: ModernTheme.bodyMedium.copyWith(
                    color: ModernTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(ModernTheme.spacing16),
            decoration: BoxDecoration(
              color: ModernTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ModernTheme.radius16),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              size: 48,
              color: ModernTheme.primary,
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
        Text(
          'System Overview',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: ModernTheme.spacing12,
          mainAxisSpacing: ModernTheme.spacing12,
          children: [
            ModernStatCard(
              title: 'Total Students',
              value: '1,247',
              subtitle: '+12% this month',
              icon: Icons.people_outline,
              iconColor: ModernTheme.info,
            ),
            ModernStatCard(
              title: 'Hostels',
              value: '8',
              subtitle: 'All active',
              icon: Icons.home_work_outlined,
              iconColor: ModernTheme.success,
            ),
            ModernStatCard(
              title: 'Occupancy Rate',
              value: '87%',
              subtitle: 'Above average',
              icon: Icons.bed_outlined,
              iconColor: ModernTheme.warning,
            ),
            ModernStatCard(
              title: 'System Health',
              value: '99.9%',
              subtitle: 'Excellent',
              icon: Icons.health_and_safety_outlined,
              iconColor: ModernTheme.success,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        Column(
          children: [
            ModernActionCard(
              title: 'Room Allotment',
              description: 'Manage room assignments and bed allocations',
              icon: Icons.bed_outlined,
              iconColor: ModernTheme.primary,
              onTap: () => NavigationService.navigateToRoomAllotmentWithGuard(context),
            ),
            ModernActionCard(
              title: 'Hostel Management',
              description: 'Configure hostels, blocks, and rooms',
              icon: Icons.home_work_outlined,
              iconColor: ModernTheme.secondary,
              onTap: () => NavigationService.navigateToHostelDataWithGuard(context),
            ),
            ModernActionCard(
              title: 'User Management',
              description: 'Manage students, wardens, and staff accounts',
              icon: Icons.people_outline,
              iconColor: ModernTheme.info,
              onTap: () => _showUserManagement(),
            ),
            ModernActionCard(
              title: 'System Reports',
              description: 'Generate comprehensive system reports',
              icon: Icons.assessment_outlined,
              iconColor: ModernTheme.warning,
              onTap: () => NavigationService.navigateToReportsWithGuard(context),
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
        Text(
          'Recent Activity',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        ModernCard(
          child: Column(
            children: [
              _buildActivityItem(
                'New student registered',
                'John Doe joined Hostel A',
                Icons.person_add_outlined,
                ModernTheme.success,
                '2 min ago',
              ),
              const Divider(),
              _buildActivityItem(
                'Room allocated',
                'Room 101 assigned to student',
                Icons.bed_outlined,
                ModernTheme.info,
                '5 min ago',
              ),
              const Divider(),
              _buildActivityItem(
                'System backup completed',
                'Daily backup successful',
                Icons.backup_outlined,
                ModernTheme.success,
                '1 hour ago',
              ),
              const Divider(),
              _buildActivityItem(
                'Maintenance scheduled',
                'Block B maintenance planned',
                Icons.build_outlined,
                ModernTheme.warning,
                '2 hours ago',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(String title, String description, IconData icon, Color color, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ModernTheme.spacing8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ModernTheme.spacing8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ModernTheme.radius8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: ModernTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernTheme.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: ModernTheme.bodySmall.copyWith(
                    color: ModernTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: ModernTheme.bodySmall.copyWith(
              color: ModernTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Management Tools',
            style: ModernTheme.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing24),
          _buildManagementSection('Hostel Management', [
            ModernActionCard(
              title: 'Create New Hostel',
              description: 'Add a new hostel to the system',
              icon: Icons.add_home_outlined,
              iconColor: ModernTheme.success,
              onTap: () => NavigationService.navigateToHostelDataWithGuard(context),
            ),
            ModernActionCard(
              title: 'Manage Blocks',
              description: 'Configure hostel blocks and floors',
              icon: Icons.business_outlined,
              iconColor: ModernTheme.info,
              onTap: () => NavigationService.navigateToHostelStructureWithGuard(context),
            ),
            ModernActionCard(
              title: 'Room Configuration',
              description: 'Set up rooms and bed configurations',
              icon: Icons.room_outlined,
              iconColor: ModernTheme.warning,
              onTap: () => NavigationService.navigateToRoomMapWithGuard(context),
            ),
          ]),
          const SizedBox(height: ModernTheme.spacing24),
          _buildManagementSection('User Management', [
            ModernActionCard(
              title: 'Student Management',
              description: 'Manage student accounts and profiles',
              icon: Icons.school_outlined,
              iconColor: ModernTheme.primary,
              onTap: () => _showStudentManagement(),
            ),
            ModernActionCard(
              title: 'Staff Management',
              description: 'Manage warden and staff accounts',
              icon: Icons.badge_outlined,
              iconColor: ModernTheme.secondary,
              onTap: () => _showStaffManagement(),
            ),
            ModernActionCard(
              title: 'Role Management',
              description: 'Configure user roles and permissions',
              icon: Icons.admin_panel_settings_outlined,
              iconColor: ModernTheme.info,
              onTap: () => _showRoleManagement(),
            ),
          ]),
          const SizedBox(height: ModernTheme.spacing24),
          _buildManagementSection('System Configuration', [
            ModernActionCard(
              title: 'System Settings',
              description: 'Configure system-wide settings',
              icon: Icons.settings_outlined,
              iconColor: ModernTheme.textSecondary,
              onTap: () => _showSystemSettings(),
            ),
            ModernActionCard(
              title: 'Backup & Restore',
              description: 'Manage system backups and restore data',
              icon: Icons.backup_outlined,
              iconColor: ModernTheme.warning,
              onTap: () => _showBackupRestore(),
            ),
            ModernActionCard(
              title: 'Security Settings',
              description: 'Configure security and access controls',
              icon: Icons.security_outlined,
              iconColor: ModernTheme.error,
              onTap: () => _showSecuritySettings(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildManagementSection(String title, List<Widget> actions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        Column(children: actions),
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics & Reports',
            style: ModernTheme.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing24),
          _buildAnalyticsCards(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildReportSection(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: ModernTheme.spacing12,
      mainAxisSpacing: ModernTheme.spacing12,
      children: [
        ModernStatCard(
          title: 'Monthly Revenue',
          value: '₹2.4M',
          subtitle: '+8% vs last month',
          icon: Icons.attach_money_outlined,
          iconColor: ModernTheme.success,
        ),
        ModernStatCard(
          title: 'Occupancy Trends',
          value: '87%',
          subtitle: 'Stable growth',
          icon: Icons.trending_up_outlined,
          iconColor: ModernTheme.info,
        ),
        ModernStatCard(
          title: 'Student Satisfaction',
          value: '4.8/5',
          subtitle: 'Excellent rating',
          icon: Icons.star_outline,
          iconColor: ModernTheme.warning,
        ),
        ModernStatCard(
          title: 'System Uptime',
          value: '99.9%',
          subtitle: 'Last 30 days',
          icon: Icons.timer_outlined,
          iconColor: ModernTheme.success,
        ),
      ],
    );
  }

  Widget _buildReportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Generate Reports',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        Column(
          children: [
            ModernActionCard(
              title: 'Financial Reports',
              description: 'Revenue, expenses, and financial analytics',
              icon: Icons.account_balance_outlined,
              iconColor: ModernTheme.success,
              onTap: () => _generateFinancialReport(),
            ),
            ModernActionCard(
              title: 'Occupancy Reports',
              description: 'Room utilization and occupancy trends',
              icon: Icons.bed_outlined,
              iconColor: ModernTheme.info,
              onTap: () => _generateOccupancyReport(),
            ),
            ModernActionCard(
              title: 'Student Reports',
              description: 'Student demographics and statistics',
              icon: Icons.people_outline,
              iconColor: ModernTheme.primary,
              onTap: () => _generateStudentReport(),
            ),
            ModernActionCard(
              title: 'System Reports',
              description: 'System performance and usage analytics',
              icon: Icons.analytics_outlined,
              iconColor: ModernTheme.warning,
              onTap: () => _generateSystemReport(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ModernTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Administration',
            style: ModernTheme.headlineMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing24),
          _buildSystemHealth(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildSystemActions(),
          const SizedBox(height: ModernTheme.spacing24),
          _buildSystemLogs(),
        ],
      ),
    );
  }

  Widget _buildSystemHealth() {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Health',
            style: ModernTheme.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: _buildHealthMetric('CPU Usage', '45%', ModernTheme.success),
              ),
              Expanded(
                child: _buildHealthMetric('Memory', '67%', ModernTheme.warning),
              ),
              Expanded(
                child: _buildHealthMetric('Storage', '23%', ModernTheme.success),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: ModernTheme.bodySmall.copyWith(
            color: ModernTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Actions',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        Column(
          children: [
            ModernActionCard(
              title: 'Database Backup',
              description: 'Create a complete system backup',
              icon: Icons.backup_outlined,
              iconColor: ModernTheme.info,
              onTap: () => _performBackup(),
            ),
            ModernActionCard(
              title: 'System Restart',
              description: 'Restart all system services',
              icon: Icons.restart_alt_outlined,
              iconColor: ModernTheme.warning,
              onTap: () => _restartSystem(),
            ),
            ModernActionCard(
              title: 'Clear Cache',
              description: 'Clear system cache and temporary files',
              icon: Icons.clear_all_outlined,
              iconColor: ModernTheme.textSecondary,
              onTap: () => _clearCache(),
            ),
            ModernActionCard(
              title: 'Update System',
              description: 'Check for and install system updates',
              icon: Icons.system_update_outlined,
              iconColor: ModernTheme.primary,
              onTap: () => _updateSystem(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemLogs() {
    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent System Logs',
            style: ModernTheme.titleLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing16),
          _buildLogEntry('System backup completed successfully', 'INFO', ModernTheme.info),
          _buildLogEntry('User login: admin@demo.com', 'INFO', ModernTheme.info),
          _buildLogEntry('Room allocation: Student ID 12345', 'INFO', ModernTheme.info),
          _buildLogEntry('Database connection restored', 'WARN', ModernTheme.warning),
          _buildLogEntry('System maintenance scheduled', 'INFO', ModernTheme.info),
        ],
      ),
    );
  }

  Widget _buildLogEntry(String message, String level, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ModernTheme.spacing4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ModernTheme.radius4),
            ),
            child: Text(
              level,
              style: ModernTheme.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: ModernTheme.bodySmall,
            ),
          ),
          Text(
            '2 min ago',
            style: ModernTheme.bodySmall.copyWith(
              color: ModernTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  // Action methods
  void _showNotifications() {
    // TODO: Implement notifications
  }

  void _showSettings() {
    // TODO: Implement settings
  }

  void _showUserManagement() {
    // TODO: Implement user management
  }

  void _showCreateHostel() {
    // TODO: Implement create hostel
  }

  void _showManageBlocks() {
    // TODO: Implement manage blocks
  }

  void _showRoomConfiguration() {
    // TODO: Implement room configuration
  }

  void _showStudentManagement() {
    // TODO: Implement student management
  }

  void _showStaffManagement() {
    // TODO: Implement staff management
  }

  void _showRoleManagement() {
    // TODO: Implement role management
  }

  void _showSystemSettings() {
    // TODO: Implement system settings
  }

  void _showBackupRestore() {
    // TODO: Implement backup restore
  }

  void _showSecuritySettings() {
    // TODO: Implement security settings
  }

  void _generateFinancialReport() {
    // TODO: Implement financial report
  }

  void _generateOccupancyReport() {
    // TODO: Implement occupancy report
  }

  void _generateStudentReport() {
    // TODO: Implement student report
  }

  void _generateSystemReport() {
    // TODO: Implement system report
  }

  void _performBackup() {
    // TODO: Implement backup
  }

  void _restartSystem() {
    // TODO: Implement restart
  }

  void _clearCache() {
    // TODO: Implement clear cache
  }

  void _updateSystem() {
    // TODO: Implement update system
  }
}
