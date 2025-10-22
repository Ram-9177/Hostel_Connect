// lib/core/models/dashboard_models.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Defines the type of dashboard tile for different visual representations.
enum DashboardTileType {
  info,
  warning,
  error,
  success,
  progress,
  action,
  attendance,
  gate,
  meals,
  occupancy,
  integrity,
  custom,
}

/// Defines drill down types
enum DrillDownType {
  list,
  chart,
  table,
  export,
}

/// Defines dashboard period types
enum DashboardPeriod {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
}

/// Dashboard drill down model
@immutable
class DashboardDrillDown {
  final String id;
  final String title;
  final String description;
  final String type;
  final Map<String, dynamic> data;
  final Map<String, String>? parameters;

  const DashboardDrillDown({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.data,
    this.parameters,
  });

  factory DashboardDrillDown.fromJson(Map<String, dynamic> json) {
    return DashboardDrillDown(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      data: json['data'] ?? {},
      parameters: json['parameters'] != null ? Map<String, String>.from(json['parameters']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'data': data,
      'parameters': parameters,
    };
  }
}

/// Live dashboard tile model
@immutable
class LiveDashboardTile {
  final String id;
  final String title;
  final String status;
  final double value;
  final String unit;
  final String type;
  final IconData icon;
  final Color color;
  final DashboardTileType tileType;
  final bool isFresh;
  final List<DashboardDrillDown> drillDowns;

  const LiveDashboardTile({
    required this.id,
    required this.title,
    required this.status,
    required this.value,
    required this.unit,
    required this.type,
    required this.icon,
    required this.color,
    required this.tileType,
    this.isFresh = true,
    this.drillDowns = const [],
  });

  factory LiveDashboardTile.fromJson(Map<String, dynamic> json) {
    return LiveDashboardTile(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      value: (json['value'] ?? 0.0).toDouble(),
      unit: json['unit'] ?? '',
      type: json['type'] ?? '',
      icon: Icons.info_outline,
      color: Colors.blue,
      tileType: DashboardTileType.info,
      isFresh: json['isFresh'] ?? true,
      drillDowns: (json['drillDowns'] as List?)
          ?.map((e) => DashboardDrillDown.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'value': value,
      'unit': unit,
      'type': type,
      'isFresh': isFresh,
      'drillDowns': drillDowns.map((e) => e.toJson()).toList(),
    };
  }
}

/// Monthly analytics model
@immutable
class MonthlyAnalytics {
  final AttendanceTrends attendance;
  final GateTrends gate;
  final MealTrends meals;
  final OccupancyTrends occupancy;
  final IntegrityTrends integrity;

  const MonthlyAnalytics({
    required this.attendance,
    required this.gate,
    required this.meals,
    required this.occupancy,
    required this.integrity,
  });

  factory MonthlyAnalytics.fromJson(Map<String, dynamic> json) {
    return MonthlyAnalytics(
      attendance: AttendanceTrends.fromJson(json['attendance'] ?? {}),
      gate: GateTrends.fromJson(json['gate'] ?? {}),
      meals: MealTrends.fromJson(json['meals'] ?? {}),
      occupancy: OccupancyTrends.fromJson(json['occupancy'] ?? {}),
      integrity: IntegrityTrends.fromJson(json['integrity'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance': attendance.toJson(),
      'gate': gate.toJson(),
      'meals': meals.toJson(),
      'occupancy': occupancy.toJson(),
      'integrity': integrity.toJson(),
    };
  }
}

/// Attendance trends model
@immutable
class AttendanceTrends {
  final double averageAttendance;
  final String trendDirection;
  final List<DailyAttendanceTrend> dailyTrends;
  final List<WeeklyAttendanceSummary> weeklyAverages;

  const AttendanceTrends({
    required this.averageAttendance,
    required this.trendDirection,
    required this.dailyTrends,
    required this.weeklyAverages,
  });

  factory AttendanceTrends.fromJson(Map<String, dynamic> json) {
    return AttendanceTrends(
      averageAttendance: (json['averageAttendance'] ?? 0.0).toDouble(),
      trendDirection: json['trendDirection'] ?? 'stable',
      dailyTrends: (json['dailyTrends'] as List?)
          ?.map((e) => DailyAttendanceTrend.fromJson(e))
          .toList() ?? [],
      weeklyAverages: (json['weeklyAverages'] as List?)
          ?.map((e) => WeeklyAttendanceSummary.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageAttendance': averageAttendance,
      'trendDirection': trendDirection,
      'dailyTrends': dailyTrends.map((e) => e.toJson()).toList(),
      'weeklyAverages': weeklyAverages.map((e) => e.toJson()).toList(),
    };
  }
}

/// Daily attendance trend model
@immutable
class DailyAttendanceTrend {
  final DateTime date;
  final int presentCount;
  final int totalStudents;
  final double attendancePercentage;

  const DailyAttendanceTrend({
    required this.date,
    required this.presentCount,
    required this.totalStudents,
    required this.attendancePercentage,
  });

  factory DailyAttendanceTrend.fromJson(Map<String, dynamic> json) {
    return DailyAttendanceTrend(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      presentCount: json['presentCount'] ?? 0,
      totalStudents: json['totalStudents'] ?? 0,
      attendancePercentage: (json['attendancePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'presentCount': presentCount,
      'totalStudents': totalStudents,
      'attendancePercentage': attendancePercentage,
    };
  }
}

/// Weekly attendance summary model
@immutable
class WeeklyAttendanceSummary {
  final int weekNumber;
  final double averagePercentage;

  const WeeklyAttendanceSummary({
    required this.weekNumber,
    required this.averagePercentage,
  });

  factory WeeklyAttendanceSummary.fromJson(Map<String, dynamic> json) {
    return WeeklyAttendanceSummary(
      weekNumber: json['weekNumber'] ?? 0,
      averagePercentage: (json['averagePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'averagePercentage': averagePercentage,
    };
  }
}

/// Gate trends model
@immutable
class GateTrends {
  final double averageTAT;
  final String trendDirection;
  final List<DailyGateTrend> dailyTrends;
  final List<WeeklyGateSummary> weeklyTotals;

  const GateTrends({
    required this.averageTAT,
    required this.trendDirection,
    required this.dailyTrends,
    required this.weeklyTotals,
  });

  factory GateTrends.fromJson(Map<String, dynamic> json) {
    return GateTrends(
      averageTAT: (json['averageTAT'] ?? 0.0).toDouble(),
      trendDirection: json['trendDirection'] ?? 'stable',
      dailyTrends: (json['dailyTrends'] as List?)
          ?.map((e) => DailyGateTrend.fromJson(e))
          .toList() ?? [],
      weeklyTotals: (json['weeklyTotals'] as List?)
          ?.map((e) => WeeklyGateSummary.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageTAT': averageTAT,
      'trendDirection': trendDirection,
      'dailyTrends': dailyTrends.map((e) => e.toJson()).toList(),
      'weeklyTotals': weeklyTotals.map((e) => e.toJson()).toList(),
    };
  }
}

/// Daily gate trend model
@immutable
class DailyGateTrend {
  final DateTime date;
  final int totalPasses;
  final int approvedPasses;
  final int rejectedPasses;
  final double averageTAT;

  const DailyGateTrend({
    required this.date,
    required this.totalPasses,
    required this.approvedPasses,
    required this.rejectedPasses,
    required this.averageTAT,
  });

  factory DailyGateTrend.fromJson(Map<String, dynamic> json) {
    return DailyGateTrend(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      totalPasses: json['totalPasses'] ?? 0,
      approvedPasses: json['approvedPasses'] ?? 0,
      rejectedPasses: json['rejectedPasses'] ?? 0,
      averageTAT: (json['averageTAT'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'totalPasses': totalPasses,
      'approvedPasses': approvedPasses,
      'rejectedPasses': rejectedPasses,
      'averageTAT': averageTAT,
    };
  }
}

/// Weekly gate summary model
@immutable
class WeeklyGateSummary {
  final int weekNumber;
  final int totalPasses;

  const WeeklyGateSummary({
    required this.weekNumber,
    required this.totalPasses,
  });

  factory WeeklyGateSummary.fromJson(Map<String, dynamic> json) {
    return WeeklyGateSummary(
      weekNumber: json['weekNumber'] ?? 0,
      totalPasses: json['totalPasses'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'totalPasses': totalPasses,
    };
  }
}

/// Meal trends model
@immutable
class MealTrends {
  final double averageVariance;
  final String trendDirection;
  final List<DailyMealTrend> dailyTrends;
  final List<WeeklyMealSummary> weeklyVariances;
  final List<MealTypeTrend> mealTypeTrends;

  const MealTrends({
    required this.averageVariance,
    required this.trendDirection,
    required this.dailyTrends,
    required this.weeklyVariances,
    required this.mealTypeTrends,
  });

  factory MealTrends.fromJson(Map<String, dynamic> json) {
    return MealTrends(
      averageVariance: (json['averageVariance'] ?? 0.0).toDouble(),
      trendDirection: json['trendDirection'] ?? 'stable',
      dailyTrends: (json['dailyTrends'] as List?)
          ?.map((e) => DailyMealTrend.fromJson(e))
          .toList() ?? [],
      weeklyVariances: (json['weeklyVariances'] as List?)
          ?.map((e) => WeeklyMealSummary.fromJson(e))
          .toList() ?? [],
      mealTypeTrends: (json['mealTypeTrends'] as List?)
          ?.map((e) => MealTypeTrend.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageVariance': averageVariance,
      'trendDirection': trendDirection,
      'dailyTrends': dailyTrends.map((e) => e.toJson()).toList(),
      'weeklyVariances': weeklyVariances.map((e) => e.toJson()).toList(),
      'mealTypeTrends': mealTypeTrends.map((e) => e.toJson()).toList(),
    };
  }
}

/// Daily meal trend model
@immutable
class DailyMealTrend {
  final DateTime date;
  final double predictedConsumption;
  final double actualConsumption;
  final double variance;

  const DailyMealTrend({
    required this.date,
    required this.predictedConsumption,
    required this.actualConsumption,
    required this.variance,
  });

  factory DailyMealTrend.fromJson(Map<String, dynamic> json) {
    return DailyMealTrend(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      predictedConsumption: (json['predictedConsumption'] ?? 0.0).toDouble(),
      actualConsumption: (json['actualConsumption'] ?? 0.0).toDouble(),
      variance: (json['variance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'predictedConsumption': predictedConsumption,
      'actualConsumption': actualConsumption,
      'variance': variance,
    };
  }
}

/// Weekly meal summary model
@immutable
class WeeklyMealSummary {
  final int weekNumber;
  final double averageVariance;

  const WeeklyMealSummary({
    required this.weekNumber,
    required this.averageVariance,
  });

  factory WeeklyMealSummary.fromJson(Map<String, dynamic> json) {
    return WeeklyMealSummary(
      weekNumber: json['weekNumber'] ?? 0,
      averageVariance: (json['averageVariance'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'averageVariance': averageVariance,
    };
  }
}

/// Meal type trend model
@immutable
class MealTypeTrend {
  final String mealType;
  final double averageConsumption;

  const MealTypeTrend({
    required this.mealType,
    required this.averageConsumption,
  });

  factory MealTypeTrend.fromJson(Map<String, dynamic> json) {
    return MealTypeTrend(
      mealType: json['mealType'] ?? '',
      averageConsumption: (json['averageConsumption'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'averageConsumption': averageConsumption,
    };
  }
}

/// Occupancy trends model
@immutable
class OccupancyTrends {
  final double averageOccupancy;
  final String trendDirection;
  final List<DailyOccupancyTrend> dailyTrends;
  final List<WeeklyOccupancySummary> weeklyAverages;
  final List<BlockOccupancyTrend> blockTrends;

  const OccupancyTrends({
    required this.averageOccupancy,
    required this.trendDirection,
    required this.dailyTrends,
    required this.weeklyAverages,
    required this.blockTrends,
  });

  factory OccupancyTrends.fromJson(Map<String, dynamic> json) {
    return OccupancyTrends(
      averageOccupancy: (json['averageOccupancy'] ?? 0.0).toDouble(),
      trendDirection: json['trendDirection'] ?? 'stable',
      dailyTrends: (json['dailyTrends'] as List?)
          ?.map((e) => DailyOccupancyTrend.fromJson(e))
          .toList() ?? [],
      weeklyAverages: (json['weeklyAverages'] as List?)
          ?.map((e) => WeeklyOccupancySummary.fromJson(e))
          .toList() ?? [],
      blockTrends: (json['blockTrends'] as List?)
          ?.map((e) => BlockOccupancyTrend.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageOccupancy': averageOccupancy,
      'trendDirection': trendDirection,
      'dailyTrends': dailyTrends.map((e) => e.toJson()).toList(),
      'weeklyAverages': weeklyAverages.map((e) => e.toJson()).toList(),
      'blockTrends': blockTrends.map((e) => e.toJson()).toList(),
    };
  }
}

/// Daily occupancy trend model
@immutable
class DailyOccupancyTrend {
  final DateTime date;
  final int occupiedBeds;
  final int totalBeds;
  final double occupancyPercentage;

  const DailyOccupancyTrend({
    required this.date,
    required this.occupiedBeds,
    required this.totalBeds,
    required this.occupancyPercentage,
  });

  factory DailyOccupancyTrend.fromJson(Map<String, dynamic> json) {
    return DailyOccupancyTrend(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      occupiedBeds: json['occupiedBeds'] ?? 0,
      totalBeds: json['totalBeds'] ?? 0,
      occupancyPercentage: (json['occupancyPercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'occupiedBeds': occupiedBeds,
      'totalBeds': totalBeds,
      'occupancyPercentage': occupancyPercentage,
    };
  }
}

/// Weekly occupancy summary model
@immutable
class WeeklyOccupancySummary {
  final int weekNumber;
  final double averagePercentage;

  const WeeklyOccupancySummary({
    required this.weekNumber,
    required this.averagePercentage,
  });

  factory WeeklyOccupancySummary.fromJson(Map<String, dynamic> json) {
    return WeeklyOccupancySummary(
      weekNumber: json['weekNumber'] ?? 0,
      averagePercentage: (json['averagePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'averagePercentage': averagePercentage,
    };
  }
}

/// Block occupancy trend model
@immutable
class BlockOccupancyTrend {
  final String blockId;
  final String blockName;
  final double occupancyPercentage;

  const BlockOccupancyTrend({
    required this.blockId,
    required this.blockName,
    required this.occupancyPercentage,
  });

  factory BlockOccupancyTrend.fromJson(Map<String, dynamic> json) {
    return BlockOccupancyTrend(
      blockId: json['blockId'] ?? '',
      blockName: json['blockName'] ?? '',
      occupancyPercentage: (json['occupancyPercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockId': blockId,
      'blockName': blockName,
      'occupancyPercentage': occupancyPercentage,
    };
  }
}

/// Integrity trends model
@immutable
class IntegrityTrends {
  final double averageIntegrity;
  final String trendDirection;
  final List<DailyIntegrityTrend> dailyTrends;
  final List<WeeklyIntegritySummary> weeklyAverages;
  final List<CheckTypeTrend> checkTypeTrends;

  const IntegrityTrends({
    required this.averageIntegrity,
    required this.trendDirection,
    required this.dailyTrends,
    required this.weeklyAverages,
    required this.checkTypeTrends,
  });

  factory IntegrityTrends.fromJson(Map<String, dynamic> json) {
    return IntegrityTrends(
      averageIntegrity: (json['averageIntegrity'] ?? 0.0).toDouble(),
      trendDirection: json['trendDirection'] ?? 'stable',
      dailyTrends: (json['dailyTrends'] as List?)
          ?.map((e) => DailyIntegrityTrend.fromJson(e))
          .toList() ?? [],
      weeklyAverages: (json['weeklyAverages'] as List?)
          ?.map((e) => WeeklyIntegritySummary.fromJson(e))
          .toList() ?? [],
      checkTypeTrends: (json['checkTypeTrends'] as List?)
          ?.map((e) => CheckTypeTrend.fromJson(e))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageIntegrity': averageIntegrity,
      'trendDirection': trendDirection,
      'dailyTrends': dailyTrends.map((e) => e.toJson()).toList(),
      'weeklyAverages': weeklyAverages.map((e) => e.toJson()).toList(),
      'checkTypeTrends': checkTypeTrends.map((e) => e.toJson()).toList(),
    };
  }
}

/// Daily integrity trend model
@immutable
class DailyIntegrityTrend {
  final DateTime date;
  final int successfulChecks;
  final int totalChecks;
  final double integrityPercentage;

  const DailyIntegrityTrend({
    required this.date,
    required this.successfulChecks,
    required this.totalChecks,
    required this.integrityPercentage,
  });

  factory DailyIntegrityTrend.fromJson(Map<String, dynamic> json) {
    return DailyIntegrityTrend(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      successfulChecks: json['successfulChecks'] ?? 0,
      totalChecks: json['totalChecks'] ?? 0,
      integrityPercentage: (json['integrityPercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'successfulChecks': successfulChecks,
      'totalChecks': totalChecks,
      'integrityPercentage': integrityPercentage,
    };
  }
}

/// Weekly integrity summary model
@immutable
class WeeklyIntegritySummary {
  final int weekNumber;
  final double averagePercentage;

  const WeeklyIntegritySummary({
    required this.weekNumber,
    required this.averagePercentage,
  });

  factory WeeklyIntegritySummary.fromJson(Map<String, dynamic> json) {
    return WeeklyIntegritySummary(
      weekNumber: json['weekNumber'] ?? 0,
      averagePercentage: (json['averagePercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weekNumber': weekNumber,
      'averagePercentage': averagePercentage,
    };
  }
}

/// Check type trend model
@immutable
class CheckTypeTrend {
  final String checkType;
  final double averageSuccessRate;

  const CheckTypeTrend({
    required this.checkType,
    required this.averageSuccessRate,
  });

  factory CheckTypeTrend.fromJson(Map<String, dynamic> json) {
    return CheckTypeTrend(
      checkType: json['checkType'] ?? '',
      averageSuccessRate: (json['averageSuccessRate'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'checkType': checkType,
      'averageSuccessRate': averageSuccessRate,
    };
  }
}