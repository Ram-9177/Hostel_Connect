// lib/core/models/integrity_trends.dart

/// Model for data integrity trend analytics
class IntegrityTrends {
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  final List<IntegrityTrendDataPoint> dataPoints;
  final IntegrityTrendSummary summary;
  final Map<String, int>? violationTypeBreakdown;
  final Map<String, int>? moduleBreakdown; // Attendance, GatePass, Meals, etc.

  const IntegrityTrends({
    required this.hostelId,
    required this.startDate,
    required this.endDate,
    required this.dataPoints,
    required this.summary,
    this.violationTypeBreakdown,
    this.moduleBreakdown,
  });

  Map<String, dynamic> toJson() => {
    'hostelId': hostelId,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'dataPoints': dataPoints.map((dp) => dp.toJson()).toList(),
    'summary': summary.toJson(),
    if (violationTypeBreakdown != null) 'violationTypeBreakdown': violationTypeBreakdown,
    if (moduleBreakdown != null) 'moduleBreakdown': moduleBreakdown,
  };

  factory IntegrityTrends.fromJson(Map<String, dynamic> json) {
    return IntegrityTrends(
      hostelId: json['hostelId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((dp) => IntegrityTrendDataPoint.fromJson(dp as Map<String, dynamic>))
          .toList(),
      summary: IntegrityTrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
      violationTypeBreakdown: json['violationTypeBreakdown'] != null
          ? Map<String, int>.from(json['violationTypeBreakdown'] as Map)
          : null,
      moduleBreakdown: json['moduleBreakdown'] != null
          ? Map<String, int>.from(json['moduleBreakdown'] as Map)
          : null,
    );
  }
}

class IntegrityTrendDataPoint {
  final DateTime date;
  final int totalChecks;
  final int passed;
  final int failed;
  final int warnings;
  final double integrityScore; // 0-100 scale
  final int criticalViolations;

  const IntegrityTrendDataPoint({
    required this.date,
    required this.totalChecks,
    required this.passed,
    required this.failed,
    required this.warnings,
    required this.integrityScore,
    required this.criticalViolations,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'totalChecks': totalChecks,
    'passed': passed,
    'failed': failed,
    'warnings': warnings,
    'integrityScore': integrityScore,
    'criticalViolations': criticalViolations,
  };

  factory IntegrityTrendDataPoint.fromJson(Map<String, dynamic> json) {
    return IntegrityTrendDataPoint(
      date: DateTime.parse(json['date'] as String),
      totalChecks: json['totalChecks'] as int,
      passed: json['passed'] as int,
      failed: json['failed'] as int,
      warnings: json['warnings'] as int,
      integrityScore: (json['integrityScore'] as num).toDouble(),
      criticalViolations: json['criticalViolations'] as int,
    );
  }
}

class IntegrityTrendSummary {
  final double averageIntegrityScore;
  final int totalViolations;
  final int totalCriticalViolations;
  final int resolvedViolations;
  final double resolutionRate;
  final String trend; // 'IMPROVING', 'DECLINING', 'STABLE'
  final String overallHealth; // 'EXCELLENT', 'GOOD', 'FAIR', 'POOR'

  const IntegrityTrendSummary({
    required this.averageIntegrityScore,
    required this.totalViolations,
    required this.totalCriticalViolations,
    required this.resolvedViolations,
    required this.resolutionRate,
    required this.trend,
    required this.overallHealth,
  });

  Map<String, dynamic> toJson() => {
    'averageIntegrityScore': averageIntegrityScore,
    'totalViolations': totalViolations,
    'totalCriticalViolations': totalCriticalViolations,
    'resolvedViolations': resolvedViolations,
    'resolutionRate': resolutionRate,
    'trend': trend,
    'overallHealth': overallHealth,
  };

  factory IntegrityTrendSummary.fromJson(Map<String, dynamic> json) {
    return IntegrityTrendSummary(
      averageIntegrityScore: (json['averageIntegrityScore'] as num).toDouble(),
      totalViolations: json['totalViolations'] as int,
      totalCriticalViolations: json['totalCriticalViolations'] as int,
      resolvedViolations: json['resolvedViolations'] as int,
      resolutionRate: (json['resolutionRate'] as num).toDouble(),
      trend: json['trend'] as String,
      overallHealth: json['overallHealth'] as String,
    );
  }
}
