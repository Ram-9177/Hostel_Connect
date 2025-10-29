// lib/core/guards/role_guard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_service.dart';
import '../../core/navigation/navigation_service.dart';
import '../../shared/theme/ios_grade_theme.dart';
import '../../shared/widgets/ui/ios_grade_components.dart';

class RoleGuard extends ConsumerWidget {
  final List<String> allowedRoles;
  final Widget child;

  const RoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(AuthService.authStateProvider);

    // Show loading while checking auth
    if (authState.isLoading) {
      return Scaffold(
        backgroundColor: IOSGradeTheme.background,
        body: const Center(
          child: CircularProgressIndicator(
            color: IOSGradeTheme.primary,
          ),
        ),
      );
    }

    // If not authenticated, show login
    if (!authState.isAuthenticated || authState.user == null) {
      return const ForbiddenAccessPage();
    }

    // Check if user role is allowed
    final userRole = authState.user!.role.toLowerCase();
    final isAllowed = allowedRoles.any((role) => role.toLowerCase() == userRole);

    if (isAllowed) {
      return child;
    } else {
      return const ForbiddenAccessPage();
    }
  }
}

class ForbiddenAccessPage extends StatelessWidget {
  const ForbiddenAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(IOSGradeTheme.spacing6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: IOSGradeTheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusLarge),
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: 60,
                  color: IOSGradeTheme.error,
                ),
              ),
              
              const SizedBox(height: IOSGradeTheme.spacing6),
              
              // Telugu Message
              Text(
                'ఈ భాగానికి మీకు అనుమతి లేదు',
                style: IOSGradeTheme.title1.copyWith(
                  fontWeight: FontWeight.w700,
                  color: IOSGradeTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: IOSGradeTheme.spacing2),
              
              // English Message
              Text(
                'You do not have access to this section.',
                style: IOSGradeTheme.body.copyWith(
                  color: IOSGradeTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: IOSGradeTheme.spacing6),
              
              // Back Button
              ElevatedButton.icon(
                onPressed: () => NavigationService.goBack(),
                icon: const Icon(Icons.arrow_back_ios_new),
                label: const Text('Go Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: IOSGradeTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: IOSGradeTheme.spacing6,
                    vertical: IOSGradeTheme.spacing3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                  ),
                ),
              ),
              
              const SizedBox(height: IOSGradeTheme.spacing4),
              
              // Contact Support Button
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.support_agent_outlined),
                label: const Text('Contact Support'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: IOSGradeTheme.primary,
                  side: const BorderSide(color: IOSGradeTheme.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: IOSGradeTheme.spacing6,
                    vertical: IOSGradeTheme.spacing3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Global Back Button Widget
class GlobalBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const GlobalBackButton({
    super.key,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? IOSGradeTheme.textPrimary,
        size: 20,
      ),
      onPressed: onPressed ?? () => NavigationService.goBack(),
    );
  }
}

// App Bar with Global Back Button
class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool automaticallyImplyLeading;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: IOSGradeTheme.title2.copyWith(
          fontWeight: FontWeight.w700,
          color: foregroundColor ?? IOSGradeTheme.textPrimary,
        ),
      ),
      backgroundColor: backgroundColor ?? IOSGradeTheme.surface,
      foregroundColor: foregroundColor ?? IOSGradeTheme.textPrimary,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? const GlobalBackButton()
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}