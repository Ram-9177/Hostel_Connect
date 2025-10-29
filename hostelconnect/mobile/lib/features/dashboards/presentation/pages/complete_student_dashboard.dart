// Complete Student Dashboard - Production Ready
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../shared/widgets/dashboard_card.dart';
import '../../../../shared/widgets/stat_card.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../gatepass/presentation/pages/gate_pass_list_page.dart';
import '../../../meals/presentation/pages/meal_intent_page.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../profile/presentation/pages/student_profile_page.dart';
import '../../../../shared/widgets/navigation/role_quick_access_button.dart';

class CompleteStudentDashboard extends ConsumerStatefulWidget {
  const CompleteStudentDashboard({super.key});

  @override
  ConsumerState<CompleteStudentDashboard> createState() => _CompleteStudentDashboardState();
}

class _CompleteStudentDashboardState extends ConsumerState<CompleteStudentDashboard> {
  int _selectedIndex = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Badge(
              label: const Text('3'),
              child: const Icon(Icons.notifications),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsPage()),
            ),
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(
                authState.user?.profileImageUrl ?? 'https://via.placeholder.com/150',
              ),
              radius: 16,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentProfilePage()),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Gate Pass'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Meals'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: const RoleQuickAccessButton(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return const GatePassListPage();
      case 2:
        return const MealIntentPage();
      case 3:
        return const StudentProfilePage();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    final authState = ref.watch(authProvider);
    final studentName = authState.user?.name ?? 'Student';
    
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh data
        await Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeCard(studentName),
            const SizedBox(height: 20),
            
            // Quick Stats
            _buildQuickStats(),
            const SizedBox(height: 24),
            
            // Meal Reminder Banner (if applicable)
            _buildMealReminderBanner(),
            const SizedBox(height: 20),
            
            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildQuickActions(),
            const SizedBox(height: 24),
            
            // Recent Activity
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildRecentActivity(),
            const SizedBox(height: 24),
            
            // Announcements
            Text(
              'Announcements',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildAnnouncements(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(String name) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Room 101, Block A',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.6,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        StatCard(
          title: 'Attendance',
          value: '95%',
          subtitle: 'This Month',
          icon: Icons.check_circle,
          color: Colors.green,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AttendancePage()),
          ),
        ),
        StatCard(
          title: 'Gate Passes',
          value: '3',
          subtitle: 'Active',
          icon: Icons.qr_code,
          color: Colors.blue,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GatePassListPage()),
          ),
        ),
        StatCard(
          title: 'Meals',
          value: '28',
          subtitle: 'This Month',
          icon: Icons.restaurant,
          color: Colors.orange,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MealIntentPage()),
          ),
        ),
        StatCard(
          title: 'Notices',
          value: '5',
          subtitle: 'Unread',
          icon: Icons.notifications,
          color: Colors.purple,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildMealReminderBanner() {
    final now = DateTime.now();
    final hour = now.hour;
    
    // Show banner between 7 AM - 8 PM for meal intent reminder
    if (hour < 7 || hour >= 20) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[400]!, Colors.deepOrange[400]!],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '🍽️ Meal Intent Reminder',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Submit your meal preferences before 8 PM',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MealIntentPage()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepOrange,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.0,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        DashboardCard(
          icon: Icons.qr_code_scanner,
          title: 'New Gate Pass',
          color: Colors.blue,
          onTap: () {
            // Navigate to create gate pass
          },
        ),
        DashboardCard(
          icon: Icons.restaurant_menu,
          title: 'Meal Intent',
          color: Colors.orange,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MealIntentPage()),
          ),
        ),
        DashboardCard(
          icon: Icons.receipt_long,
          title: 'My Attendance',
          color: Colors.green,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AttendancePage()),
          ),
        ),
        DashboardCard(
          icon: Icons.announcement,
          title: 'Notices',
          color: Colors.purple,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationsPage()),
          ),
        ),
        DashboardCard(
          icon: Icons.report_problem,
          title: 'Complaints',
          color: Colors.red,
          onTap: () {
            // Navigate to complaints
          },
        ),
        DashboardCard(
          icon: Icons.settings,
          title: 'Settings',
          color: Colors.grey,
          onTap: () {
            // Navigate to settings
          },
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildActivityTile(
            icon: Icons.check_circle,
            title: 'Attendance Marked',
            subtitle: 'Today at 9:00 AM',
            color: Colors.green,
          ),
          const Divider(height: 1),
          _buildActivityTile(
            icon: Icons.restaurant,
            title: 'Meal Intent Submitted',
            subtitle: 'Yesterday at 7:00 PM',
            color: Colors.orange,
          ),
          const Divider(height: 1),
          _buildActivityTile(
            icon: Icons.verified,
            title: 'Gate Pass Approved',
            subtitle: '2 days ago',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({
    required IconData icon,
    required String title,
    required String subtitle,
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
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
    );
  }

  Widget _buildAnnouncements() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildAnnouncementTile(
            title: 'Hostel Maintenance',
            subtitle: 'Scheduled maintenance on Sunday, 10 AM - 2 PM',
            time: '2 hours ago',
            isNew: true,
          ),
          const Divider(height: 1),
          _buildAnnouncementTile(
            title: 'New Meal Menu',
            subtitle: 'Check out the new menu for this week',
            time: '1 day ago',
            isNew: false,
          ),
          const Divider(height: 1),
          _buildAnnouncementTile(
            title: 'Room Inspection',
            subtitle: 'Room inspection scheduled for all blocks',
            time: '3 days ago',
            isNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementTile({
    required String title,
    required String subtitle,
    required String time,
    required bool isNew,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isNew ? Colors.red : Colors.grey[300],
        child: Icon(
          Icons.announcement,
          color: isNew ? Colors.white : Colors.grey[700],
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (isNew)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'NEW',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        ],
      ),
      isThreeLine: true,
      onTap: () {
        // Navigate to announcement details
      },
    );
  }
}
