import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/providers/user_management_providers.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// User Filters Widget
/// Widget for filtering users by various criteria
class UserFiltersWidget extends ConsumerStatefulWidget {
  final Function(UserSearchFilters) onFiltersChanged;

  const UserFiltersWidget({
    super.key,
    required this.onFiltersChanged,
  });

  @override
  ConsumerState<UserFiltersWidget> createState() => _UserFiltersWidgetState();
}

class _UserFiltersWidgetState extends ConsumerState<UserFiltersWidget> {
  UserRole? _selectedRole;
  UserStatus? _selectedStatus;
  String? _selectedHostelId;
  DateTime? _createdAfter;
  DateTime? _createdBefore;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<UserRole?>(
                  value: _selectedRole,
                  hint: const Text('All Roles'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Roles'),
                    ),
                    ...UserRole.values.map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role.displayName),
                    )),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                    });
                    _applyFilters();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                    ),
                    filled: true,
                    fillColor: IOSGradeTheme.surface,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<UserStatus?>(
                  value: _selectedStatus,
                  hint: const Text('All Status'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Status'),
                    ),
                    ...UserStatus.values.map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status.displayName),
                    )),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                    _applyFilters();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                    ),
                    filled: true,
                    fillColor: IOSGradeTheme.surface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Hostel ID',
                    hintText: 'Enter hostel ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
                    ),
                    filled: true,
                    fillColor: IOSGradeTheme.surface,
                  ),
                  onChanged: (value) {
                    _selectedHostelId = value.isEmpty ? null : value;
                    _applyFilters();
                  },
                ),
              ),
              const SizedBox(width: 12),
              IOSGradeButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    final filters = UserSearchFilters(
      role: _selectedRole,
      status: _selectedStatus,
      hostelId: _selectedHostelId,
      createdAfter: _createdAfter,
      createdBefore: _createdBefore,
    );
    widget.onFiltersChanged(filters);
  }

  void _clearFilters() {
    setState(() {
      _selectedRole = null;
      _selectedStatus = null;
      _selectedHostelId = null;
      _createdAfter = null;
      _createdBefore = null;
    });
    _applyFilters();
  }
}