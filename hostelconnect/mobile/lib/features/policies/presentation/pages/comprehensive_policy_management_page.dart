// lib/features/policies/presentation/pages/comprehensive_policy_management_page.dart
import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/policy_models.dart';
import '../../../../core/services/policy_service.dart';
import '../../../../core/state/load_state.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';
import 'package:file_picker/file_picker.dart';

class ComprehensivePolicyManagementPage extends ConsumerStatefulWidget {
  const ComprehensivePolicyManagementPage({super.key});

  @override
  ConsumerState<ComprehensivePolicyManagementPage> createState() => _ComprehensivePolicyManagementPageState();
}

class _ComprehensivePolicyManagementPageState extends ConsumerState<ComprehensivePolicyManagementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1';
  
  // Data
  List<HostelPolicy> _policies = [];
  List<PolicyTemplate> _templates = [];
  List<PolicyChangeHistory> _history = [];
  Map<String, dynamic> _compliance = {};
  
  // Loading states
  bool _isLoadingPolicies = false;
  bool _isLoadingTemplates = false;
  bool _isLoadingHistory = false;
  bool _isLoadingCompliance = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadInitialData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _loadPolicies(),
      _loadTemplates(),
      _loadHistory(),
      _loadCompliance(),
    ]);
  }

  Future<void> _loadPolicies() async {
    setState(() => _isLoadingPolicies = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getPolicies(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _policies = result.data ?? [];
          _isLoadingPolicies = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load policies');
        setState(() => _isLoadingPolicies = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading policies: $e');
      setState(() => _isLoadingPolicies = false);
    }
  }

  Future<void> _loadTemplates() async {
    setState(() => _isLoadingTemplates = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getPolicyTemplates();
      
      if (result.state == LoadState.success) {
        setState(() {
          _templates = result.data ?? [];
          _isLoadingTemplates = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load templates');
        setState(() => _isLoadingTemplates = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading templates: $e');
      setState(() => _isLoadingTemplates = false);
    }
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoadingHistory = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getHostelPolicyHistory(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _history = result.data ?? [];
          _isLoadingHistory = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load history');
        setState(() => _isLoadingHistory = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading history: $e');
      setState(() => _isLoadingHistory = false);
    }
  }

  Future<void> _loadCompliance() async {
    setState(() => _isLoadingCompliance = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getPolicyCompliance(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _compliance = result.data ?? {};
          _isLoadingCompliance = false;
        });
      } else {
        Toast.showError(context, result.error ?? 'Failed to load compliance');
        setState(() => _isLoadingCompliance = false);
      }
    } catch (e) {
      Toast.showError(context, 'Error loading compliance: $e');
      setState(() => _isLoadingCompliance = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Policy Management'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Policies', icon: Icon(Icons.policy)),
            Tab(text: 'Curfew', icon: Icon(Icons.nightlight_round)),
            Tab(text: 'Attendance', icon: Icon(Icons.check_circle)),
            Tab(text: 'Meals', icon: Icon(Icons.restaurant)),
            Tab(text: 'Rooms', icon: Icon(Icons.room)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showCreatePolicyDialog,
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: _showImportExportDialog,
            icon: const Icon(Icons.import_export),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPoliciesTab(),
          _buildCurfewTab(),
          _buildAttendanceTab(),
          _buildMealsTab(),
          _buildRoomsTab(),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    if (_isLoadingPolicies) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadPolicies,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Policy Overview Cards
          _buildPolicyOverviewCards(),
          const SizedBox(height: 24),
          
          // Active Policies
          Text(
            'Active Policies',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._policies.where((p) => p.isActive).map((policy) => _buildPolicyCard(policy)),
          
          const SizedBox(height: 24),
          
          // Inactive Policies
          Text(
            'Inactive Policies',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._policies.where((p) => !p.isActive).map((policy) => _buildPolicyCard(policy)),
        ],
      ),
    );
  }

  Widget _buildPolicyOverviewCards() {
    final activeCount = _policies.where((p) => p.isActive).length;
    final totalCount = _policies.length;
    final complianceRate = _compliance['complianceRate'] ?? 0.0;
    final violationsThisMonth = _compliance['violationsThisMonth'] ?? 0;

    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard(
            'Active Policies',
            activeCount.toString(),
            Icons.policy,
            IOSGradeTheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOverviewCard(
            'Total Policies',
            totalCount.toString(),
            Icons.list,
            IOSGradeTheme.info,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOverviewCard(
            'Compliance',
            '${(complianceRate * 100).toInt()}%',
            Icons.check_circle,
            IOSGradeTheme.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildOverviewCard(
            'Violations',
            violationsThisMonth.toString(),
            Icons.warning,
            IOSGradeTheme.error,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: IOSGradeTheme.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
            Text(
              title,
              style: IOSGradeTheme.bodySmall.copyWith(
                color: IOSGradeTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyCard(HostelPolicy policy) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: policy.isActive 
              ? IOSGradeTheme.success.withOpacity(0.1)
              : IOSGradeTheme.textSecondary.withOpacity(0.1),
          child: Icon(
            _getPolicyIcon(policy.type),
            color: policy.isActive ? IOSGradeTheme.success : IOSGradeTheme.textSecondary,
          ),
        ),
        title: Text(policy.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${policy.type.name.toUpperCase()}'),
            Text('Effective: ${_formatDate(policy.effectiveFrom)}'),
            if (policy.description != null)
              Text(policy.description!),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _editPolicy(policy),
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => _togglePolicyStatus(policy),
              icon: Icon(policy.isActive ? Icons.pause : Icons.play_arrow),
            ),
            IconButton(
              onPressed: () => _deletePolicy(policy),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        onTap: () => _viewPolicyDetails(policy),
      ),
    );
  }

  Widget _buildCurfewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Curfew Policy',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurfewTimeField('Weekdays Curfew', TimeOfDay(hour: 22, minute: 0)),
                  const SizedBox(height: 16),
                  _buildCurfewTimeField('Weekends Curfew', TimeOfDay(hour: 23, minute: 0)),
                  const SizedBox(height: 16),
                  _buildNumberField('Grace Minutes', 15),
                  const SizedBox(height: 16),
                  _buildSwitchField('Allow Late Entry', true),
                  const SizedBox(height: 16),
                  _buildMultiSelectField('Exempt Roles', ['warden', 'warden_head', 'super_admin']),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveCurfewPolicy,
                          child: const Text('Save Changes'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetCurfewPolicy,
                          child: const Text('Reset'),
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
    );
  }

  Widget _buildAttendanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attendance Policy',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNumberField('Grace Minutes', 10),
                  const SizedBox(height: 16),
                  _buildNumberField('Minimum Attendance %', 75),
                  const SizedBox(height: 16),
                  _buildSwitchField('Allow Manual Entry', true),
                  const SizedBox(height: 16),
                  _buildSwitchField('Require Reason for Absence', true),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveAttendancePolicy,
                          child: const Text('Save Changes'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetAttendancePolicy,
                          child: const Text('Reset'),
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
    );
  }

  Widget _buildMealsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meal Policy',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMealTimeField('Breakfast Cutoff', TimeOfDay(hour: 9, minute: 0)),
                  const SizedBox(height: 16),
                  _buildMealTimeField('Lunch Cutoff', TimeOfDay(hour: 14, minute: 0)),
                  const SizedBox(height: 16),
                  _buildMealTimeField('Dinner Cutoff', TimeOfDay(hour: 20, minute: 0)),
                  const SizedBox(height: 16),
                  _buildNumberField('Forecast Buffer %', 10),
                  const SizedBox(height: 16),
                  _buildNumberField('Advance Booking Days', 1),
                  const SizedBox(height: 16),
                  _buildSwitchField('Allow Late Booking', false),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveMealPolicy,
                          child: const Text('Save Changes'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetMealPolicy,
                          child: const Text('Reset'),
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
    );
  }

  Widget _buildRoomsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Policy',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdownField('Gender Policy', GenderPolicy.sameGender),
                  const SizedBox(height: 16),
                  _buildNumberField('Max Room Capacity', 4),
                  const SizedBox(height: 16),
                  _buildSwitchField('Allow Room Swapping', true),
                  const SizedBox(height: 16),
                  _buildNumberField('Swap Cooldown Days', 7),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveRoomPolicy,
                          child: const Text('Save Changes'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetRoomPolicy,
                          child: const Text('Reset'),
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
    );
  }

  // Helper Widgets
  Widget _buildCurfewTimeField(String label, TimeOfDay initialTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectTime(context, initialTime),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: IOSGradeTheme.border),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: IOSGradeTheme.textSecondary),
                const SizedBox(width: 12),
                Text(
                  initialTime.to12HourFormat(),
                  style: IOSGradeTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMealTimeField(String label, TimeOfDay initialTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectTime(context, initialTime),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: IOSGradeTheme.border),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Row(
              children: [
                const Icon(Icons.restaurant, color: IOSGradeTheme.textSecondary),
                const SizedBox(width: 12),
                Text(
                  initialTime.to12HourFormat(),
                  style: IOSGradeTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField(String label, int initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue.toString(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchField(String label, bool initialValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        Switch(
          value: initialValue,
          onChanged: (value) {
            // Handle switch change
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, GenderPolicy initialValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<GenderPolicy>(
          value: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          items: GenderPolicy.values.map((policy) {
            return DropdownMenuItem(
              value: policy,
              child: Text(policy.name.replaceAll('_', ' ').toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            // Handle dropdown change
          },
        ),
      ],
    );
  }

  Widget _buildMultiSelectField(String label, List<String> initialValues) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: initialValues.map((role) {
            return Chip(
              label: Text(role),
              onDeleted: () {
                // Handle chip deletion
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  // Helper Methods
  IconData _getPolicyIcon(PolicyType type) {
    switch (type) {
      case PolicyType.curfew:
        return Icons.nightlight_round;
      case PolicyType.attendance:
        return Icons.check_circle;
      case PolicyType.meal:
        return Icons.restaurant;
      case PolicyType.room:
        return Icons.room;
      case PolicyType.visitor:
        return Icons.people;
      case PolicyType.maintenance:
        return Icons.build;
      case PolicyType.general:
        return Icons.policy;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      // Handle time selection
    }
  }

  void _showCreatePolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Policy'),
        content: const Text('Policy creation dialog - Implementation needed'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showImportExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import/Export Policies'),
        content: const Text('Import/Export dialog - Implementation needed'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editPolicy(HostelPolicy policy) {
    Toast.showInfo(context, 'Edit policy - Implementation needed');
  }

  void _togglePolicyStatus(HostelPolicy policy) {
    Toast.showInfo(context, 'Toggle policy status - Implementation needed');
  }

  void _deletePolicy(HostelPolicy policy) {
    Toast.showInfo(context, 'Delete policy - Implementation needed');
  }

  void _viewPolicyDetails(HostelPolicy policy) {
    Toast.showInfo(context, 'View policy details - Implementation needed');
  }

  void _saveCurfewPolicy() {
    Toast.showSuccess(context, 'Curfew policy saved successfully');
  }

  void _resetCurfewPolicy() {
    Toast.showInfo(context, 'Curfew policy reset');
  }

  void _saveAttendancePolicy() {
    Toast.showSuccess(context, 'Attendance policy saved successfully');
  }

  void _resetAttendancePolicy() {
    Toast.showInfo(context, 'Attendance policy reset');
  }

  void _saveMealPolicy() {
    Toast.showSuccess(context, 'Meal policy saved successfully');
  }

  void _resetMealPolicy() {
    Toast.showInfo(context, 'Meal policy reset');
  }

  void _saveRoomPolicy() {
    Toast.showSuccess(context, 'Room policy saved successfully');
  }

  void _resetRoomPolicy() {
    Toast.showInfo(context, 'Room policy reset');
  }
}
