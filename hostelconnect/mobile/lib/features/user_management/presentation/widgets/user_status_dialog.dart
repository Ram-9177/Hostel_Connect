import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// User Status Dialog
/// Dialog for changing user status
class UserStatusDialog extends ConsumerStatefulWidget {
  final User user;
  final UserStatus newStatus;
  final Function(User) onStatusChanged;

  const UserStatusDialog({
    super.key,
    required this.user,
    required this.newStatus,
    required this.onStatusChanged,
  });

  @override
  ConsumerState<UserStatusDialog> createState() => _UserStatusDialogState();
}

class _UserStatusDialogState extends ConsumerState<UserStatusDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change User Status',
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
          const SizedBox(height: 8),
          Text(
            'Current Status: ${widget.user.status.displayName}',
            style: IOSGradeTheme.bodyMedium.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'New Status: ${widget.newStatus.displayName}',
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: _getStatusColor(widget.newStatus),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.newStatus.description,
            style: IOSGradeTheme.bodySmall.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        IOSGradeButton(
          onPressed: _isLoading ? null : _changeStatus,
          child: _isLoading 
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text('Change Status'),
        ),
      ],
    );
  }

  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.active:
        return IOSGradeTheme.success;
      case UserStatus.inactive:
        return IOSGradeTheme.warning;
      case UserStatus.suspended:
        return IOSGradeTheme.error;
      case UserStatus.pending:
        return IOSGradeTheme.info;
    }
  }

  Future<void> _changeStatus() async {
    if (widget.newStatus == widget.user.status) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final request = UserActivationRequest(
        userId: widget.user.id,
        status: widget.newStatus,
      );

      await ref.read(userManagementServiceProvider).updateUserStatus(request);
      
      final updatedUser = widget.user.copyWith(status: widget.newStatus);
      widget.onStatusChanged(updatedUser);
      
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change status: $e'),
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
