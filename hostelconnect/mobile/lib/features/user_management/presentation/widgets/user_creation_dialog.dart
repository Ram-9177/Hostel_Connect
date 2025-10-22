import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// User Creation Dialog
/// Dialog for creating new users with role assignment
class UserCreationDialog extends ConsumerStatefulWidget {
  final Function(User) onUserCreated;

  const UserCreationDialog({
    super.key,
    required this.onUserCreated,
  });

  @override
  ConsumerState<UserCreationDialog> createState() => _UserCreationDialogState();
}

class _UserCreationDialogState extends ConsumerState<UserCreationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  
  UserRole _selectedRole = UserRole.student;
  String? _selectedHostelId;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                'Create User',
                style: IOSGradeTheme.headlineSmall.copyWith(
                  color: IOSGradeTheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),
              IOSGradeTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter email address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              IOSGradeTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: 'Enter password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                    onPressed: _isLoading ? null : _createUser,
                    child: _isLoading 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create User'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final request = CreateUserRequest(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        role: _selectedRole,
        hostelId: _selectedHostelId,
      );

      final result = await ref.read(userManagementServiceProvider).createUser(request);

      if (result is LoadStateSuccess<User>) {
        widget.onUserCreated(result.data);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else if (result is LoadStateError<User>) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create user: ${result.error}'),
              backgroundColor: IOSGradeTheme.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating user: $e'),
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
