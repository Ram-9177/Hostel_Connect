import 'package:flutter/material.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// Staff Filters Widget
/// Specialized filters for staff members
class StaffFiltersWidget extends StatelessWidget {
  final UserRole? selectedRole;
  final UserStatus? selectedStatus;
  final String? selectedHostelId;
  final Function({
    UserRole? role,
    UserStatus? status,
    String? hostelId,
  }) onFiltersChanged;

  const StaffFiltersWidget({
    super.key,
    required this.selectedRole,
    required this.selectedStatus,
    required this.selectedHostelId,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 20),
              const SizedBox(width: 8),
              Text(
                'Staff Filters',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              // Role Filter (Staff-specific roles)
              _buildRoleFilter(),
              // Status Filter
              _buildStatusFilter(),
              // Hostel Filter
              _buildHostelFilter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserRole?>(
          value: selectedRole,
          hint: const Text('Role'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Roles'),
            ),
            // Only staff roles
            const DropdownMenuItem(
              value: UserRole.warden,
              child: Text('Warden'),
            ),
            const DropdownMenuItem(
              value: UserRole.wardenHead,
              child: Text('Warden Head'),
            ),
            const DropdownMenuItem(
              value: UserRole.chef,
              child: Text('Chef'),
            ),
          ],
          onChanged: (value) {
            onFiltersChanged(role: value);
          },
        ),
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserStatus?>(
          value: selectedStatus,
          hint: const Text('Status'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Status'),
            ),
            ...UserStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status.displayName),
              );
            }),
          ],
          onChanged: (value) {
            onFiltersChanged(status: value);
          },
        ),
      ),
    );
  }

  Widget _buildHostelFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedHostelId,
          hint: const Text('Hostel'),
          items: const [
            DropdownMenuItem(
              value: null,
              child: Text('All Hostels'),
            ),
            // TODO: Add actual hostels from provider
          ],
          onChanged: (value) {
            onFiltersChanged(hostelId: value);
          },
        ),
      ),
    );
  }

  void _clearFilters() {
    onFiltersChanged(role: null, status: null, hostelId: null);
  }
}

/// Student Filters Widget
/// Specialized filters for students
class StudentFiltersWidget extends StatelessWidget {
  final UserStatus? selectedStatus;
  final String? selectedHostelId;
  final Function({
    UserStatus? status,
    String? hostelId,
  }) onFiltersChanged;

  const StudentFiltersWidget({
    super.key,
    required this.selectedStatus,
    required this.selectedHostelId,
    required this.onFiltersChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 20),
              const SizedBox(width: 8),
              Text(
                'Student Filters',
                style: IOSGradeTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              // Status Filter
              _buildStatusFilter(),
              // Hostel Filter
              _buildHostelFilter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UserStatus?>(
          value: selectedStatus,
          hint: const Text('Status'),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('All Status'),
            ),
            ...UserStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Text(status.displayName),
              );
            }),
          ],
          onChanged: (value) {
            onFiltersChanged(status: value);
          },
        ),
      ),
    );
  }

  Widget _buildHostelFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: IOSGradeTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: IOSGradeTheme.outline),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: selectedHostelId,
          hint: const Text('Hostel'),
          items: const [
            DropdownMenuItem(
              value: null,
              child: Text('All Hostels'),
            ),
            // TODO: Add actual hostels from provider
          ],
          onChanged: (value) {
            onFiltersChanged(hostelId: value);
          },
        ),
      ),
    );
  }

  void _clearFilters() {
    onFiltersChanged(status: null, hostelId: null);
  }
}
