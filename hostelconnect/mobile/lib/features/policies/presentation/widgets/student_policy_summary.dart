// lib/features/policies/presentation/widgets/student_policy_summary.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/policy_models.dart';
import '../../../../core/services/policy_service.dart';
import '../../../../shared/theme/ios_grade_theme.dart';
import '../../../../shared/widgets/ui/ios_grade_components.dart';
import '../../../../shared/widgets/ui/toast.dart';

class StudentPolicySummary extends ConsumerStatefulWidget {
  final String hostelId;
  final bool isCompact;

  const StudentPolicySummary({
    super.key,
    required this.hostelId,
    this.isCompact = false,
  });

  @override
  ConsumerState<StudentPolicySummary> createState() => _StudentPolicySummaryState();
}

class _StudentPolicySummaryState extends ConsumerState<StudentPolicySummary> {
  PolicySummary? _policySummary;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPolicySummary();
  }

  Future<void> _loadPolicySummary() async {
    setState(() => _isLoading = true);
    
    try {
      final policyService = ref.read(policyServiceProvider);
      final result = await policyService.getStudentPolicySummary(widget.hostelId);
      
      setState(() {
        if (result.state == LoadState.success) {
          _policySummary = result.data;
        }
        _isLoading = false;
        _error = result.error;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.isCompact
          ? const SizedBox(
              height: 60,
              child: Center(child: CircularProgressIndicator()),
            )
          : const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return widget.isCompact
          ? IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: IOSGradeTheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Unable to load policies',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.error,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadPolicySummary,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: IOSGradeTheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Policies',
                    style: IOSGradeTheme.titleLarge.copyWith(
                      color: IOSGradeTheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _loadPolicySummary,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
    }

    if (_policySummary == null || _policySummary!.rules.isEmpty) {
      return widget.isCompact
          ? IOSGradeCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.policy_outlined,
                      color: IOSGradeTheme.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No policies available',
                        style: IOSGradeTheme.bodyMedium.copyWith(
                          color: IOSGradeTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.policy_outlined,
                    size: 64,
                    color: IOSGradeTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Policies Available',
                    style: IOSGradeTheme.titleLarge.copyWith(
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No hostel policies have been set yet.',
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
    }

    return widget.isCompact ? _buildCompactView() : _buildFullView();
  }

  Widget _buildCompactView() {
    return IOSGradeCard(
      child: InkWell(
        onTap: () => _showPolicyDetails(),
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: IOSGradeTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.policy,
                  color: IOSGradeTheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hostel Policies',
                      style: IOSGradeTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: IOSGradeTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_policySummary!.rules.length} rules • Updated ${_formatDate(_policySummary!.lastUpdated)}',
                      style: IOSGradeTheme.bodyMedium.copyWith(
                        color: IOSGradeTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: IOSGradeTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFullView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(IOSGradeTheme.radiusLarge),
                    ),
                    child: const Icon(
                      Icons.policy,
                      size: 32,
                      color: IOSGradeTheme.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hostel Policies',
                          style: IOSGradeTheme.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: IOSGradeTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Important rules and guidelines for hostel residents',
                          style: IOSGradeTheme.bodyMedium.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Last updated: ${_formatDate(_policySummary!.lastUpdated)}',
                          style: IOSGradeTheme.footnote.copyWith(
                            color: IOSGradeTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Important Rules
          Text(
            'Important Rules',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._policySummary!.rules.where((rule) => rule.isImportant).map((rule) => _buildImportantRuleCard(rule)),
          
          const SizedBox(height: 24),
          
          // All Rules
          Text(
            'All Rules',
            style: IOSGradeTheme.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: IOSGradeTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._policySummary!.rules.map((rule) => _buildRuleCard(rule)),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          IOSGradeCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: IOSGradeTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showPolicyDetails(),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('View Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _downloadPolicyPDF(),
                          icon: const Icon(Icons.download),
                          label: const Text('Download PDF'),
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

  Widget _buildImportantRuleCard(PolicyRule rule) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          border: Border.all(
            color: IOSGradeTheme.warning.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: IOSGradeTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Icon(
                _getRuleIcon(rule.icon),
                color: IOSGradeTheme.warning,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rule.title,
                    style: IOSGradeTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: IOSGradeTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    rule.description,
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: IOSGradeTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: IOSGradeTheme.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      rule.category.toUpperCase(),
                      style: IOSGradeTheme.footnote.copyWith(
                        color: IOSGradeTheme.warning,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(PolicyRule rule) {
    return IOSGradeCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _getCategoryColor(rule.category).withOpacity(0.1),
            borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
          ),
          child: Icon(
            _getRuleIcon(rule.icon),
            color: _getCategoryColor(rule.category),
            size: 20,
          ),
        ),
        title: Text(
          rule.title,
          style: IOSGradeTheme.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: IOSGradeTheme.textPrimary,
          ),
        ),
        subtitle: Text(
          rule.description,
          style: IOSGradeTheme.bodyMedium.copyWith(
            color: IOSGradeTheme.textSecondary,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getCategoryColor(rule.category).withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            rule.category.toUpperCase(),
            style: IOSGradeTheme.footnote.copyWith(
              color: _getCategoryColor(rule.category),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        onTap: () => _showRuleDetails(rule),
      ),
    );
  }

  IconData _getRuleIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'curfew':
        return Icons.nightlight_round;
      case 'attendance':
        return Icons.check_circle;
      case 'meal':
        return Icons.restaurant;
      case 'room':
        return Icons.room;
      case 'visitor':
        return Icons.people;
      case 'maintenance':
        return Icons.build;
      case 'general':
        return Icons.policy;
      default:
        return Icons.info;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'curfew':
        return IOSGradeTheme.warning;
      case 'attendance':
        return IOSGradeTheme.info;
      case 'meal':
        return IOSGradeTheme.success;
      case 'room':
        return IOSGradeTheme.secondary;
      case 'visitor':
        return IOSGradeTheme.primary;
      case 'maintenance':
        return IOSGradeTheme.error;
      case 'general':
        return IOSGradeTheme.textSecondary;
      default:
        return IOSGradeTheme.textSecondary;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showPolicyDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hostel Policies'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _policySummary!.rules.length,
            itemBuilder: (context, index) {
              final rule = _policySummary!.rules[index];
              return ListTile(
                leading: Icon(_getRuleIcon(rule.icon)),
                title: Text(rule.title),
                subtitle: Text(rule.description),
                trailing: Text(
                  rule.category.toUpperCase(),
                  style: IOSGradeTheme.footnote.copyWith(
                    color: _getCategoryColor(rule.category),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
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

  void _showRuleDetails(PolicyRule rule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(rule.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rule.description,
              style: IOSGradeTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getCategoryColor(rule.category).withOpacity(0.1),
                borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
              ),
              child: Row(
                children: [
                  Icon(
                    _getRuleIcon(rule.icon),
                    color: _getCategoryColor(rule.category),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Category: ${rule.category.toUpperCase()}',
                    style: IOSGradeTheme.bodyMedium.copyWith(
                      color: _getCategoryColor(rule.category),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
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

  void _downloadPolicyPDF() {
    Toast.showInfo(context, 'PDF download feature coming soon');
  }
}
