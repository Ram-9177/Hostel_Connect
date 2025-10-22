import 'package:flutter/material.dart';
import 'package:hostelconnect/core/models/user_management_models.dart';
import 'package:hostelconnect/core/themes/ios_grade_theme.dart';
import 'package:hostelconnect/core/themes/ios_grade_components.dart';

/// Bulk Operations Widget
/// Widget for performing bulk operations on selected users
class BulkOperationsWidget extends StatefulWidget {
  final List<String> selectedUsers;
  final Function(String, List<String>) onBulkOperation;

  const BulkOperationsWidget({
    super.key,
    required this.selectedUsers,
    required this.onBulkOperation,
  });

  @override
  State<BulkOperationsWidget> createState() => _BulkOperationsWidgetState();
}

class _BulkOperationsWidgetState extends State<BulkOperationsWidget> {
  String? _selectedOperation;

  @override
  Widget build(BuildContext context) {
    if (widget.selectedUsers.isEmpty) {
      return const SizedBox.shrink();
    }

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
            'Bulk Operations (${widget.selectedUsers.length} selected)',
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedOperation,
                  hint: const Text('Select Operation'),
                  items: const [
                    DropdownMenuItem(
                      value: 'activate',
                      child: Text('Activate'),
                    ),
                    DropdownMenuItem(
                      value: 'deactivate',
                      child: Text('Deactivate'),
                    ),
                    DropdownMenuItem(
                      value: 'suspend',
                      child: Text('Suspend'),
                    ),
                    DropdownMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedOperation = value;
                    });
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
              IOSGradeButton(
                onPressed: _selectedOperation != null ? _performBulkOperation : null,
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _performBulkOperation() {
    if (_selectedOperation != null) {
      widget.onBulkOperation(_selectedOperation!, widget.selectedUsers);
      setState(() {
        _selectedOperation = null;
      });
    }
  }
}