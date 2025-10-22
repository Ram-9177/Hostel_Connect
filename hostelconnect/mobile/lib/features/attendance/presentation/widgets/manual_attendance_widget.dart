// lib/features/attendance/presentation/widgets/manual_attendance_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/attendance_models.dart';
import '../../../../core/services/attendance_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class ManualAttendanceWidget extends ConsumerStatefulWidget {
  final String sessionId;
  final AttendanceSession session;
  final VoidCallback? onEntryAdded;

  const ManualAttendanceWidget({
    super.key,
    required this.sessionId,
    required this.session,
    this.onEntryAdded,
  });

  @override
  ConsumerState<ManualAttendanceWidget> createState() => _ManualAttendanceWidgetState();
}

class _ManualAttendanceWidgetState extends ConsumerState<ManualAttendanceWidget> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _reasonController = TextEditingController();
  final _notesController = TextEditingController();
  
  AttendanceStatus _selectedStatus = AttendanceStatus.present;
  DateTime? _customTimestamp;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: Text('Manual Entry - ${widget.session.title}'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Session Info
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Session Information',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mode: ${widget.session.mode.displayName}',
                        style: IOSGradeTheme.bodyMedium,
                      ),
                      Text(
                        'Started: ${_formatDateTime(widget.session.startTime)}',
                        style: IOSGradeTheme.bodyMedium,
                      ),
                      if (widget.session.gracePeriodEnd != null)
                        Text(
                          'Grace Period Ends: ${_formatDateTime(widget.session.gracePeriodEnd!)}',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: widget.session.isWithinGracePeriod 
                                ? IOSGradeTheme.success 
                                : IOSGradeTheme.error,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Student ID Input
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Information',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _studentIdController,
                        label: 'Student ID',
                        hint: 'Enter student ID or roll number',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter student ID';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Attendance Status Selection
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance Status',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ...AttendanceStatus.values.map((status) {
                        return RadioListTile<AttendanceStatus>(
                          title: Text(status.statusDisplayName),
                          subtitle: Text(_getStatusDescription(status)),
                          value: status,
                          groupValue: _selectedStatus,
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value!;
                            });
                          },
                          activeColor: IOSGradeTheme.primary,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Reason Input (Required for Absent/Late)
              if (_selectedStatus == AttendanceStatus.absent || _selectedStatus == AttendanceStatus.late)
                IOSGradeCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reason ${_selectedStatus == AttendanceStatus.absent ? 'for Absence' : 'for Being Late'}',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        IOSGradeInputField(
                          controller: _reasonController,
                          label: 'Reason',
                          hint: 'Enter reason for ${_selectedStatus.statusDisplayName.toLowerCase()}',
                          prefixIcon: Icons.info_outline,
                          maxLines: 3,
                          validator: (value) {
                            if ((_selectedStatus == AttendanceStatus.absent || _selectedStatus == AttendanceStatus.late) &&
                                (value == null || value.isEmpty)) {
                              return 'Reason is required for ${_selectedStatus.statusDisplayName.toLowerCase()}';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              
              if (_selectedStatus == AttendanceStatus.absent || _selectedStatus == AttendanceStatus.late)
                const SizedBox(height: 16),
              
              // Additional Notes
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Notes',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _notesController,
                        label: 'Notes',
                        hint: 'Any additional information (optional)',
                        prefixIcon: Icons.note_outlined,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Custom Timestamp (Optional)
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custom Timestamp',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Leave empty to use current time',
                        style: IOSGradeTheme.bodySmall.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _customTimestamp != null 
                                  ? _formatDateTime(_customTimestamp!)
                                  : 'Use current time',
                              style: IOSGradeTheme.bodyMedium,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _selectCustomTimestamp,
                            icon: const Icon(Icons.access_time),
                            label: const Text('Set Time'),
                          ),
                          if (_customTimestamp != null)
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _customTimestamp = null;
                                });
                              },
                              icon: const Icon(Icons.clear),
                              label: const Text('Clear'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: IOSGradeButton(
                  text: _isSubmitting ? 'Adding Entry...' : 'Add Manual Entry',
                  onPressed: _isSubmitting ? null : _submitManualEntry,
                  icon: Icons.add_circle_outline,
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusDescription(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'Student is present and on time';
      case AttendanceStatus.absent:
        return 'Student is not present';
      case AttendanceStatus.late:
        return 'Student arrived late but within grace period';
      case AttendanceStatus.excused:
        return 'Student has a valid excuse for absence';
    }
  }

  Future<void> _selectCustomTimestamp() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _customTimestamp ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 1)),
    );
    
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_customTimestamp ?? now),
      );
      
      if (selectedTime != null) {
        setState(() {
          _customTimestamp = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _submitManualEntry() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = ManualEntryRequest(
        sessionId: widget.sessionId,
        studentId: _studentIdController.text.trim(),
        reason: _reasonController.text.trim(),
        status: _selectedStatus,
        notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
        customTimestamp: _customTimestamp,
      );

      final attendanceService = ref.read(attendanceServiceProvider);
      final result = await attendanceService.addManualEntry(request);

      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Manual entry added successfully');
        widget.onEntryAdded?.call();
        Navigator.pop(context);
      } else {
        Toast.showError(context, result.error ?? 'Failed to add manual entry');
      }
    } catch (e) {
      Toast.showError(context, 'Error adding manual entry: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// Quick Manual Entry Widget for common scenarios
class QuickManualEntryWidget extends ConsumerWidget {
  final String sessionId;
  final AttendanceSession session;
  final VoidCallback? onEntryAdded;

  const QuickManualEntryWidget({
    super.key,
    required this.sessionId,
    required this.session,
    this.onEntryAdded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Manual Entry',
              style: IOSGradeTheme.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Common scenarios for quick entry',
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showQuickEntryDialog(context, AttendanceStatus.present, 'Present'),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark Present'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOSGradeTheme.success,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showQuickEntryDialog(context, AttendanceStatus.absent, 'Absent'),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Mark Absent'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOSGradeTheme.error,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showQuickEntryDialog(context, AttendanceStatus.late, 'Late'),
                    icon: const Icon(Icons.schedule),
                    label: const Text('Mark Late'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOSGradeTheme.warning,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showQuickEntryDialog(context, AttendanceStatus.excused, 'Excused'),
                    icon: const Icon(Icons.info),
                    label: const Text('Mark Excused'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: IOSGradeTheme.info,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickEntryDialog(BuildContext context, AttendanceStatus status, String statusName) {
    final studentIdController = TextEditingController();
    final reasonController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quick Entry - $statusName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                hintText: 'Enter student ID',
              ),
            ),
            if (status == AttendanceStatus.absent || status == AttendanceStatus.late) ...[
              const SizedBox(height: 16),
              TextField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  hintText: 'Enter reason for $statusName',
                ),
                maxLines: 2,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (studentIdController.text.trim().isEmpty) {
                Toast.showError(context, 'Please enter student ID');
                return;
              }
              
              if ((status == AttendanceStatus.absent || status == AttendanceStatus.late) &&
                  reasonController.text.trim().isEmpty) {
                Toast.showError(context, 'Please enter reason');
                return;
              }
              
              Navigator.pop(context);
              
              try {
                final request = ManualEntryRequest(
                  sessionId: sessionId,
                  studentId: studentIdController.text.trim(),
                  reason: reasonController.text.trim(),
                  status: status,
                );

                final attendanceService = ref.read(attendanceServiceProvider);
                final result = await attendanceService.addManualEntry(request);

                if (result.state == LoadState.success) {
                  Toast.showSuccess(context, 'Entry added successfully');
                  onEntryAdded?.call();
                } else {
                  Toast.showError(context, result.error ?? 'Failed to add entry');
                }
              } catch (e) {
                Toast.showError(context, 'Error adding entry: $e');
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
