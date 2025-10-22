import 'package:flutter/material.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// User List Item Widget
/// Individual user item in the user list
class UserListItem extends StatelessWidget {
  final User user;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Function(String) onAction;

  const UserListItem({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected 
            ? IOSGradeTheme.primary.withOpacity(0.1)
            : IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected 
              ? IOSGradeTheme.primary
              : IOSGradeTheme.outline.withOpacity(0.3),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                backgroundColor: _getRoleColor(user.role).withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: _getRoleColor(user.role),
                ),
              ),
              const SizedBox(width: 12),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName,
                      style: IOSGradeTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: IOSGradeTheme.bodySmall.copyWith(
                        color: IOSGradeTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Role Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getRoleColor(user.role).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user.roleDisplayName,
                            style: IOSGradeTheme.bodySmall.copyWith(
                              color: _getRoleColor(user.role),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(user.status).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user.statusDisplayName,
                            style: IOSGradeTheme.bodySmall.copyWith(
                              color: _getStatusColor(user.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              PopupMenuButton<String>(
                onSelected: onAction,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view_details',
                    child: ListTile(
                      leading: Icon(Icons.visibility),
                      title: Text('View Details'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'assign_role',
                    child: ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      title: Text('Assign Role'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'reset_password',
                    child: ListTile(
                      leading: Icon(Icons.lock_reset),
                      title: Text('Reset Password'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  if (user.status == UserStatus.active) ...[
                    const PopupMenuItem(
                      value: 'deactivate',
                      child: ListTile(
                        leading: Icon(Icons.pause_circle),
                        title: Text('Deactivate'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'suspend',
                      child: ListTile(
                        leading: Icon(Icons.block),
                        title: Text('Suspend'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ] else ...[
                    const PopupMenuItem(
                      value: 'activate',
                      child: ListTile(
                        leading: Icon(Icons.play_circle),
                        title: Text('Activate'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, color: Colors.red),
                      title: Text('Delete', style: TextStyle(color: Colors.red)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.student:
        return Colors.green;
      case UserRole.warden:
        return Colors.blue;
      case UserRole.wardenHead:
        return Colors.orange;
      case UserRole.chef:
        return Colors.purple;
      case UserRole.superAdmin:
        return Colors.red;
    }
  }

  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return Colors.green;
      case UserStatus.inactive:
        return Colors.grey;
      case UserStatus.suspended:
        return Colors.orange;
      case UserStatus.pending:
        return Colors.blue;
    }
  }
}
