import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/state/app_state.dart';
import 'package:hostelconnect/shared/widgets/ui/professional_components.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    final user = appState.user;

    if (user == null) {
      return const Center(
        child: HProfessionalError(
          message: 'User not found',
          icon: Icons.person_off,
        ),
      );
    }

    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: HTeluguTheme.primary,
          foregroundColor: HTeluguTheme.onPrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(user, r),
                  SizedBox(height: 24),
                  _buildProfileDetails(user, r),
                  SizedBox(height: 24),
                  _buildActionButtons(r),
                  SizedBox(height: 24),
                  _buildSettingsSection(r),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProfileHeader(user, HResponsive r) {
    return HProfessionalCard(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HTeluguTheme.primary,
              HTeluguTheme.primary.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(r.radius),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: HTeluguTheme.primary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '${user.firstName} ${user.lastName}',
              style: HTeluguTheme.headlineMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              user.email,
              style: HTeluguTheme.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                user.role,
                style: HTeluguTheme.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails(user, HResponsive r) {
    return HProfessionalCard(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('personal_info', 'Personal Information'),
              style: HTeluguTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: HTeluguTheme.onSurface,
              ),
            ),
            SizedBox(height: 24),
            _buildDetailRow(
              Icons.badge,
              HTeluguTheme.getTeluguEnglishText('student_id', 'Student ID'),
              user.studentId,
              r,
            ),
            SizedBox(height: 16),
            _buildDetailRow(
              Icons.room,
              HTeluguTheme.getTeluguEnglishText('room', 'Room'),
              user.roomId,
              r,
            ),
            SizedBox(height: 16),
            _buildDetailRow(
              Icons.home,
              HTeluguTheme.getTeluguEnglishText('hostel', 'Hostel'),
              user.hostelId,
              r,
            ),
            SizedBox(height: 16),
            _buildDetailRow(
              Icons.email,
              HTeluguTheme.getTeluguEnglishText('email', 'Email'),
              user.email,
              r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, HResponsive r) {
    return Row(
      children: [
        Icon(
          icon,
          color: HTeluguTheme.primary,
          size: r.spacing,
        ),
            SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: HTeluguTheme.bodySmall.copyWith(
                  color: HTeluguTheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: HTeluguTheme.bodyMedium.copyWith(
                  color: HTeluguTheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(HResponsive r) {
    return Column(
      children: [
        HProfessionalButton(
          text: HTeluguTheme.getTeluguEnglishText('edit_profile', 'Edit Profile'),
          variant: HProfessionalButtonVariant.primary,
          size: HProfessionalButtonSize.lg,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(HTeluguTheme.getTeluguEnglishText('coming_soon', 'Coming Soon')),
                backgroundColor: HTeluguTheme.primary,
              ),
            );
          },
        ),
            SizedBox(height: 16),
        HProfessionalButton(
          text: HTeluguTheme.getTeluguEnglishText('change_password', 'Change Password'),
          variant: HProfessionalButtonVariant.secondary,
          size: HProfessionalButtonSize.lg,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(HTeluguTheme.getTeluguEnglishText('coming_soon', 'Coming Soon')),
                backgroundColor: HTeluguTheme.secondary,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingsSection(HResponsive r) {
    return HProfessionalCard(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HTeluguTheme.getTeluguEnglishText('settings', 'Settings'),
              style: HTeluguTheme.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: HTeluguTheme.onSurface,
              ),
            ),
            SizedBox(height: 24),
            _buildSettingItem(
              Icons.notifications,
              HTeluguTheme.getTeluguEnglishText('notifications', 'Notifications'),
              HTeluguTheme.getTeluguEnglishText('manage_notifications', 'Manage Notifications'),
              () {},
              r,
            ),
            SizedBox(height: 16),
            _buildSettingItem(
              Icons.privacy_tip,
              HTeluguTheme.getTeluguEnglishText('privacy', 'Privacy'),
              HTeluguTheme.getTeluguEnglishText('privacy_settings', 'Privacy Settings'),
              () {},
              r,
            ),
            SizedBox(height: 16),
            _buildSettingItem(
              Icons.help,
              HTeluguTheme.getTeluguEnglishText('help', 'Help & Support'),
              HTeluguTheme.getTeluguEnglishText('get_help', 'Get Help'),
              () {},
              r,
            ),
            SizedBox(height: 16),
            _buildSettingItem(
              Icons.info,
              HTeluguTheme.getTeluguEnglishText('about', 'About'),
              HTeluguTheme.getTeluguEnglishText('app_info', 'App Information'),
              () {},
              r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
    HResponsive r,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: HTeluguTheme.primary,
              size: 20,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: HTeluguTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: HTeluguTheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: HTeluguTheme.bodySmall.copyWith(
                      color: HTeluguTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: HTeluguTheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
