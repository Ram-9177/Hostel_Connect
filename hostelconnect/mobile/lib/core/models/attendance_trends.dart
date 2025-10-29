// lib/core/models/attendance_trends.dart

/// Model for attendance trend analytics
class AttendanceTrends {
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  final List<AttendanceTrendDataPoint> dataPoints;
  final AttendanceTrendSummary summary;
  final Map<String, double>? dayOfWeekAverages;
  final Map<String, double>? slotAverages;

  const AttendanceTrends({
    required this.hostelId,
    required this.startDate,
    required this.endDate,
    required this.dataPoints,
    required this.summary,
    this.dayOfWeekAverages,
    this.slotAverages,
  });

  Map<String, dynamic> toJson() => {
    'hostelId': hostelId,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'dataPoints': dataPoints.map((dp) => dp.toJson()).toList(),
    'summary': summary.toJson(),
    if (dayOfWeekAverages != null) 'dayOfWeekAverages': dayOfWeekAverages,
    if (slotAverages != null) 'slotAverages': slotAverages,
  };

  factory AttendanceTrends.fromJson(Map<String, dynamic> json) {
    return AttendanceTrends(
      hostelId: json['hostelId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((dp) => AttendanceTrendDataPoint.fromJson(dp as Map<String, dynamic>))
          .toList(),
      summary: AttendanceTrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
      dayOfWeekAverages: json['dayOfWeekAverages'] != null
          ? Map<String, double>.from(json['dayOfWeekAverages'] as Map)
          : null,
      slotAverages: json['slotAverages'] != null
          ? Map<String, double>.from(json['slotAverages'] as Map)
          : null,
    );
  }
}

class AttendanceTrendDataPoint {
  final DateTime date;
  final int totalStudents;
  final int presentCount;
  final int absentCount;
  final double attendancePercentage;
  final String? slot;

  const AttendanceTrendDataPoint({
    required this.date,
    required this.totalStudents,
    required this.presentCount,
    required this.absentCount,
    required this.attendancePercentage,
    this.slot,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'totalStudents': totalStudents,
    'presentCount': presentCount,
    'absentCount': absentCount,
    'attendancePercentage': attendancePercentage,
    if (slot != null) 'slot': slot,
  };

  factory AttendanceTrendDataPoint.fromJson(Map<String, dynamic> json) {
    return AttendanceTrendDataPoint(
      date: DateTime.parse(json['date'] as String),
      totalStudents: json['totalStudents'] as int,
      presentCount: json['presentCount'] as int,
      absentCount: json['absentCount'] as int,
      attendancePercentage: (json['attendancePercentage'] as num).toDouble(),
      slot: json['slot'] as String?,
    );
  }
}

class AttendanceTrendSummary {
  final double averageAttendance;
  final double peakAttendance;
  final double lowestAttendance;
  final int totalSessionsConducted;
  final String trend; // 'IMPROVING', 'DECLINING', 'STABLE'

  const AttendanceTrendSummary({
    required this.averageAttendance,
    required this.peakAttendance,
    required this.lowestAttendance,
    required this.totalSessionsConducted,
    required this.trend,
  });

  Map<String, dynamic> toJson() => {
    'averageAttendance': averageAttendance,
    'peakAttendance': peakAttendance,
    'lowestAttendance': lowestAttendance,
    'totalSessionsConducted': totalSessionsConducted,
    'trend': trend,
  };

  factory AttendanceTrendSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceTrendSummary(
      averageAttendance: (json['averageAttendance'] as num).toDouble(),
      peakAttendance: (json['peakAttendance'] as num).toDouble(),
      lowestAttendance: (json['lowestAttendance'] as num).toDouble(),
      totalSessionsConducted: json['totalSessionsConducted'] as int,
      trend: json['trend'] as String,
    );
  }
}
