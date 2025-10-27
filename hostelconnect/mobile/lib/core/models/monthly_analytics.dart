class MonthlyAnalytics {
  final String month;
  final int totalStudents;
  final int activeStudents;
  final double attendanceRate;
  final int gatePassesIssued;
  final int gatePassesApproved;
  final int gatePassesPending;
  final double mealAttendanceRate;
  
  MonthlyAnalytics({
    required this.month,
    required this.totalStudents,
    required this.activeStudents,
    required this.attendanceRate,
    required this.gatePassesIssued,
    this.gatePassesApproved = 0,
    this.gatePassesPending = 0,
    this.mealAttendanceRate = 0.0,
  });
  
  factory MonthlyAnalytics.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalytics(
      month: json['month'] as String,
      totalStudents: json['total_students'] as int,
      activeStudents: json['active_students'] as int,
      attendanceRate: (json['attendance_rate'] as num).toDouble(),
      gatePassesIssued: json['gate_passes_issued'] as int,
      gatePassesApproved: json['gate_passes_approved'] as int? ?? 0,
      gatePassesPending: json['gate_passes_pending'] as int? ?? 0,
      mealAttendanceRate: (json['meal_attendance_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'month': month,
    'total_students': totalStudents,
    'active_students': activeStudents,
    'attendance_rate': attendanceRate,
    'gate_passes_issued': gatePassesIssued,
    'gate_passes_approved': gatePassesApproved,
    'gate_passes_pending': gatePassesPending,
    'meal_attendance_rate': mealAttendanceRate,
  };
}
