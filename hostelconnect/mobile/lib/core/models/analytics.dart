// lib/core/models/analytics.dart
class DailyAnalytics {
  final String date;
  final int totalStudents;
  final int presentStudents;
  final int absentStudents;
  final double attendancePercentage;
  final Map<String, dynamic> mealStats;
  final Map<String, dynamic> gateStats;

  const DailyAnalytics({
    required this.date,
    required this.totalStudents,
    required this.presentStudents,
    required this.absentStudents,
    required this.attendancePercentage,
    required this.mealStats,
    required this.gateStats,
  });

  factory DailyAnalytics.fromJson(Map<String, dynamic> json) {
    return DailyAnalytics(
      date: json['date']?.toString() ?? '',
      totalStudents: json['totalStudents'] ?? 0,
      presentStudents: json['presentStudents'] ?? 0,
      absentStudents: json['absentStudents'] ?? 0,
      attendancePercentage: (json['attendancePercentage'] ?? 0.0).toDouble(),
      mealStats: json['mealStats'] ?? {},
      gateStats: json['gateStats'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalStudents': totalStudents,
      'presentStudents': presentStudents,
      'absentStudents': absentStudents,
      'attendancePercentage': attendancePercentage,
      'mealStats': mealStats,
      'gateStats': gateStats,
    };
  }
}

class AttendanceAnalytics {
  final String sessionId;
  final String sessionName;
  final DateTime startTime;
  final DateTime endTime;
  final int totalStudents;
  final int presentStudents;
  final double attendancePercentage;

  const AttendanceAnalytics({
    required this.sessionId,
    required this.sessionName,
    required this.startTime,
    required this.endTime,
    required this.totalStudents,
    required this.presentStudents,
    required this.attendancePercentage,
  });

  factory AttendanceAnalytics.fromJson(Map<String, dynamic> json) {
    return AttendanceAnalytics(
      sessionId: json['sessionId']?.toString() ?? '',
      sessionName: json['sessionName']?.toString() ?? '',
      startTime: DateTime.tryParse(json['startTime'].toString()) ?? DateTime.now(),
      endTime: DateTime.tryParse(json['endTime'].toString()) ?? DateTime.now(),
      totalStudents: json['totalStudents'] ?? 0,
      presentStudents: json['presentStudents'] ?? 0,
      attendancePercentage: (json['attendancePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'sessionName': sessionName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'totalStudents': totalStudents,
      'presentStudents': presentStudents,
      'attendancePercentage': attendancePercentage,
    };
  }
}

class AttendanceSessionSummary {
  final String sessionId;
  final String sessionName;
  final DateTime date;
  final int totalStudents;
  final int presentStudents;
  final double attendancePercentage;

  const AttendanceSessionSummary({
    required this.sessionId,
    required this.sessionName,
    required this.date,
    required this.totalStudents,
    required this.presentStudents,
    required this.attendancePercentage,
  });

  factory AttendanceSessionSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSessionSummary(
      sessionId: json['sessionId']?.toString() ?? '',
      sessionName: json['sessionName']?.toString() ?? '',
      date: DateTime.tryParse(json['date'].toString()) ?? DateTime.now(),
      totalStudents: json['totalStudents'] ?? 0,
      presentStudents: json['presentStudents'] ?? 0,
      attendancePercentage: (json['attendancePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'sessionName': sessionName,
      'date': date.toIso8601String(),
      'totalStudents': totalStudents,
      'presentStudents': presentStudents,
      'attendancePercentage': attendancePercentage,
    };
  }
}

class GateAnalytics {
  final String date;
  final int totalPasses;
  final int usedPasses;
  final int expiredPasses;
  final Map<String, int> hourlyStats;

  const GateAnalytics({
    required this.date,
    required this.totalPasses,
    required this.usedPasses,
    required this.expiredPasses,
    required this.hourlyStats,
  });

  factory GateAnalytics.fromJson(Map<String, dynamic> json) {
    return GateAnalytics(
      date: json['date']?.toString() ?? '',
      totalPasses: json['totalPasses'] ?? 0,
      usedPasses: json['usedPasses'] ?? 0,
      expiredPasses: json['expiredPasses'] ?? 0,
      hourlyStats: Map<String, int>.from(json['hourlyStats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalPasses': totalPasses,
      'usedPasses': usedPasses,
      'expiredPasses': expiredPasses,
      'hourlyStats': hourlyStats,
    };
  }
}

class GatePassSummary {
  final String passId;
  final String studentId;
  final String studentName;
  final String reason;
  final DateTime fromTime;
  final DateTime toTime;
  final String status;
  final DateTime? usedAt;

  const GatePassSummary({
    required this.passId,
    required this.studentId,
    required this.studentName,
    required this.reason,
    required this.fromTime,
    required this.toTime,
    required this.status,
    this.usedAt,
  });

  factory GatePassSummary.fromJson(Map<String, dynamic> json) {
    return GatePassSummary(
      passId: json['passId']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      studentName: json['studentName']?.toString() ?? '',
      reason: json['reason']?.toString() ?? '',
      fromTime: DateTime.tryParse(json['fromTime'].toString()) ?? DateTime.now(),
      toTime: DateTime.tryParse(json['toTime'].toString()) ?? DateTime.now(),
      status: json['status']?.toString() ?? 'pending',
      usedAt: json['usedAt'] != null ? DateTime.tryParse(json['usedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passId': passId,
      'studentId': studentId,
      'studentName': studentName,
      'reason': reason,
      'fromTime': fromTime.toIso8601String(),
      'toTime': toTime.toIso8601String(),
      'status': status,
      'usedAt': usedAt?.toIso8601String(),
    };
  }
}

class MealAnalytics {
  final String date;
  final int totalMeals;
  final int consumedMeals;
  final int wastedMeals;
  final Map<String, int> mealTypeStats;

  const MealAnalytics({
    required this.date,
    required this.totalMeals,
    required this.consumedMeals,
    required this.wastedMeals,
    required this.mealTypeStats,
  });

  factory MealAnalytics.fromJson(Map<String, dynamic> json) {
    return MealAnalytics(
      date: json['date']?.toString() ?? '',
      totalMeals: json['totalMeals'] ?? 0,
      consumedMeals: json['consumedMeals'] ?? 0,
      wastedMeals: json['wastedMeals'] ?? 0,
      mealTypeStats: Map<String, int>.from(json['mealTypeStats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalMeals': totalMeals,
      'consumedMeals': consumedMeals,
      'wastedMeals': wastedMeals,
      'mealTypeStats': mealTypeStats,
    };
  }
}

class MealVarianceSummary {
  final String mealType;
  final int plannedQuantity;
  final int actualQuantity;
  final double variancePercentage;
  final String date;

  const MealVarianceSummary({
    required this.mealType,
    required this.plannedQuantity,
    required this.actualQuantity,
    required this.variancePercentage,
    required this.date,
  });

  factory MealVarianceSummary.fromJson(Map<String, dynamic> json) {
    return MealVarianceSummary(
      mealType: json['mealType']?.toString() ?? '',
      plannedQuantity: json['plannedQuantity'] ?? 0,
      actualQuantity: json['actualQuantity'] ?? 0,
      variancePercentage: (json['variancePercentage'] ?? 0.0).toDouble(),
      date: json['date']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'plannedQuantity': plannedQuantity,
      'actualQuantity': actualQuantity,
      'variancePercentage': variancePercentage,
      'date': date,
    };
  }
}

enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

class MealTypeAnalytics {
  final MealType mealType;
  final int totalQuantity;
  final int consumedQuantity;
  final int wastedQuantity;
  final double consumptionRate;

  const MealTypeAnalytics({
    required this.mealType,
    required this.totalQuantity,
    required this.consumedQuantity,
    required this.wastedQuantity,
    required this.consumptionRate,
  });

  factory MealTypeAnalytics.fromJson(Map<String, dynamic> json) {
    return MealTypeAnalytics(
      mealType: MealType.values.firstWhere(
        (e) => e.name == json['mealType'],
        orElse: () => MealType.breakfast,
      ),
      totalQuantity: json['totalQuantity'] ?? 0,
      consumedQuantity: json['consumedQuantity'] ?? 0,
      wastedQuantity: json['wastedQuantity'] ?? 0,
      consumptionRate: (json['consumptionRate'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType.name,
      'totalQuantity': totalQuantity,
      'consumedQuantity': consumedQuantity,
      'wastedQuantity': wastedQuantity,
      'consumptionRate': consumptionRate,
    };
  }
}

class OccupancyAnalytics {
  final String hostelId;
  final int totalRooms;
  final int occupiedRooms;
  final int vacantRooms;
  final double occupancyRate;
  final Map<String, int> roomTypeStats;

  const OccupancyAnalytics({
    required this.hostelId,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.vacantRooms,
    required this.occupancyRate,
    required this.roomTypeStats,
  });

  factory OccupancyAnalytics.fromJson(Map<String, dynamic> json) {
    return OccupancyAnalytics(
      hostelId: json['hostelId']?.toString() ?? '',
      totalRooms: json['totalRooms'] ?? 0,
      occupiedRooms: json['occupiedRooms'] ?? 0,
      vacantRooms: json['vacantRooms'] ?? 0,
      occupancyRate: (json['occupancyRate'] ?? 0.0).toDouble(),
      roomTypeStats: Map<String, int>.from(json['roomTypeStats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hostelId': hostelId,
      'totalRooms': totalRooms,
      'occupiedRooms': occupiedRooms,
      'vacantRooms': vacantRooms,
      'occupancyRate': occupancyRate,
      'roomTypeStats': roomTypeStats,
    };
  }
}

class OccupancySummary {
  final String roomId;
  final String roomType;
  final int totalBeds;
  final int occupiedBeds;
  final int vacantBeds;
  final double occupancyRate;

  const OccupancySummary({
    required this.roomId,
    required this.roomType,
    required this.totalBeds,
    required this.occupiedBeds,
    required this.vacantBeds,
    required this.occupancyRate,
  });

  factory OccupancySummary.fromJson(Map<String, dynamic> json) {
    return OccupancySummary(
      roomId: json['roomId']?.toString() ?? '',
      roomType: json['roomType']?.toString() ?? '',
      totalBeds: json['totalBeds'] ?? 0,
      occupiedBeds: json['occupiedBeds'] ?? 0,
      vacantBeds: json['vacantBeds'] ?? 0,
      occupancyRate: (json['occupancyRate'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'roomType': roomType,
      'totalBeds': totalBeds,
      'occupiedBeds': occupiedBeds,
      'vacantBeds': vacantBeds,
      'occupancyRate': occupancyRate,
    };
  }
}

class IntegrityAnalytics {
  final String date;
  final int totalChecks;
  final int passedChecks;
  final int failedChecks;
  final Map<String, int> checkTypeStats;

  const IntegrityAnalytics({
    required this.date,
    required this.totalChecks,
    required this.passedChecks,
    required this.failedChecks,
    required this.checkTypeStats,
  });

  factory IntegrityAnalytics.fromJson(Map<String, dynamic> json) {
    return IntegrityAnalytics(
      date: json['date']?.toString() ?? '',
      totalChecks: json['totalChecks'] ?? 0,
      passedChecks: json['passedChecks'] ?? 0,
      failedChecks: json['failedChecks'] ?? 0,
      checkTypeStats: Map<String, int>.from(json['checkTypeStats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'totalChecks': totalChecks,
      'passedChecks': passedChecks,
      'failedChecks': failedChecks,
      'checkTypeStats': checkTypeStats,
    };
  }
}

class IntegrityCheck {
  final String checkId;
  final String checkType;
  final String description;
  final bool passed;
  final String? failureReason;
  final DateTime checkedAt;
  final String checkedBy;

  const IntegrityCheck({
    required this.checkId,
    required this.checkType,
    required this.description,
    required this.passed,
    this.failureReason,
    required this.checkedAt,
    required this.checkedBy,
  });

  factory IntegrityCheck.fromJson(Map<String, dynamic> json) {
    return IntegrityCheck(
      checkId: json['checkId']?.toString() ?? '',
      checkType: json['checkType']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      passed: json['passed'] ?? false,
      failureReason: json['failureReason']?.toString(),
      checkedAt: DateTime.tryParse(json['checkedAt'].toString()) ?? DateTime.now(),
      checkedBy: json['checkedBy']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkId': checkId,
      'checkType': checkType,
      'description': description,
      'passed': passed,
      'failureReason': failureReason,
      'checkedAt': checkedAt.toIso8601String(),
      'checkedBy': checkedBy,
    };
  }
}

// DrillDownRequest is now in dashboard_models.dart to avoid duplicate
// Export it from there if needed
