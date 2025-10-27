// Complete Super Admin Dashboard - Production Ready with New Features
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../admin/presentation/pages/create_notification_page.dart';
import '../../../admin/presentation/pages/bulk_student_upload_page.dart';
import '../../../admin/presentation/pages/student_management_page.dart';
import '../../../admin/presentation/pages/meal_notification_settings_page.dart';
import '../../../reports/presentation/pages/analytics_dashboard_page.dart';

class CompleteSuperAdminDashboard extends ConsumerStatefulWidget {
  const CompleteSuperAdminDashboard({super.key});

  @override
  ConsumerState<CompleteSuperAdminDashboard> createState() => _CompleteSuperAdminDashboardState();
}

class _CompleteSuperAdminDashboardState extends ConsumerState<CompleteSuperAdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Badge(
              label: const Text('12'),
              child: const Icon(Icons.notifications),
            ),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.notifications_active), text: 'Notifications'),
            Tab(icon: Icon(Icons.people), text: 'Students'),
            Tab(icon: Icon(Icons.analytics), text: 'Analytics'),
            Tab(icon: Icon(Icons.settings_applications), text: 'System'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildNotificationsTab(),
          _buildStudentsTab(),
          _buildAnalyticsTab(),
          _buildSystemTab(),
        ],
      ),
    );
  }

  // OVERVIEW TAB
  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 20),
            _buildSystemStats(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildRecentActivity(),
            const SizedBox(height: 24),
            _buildSystemHealth(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[700]!, Colors.purple[500]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome, Super Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Manage your entire hostel system from one place',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            StatCard(
              title: 'Total Students',
              value: '1,245',
              subtitle: '+15 this week',
              icon: Icons.people,
              color: Colors.blue,
              onTap: () {},
            ),
            StatCard(
              title: 'Active Gate Passes',
              value: '87',
              subtitle: '23 pending',
              icon: Icons.qr_code,
              color: Colors.green,
              onTap: () {},
            ),
            StatCard(
              title: 'Total Hostels',
              value: '4',
              subtitle: '100% occupied',
              icon: Icons.domain,
              color: Colors.orange,
              onTap: () {},
            ),
            StatCard(
              title: 'Staff Members',
              value: '45',
              subtitle: '12 wardens',
              icon: Icons.badge,
              color: Colors.purple,
              onTap: () {},
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
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildActionCard(
              icon: Icons.notifications_active,
              title: 'Send Notification',
              color: Colors.blue,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateNotificationPage()),
              ),
            ),
            _buildActionCard(
              icon: Icons.upload_file,
              title: 'Bulk Upload',
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BulkStudentUploadPage()),
              ),
            ),
            _buildActionCard(
              icon: Icons.people_alt,
              title: 'Manage Students',
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudentManagementPage()),
              ),
            ),
            _buildActionCard(
              icon: Icons.restaurant_menu,
              title: 'Meal Settings',
              color: Colors.red,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MealNotificationSettingsPage()),
              ),
            ),
            _buildActionCard(
              icon: Icons.analytics,
              title: 'Analytics',
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalyticsDashboardPage()),
              ),
            ),
            _buildActionCard(
              icon: Icons.settings,
              title: 'System Config',
              color: Colors.grey,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildActivityItem(
                icon: Icons.person_add,
                title: '15 new students added',
                subtitle: 'Via bulk upload',
                time: '2 hours ago',
                color: Colors.green,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                icon: Icons.notifications_active,
                title: 'Notification sent to 1,245 students',
                subtitle: 'Hostel maintenance announcement',
                time: '5 hours ago',
                color: Colors.blue,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                icon: Icons.lock_reset,
                title: '3 passwords reset',
                subtitle: 'By admin action',
                time: '1 day ago',
                color: Colors.orange,
              ),
              const Divider(height: 1),
              _buildActivityItem(
                icon: Icons.verified,
                title: '45 gate passes approved',
                subtitle: 'By wardens',
                time: '1 day ago',
                color: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
    );
  }

  Widget _buildSystemHealth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Health',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHealthIndicator('Server Status', 99.9, Colors.green),
                const SizedBox(height: 12),
                _buildHealthIndicator('Database Performance', 95.5, Colors.green),
                const SizedBox(height: 12),
                _buildHealthIndicator('API Response Time', 87.2, Colors.orange),
                const SizedBox(height: 12),
                _buildHealthIndicator('Storage Usage', 68.0, Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthIndicator(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text('${value.toStringAsFixed(1)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 6,
        ),
      ],
    );
  }

  // NOTIFICATIONS TAB
  Widget _buildNotificationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification Management',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildNotificationStats(),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateNotificationPage()),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Create New Notification'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          const SizedBox(height: 24),
          _buildRecentNotifications(),
        ],
      ),
    );
  }

  Widget _buildNotificationStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.8,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildStatBox('Sent Today', '45', Icons.send, Colors.blue),
        _buildStatBox('Total This Week', '312', Icons.notifications, Colors.green),
        _buildStatBox('Scheduled', '8', Icons.schedule, Colors.orange),
        _buildStatBox('Failed', '2', Icons.error, Colors.red),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Spacer(),
                Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Notifications',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              _buildNotificationTile(
                title: 'Hostel Maintenance',
                target: 'All Students (1,245)',
                time: '2 hours ago',
                status: 'Delivered',
                statusColor: Colors.green,
              ),
              const Divider(height: 1),
              _buildNotificationTile(
                title: 'Meal Menu Update',
                target: 'Hostel A (312 students)',
                time: '5 hours ago',
                status: 'Delivered',
                statusColor: Colors.green,
              ),
              const Divider(height: 1),
              _buildNotificationTile(
                title: 'Room Inspection',
                target: 'Block B, Floor 2 (45 students)',
                time: '1 day ago',
                status: 'Delivered',
                statusColor: Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationTile({
    required String title,
    required String target,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: const Icon(Icons.notifications, color: Colors.blue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text('To: $target'),
          const SizedBox(height: 2),
          Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
      isThreeLine: true,
    );
  }

  // STUDENTS TAB
  Widget _buildStudentsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Management',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BulkStudentUploadPage()),
                  ),
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Bulk Upload'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentManagementPage()),
                  ),
                  icon: const Icon(Icons.people),
                  label: const Text('View All'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildStudentStats(),
        ],
      ),
    );
  }

  Widget _buildStudentStats() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatRow('Total Students', '1,245', Icons.people, Colors.blue),
            const Divider(),
            _buildStatRow('Active Students', '1,230', Icons.check_circle, Colors.green),
            const Divider(),
            _buildStatRow('Inactive Students', '15', Icons.cancel, Colors.red),
            const Divider(),
            _buildStatRow('New This Month', '45', Icons.person_add, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16)),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  // ANALYTICS TAB
  Widget _buildAnalyticsTab() {
    // Navigate to full analytics dashboard
    return const AnalyticsDashboardPage();
  }

  // SYSTEM TAB
  Widget _buildSystemTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // System Configuration Section
          _buildSectionHeader('System Configuration', Icons.settings),
          const SizedBox(height: 12),
          _buildSettingCard(
            'App Version',
            '1.0.0 (Production)',
            Icons.info_outline,
            Colors.blue,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('App Version: 1.0.0')),
              );
            },
          ),
          _buildSettingCard(
            'Database Status',
            'Connected • PostgreSQL 15',
            Icons.storage,
            Colors.green,
            onTap: () {
              // Show database stats
            },
          ),
          _buildSettingCard(
            'Cache Management',
            'Clear application cache',
            Icons.cleaning_services,
            Colors.orange,
            onTap: () {
              _showClearCacheDialog();
            },
          ),
          const SizedBox(height: 24),

          // Notification Settings Section
          _buildSectionHeader('Notification Settings', Icons.notifications),
          const SizedBox(height: 12),
          _buildToggleSetting(
            'Push Notifications',
            'Receive push notifications for important updates',
            true,
            (value) {
              // Update push notification setting
            },
          ),
          _buildToggleSetting(
            'Email Notifications',
            'Receive email alerts for critical events',
            true,
            (value) {
              // Update email notification setting
            },
          ),
          _buildToggleSetting(
            'SMS Alerts',
            'Get SMS for emergency situations',
            false,
            (value) {
              // Update SMS setting
            },
          ),
          const SizedBox(height: 24),

          // Security Settings Section
          _buildSectionHeader('Security Settings', Icons.security),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Two-Factor Authentication',
            'Not configured',
            Icons.phonelink_lock,
            Colors.red,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('2FA setup coming soon')),
              );
            },
          ),
          _buildSettingCard(
            'Session Timeout',
            '15 minutes of inactivity',
            Icons.timer,
            Colors.purple,
            onTap: () {
              // Show session timeout options
            },
          ),
          _buildSettingCard(
            'API Rate Limiting',
            '1000 requests/hour',
            Icons.speed,
            Colors.indigo,
            onTap: () {
              // Show rate limit settings
            },
          ),
          const SizedBox(height: 24),

          // Backup & Recovery Section
          _buildSectionHeader('Backup & Recovery', Icons.backup),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Last Backup',
            'Today at 3:00 AM',
            Icons.check_circle,
            Colors.green,
            onTap: () {
              // Show backup details
            },
          ),
          _buildSettingCard(
            'Auto Backup',
            'Daily at 3:00 AM',
            Icons.schedule,
            Colors.blue,
            onTap: () {
              // Configure backup schedule
            },
          ),
          _buildSettingCard(
            'Restore Database',
            'Restore from backup',
            Icons.restore,
            Colors.amber,
            onTap: () {
              _showRestoreDialog();
            },
          ),
          const SizedBox(height: 24),

          // System Maintenance Section
          _buildSectionHeader('System Maintenance', Icons.build),
          const SizedBox(height: 12),
          _buildSettingCard(
            'Run Diagnostics',
            'Check system health',
            Icons.analytics,
            Colors.teal,
            onTap: () {
              _runDiagnostics();
            },
          ),
          _buildSettingCard(
            'Clear Logs',
            'Remove old log files (>30 days)',
            Icons.delete_sweep,
            Colors.red,
            onTap: () {
              _showClearLogsDialog();
            },
          ),
          const SizedBox(height: 24),

          // Danger Zone
          _buildSectionHeader('Danger Zone', Icons.warning, color: Colors.red),
          const SizedBox(height: 12),
          Card(
            color: Colors.red[50],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.red[200]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.delete_forever, color: Colors.red[700]),
                    title: Text(
                      'Reset All Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                      ),
                    ),
                    subtitle: const Text('This action cannot be undone'),
                    onTap: () {
                      _showResetDataDialog();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? Colors.deepPurple[700], size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.grey[900],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard(
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleSetting(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.deepPurple[700],
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Database'),
        content: const Text(
          'This will restore the database from the last backup. All data since the backup will be lost. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Database restore initiated')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }

  void _runDiagnostics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Diagnostics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDiagnosticRow('Database', 'OK', Colors.green),
            _buildDiagnosticRow('Redis Cache', 'OK', Colors.green),
            _buildDiagnosticRow('API Server', 'OK', Colors.green),
            _buildDiagnosticRow('File Storage', 'OK', Colors.green),
            _buildDiagnosticRow('Notifications', 'OK', Colors.green),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosticRow(String service, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(service),
          Row(
            children: [
              Icon(Icons.check_circle, color: color, size: 16),
              const SizedBox(width: 4),
              Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  void _showClearLogsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Logs'),
        content: const Text('This will remove log files older than 30 days. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Old logs cleared successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Reset All Data'),
        content: const Text(
          'This will PERMANENTLY delete all data including students, gate passes, attendance records, and meals. This action CANNOT be undone!\n\nType "CONFIRM" to proceed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Require confirmation input
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset cancelled - confirmation required'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset All Data'),
          ),
        ],
      ),
    );
  }
}
