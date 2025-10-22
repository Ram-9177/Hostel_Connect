// lib/features/dashboards/presentation/pages/modern_student_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../shared/theme/modern_theme.dart';
import '../../../../shared/widgets/ui/modern_card.dart';

class ModernStudentDashboard extends ConsumerStatefulWidget {
  const ModernStudentDashboard({super.key});

  @override
  ConsumerState<ModernStudentDashboard> createState() => _ModernStudentDashboardState();
}

class _ModernStudentDashboardState extends ConsumerState<ModernStudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModernTheme.background,
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: ModernTheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(),
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => NavigationService.navigateToProfile(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
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
            const SizedBox(height: ModernTheme.spacing24),
            _buildUpcomingEvents(),
          ],
        ),
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
                  'Welcome back, John!',
                  style: ModernTheme.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: ModernTheme.spacing8),
                Text(
                  'Room 101, Block A • Hostel 1',
                  style: ModernTheme.bodyMedium.copyWith(
                    color: ModernTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: ModernTheme.spacing4),
                Text(
                  'Student ID: STU001',
                  style: ModernTheme.bodySmall.copyWith(
                    color: ModernTheme.textTertiary,
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
              Icons.school_outlined,
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
          'Your Status',
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
              title: 'Attendance',
              value: '95%',
              subtitle: 'This month',
              icon: Icons.check_circle_outline,
              iconColor: ModernTheme.success,
            ),
            ModernStatCard(
              title: 'Meals Taken',
              value: '28',
              subtitle: 'This month',
              icon: Icons.restaurant_outlined,
              iconColor: ModernTheme.info,
            ),
            ModernStatCard(
              title: 'Outpass Used',
              value: '3',
              subtitle: 'This month',
              icon: Icons.exit_to_app_outlined,
              iconColor: ModernTheme.warning,
            ),
            ModernStatCard(
              title: 'Complaints',
              value: '0',
              subtitle: 'Pending',
              icon: Icons.report_problem_outlined,
              iconColor: ModernTheme.error,
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
              title: 'Apply for Outpass',
              description: 'Request permission to leave hostel',
              icon: Icons.exit_to_app_outlined,
              iconColor: ModernTheme.primary,
              onTap: () => _applyOutpass(),
            ),
            ModernActionCard(
              title: 'Meal Booking',
              description: 'Book your meals for the day',
              icon: Icons.restaurant_outlined,
              iconColor: ModernTheme.secondary,
              onTap: () => _bookMeals(),
            ),
            ModernActionCard(
              title: 'Room Service',
              description: 'Request room maintenance',
              icon: Icons.build_outlined,
              iconColor: ModernTheme.info,
              onTap: () => _requestRoomService(),
            ),
            ModernActionCard(
              title: 'Emergency Contact',
              description: 'Contact emergency services',
              icon: Icons.emergency_outlined,
              iconColor: ModernTheme.error,
              onTap: () => NavigationService.navigateToEmergencyContact(context),
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
                'Meal booked',
                'Lunch and dinner for today',
                Icons.restaurant_outlined,
                ModernTheme.success,
                '2 hours ago',
              ),
              const Divider(),
              _buildActivityItem(
                'Outpass approved',
                'Weekend outpass approved',
                Icons.check_circle_outline,
                ModernTheme.success,
                '1 day ago',
              ),
              const Divider(),
              _buildActivityItem(
                'Room inspection',
                'Monthly room inspection completed',
                Icons.home_outlined,
                ModernTheme.info,
                '3 days ago',
              ),
              const Divider(),
              _buildActivityItem(
                'Payment reminder',
                'Monthly fee payment due',
                Icons.payment_outlined,
                ModernTheme.warning,
                '5 days ago',
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

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Events',
          style: ModernTheme.headlineSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ModernTheme.spacing16),
        ModernCard(
          child: Column(
            children: [
              _buildEventItem(
                'Hostel Meeting',
                'Monthly hostel meeting',
                'Tomorrow, 6:00 PM',
                Icons.meeting_room_outlined,
                ModernTheme.primary,
              ),
              const Divider(),
              _buildEventItem(
                'Cultural Festival',
                'Annual cultural festival',
                'Next Week',
                Icons.festival_outlined,
                ModernTheme.secondary,
              ),
              const Divider(),
              _buildEventItem(
                'Room Inspection',
                'Monthly room inspection',
                'Next Month',
                Icons.home_outlined,
                ModernTheme.info,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventItem(String title, String description, String date, IconData icon, Color color) {
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
            date,
            style: ModernTheme.bodySmall.copyWith(
              color: ModernTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    // TODO: Implement notifications
  }

  void _applyOutpass() {
    // TODO: Implement outpass application
  }

  void _bookMeals() {
    // TODO: Implement meal booking
  }

  void _requestRoomService() {
    // TODO: Implement room service request
  }
}
