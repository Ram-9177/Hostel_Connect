// lib/core/models/policy_statistics.dart

/// Model for policy usage and compliance statistics
class PolicyStatistics {
  final String policyId;
  final String policyName;
  final String category;
  final DateTime startDate;
  final DateTime endDate;
  final PolicyComplianceStats compliance;
  final PolicyViolationStats violations;
  final PolicyUsageStats usage;

  const PolicyStatistics({
    required this.policyId,
    required this.policyName,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.compliance,
    required this.violations,
    required this.usage,
  });

  Map<String, dynamic> toJson() => {
    'policyId': policyId,
    'policyName': policyName,
    'category': category,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'compliance': compliance.toJson(),
    'violations': violations.toJson(),
    'usage': usage.toJson(),
  };

  factory PolicyStatistics.fromJson(Map<String, dynamic> json) {
    return PolicyStatistics(
      policyId: json['policyId'] as String,
      policyName: json['policyName'] as String,
      category: json['category'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      compliance: PolicyComplianceStats.fromJson(json['compliance'] as Map<String, dynamic>),
      violations: PolicyViolationStats.fromJson(json['violations'] as Map<String, dynamic>),
      usage: PolicyUsageStats.fromJson(json['usage'] as Map<String, dynamic>),
    );
  }
}

class PolicyComplianceStats {
  final int totalChecks;
  final int compliantChecks;
  final int nonCompliantChecks;
  final double complianceRate;
  final String trend; // 'IMPROVING', 'DECLINING', 'STABLE'

  const PolicyComplianceStats({
    required this.totalChecks,
    required this.compliantChecks,
    required this.nonCompliantChecks,
    required this.complianceRate,
    required this.trend,
  });

  Map<String, dynamic> toJson() => {
    'totalChecks': totalChecks,
    'compliantChecks': compliantChecks,
    'nonCompliantChecks': nonCompliantChecks,
    'complianceRate': complianceRate,
    'trend': trend,
  };

  factory PolicyComplianceStats.fromJson(Map<String, dynamic> json) {
    return PolicyComplianceStats(
      totalChecks: json['totalChecks'] as int,
      compliantChecks: json['compliantChecks'] as int,
      nonCompliantChecks: json['nonCompliantChecks'] as int,
      complianceRate: (json['complianceRate'] as num).toDouble(),
      trend: json['trend'] as String,
    );
  }
}

class PolicyViolationStats {
  final int totalViolations;
  final int criticalViolations;
  final int resolvedViolations;
  final Map<String, int> violationsByType;
  final Map<String, int> violationsByStudent;

  const PolicyViolationStats({
    required this.totalViolations,
    required this.criticalViolations,
    required this.resolvedViolations,
    required this.violationsByType,
    required this.violationsByStudent,
  });

  Map<String, dynamic> toJson() => {
    'totalViolations': totalViolations,
    'criticalViolations': criticalViolations,
    'resolvedViolations': resolvedViolations,
    'violationsByType': violationsByType,
    'violationsByStudent': violationsByStudent,
  };

  factory PolicyViolationStats.fromJson(Map<String, dynamic> json) {
    return PolicyViolationStats(
      totalViolations: json['totalViolations'] as int,
      criticalViolations: json['criticalViolations'] as int,
      resolvedViolations: json['resolvedViolations'] as int,
      violationsByType: Map<String, int>.from(json['violationsByType'] as Map),
      violationsByStudent: Map<String, int>.from(json['violationsByStudent'] as Map),
    );
  }
}

class PolicyUsageStats {
  final int totalApplications;
  final int successfulApplications;
  final int failedApplications;
  final double successRate;
  final Map<String, int> usageByRole;

  const PolicyUsageStats({
    required this.totalApplications,
    required this.successfulApplications,
    required this.failedApplications,
    required this.successRate,
    required this.usageByRole,
  });

  Map<String, dynamic> toJson() => {
    'totalApplications': totalApplications,
    'successfulApplications': successfulApplications,
    'failedApplications': failedApplications,
    'successRate': successRate,
    'usageByRole': usageByRole,
  };

  factory PolicyUsageStats.fromJson(Map<String, dynamic> json) {
    return PolicyUsageStats(
      totalApplications: json['totalApplications'] as int,
      successfulApplications: json['successfulApplications'] as int,
      failedApplications: json['failedApplications'] as int,
      successRate: (json['successRate'] as num).toDouble(),
      usageByRole: Map<String, int>.from(json['usageByRole'] as Map),
    );
  }
}
