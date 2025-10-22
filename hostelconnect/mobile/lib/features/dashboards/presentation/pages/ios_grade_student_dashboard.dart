// lib/features/dashboards/presentation/pages/ios_grade_student_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';

class IOSGradeStudentDashboard extends ConsumerStatefulWidget {
  const IOSGradeStudentDashboard({super.key});

  @override
  ConsumerState<IOSGradeStudentDashboard> createState() => _IOSGradeStudentDashboardState();
}

class _IOSGradeStudentDashboardState extends ConsumerState<IOSGradeStudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HostelConnect',
                    style: IOSGradeTheme.headlineMedium.copyWith(
                      color: IOSGradeTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      NavigationService.navigateToProfile(context);
                    },
                    icon: const Icon(
                      Icons.person_outline,
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // Quick Access
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildQuickAccessCard(
                      'Gate Pass',
                      Icons.exit_to_app,
                      () => NavigationService.navigateToGatePass(context),
                    ),
                    _buildQuickAccessCard(
                      'Attendance',
                      Icons.check_circle_outline,
                      () => NavigationService.navigateToAttendance(context),
                    ),
                    _buildQuickAccessCard(
                      'Meals',
                      Icons.restaurant_outlined,
                      () => NavigationService.navigateToMeals(context),
                    ),
                    _buildQuickAccessCard(
                      'Notices',
                      Icons.notifications_outlined,
                      () => NavigationService.navigateToNotices(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: IOSGradeTheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: IOSGradeTheme.bodyMedium.copyWith(
                  color: IOSGradeTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}