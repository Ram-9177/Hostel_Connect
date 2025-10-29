// lib/core/models/gate_trends.dart

/// Model for gate pass trend analytics
class GateTrends {
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  final List<GateTrendDataPoint> dataPoints;
  final GateTrendSummary summary;
  final Map<String, int>? reasonBreakdown;
  final Map<String, int>? destinationBreakdown;

  const GateTrends({
    required this.hostelId,
    required this.startDate,
    required this.endDate,
    required this.dataPoints,
    required this.summary,
    this.reasonBreakdown,
    this.destinationBreakdown,
  });

  Map<String, dynamic> toJson() => {
    'hostelId': hostelId,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'dataPoints': dataPoints.map((dp) => dp.toJson()).toList(),
    'summary': summary.toJson(),
    if (reasonBreakdown != null) 'reasonBreakdown': reasonBreakdown,
    if (destinationBreakdown != null) 'destinationBreakdown': destinationBreakdown,
  };

  factory GateTrends.fromJson(Map<String, dynamic> json) {
    return GateTrends(
      hostelId: json['hostelId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((dp) => GateTrendDataPoint.fromJson(dp as Map<String, dynamic>))
          .toList(),
      summary: GateTrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
      reasonBreakdown: json['reasonBreakdown'] != null
          ? Map<String, int>.from(json['reasonBreakdown'] as Map)
          : null,
      destinationBreakdown: json['destinationBreakdown'] != null
          ? Map<String, int>.from(json['destinationBreakdown'] as Map)
          : null,
    );
  }
}

class GateTrendDataPoint {
  final DateTime date;
  final int totalRequests;
  final int approved;
  final int rejected;
  final int pending;
  final int emergencyPasses;
  final double approvalRate;

  const GateTrendDataPoint({
    required this.date,
    required this.totalRequests,
    required this.approved,
    required this.rejected,
    required this.pending,
    required this.emergencyPasses,
    required this.approvalRate,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'totalRequests': totalRequests,
    'approved': approved,
    'rejected': rejected,
    'pending': pending,
    'emergencyPasses': emergencyPasses,
    'approvalRate': approvalRate,
  };

  factory GateTrendDataPoint.fromJson(Map<String, dynamic> json) {
    return GateTrendDataPoint(
      date: DateTime.parse(json['date'] as String),
      totalRequests: json['totalRequests'] as int,
      approved: json['approved'] as int,
      rejected: json['rejected'] as int,
      pending: json['pending'] as int,
      emergencyPasses: json['emergencyPasses'] as int,
      approvalRate: (json['approvalRate'] as num).toDouble(),
    );
  }
}

class GateTrendSummary {
  final int totalGatePasses;
  final double averageApprovalRate;
  final int totalEmergencyPasses;
  final double averageProcessingTimeMinutes;
  final String peakDay; // Day of week with most passes

  const GateTrendSummary({
    required this.totalGatePasses,
    required this.averageApprovalRate,
    required this.totalEmergencyPasses,
    required this.averageProcessingTimeMinutes,
    required this.peakDay,
  });

  Map<String, dynamic> toJson() => {
    'totalGatePasses': totalGatePasses,
    'averageApprovalRate': averageApprovalRate,
    'totalEmergencyPasses': totalEmergencyPasses,
    'averageProcessingTimeMinutes': averageProcessingTimeMinutes,
    'peakDay': peakDay,
  };

  factory GateTrendSummary.fromJson(Map<String, dynamic> json) {
    return GateTrendSummary(
      totalGatePasses: json['totalGatePasses'] as int,
      averageApprovalRate: (json['averageApprovalRate'] as num).toDouble(),
      totalEmergencyPasses: json['totalEmergencyPasses'] as int,
      averageProcessingTimeMinutes: (json['averageProcessingTimeMinutes'] as num).toDouble(),
      peakDay: json['peakDay'] as String,
    );
  }
}
