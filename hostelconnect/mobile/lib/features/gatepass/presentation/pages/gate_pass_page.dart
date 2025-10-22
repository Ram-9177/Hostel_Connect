// lib/features/gatepass/presentation/pages/gate_pass_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/gatepass_models.dart';
import '../../../../core/providers/gatepass_providers.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import '../widgets/qr_unlock_widget.dart';
import '../widgets/gate_scan_history_widget.dart';
import 'create_gatepass_request_page.dart';

class GatePassPage extends ConsumerStatefulWidget {
  const GatePassPage({super.key});

  @override
  ConsumerState<GatePassPage> createState() => _GatePassPageState();
}

class _GatePassPageState extends ConsumerState<GatePassPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1'; // TODO: Get from auth context

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardData = ref.watch(gatepassDashboardProvider(_selectedHostelId));
    final recentScans = ref.watch(recentScansProvider(_selectedHostelId));

    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Gate Pass Management'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(gatepassDashboardProvider(_selectedHostelId));
              ref.invalidate(recentScansProvider(_selectedHostelId));
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createGatePassRequest,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'My Passes', icon: Icon(Icons.card_membership)),
            Tab(text: 'Scan History', icon: Icon(Icons.history)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(dashboardData, recentScans),
          _buildMyPassesTab(),
          _buildScanHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createGatePassRequest,
        icon: const Icon(Icons.add),
        label: const Text('New Request'),
        backgroundColor: IOSGradeTheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildDashboardTab(LoadStateData<GatePassDashboardData> dashboardData, LoadStateData<List<GateScanEvent>> recentScans) {
    if (dashboardData.state == LoadState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (dashboardData.state == LoadState.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: IOSGradeTheme.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load dashboard',
              style: IOSGradeTheme.titleLarge.copyWith(
                color: IOSGradeTheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dashboardData.error ?? 'Unknown error',
              style: IOSGradeTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(gatepassDashboardProvider(_selectedHostelId));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final data = dashboardData.data!;

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(gatepassDashboardProvider(_selectedHostelId));
        ref.invalidate(recentScansProvider(_selectedHostelId));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    data.pendingApprovals.toString(),
                    Icons.pending,
                    IOSGradeTheme.warning,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    'Active',
                    data.activePasses.toString(),
                    Icons.play_circle,
                    IOSGradeTheme.success,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Overdue',
                    data.overduePasses.toString(),
                    Icons.schedule,
                    IOSGradeTheme.error,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatCard(
                    'Today',
                    data.todayDepartures.toString(),
                    Icons.exit_to_app,
                    IOSGradeTheme.info,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Recent Requests
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Recent Requests',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            _tabController.animateTo(1);
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    if (data.recentRequests.isEmpty)
                      Center(
                        child: Text(
                          'No recent requests',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      )
                    else
                      ...data.recentRequests.take(5).map((request) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                _getStatusIcon(request.status),
                                color: _getStatusColor(request.status),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  request.studentName,
                                  style: IOSGradeTheme.bodyMedium,
                                ),
                              ),
                              Text(
                                request.type.displayName,
                                style: IOSGradeTheme.bodySmall.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Recent Scans
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Recent Scans',
                          style: IOSGradeTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            _tabController.animateTo(2);
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    if (recentScans.data?.isEmpty ?? true)
                      Center(
                        child: Text(
                          'No recent scans',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      )
                    else
                      ...(recentScans.data ?? []).take(5).map((scan) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                _getScanTypeIcon(scan.scanType),
                                color: _getScanTypeColor(scan.scanType),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  scan.studentName,
                                  style: IOSGradeTheme.bodyMedium,
                                ),
                              ),
                              Text(
                                _formatTime(scan.scanTime),
                                style: IOSGradeTheme.bodySmall.copyWith(
                                  color: IOSGradeTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Quick Actions
            IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _createGatePassRequest,
                            icon: const Icon(Icons.add),
                            label: const Text('New Request'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: IOSGradeTheme.primary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _scanQRCode,
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scan QR'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: IOSGradeTheme.success,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPassesTab() {
    // TODO: Implement student's gate passes tab
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.card_membership,
            color: IOSGradeTheme.textSecondary,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'My Gate Passes',
            style: IOSGradeTheme.titleLarge.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your gate pass requests and QR codes will appear here',
            style: IOSGradeTheme.bodyMedium.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _createGatePassRequest,
            icon: const Icon(Icons.add),
            label: const Text('Create New Request'),
          ),
        ],
      ),
    );
  }

  Widget _buildScanHistoryTab() {
    return GateScanHistoryWidget(hostelId: _selectedHostelId);
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(GatePassStatus status) {
    switch (status) {
      case GatePassStatus.pending:
        return IOSGradeTheme.warning;
      case GatePassStatus.approved:
        return IOSGradeTheme.success;
      case GatePassStatus.rejected:
        return IOSGradeTheme.error;
      case GatePassStatus.active:
        return IOSGradeTheme.info;
      case GatePassStatus.completed:
        return IOSGradeTheme.textSecondary;
      case GatePassStatus.overdue:
        return IOSGradeTheme.error;
      case GatePassStatus.cancelled:
        return IOSGradeTheme.textSecondary;
    }
  }

  IconData _getStatusIcon(GatePassStatus status) {
    switch (status) {
      case GatePassStatus.pending:
        return Icons.pending;
      case GatePassStatus.approved:
        return Icons.check_circle;
      case GatePassStatus.rejected:
        return Icons.cancel;
      case GatePassStatus.active:
        return Icons.play_circle;
      case GatePassStatus.completed:
        return Icons.check;
      case GatePassStatus.overdue:
        return Icons.schedule;
      case GatePassStatus.cancelled:
        return Icons.close;
    }
  }

  Color _getScanTypeColor(GateScanType scanType) {
    switch (scanType) {
      case GateScanType.departure:
        return IOSGradeTheme.success;
      case GateScanType.return_:
        return IOSGradeTheme.info;
      case GateScanType.emergencyDeparture:
        return IOSGradeTheme.warning;
      case GateScanType.emergencyReturn:
        return IOSGradeTheme.error;
    }
  }

  IconData _getScanTypeIcon(GateScanType scanType) {
    switch (scanType) {
      case GateScanType.departure:
        return Icons.exit_to_app;
      case GateScanType.return_:
        return Icons.login;
      case GateScanType.emergencyDeparture:
        return Icons.warning;
      case GateScanType.emergencyReturn:
        return Icons.warning;
    }
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _createGatePassRequest() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGatePassRequestPage(hostelId: _selectedHostelId),
      ),
    );

    if (result == true) {
      Toast.showSuccess(context, 'Gate pass request created successfully');
      ref.invalidate(gatepassDashboardProvider(_selectedHostelId));
    }
  }

  Future<void> _scanQRCode() async {
    // TODO: Implement QR code scanning for gate security
    Toast.showInfo(context, 'QR code scanning functionality will be implemented');
  }
}

/// Create Gate Pass Request Page
class CreateGatePassRequestPage extends ConsumerStatefulWidget {
  final String hostelId;

  const CreateGatePassRequestPage({
    super.key,
    required this.hostelId,
  });

  @override
  ConsumerState<CreateGatePassRequestPage> createState() => _CreateGatePassRequestPageState();
}

class _CreateGatePassRequestPageState extends ConsumerState<CreateGatePassRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _destinationController = TextEditingController();
  final _contactController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime? _departureTime;
  DateTime? _returnTime;
  GatePassType _selectedType = GatePassType.personal;
  GatePassPriority _selectedPriority = GatePassPriority.medium;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reasonController.dispose();
    _destinationController.dispose();
    _contactController.dispose();
    _emergencyContactController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Create Gate Pass Request'),
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
              // Request Type Selection
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request Type',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ...GatePassType.values.map((type) {
                        return RadioListTile<GatePassType>(
                          title: Text(type.displayName),
                          subtitle: Text(type.description),
                          value: type,
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value!;
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
              
              // Priority Selection
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Priority Level',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ...GatePassPriority.values.map((priority) {
                        return RadioListTile<GatePassPriority>(
                          title: Text(priority.displayName),
                          subtitle: Text(priority.description),
                          value: priority,
                          groupValue: _selectedPriority,
                          onChanged: (value) {
                            setState(() {
                              _selectedPriority = value!;
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
              
              // Reason
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reason for Gate Pass',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _reasonController,
                        label: 'Reason',
                        hint: 'Enter the reason for your gate pass request',
                        prefixIcon: Icons.info_outline,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a reason';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Destination
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destination Details',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _destinationController,
                        label: 'Destination',
                        hint: 'Where are you going?',
                        prefixIcon: Icons.location_on,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter destination';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _contactController,
                        label: 'Contact Number',
                        hint: 'Your contact number',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      IOSGradeInputField(
                        controller: _emergencyContactController,
                        label: 'Emergency Contact (Optional)',
                        hint: 'Emergency contact number',
                        prefixIcon: Icons.emergency,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Time Selection
              IOSGradeCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Timing',
                        style: IOSGradeTheme.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Departure Time',
                                  style: IOSGradeTheme.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: _selectDepartureTime,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: IOSGradeTheme.border),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time),
                                        const SizedBox(width: 8),
                                        Text(
                                          _departureTime != null
                                              ? _formatDateTime(_departureTime!)
                                              : 'Select departure time',
                                          style: IOSGradeTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expected Return',
                                  style: IOSGradeTheme.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: _selectReturnTime,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: IOSGradeTheme.border),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.access_time),
                                        const SizedBox(width: 8),
                                        Text(
                                          _returnTime != null
                                              ? _formatDateTime(_returnTime!)
                                              : 'Select return time',
                                          style: IOSGradeTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
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
                        label: 'Notes (Optional)',
                        hint: 'Any additional information',
                        prefixIcon: Icons.note_outlined,
                        maxLines: 3,
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
                  text: _isSubmitting ? 'Submitting Request...' : 'Submit Request',
                  onPressed: _isSubmitting ? null : _submitRequest,
                  icon: Icons.send,
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDepartureTime() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _departureTime ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 7)),
    );
    
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_departureTime ?? now),
      );
      
      if (selectedTime != null) {
        setState(() {
          _departureTime = DateTime(
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

  Future<void> _selectReturnTime() async {
    final now = DateTime.now();
    final initialDate = _returnTime ?? _departureTime ?? now;
    
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _departureTime ?? now,
      lastDate: now.add(const Duration(days: 7)),
    );
    
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_returnTime ?? initialDate),
      );
      
      if (selectedTime != null) {
        setState(() {
          _returnTime = DateTime(
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

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_departureTime == null) {
      Toast.showError(context, 'Please select departure time');
      return;
    }

    if (_returnTime == null) {
      Toast.showError(context, 'Please select return time');
      return;
    }

    if (_returnTime!.isBefore(_departureTime!)) {
      Toast.showError(context, 'Return time must be after departure time');
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = GatePassRequest(
        studentId: 'student_1', // TODO: Get from auth context
        studentName: 'John Doe', // TODO: Get from auth context
        studentRollNumber: 'STU001', // TODO: Get from auth context
        hostelId: widget.hostelId,
        reason: _reasonController.text.trim(),
        departureTime: _departureTime!,
        expectedReturnTime: _returnTime!,
        destination: _destinationController.text.trim(),
        contactNumber: _contactController.text.trim(),
        emergencyContact: _emergencyContactController.text.trim().isNotEmpty 
            ? _emergencyContactController.text.trim() 
            : null,
        notes: _notesController.text.trim().isNotEmpty 
            ? _notesController.text.trim() 
            : null,
        type: _selectedType,
        priority: _selectedPriority,
      );

      final gatepassService = ref.read(gatepassServiceProvider);
      final result = await gatepassService.createGatePassRequest(request);

      if (result.state == LoadState.success) {
        Toast.showSuccess(context, 'Gate pass request submitted successfully');
        Navigator.pop(context, true);
      } else {
        Toast.showError(context, result.error ?? 'Failed to submit request');
      }
    } catch (e) {
      Toast.showError(context, 'Error submitting request: $e');
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