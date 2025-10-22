import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../shared/widgets/ui/professional_components.dart';
import '../../../../shared/theme/telugu_theme.dart';

class WardenHeadDashboardPage extends ConsumerStatefulWidget {
  const WardenHeadDashboardPage({super.key});

  @override
  ConsumerState<WardenHeadDashboardPage> createState() => _WardenHeadDashboardPageState();
}

class _WardenHeadDashboardPageState extends ConsumerState<WardenHeadDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [HTeluguTheme.primary, HTeluguTheme.primary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Warden Head Dashboard',
                            style: HTeluguTheme.headlineMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Manage hostel operations efficiently',
                            style: HTeluguTheme.bodyLarge.copyWith(
                              color: Colors.white.withOpacity(0.9),
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
                        Icons.admin_panel_settings,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Quick Actions
              Text(
                'Quick Actions',
                style: HTeluguTheme.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: HTeluguTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildActionCard(
                    'Policies',
                    Icons.policy_outlined,
                    () => NavigationService.navigateToPolicies(context),
                  ),
                  _buildActionCard(
                    'Meal Overrides',
                    Icons.restaurant_menu_outlined,
                    () => NavigationService.navigateToMealOverrides(context),
                  ),
                  _buildActionCard(
                    'Broadcast Notice',
                    Icons.campaign_outlined,
                    () => NavigationService.navigateToBroadcastNotice(context),
                  ),
                  _buildActionCard(
                    'Manage Policies',
                    Icons.policy_outlined,
                    () => NavigationService.navigateToPolicyManagement(context),
                  ),
                  _buildActionCard(
                    'Reports',
                    Icons.analytics_outlined,
                    () => NavigationService.navigateToReports(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap) {
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
                color: HTeluguTheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: HTeluguTheme.bodyMedium.copyWith(
                  color: HTeluguTheme.textPrimary,
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