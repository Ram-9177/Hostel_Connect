// lib/features/settings/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/state/app_state.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _darkMode = false;
  bool _biometricEnabled = false;
  bool _dataSharing = true;
  bool _analytics = true;
  bool _notificationsEnabled = true;
  bool _gatePassNotifications = true;
  bool _attendanceNotifications = true;
  bool _mealNotifications = true;
  bool _complaintNotifications = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Text(
                    (user?.firstName?[0] ?? 'S').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.role ?? 'Student',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Account Management Section
          _buildSectionHeader('Account Management'),
          _buildSettingsCard([
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: 'Change Password',
              subtitle: 'Update your password',
              onTap: () => _showChangePasswordDialog(),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.badge_outlined,
              title: 'Digital ID Card',
              subtitle: 'View your student ID',
              onTap: () => context.push('/id-card'),
            ),
          ]),

          const SizedBox(height: 16),

          // Appearance Section
          _buildSectionHeader('Appearance'),
          _buildSettingsCard([
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              subtitle: 'Switch to dark theme',
              value: _darkMode,
              onChanged: (value) => setState(() => _darkMode = value),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.language,
              title: 'Language',
              subtitle: _selectedLanguage,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showLanguageDialog(),
            ),
          ]),

          const SizedBox(height: 16),

          // Security & Privacy Section
          _buildSectionHeader('Security & Privacy'),
          _buildSettingsCard([
            _buildSwitchTile(
              icon: Icons.fingerprint,
              title: 'Biometric Login',
              subtitle: 'Use fingerprint/face ID',
              value: _biometricEnabled,
              onChanged: (value) => setState(() => _biometricEnabled = value),
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              icon: Icons.share,
              title: 'Data Sharing',
              subtitle: 'Share usage data for improvements',
              value: _dataSharing,
              onChanged: (value) => setState(() => _dataSharing = value),
            ),
            const Divider(height: 1),
            _buildSwitchTile(
              icon: Icons.analytics_outlined,
              title: 'Analytics',
              subtitle: 'Help improve the app',
              value: _analytics,
              onChanged: (value) => setState(() => _analytics = value),
            ),
          ]),

          const SizedBox(height: 16),

          // Notifications Section
          _buildSectionHeader('Notifications'),
          _buildSettingsCard([
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              title: 'Enable Notifications',
              subtitle: 'Master notification toggle',
              value: _notificationsEnabled,
              onChanged: (value) => setState(() {
                _notificationsEnabled = value;
                if (!value) {
                  _gatePassNotifications = false;
                  _attendanceNotifications = false;
                  _mealNotifications = false;
                  _complaintNotifications = false;
                }
              }),
            ),
            if (_notificationsEnabled) ...[
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.exit_to_app,
                title: 'Gate Pass Updates',
                subtitle: 'Approval and status changes',
                value: _gatePassNotifications,
                onChanged: (value) => setState(() => _gatePassNotifications = value),
                indent: 16,
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.check_circle_outline,
                title: 'Attendance Alerts',
                subtitle: 'Daily attendance reminders',
                value: _attendanceNotifications,
                onChanged: (value) => setState(() => _attendanceNotifications = value),
                indent: 16,
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.restaurant,
                title: 'Meal Updates',
                subtitle: 'Menu changes and preferences',
                value: _mealNotifications,
                onChanged: (value) => setState(() => _mealNotifications = value),
                indent: 16,
              ),
              const Divider(height: 1),
              _buildSwitchTile(
                icon: Icons.report_problem_outlined,
                title: 'Complaint Status',
                subtitle: 'Resolution and updates',
                value: _complaintNotifications,
                onChanged: (value) => setState(() => _complaintNotifications = value),
                indent: 16,
              ),
            ],
          ]),

          const SizedBox(height: 16),

          // Data & Storage Section
          _buildSectionHeader('Data & Storage'),
          _buildSettingsCard([
            _buildSettingsTile(
              icon: Icons.storage,
              title: 'Cache Size',
              subtitle: '24.5 MB',
              trailing: const Icon(Icons.info_outline, size: 20),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.download,
              title: 'Export My Data',
              subtitle: 'Download your data',
              onTap: () => _exportData(),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.delete_outline,
              title: 'Clear Cache',
              subtitle: 'Free up storage space',
              onTap: () => _clearCache(),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.delete_forever,
              title: 'Clear All Data',
              subtitle: 'Reset app to defaults',
              textColor: const Color(0xFFEF4444),
              onTap: () => _clearAllData(),
            ),
          ]),

          const SizedBox(height: 16),

          // About & Help Section
          _buildSectionHeader('About & Help'),
          _buildSettingsCard([
            _buildSettingsTile(
              icon: Icons.help_outline,
              title: 'Help & FAQs',
              subtitle: 'Get help and support',
              onTap: () => context.push('/help'),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              subtitle: 'Read our privacy policy',
              onTap: () => _openPrivacyPolicy(),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              subtitle: 'Read terms and conditions',
              onTap: () => _openTerms(),
            ),
            const Divider(height: 1),
            _buildSettingsTile(
              icon: Icons.info_outline,
              title: 'App Version',
              subtitle: '1.0.0 (Build 1)',
            ),
          ]),

          const SizedBox(height: 24),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _logout(context, ref),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? const Color(0xFF3B82F6)),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? const Color(0xFF1F2937),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    double indent = 0,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16 + indent, right: 8),
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)))
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF3B82F6),
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
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
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('తెలుగు (Telugu)'),
              value: 'Telugu',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting data... Check downloads folder')),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear 24.5 MB of cached data. Continue?'),
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

  void _clearAllData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will delete all local data and reset the app to defaults. You will need to log in again. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In real app, clear data and logout
              _logout(context, ref);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening privacy policy...')),
    );
  }

  void _openTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening terms of service...')),
    );
  }

  void _logout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).logout();
              Navigator.pop(context);
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
