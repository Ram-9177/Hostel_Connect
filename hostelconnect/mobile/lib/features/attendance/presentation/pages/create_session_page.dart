// lib/features/attendance/presentation/pages/create_session_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/attendance_models.dart';
import '../../../../core/services/attendance_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import '../widgets/session_mode_selector.dart';
import '../widgets/session_settings_widget.dart';

class CreateSessionPage extends ConsumerStatefulWidget {
  final String hostelId;

  const CreateSessionPage({
    super.key,
    required this.hostelId,
  });

  @override
  ConsumerState<CreateSessionPage> createState() => _CreateSessionPageState();
}

class _CreateSessionPageState extends ConsumerState<CreateSessionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  AttendanceMode _selectedMode = AttendanceMode.hybrid;
  SessionSettings _sessionSettings = const SessionSettings(
    gracePeriodMinutes: 15,
    allowManualEntry: true,
    allowLateEntry: true,
    autoCloseAfterInactivity: false,
    inactivityTimeoutMinutes: 30,
    requireReasonForAbsence: true,
    enableQRScanning: true,
    enableManualMarking: true,
    allowedRoles: ['warden', 'warden_head'],
  );
  
  DateTime? _scheduledStartTime;
  bool _isCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Create Attendance Session'),
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
              // Session Information
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
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _titleController,
                        label: 'Session Title',
                        hint: 'e.g., Morning Attendance',
                        prefixIcon: Icons.title,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter session title';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _descriptionController,
                        label: 'Description',
                        hint: 'Optional description for this session',
                        prefixIcon: Icons.description,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Mode Selection
              SessionModeSelector(
                selectedMode: _selectedMode,
                onModeChanged: (mode) {
                  setState(() {
                    _selectedMode = mode;
                    _updateSettingsForMode(mode);
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Session Settings
              SessionSettingsWidget(
                settings: _sessionSettings,
                onSettingsChanged: (settings) {
                  setState(() {
                    _sessionSettings = settings;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Scheduled Start Time
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Scheduled Start Time',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Leave empty to start immediately',
                        style: IOSGradeTheme.bodySmall.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _scheduledStartTime != null 
                                  ? _formatDateTime(_scheduledStartTime!)
                                  : 'Start immediately',
                              style: IOSGradeTheme.bodyMedium,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _selectScheduledTime,
                            icon: const Icon(Icons.access_time),
                            label: const Text('Set Time'),
                          ),
                          if (_scheduledStartTime != null)
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _scheduledStartTime = null;
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
              
              // Create Button
              SizedBox(
                width: double.infinity,
                child: IOSGradeButton(
                  text: _isCreating ? 'Creating Session...' : 'Create Session',
                  onPressed: _isCreating ? null : _createSession,
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

  void _updateSettingsForMode(AttendanceMode mode) {
    switch (mode) {
      case AttendanceMode.kiosk:
        setState(() {
          _sessionSettings = _sessionSettings.copyWith(
            enableQRScanning: true,
            enableManualMarking: false,
            allowManualEntry: false,
          );
        });
        break;
      case AttendanceMode.warden:
        setState(() {
          _sessionSettings = _sessionSettings.copyWith(
            enableQRScanning: false,
            enableManualMarking: true,
            allowManualEntry: true,
          );
        });
        break;
      case AttendanceMode.hybrid:
        setState(() {
          _sessionSettings = _sessionSettings.copyWith(
            enableQRScanning: true,
            enableManualMarking: true,
            allowManualEntry: true,
          );
        });
        break;
    }
  }

  Future<void> _selectScheduledTime() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _scheduledStartTime ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );
    
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_scheduledStartTime ?? now),
      );
      
      if (selectedTime != null) {
        setState(() {
          _scheduledStartTime = DateTime(
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

  Future<void> _createSession() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isCreating = true;
    });

    try {
      final request = CreateSessionRequest(
        hostelId: widget.hostelId,
        mode: _selectedMode,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty 
            ? _descriptionController.text.trim() 
            : null,
        settings: _sessionSettings,
        scheduledStartTime: _scheduledStartTime,
        metadata: {
          'createdBy': 'warden', // TODO: Get from auth context
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      final attendanceService = ref.read(attendanceServiceProvider);
      final result = await attendanceService.createSession(request);

      if (result.state == LoadState.success && result.data != null) {
        Toast.showSuccess(context, 'Session created successfully');
        
        // Navigate to session management or summary
        Navigator.pop(context, result.data);
      } else {
        Toast.showError(context, result.error ?? 'Failed to create session');
      }
    } catch (e) {
      Toast.showError(context, 'Error creating session: $e');
    } finally {
      setState(() {
        _isCreating = false;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

/// Session Mode Selector Widget
class SessionModeSelector extends StatelessWidget {
  final AttendanceMode selectedMode;
  final ValueChanged<AttendanceMode> onModeChanged;

  const SessionModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Mode',
              style: IOSGradeTheme.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose how students will mark their attendance',
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            
            ...AttendanceMode.values.map((mode) {
              return RadioListTile<AttendanceMode>(
                title: Text(mode.displayName),
                subtitle: Text(mode.description),
                value: mode,
                groupValue: selectedMode,
                onChanged: (value) {
                  onModeChanged(value!);
                },
                activeColor: IOSGradeTheme.primary,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

/// Session Settings Widget
class SessionSettingsWidget extends StatefulWidget {
  final SessionSettings settings;
  final ValueChanged<SessionSettings> onSettingsChanged;

  const SessionSettingsWidget({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  State<SessionSettingsWidget> createState() => _SessionSettingsWidgetState();
}

class _SessionSettingsWidgetState extends State<SessionSettingsWidget> {
  late SessionSettings _currentSettings;

  @override
  void initState() {
    super.initState();
    _currentSettings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session Settings',
              style: IOSGradeTheme.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Grace Period
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Grace Period (minutes)',
                    style: IOSGradeTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    initialValue: _currentSettings.gracePeriodMinutes.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    onChanged: (value) {
                      final minutes = int.tryParse(value);
                      if (minutes != null && minutes >= 0 && minutes <= 60) {
                        _updateSettings(_currentSettings.copyWith(gracePeriodMinutes: minutes));
                      }
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Allow Manual Entry
            SwitchListTile(
              title: const Text('Allow Manual Entry'),
              subtitle: const Text('Warden can manually mark attendance'),
              value: _currentSettings.allowManualEntry,
              onChanged: (value) {
                _updateSettings(_currentSettings.copyWith(allowManualEntry: value));
              },
              activeColor: IOSGradeTheme.primary,
            ),
            
            // Allow Late Entry
            SwitchListTile(
              title: const Text('Allow Late Entry'),
              subtitle: const Text('Students can mark attendance after grace period'),
              value: _currentSettings.allowLateEntry,
              onChanged: (value) {
                _updateSettings(_currentSettings.copyWith(allowLateEntry: value));
              },
              activeColor: IOSGradeTheme.primary,
            ),
            
            // Require Reason for Absence
            SwitchListTile(
              title: const Text('Require Reason for Absence'),
              subtitle: const Text('Students must provide reason when marked absent'),
              value: _currentSettings.requireReasonForAbsence,
              onChanged: (value) {
                _updateSettings(_currentSettings.copyWith(requireReasonForAbsence: value));
              },
              activeColor: IOSGradeTheme.primary,
            ),
            
            // Auto Close After Inactivity
            SwitchListTile(
              title: const Text('Auto Close After Inactivity'),
              subtitle: const Text('Automatically close session after period of inactivity'),
              value: _currentSettings.autoCloseAfterInactivity,
              onChanged: (value) {
                _updateSettings(_currentSettings.copyWith(autoCloseAfterInactivity: value));
              },
              activeColor: IOSGradeTheme.primary,
            ),
            
            if (_currentSettings.autoCloseAfterInactivity) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Inactivity Timeout (minutes)',
                      style: IOSGradeTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      initialValue: _currentSettings.inactivityTimeoutMinutes.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      onChanged: (value) {
                        final minutes = int.tryParse(value);
                        if (minutes != null && minutes >= 5 && minutes <= 120) {
                          _updateSettings(_currentSettings.copyWith(inactivityTimeoutMinutes: minutes));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _updateSettings(SessionSettings newSettings) {
    setState(() {
      _currentSettings = newSettings;
    });
    widget.onSettingsChanged(newSettings);
  }
}
