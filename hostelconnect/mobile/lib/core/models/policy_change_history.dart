// lib/core/models/policy_change_history.dart

/// Model for policy change history tracking
class PolicyChangeHistory {
  final String id;
  final String policyId;
  final String policyName;
  final String changeType; // 'CREATED', 'UPDATED', 'DELETED', 'ACTIVATED', 'DEACTIVATED'
  final Map<String, dynamic>? oldValues;
  final Map<String, dynamic>? newValues;
  final String changedBy;
  final String? reason;
  final DateTime changedAt;
  final List<String> affectedFields;

  const PolicyChangeHistory({
    required this.id,
    required this.policyId,
    required this.policyName,
    required this.changeType,
    this.oldValues,
    this.newValues,
    required this.changedBy,
    this.reason,
    required this.changedAt,
    required this.affectedFields,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'policyId': policyId,
    'policyName': policyName,
    'changeType': changeType,
    if (oldValues != null) 'oldValues': oldValues,
    if (newValues != null) 'newValues': newValues,
    'changedBy': changedBy,
    if (reason != null) 'reason': reason,
    'changedAt': changedAt.toIso8601String(),
    'affectedFields': affectedFields,
  };

  factory PolicyChangeHistory.fromJson(Map<String, dynamic> json) {
    return PolicyChangeHistory(
      id: json['id'] as String,
      policyId: json['policyId'] as String,
      policyName: json['policyName'] as String,
      changeType: json['changeType'] as String,
      oldValues: json['oldValues'] != null
          ? Map<String, dynamic>.from(json['oldValues'] as Map)
          : null,
      newValues: json['newValues'] != null
          ? Map<String, dynamic>.from(json['newValues'] as Map)
          : null,
      changedBy: json['changedBy'] as String,
      reason: json['reason'] as String?,
      changedAt: DateTime.parse(json['changedAt'] as String),
      affectedFields: List<String>.from(json['affectedFields'] as List),
    );
  }
}

enum PolicyChangeType {
  created,
  updated,
  deleted,
  activated,
  deactivated,
}
