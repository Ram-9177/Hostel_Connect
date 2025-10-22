// lib/features/policies/presentation/pages/policies_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import 'comprehensive_policy_management_page.dart';
import 'warden_policy_view_page.dart';
import '../../../../core/auth/auth_service.dart';

class PoliciesPage extends ConsumerWidget {
  const PoliciesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(AuthService.authStateProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Route to appropriate policy page based on role
    switch (user.role.toLowerCase()) {
      case 'super_admin':
      case 'warden_head':
        return const ComprehensivePolicyManagementPage();
      case 'warden':
        return const WardenPolicyViewPage();
      default:
        return Scaffold(
          backgroundColor: IOSGradeTheme.background,
          appBar: AppBar(
            title: const Text('Policies'),
            backgroundColor: IOSGradeTheme.background,
            elevation: 0,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.policy_outlined,
                    size: 64,
                    color: IOSGradeTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Policy Access',
                    style: IOSGradeTheme.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Policy management is only available to Warden Head and Super Admin roles.',
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
