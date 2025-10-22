import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// Role Assignment Dialog
/// Dialog for assigning roles to users
class RoleAssignmentDialog extends ConsumerStatefulWidget {
  final User user;
  final Function(User) onRoleAssigned;

  const RoleAssignmentDialog({
    super.key,
    required this.user,
    required this.onRoleAssigned,
  });

  @override
  ConsumerState<RoleAssignmentDialog> createState() => _RoleAssignmentDialogState();
}

class _RoleAssignmentDialogState extends ConsumerState<RoleAssignmentDialog> {
  UserRole? _selectedRole;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Assign Role',
        style: IOSGradeTheme.headlineSmall.copyWith(
          color: IOSGradeTheme.onSurface,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User: ${widget.user.displayName}',
            style: IOSGradeTheme.bodyMedium.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Role:',
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...UserRole.values.map((role) => RadioListTile<UserRole>(
            title: Text(role.displayName),
            subtitle: Text(role.description),
            value: role,
            groupValue: _selectedRole,
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
          )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        IOSGradeButton(
          onPressed: _isLoading ? null : _assignRole,
          child: _isLoading 
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Assign Role'),
        ),
      ],
    );
  }

  Future<void> _assignRole() async {
    if (_selectedRole == null || _selectedRole == widget.user.role) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = RoleAssignmentRequest(
        userId: widget.user.id,
        newRole: _selectedRole!,
      );

      await ref.read(userManagementServiceProvider).assignRole(request);
      
      final updatedUser = widget.user.copyWith(role: _selectedRole!);
      widget.onRoleAssigned(updatedUser);
      
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to assign role: $e'),
            backgroundColor: IOSGradeTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
