// lib/features/policies/presentation/pages/warden_policy_view_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/policy_models.dart';
import '../../../../core/services/policy_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class WardenPolicyViewPage extends ConsumerStatefulWidget {
  const WardenPolicyViewPage({super.key});

  @override
  ConsumerState<WardenPolicyViewPage> createState() => _WardenPolicyViewPageState();
}

class _WardenPolicyViewPageState extends ConsumerState<WardenPolicyViewPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHostelId = 'hostel_1';
  
  // Data
  List<HostelPolicy> _policies = [];
  Map<PolicyType, HostelPolicy> _policyMap = {};
  
  // Loading states
  bool _isLoadingPolicies = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadPolicies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadPolicies() async {
    setState(() => _isLoadingPolicies = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getWardenPolicies(_selectedHostelId);
      
      if (result.state == LoadState.success) {
        setState(() {
          _policies = result.data ?? [];
          _policyMap = {};
          for (final policy in _policies.where((p) => p.isActive)) {
            _policyMap[policy.type] = policy;
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IOSGradeTheme.background,
      appBar: AppBar(
        title: const Text('Hostel Policies'),
        backgroundColor: IOSGradeTheme.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Curfew', icon: Icon(Icons.nightlight_round)),
            Tab(text: 'Attendance', icon: Icon(Icons.check_circle)),
            Tab(text: 'Meals', icon: Icon(Icons.restaurant)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _loadPolicies,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildCurfewTab(),
          _buildAttendanceTab(),
          _buildMealsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    if (_isLoadingPolicies) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadPolicies,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Policy Status Cards
          _buildPolicyStatusCards(),
          const SizedBox(height: 24),
          
          // Active Policies List
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
          
          // Quick Reference
          _buildQuickReferenceCard(),
        ],
      ),
    );
  }

  Widget _buildPolicyStatusCards() {
    final activeCount = _policies.where((p) => p.isActive).length;
    final totalCount = _policies.length;
    final lastUpdated = _policies.isNotEmpty 
        ? _policies.map((p) => p.updatedAt).reduce((a, b) => a.isAfter(b) ? a : b)
        : DateTime.now();

    return Row(
      children: [
        Expanded(
          child: _buildStatusCard(
            'Active Policies',
            activeCount.toString(),
            Icons.policy,
            IOSGradeTheme.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatusCard(
            'Total Policies',
            totalCount.toString(),
            Icons.list,
            IOSGradeTheme.info,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatusCard(
            'Last Updated',
            _formatDate(lastUpdated),
            Icons.update,
            IOSGradeTheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: IOSGradeTheme.titleMedium.copyWith(
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
          backgroundColor: IOSGradeTheme.success.withOpacity(0.1),
          child: Icon(
            _getPolicyIcon(policy.type),
            color: IOSGradeTheme.success,
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
        trailing: const Icon(Icons.visibility, color: IOSGradeTheme.textSecondary),
        onTap: () => _viewPolicyDetails(policy),
      ),
    );
  }

  Widget _buildQuickReferenceCard() {
    return IOSGradeCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.quick_reference, color: IOSGradeTheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Quick Reference',
                  style: IOSGradeTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: IOSGradeTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildQuickReferenceItem('Curfew Time', '10:00 PM (Weekdays)', Icons.nightlight_round),
            _buildQuickReferenceItem('Attendance Grace', '10 minutes', Icons.check_circle),
            _buildQuickReferenceItem('Meal Cutoff', '8:00 PM', Icons.restaurant),
            _buildQuickReferenceItem('Room Capacity', '4 students max', Icons.room),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReferenceItem(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: IOSGradeTheme.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: IOSGradeTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: IOSGradeTheme.bodyMedium.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurfewTab() {
    final curfewPolicy = _policyMap[PolicyType.curfew];
    
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
                  _buildPolicyInfoItem('Weekdays Curfew', '10:00 PM', Icons.nightlight_round),
                  _buildPolicyInfoItem('Weekends Curfew', '11:00 PM', Icons.nightlight_round),
                  _buildPolicyInfoItem('Grace Period', '15 minutes', Icons.timer),
                  _buildPolicyInfoItem('Late Entry', 'Allowed with reason', Icons.door_front_door),
                  _buildPolicyInfoItem('Exempt Roles', 'Warden, Warden Head, Super Admin', Icons.admin_panel_settings),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      border: Border.all(color: IOSGradeTheme.warning.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: IOSGradeTheme.warning),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Students must be inside the hostel by curfew time. Late entry requires valid reason and warden approval.',
                            style: IOSGradeTheme.bodyMedium.copyWith(
                              color: IOSGradeTheme.warning,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    final attendancePolicy = _policyMap[PolicyType.attendance];
    
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
                  _buildPolicyInfoItem('Grace Period', '10 minutes', Icons.timer),
                  _buildPolicyInfoItem('Minimum Attendance', '75%', Icons.percent),
                  _buildPolicyInfoItem('Manual Entry', 'Allowed', Icons.edit),
                  _buildPolicyInfoItem('Absence Reason', 'Required', Icons.assignment),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      border: Border.all(color: IOSGradeTheme.info.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: IOSGradeTheme.info),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Students must maintain minimum attendance percentage. Absences require valid reasons.',
                            style: IOSGradeTheme.bodyMedium.copyWith(
                              color: IOSGradeTheme.info,
                            ),
                          ),
                        ),
                      ],
                    ),
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
    final mealPolicy = _policyMap[PolicyType.meal];
    
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
                  _buildPolicyInfoItem('Breakfast Cutoff', '9:00 AM', Icons.wb_sunny),
                  _buildPolicyInfoItem('Lunch Cutoff', '2:00 PM', Icons.wb_sunny_outlined),
                  _buildPolicyInfoItem('Dinner Cutoff', '8:00 PM', Icons.nightlight_round),
                  _buildPolicyInfoItem('Forecast Buffer', '10%', Icons.trending_up),
                  _buildPolicyInfoItem('Advance Booking', '1 day', Icons.schedule),
                  _buildPolicyInfoItem('Late Booking', 'Not allowed', Icons.block),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                      border: Border.all(color: IOSGradeTheme.success.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: IOSGradeTheme.success),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Meal bookings must be made before cutoff times. Forecast buffer ensures adequate food preparation.',
                            style: IOSGradeTheme.bodyMedium.copyWith(
                              color: IOSGradeTheme.success,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyInfoItem(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: IOSGradeTheme.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: IOSGradeTheme.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
                color: IOSGradeTheme.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: IOSGradeTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
        ],
      ),
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

  void _viewPolicyDetails(HostelPolicy policy) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(policy.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${policy.type.name.toUpperCase()}'),
              Text('Status: ${policy.isActive ? 'Active' : 'Inactive'}'),
              Text('Effective From: ${_formatDate(policy.effectiveFrom)}'),
              if (policy.effectiveUntil != null)
                Text('Effective Until: ${_formatDate(policy.effectiveUntil!)}'),
              Text('Created By: ${policy.createdByName}'),
              Text('Last Updated: ${_formatDate(policy.updatedAt)}'),
              if (policy.description != null) ...[
                const SizedBox(height: 8),
                Text('Description: ${policy.description}'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
