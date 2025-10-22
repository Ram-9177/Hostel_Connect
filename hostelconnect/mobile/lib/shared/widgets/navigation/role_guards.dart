import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/app_state.dart';
import '../../shared/theme/telugu_theme.dart';
import '../../core/responsive.dart';

/// Role-based access control widget - PRODUCTION SECURE
class RoleGuard extends ConsumerWidget {
  final List<String> allowedRoles;
  final Widget child;
  final Widget? fallback;

  const RoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    
    // Show loading while checking authentication
    if (appState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    // Redirect to login if not authenticated
    if (!appState.isAuthenticated || appState.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    final userRole = appState.user!.role;
    
    // Validate role exists
    if (userRole.isEmpty) {
      return fallback ?? const _AccessDeniedWidget(
        message: 'Invalid user role. Please contact administrator.',
      );
    }
    
    // Check if user has required role
    final hasAccess = _checkRoleAccess(userRole, allowedRoles);
    
    if (!hasAccess) {
      return fallback ?? const _AccessDeniedWidget(
        message: 'You do not have permission to access this page.',
      );
    }
    
    return child;
  }
  
  /// Check if user role has access to required roles
  bool _checkRoleAccess(String userRole, List<String> allowedRoles) {
    // Role hierarchy for permission checking
    const roleHierarchy = {
      'super_admin': 5,
      'warden_head': 4,
      'warden': 3,
      'chef': 2,
      'student': 1,
    };
    
    final userLevel = roleHierarchy[userRole] ?? 0;
    
    // Check if user has any of the allowed roles or higher
    for (final allowedRole in allowedRoles) {
      final requiredLevel = roleHierarchy[allowedRole] ?? 0;
      if (userLevel >= requiredLevel) {
        return true;
      }
    }
    
    return false;
  }
}

/// Access denied widget
class _AccessDeniedWidget extends StatelessWidget {
  final String message;
  
  const _AccessDeniedWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(HTokens.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: HTokens.iconXl,
                color: HTeluguTheme.error,
              ),
              const SizedBox(height: HTokens.lg),
              Text(
                'Access Denied',
                style: HTeluguTheme.titleLarge.copyWith(
                  color: HTeluguTheme.error,
                ),
              ),
              const SizedBox(height: HTokens.sm),
              Text(
                message,
                style: HTeluguTheme.bodyMedium.copyWith(
                  color: HTeluguTheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: HTokens.lg),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HTeluguTheme.primary,
                  foregroundColor: HTeluguTheme.onPrimary,
                ),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Admin role guard
class AdminRoleGuard extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const AdminRoleGuard({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['super_admin', 'warden_head'],
      child: child,
      fallback: fallback,
    );
  }
}

/// Warden role guard
class WardenRoleGuard extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const WardenRoleGuard({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['warden', 'warden_head', 'super_admin'],
      child: child,
      fallback: fallback,
    );
  }
}

/// Student role guard
class StudentRoleGuard extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const StudentRoleGuard({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['student'],
      child: child,
      fallback: fallback,
    );
  }
}

/// Chef role guard
class ChefRoleGuard extends StatelessWidget {
  final Widget child;
  final Widget? fallback;

  const ChefRoleGuard({
    super.key,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      allowedRoles: ['chef', 'super_admin'],
      child: child,
      fallback: fallback,
    );
  }
}

/// Role-specific quick access rows
class QuickAccessRow extends ConsumerWidget {
  const QuickAccessRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final userRole = appState.user?.role.toLowerCase();

    if (userRole == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access',
            style: HTeluguTheme.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildQuickAccessTiles(context, userRole),
        ],
      ),
    );
  }

  Widget _buildQuickAccessTiles(BuildContext context, String role) {
    switch (role) {
      case 'student':
        return _buildStudentQuickAccess(context);
      case 'warden':
        return _buildWardenQuickAccess(context);
      case 'warden_head':
        return _buildWardenHeadQuickAccess(context);
      case 'super_admin':
        return _buildSuperAdminQuickAccess(context);
      case 'chef':
        return _buildChefQuickAccess(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStudentQuickAccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.exit_to_app,
            title: 'బయట అనుమతి',
            subtitle: 'Gate Pass',
            onTap: () => Navigator.pushNamed(context, '/gate-pass'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.check_circle,
            title: 'హాజరు',
            subtitle: 'Attendance',
            onTap: () => Navigator.pushNamed(context, '/attendance'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.restaurant,
            title: 'భోజనం',
            subtitle: 'Meals',
            onTap: () => Navigator.pushNamed(context, '/meals'),
          ),
        ),
      ],
    );
  }

  Widget _buildWardenQuickAccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.approval,
            title: 'అంగీకరించు',
            subtitle: 'Approvals',
            onTap: () => Navigator.pushNamed(context, '/approvals'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.qr_code_scanner,
            title: 'స్కాన్ చేయి',
            subtitle: 'Scanner',
            onTap: () => Navigator.pushNamed(context, '/scanner'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.room,
            title: 'గదులు',
            subtitle: 'Rooms',
            onTap: () => Navigator.pushNamed(context, '/rooms'),
          ),
        ),
      ],
    );
  }

  Widget _buildWardenHeadQuickAccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.policy,
            title: 'విధానాలు',
            subtitle: 'Policies',
            onTap: () => Navigator.pushNamed(context, '/policies'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.restaurant_menu,
            title: 'భోజనం మార్పులు',
            subtitle: 'Meal Overrides',
            onTap: () => Navigator.pushNamed(context, '/meal-overrides'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.campaign,
            title: 'ప్రకటనలు',
            subtitle: 'Broadcast',
            onTap: () => Navigator.pushNamed(context, '/broadcast'),
          ),
        ),
      ],
    );
  }

  Widget _buildSuperAdminQuickAccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.people,
            title: 'వినియోగదారులు',
            subtitle: 'Users',
            onTap: () => Navigator.pushNamed(context, '/users'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.analytics,
            title: 'విజ్ఞాపనలు',
            subtitle: 'Ad Analytics',
            onTap: () => Navigator.pushNamed(context, '/ad-analytics'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.history,
            title: 'ఆడిట్',
            subtitle: 'Audit',
            onTap: () => Navigator.pushNamed(context, '/audit'),
          ),
        ),
      ],
    );
  }

  Widget _buildChefQuickAccess(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.trending_up,
            title: 'భవిష్యత్ అంచనా',
            subtitle: 'Forecast',
            onTap: () => Navigator.pushNamed(context, '/forecast'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickAccessTile(
            icon: Icons.download,
            title: 'CSV ఎగుమతి',
            subtitle: 'Export CSV',
            onTap: () => Navigator.pushNamed(context, '/export-csv'),
          ),
        ),
      ],
    );
  }
}

/// Quick access tile component
class _QuickAccessTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAccessTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: HTeluguTheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: HTeluguTheme.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
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
                fontWeight: FontWeight.w600,
                color: HTeluguTheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: HTeluguTheme.bodySmall.copyWith(
                color: HTeluguTheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}