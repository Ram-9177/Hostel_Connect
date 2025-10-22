import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// User Edit Dialog
/// Dialog for editing existing user information
class UserEditDialog extends ConsumerStatefulWidget {
  final User user;
  final Function(User) onUserUpdated;

  const UserEditDialog({
    super.key,
    required this.user,
    required this.onUserUpdated,
  });

  @override
  ConsumerState<UserEditDialog> createState() => _UserEditDialogState();
}

class _UserEditDialogState extends ConsumerState<UserEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  UserRole _selectedRole = UserRole.student;
  UserStatus _selectedStatus = UserStatus.active;
  String? _selectedHostelId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _phoneController.text = widget.user.phone ?? '';
    _selectedRole = widget.user.role;
    _selectedStatus = widget.user.status;
    _selectedHostelId = widget.user.hostelId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit User',
                style: IOSGradeTheme.headlineSmall.copyWith(
                  color: IOSGradeTheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              IOSGradeTextField(
                controller: _nameController,
                label: 'Name',
                hintText: 'Enter user name',
              ),
              const SizedBox(height: 16),
              IOSGradeTextField(
                controller: _phoneController,
                label: 'Phone',
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              Text(
                'Role',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                items: UserRole.values.map((role) => DropdownMenuItem(
                  value: role,
                  child: Text(role.displayName),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedRole = value;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                  ),
                  filled: true,
                  fillColor: IOSGradeTheme.surface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Status',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<UserStatus>(
                value: _selectedStatus,
                items: UserStatus.values.map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status.displayName),
                )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                  ),
                  filled: true,
                  fillColor: IOSGradeTheme.surface,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  IOSGradeButton(
                    onPressed: _isLoading ? null : _updateUser,
                    child: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Update User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = UpdateUserRequest(
        name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        role: _selectedRole,
        status: _selectedStatus,
        hostelId: _selectedHostelId,
      );

      final result = await ref.read(userManagementServiceProvider).updateUser(
        widget.user.id,
        request,
      );

      if (result is LoadStateSuccess<User>) {
        widget.onUserUpdated(result.data);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else if (result is LoadStateError<User>) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update user: ${result.error}'),
              backgroundColor: IOSGradeTheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating user: $e'),
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
