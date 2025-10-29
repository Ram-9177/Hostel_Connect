// lib/core/models/occupancy_trends.dart

/// Model for hostel occupancy trend analytics
class OccupancyTrends {
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  final List<OccupancyTrendDataPoint> dataPoints;
  final OccupancyTrendSummary summary;
  final Map<String, int>? roomTypeBreakdown; // Single, Double, Shared
  final Map<String, double>? floorOccupancyRates;

  const OccupancyTrends({
    required this.hostelId,
    required this.startDate,
    required this.endDate,
    required this.dataPoints,
    required this.summary,
    this.roomTypeBreakdown,
    this.floorOccupancyRates,
  });

  Map<String, dynamic> toJson() => {
    'hostelId': hostelId,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'dataPoints': dataPoints.map((dp) => dp.toJson()).toList(),
    'summary': summary.toJson(),
    if (roomTypeBreakdown != null) 'roomTypeBreakdown': roomTypeBreakdown,
    if (floorOccupancyRates != null) 'floorOccupancyRates': floorOccupancyRates,
  };

  factory OccupancyTrends.fromJson(Map<String, dynamic> json) {
    return OccupancyTrends(
      hostelId: json['hostelId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((dp) => OccupancyTrendDataPoint.fromJson(dp as Map<String, dynamic>))
          .toList(),
      summary: OccupancyTrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
      roomTypeBreakdown: json['roomTypeBreakdown'] != null
          ? Map<String, int>.from(json['roomTypeBreakdown'] as Map)
          : null,
      floorOccupancyRates: json['floorOccupancyRates'] != null
          ? Map<String, double>.from(json['floorOccupancyRates'] as Map)
          : null,
    );
  }
}

class OccupancyTrendDataPoint {
  final DateTime date;
  final int totalRooms;
  final int occupiedRooms;
  final int vacantRooms;
  final int totalBeds;
  final int occupiedBeds;
  final double roomOccupancyRate;
  final double bedOccupancyRate;

  const OccupancyTrendDataPoint({
    required this.date,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.vacantRooms,
    required this.totalBeds,
    required this.occupiedBeds,
    required this.roomOccupancyRate,
    required this.bedOccupancyRate,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'totalRooms': totalRooms,
    'occupiedRooms': occupiedRooms,
    'vacantRooms': vacantRooms,
    'totalBeds': totalBeds,
    'occupiedBeds': occupiedBeds,
    'roomOccupancyRate': roomOccupancyRate,
    'bedOccupancyRate': bedOccupancyRate,
  };

  factory OccupancyTrendDataPoint.fromJson(Map<String, dynamic> json) {
    return OccupancyTrendDataPoint(
      date: DateTime.parse(json['date'] as String),
      totalRooms: json['totalRooms'] as int,
      occupiedRooms: json['occupiedRooms'] as int,
      vacantRooms: json['vacantRooms'] as int,
      totalBeds: json['totalBeds'] as int,
      occupiedBeds: json['occupiedBeds'] as int,
      roomOccupancyRate: (json['roomOccupancyRate'] as num).toDouble(),
      bedOccupancyRate: (json['bedOccupancyRate'] as num).toDouble(),
    );
  }
}

class OccupancyTrendSummary {
  final double averageRoomOccupancy;
  final double averageBedOccupancy;
  final double peakOccupancy;
  final double lowestOccupancy;
  final int totalCheckIns;
  final int totalCheckOuts;
  final String trend; // 'INCREASING', 'DECREASING', 'STABLE'

  const OccupancyTrendSummary({
    required this.averageRoomOccupancy,
    required this.averageBedOccupancy,
    required this.peakOccupancy,
    required this.lowestOccupancy,
    required this.totalCheckIns,
    required this.totalCheckOuts,
    required this.trend,
  });

  Map<String, dynamic> toJson() => {
    'averageRoomOccupancy': averageRoomOccupancy,
    'averageBedOccupancy': averageBedOccupancy,
    'peakOccupancy': peakOccupancy,
    'lowestOccupancy': lowestOccupancy,
    'totalCheckIns': totalCheckIns,
    'totalCheckOuts': totalCheckOuts,
    'trend': trend,
  };

  factory OccupancyTrendSummary.fromJson(Map<String, dynamic> json) {
    return OccupancyTrendSummary(
      averageRoomOccupancy: (json['averageRoomOccupancy'] as num).toDouble(),
      averageBedOccupancy: (json['averageBedOccupancy'] as num).toDouble(),
      peakOccupancy: (json['peakOccupancy'] as num).toDouble(),
      lowestOccupancy: (json['lowestOccupancy'] as num).toDouble(),
      totalCheckIns: json['totalCheckIns'] as int,
      totalCheckOuts: json['totalCheckOuts'] as int,
      trend: json['trend'] as String,
    );
  }
}
