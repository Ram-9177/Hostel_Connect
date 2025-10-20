import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/state/app_state.dart';
import '../shared/theme/telugu_theme.dart';

// Role-based route guard
class RoleGuard extends ConsumerWidget {
  final List<String> allowedRoles;
  final Widget child;
  final String? forbiddenMessage;

  const RoleGuard({
    super.key,
    required this.allowedRoles,
    required this.child,
    this.forbiddenMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final userRole = appState.user?.role.toLowerCase();

    // Check if user role is allowed
    if (userRole == null || !allowedRoles.contains(userRole)) {
      return _ForbiddenPage(
        message: forbiddenMessage ?? _getDefaultForbiddenMessage(),
      );
    }

    return child;
  }

  String _getDefaultForbiddenMessage() {
    return 'ఈ భాగానికి మీకు అనుమతి లేదు\nYou do not have access to this section.';
  }
}

// Forbidden access page
class _ForbiddenPage extends StatelessWidget {
  final String message;

  const _ForbiddenPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HTeluguTheme.background,
      appBar: AppBar(
        title: const Text('Access Denied'),
        backgroundColor: HTeluguTheme.primary,
        foregroundColor: HTeluguTheme.onPrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.block,
                size: 80,
                color: HTeluguTheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                message,
                textAlign: TextAlign.center,
                style: HTeluguTheme.headlineMedium.copyWith(
                  color: HTeluguTheme.error,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: HTeluguTheme.primary,
                  foregroundColor: HTeluguTheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
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

// Role-specific quick access rows
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

// Quick access tile component
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
