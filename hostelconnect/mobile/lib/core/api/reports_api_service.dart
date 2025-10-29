// lib/core/api/reports_api_service.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../models/dashboard_models.dart';
import '../models/analytics.dart';
import '../models/dashboard_drill_down.dart';
import '../models/attendance_trends.dart';
import '../models/gate_trends.dart';
import '../models/meal_trends.dart';
import '../models/occupancy_trends.dart';
import '../models/integrity_trends.dart';
import '../providers/dio_provider.dart';

final reportsApiServiceProvider = Provider((ref) => ReportsApiService(ref.read(dioProvider)));

class ReportsApiService {
  final Dio _dio;

  ReportsApiService(this._dio);

  // Live Dashboard Tiles
  Future<List<LiveDashboardTile>> getLiveDashboardTiles(String hostelId) async {
    final response = await _dio.get('/reports/dashboard/live/$hostelId');
    return (response.data as List).map((json) => LiveDashboardTile.fromJson(json)).toList();
  }

  Future<LiveDashboardTile> getLiveDashboardTile(String tileId) async {
    final response = await _dio.get('/reports/dashboard/tiles/$tileId');
    return LiveDashboardTile.fromJson(response.data);
  }

  Future<List<LiveDashboardTile>> refreshLiveDashboardTiles(String hostelId, {List<String>? tileIds}) async {
    final queryParams = <String, dynamic>{};
    if (tileIds != null) queryParams['tileIds'] = tileIds;
    
    final response = await _dio.post('/reports/dashboard/live/$hostelId/refresh', queryParameters: queryParams);
    return (response.data as List).map((json) => LiveDashboardTile.fromJson(json)).toList();
  }

  // Daily Analytics
  Future<DailyAnalytics> getDailyAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/analytics/daily/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return DailyAnalytics.fromJson(response.data);
  }

  Future<List<DailyAnalytics>> getDailyAnalyticsRange(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/analytics/daily/$hostelId/range', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return (response.data as List).map((json) => DailyAnalytics.fromJson(json)).toList();
  }

  // Monthly Analytics
  Future<MonthlyAnalytics> getMonthlyAnalytics(String hostelId, DateTime month) async {
    final response = await _dio.get('/reports/analytics/monthly/$hostelId', queryParameters: {
      'month': month.toIso8601String(),
    });
    return MonthlyAnalytics.fromJson(response.data);
  }

  Future<List<MonthlyAnalytics>> getMonthlyAnalyticsRange(String hostelId, DateTime startMonth, DateTime endMonth) async {
    final response = await _dio.get('/reports/analytics/monthly/$hostelId/range', queryParameters: {
      'startMonth': startMonth.toIso8601String(),
      'endMonth': endMonth.toIso8601String(),
    });
    return (response.data as List).map((json) => MonthlyAnalytics.fromJson(json)).toList();
  }

  // Drill Down Operations
  Future<List<Map<String, dynamic>>> executeDrillDown(DrillDownRequest request) async {
    final response = await _dio.post('/reports/drill-down/execute', data: request.toJson());
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<DashboardDrillDown>> getAvailableDrillDowns(String tileId) async {
    final response = await _dio.get('/reports/drill-down/available/$tileId');
    return (response.data as List).map((json) => DashboardDrillDown.fromJson(json)).toList();
  }

  // Attendance Analytics
  Future<AttendanceAnalytics> getAttendanceAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/attendance/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return AttendanceAnalytics.fromJson(response.data);
  }

  Future<List<AttendanceSessionSummary>> getAttendanceSessions(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/attendance/sessions/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return (response.data as List).map((json) => AttendanceSessionSummary.fromJson(json)).toList();
  }

  Future<Map<String, int>> getAttendanceHourlyBreakdown(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/attendance/hourly/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return Map<String, int>.from(response.data);
  }

  // Gate Analytics
  Future<GateAnalytics> getGateAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/gate/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return GateAnalytics.fromJson(response.data);
  }

  Future<List<GatePassSummary>> getGatePasses(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/gate/passes/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return (response.data as List).map((json) => GatePassSummary.fromJson(json)).toList();
  }

  Future<Duration> getAverageTAT(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/gate/tat/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return Duration(milliseconds: response.data['averageTATMs'] ?? 0);
  }

  Future<Map<String, int>> getGateHourlyFlow(String hostelId, DateTime date, String flowType) async {
    final response = await _dio.get('/reports/gate/hourly/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
      'flowType': flowType, // 'out' or 'in'
    });
    return Map<String, int>.from(response.data);
  }

  // Meal Analytics
  Future<MealAnalytics> getMealAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/meals/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return MealAnalytics.fromJson(response.data);
  }

  Future<List<MealVarianceSummary>> getMealVariances(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/meals/variances/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return (response.data as List).map((json) => MealVarianceSummary.fromJson(json)).toList();
  }

  Future<Map<MealType, MealTypeAnalytics>> getMealTypeAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/meals/types/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return (response.data as Map).map((key, value) => 
      MapEntry(MealType.values.firstWhere((e) => e.name == key), 
               MealTypeAnalytics.fromJson(value)));
  }

  // Occupancy Analytics
  Future<OccupancyAnalytics> getOccupancyAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/occupancy/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return OccupancyAnalytics.fromJson(response.data);
  }

  Future<List<OccupancySummary>> getRoomOccupancyDetails(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/occupancy/rooms/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return (response.data as List).map((json) => OccupancySummary.fromJson(json)).toList();
  }

  Future<Map<String, int>> getBlockOccupancy(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/occupancy/blocks/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return Map<String, int>.from(response.data);
  }

  Future<Map<String, int>> getFloorOccupancy(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/occupancy/floors/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return Map<String, int>.from(response.data);
  }

  // Integrity Analytics
  Future<IntegrityAnalytics> getIntegrityAnalytics(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/integrity/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return IntegrityAnalytics.fromJson(response.data);
  }

  Future<List<IntegrityCheck>> getIntegrityChecks(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/integrity/checks/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return (response.data as List).map((json) => IntegrityCheck.fromJson(json)).toList();
  }

  Future<Map<String, int>> getIntegrityCheckBreakdown(String hostelId, DateTime date) async {
    final response = await _dio.get('/reports/integrity/breakdown/$hostelId', queryParameters: {
      'date': date.toIso8601String(),
    });
    return Map<String, int>.from(response.data);
  }

  // Trend Analytics
  Future<AttendanceTrends> getAttendanceTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/trends/attendance/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return AttendanceTrends.fromJson(response.data);
  }

  Future<GateTrends> getGateTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/trends/gate/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return GateTrends.fromJson(response.data);
  }

  Future<MealTrends> getMealTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/trends/meals/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return MealTrends.fromJson(response.data);
  }

  Future<OccupancyTrends> getOccupancyTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/trends/occupancy/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return OccupancyTrends.fromJson(response.data);
  }

  Future<IntegrityTrends> getIntegrityTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    final response = await _dio.get('/reports/trends/integrity/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    });
    return IntegrityTrends.fromJson(response.data);
  }

  // Materialized Views Management
  Future<void> refreshMaterializedView(String viewName) async {
    await _dio.post('/reports/materialized-views/$viewName/refresh');
  }

  Future<List<String>> getMaterializedViews() async {
    final response = await _dio.get('/reports/materialized-views');
    return List<String>.from(response.data);
  }

  Future<Map<String, dynamic>> getMaterializedViewStatus(String viewName) async {
    final response = await _dio.get('/reports/materialized-views/$viewName/status');
    return response.data;
  }

  // Export and Reporting
  Future<String> exportDashboardData(String hostelId, DashboardPeriod period, String format) async {
    final response = await _dio.get('/reports/export/dashboard/$hostelId', queryParameters: {
      'period': period.name,
      'format': format,
    });
    return response.data['exportUrl'];
  }

  Future<String> exportAnalyticsData(String hostelId, DateTime startDate, DateTime endDate, String format) async {
    final response = await _dio.get('/reports/export/analytics/$hostelId', queryParameters: {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'format': format,
    });
    return response.data['exportUrl'];
  }

  Future<List<int>> exportToCSV(String hostelId, String reportType, Map<String, dynamic> parameters) async {
    final response = await _dio.post('/reports/export/csv/$hostelId', data: {
      'reportType': reportType,
      'parameters': parameters,
    }, options: Options(responseType: ResponseType.bytes));
    return response.data;
  }

  Future<List<int>> exportToExcel(String hostelId, String reportType, Map<String, dynamic> parameters) async {
    final response = await _dio.post('/reports/export/excel/$hostelId', data: {
      'reportType': reportType,
      'parameters': parameters,
    }, options: Options(responseType: ResponseType.bytes));
    return response.data;
  }

  // Real-time Updates
  Future<void> subscribeToDashboardUpdates(String hostelId) async {
    await _dio.post('/reports/dashboard/subscribe/$hostelId');
  }

  Future<void> unsubscribeFromDashboardUpdates(String hostelId) async {
    await _dio.post('/reports/dashboard/unsubscribe/$hostelId');
  }

  Future<Map<String, dynamic>> getDashboardUpdateStatus(String hostelId) async {
    final response = await _dio.get('/reports/dashboard/status/$hostelId');
    return response.data;
  }

  // Custom Reports
  Future<List<Map<String, dynamic>>> executeCustomQuery(String query, Map<String, dynamic> parameters) async {
    final response = await _dio.post('/reports/custom/execute', data: {
      'query': query,
      'parameters': parameters,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<List<String>> getAvailableCustomQueries() async {
    final response = await _dio.get('/reports/custom/queries');
    return List<String>.from(response.data);
  }

  Future<Map<String, dynamic>> getCustomQueryDetails(String queryId) async {
    final response = await _dio.get('/reports/custom/queries/$queryId');
    return response.data;
  }

  // Dashboard Configuration
  Future<List<LiveDashboardTile>> getDashboardConfiguration(String hostelId) async {
    final response = await _dio.get('/reports/dashboard/config/$hostelId');
    return (response.data as List).map((json) => LiveDashboardTile.fromJson(json)).toList();
  }

  Future<void> updateDashboardConfiguration(String hostelId, List<LiveDashboardTile> tiles) async {
    await _dio.put('/reports/dashboard/config/$hostelId', data: {
      'tiles': tiles.map((tile) => tile.toJson()).toList(),
    });
  }

  Future<List<DashboardDrillDown>> getDashboardDrillDowns(String tileId) async {
    final response = await _dio.get('/reports/dashboard/drill-downs/$tileId');
    return (response.data as List).map((json) => DashboardDrillDown.fromJson(json)).toList();
  }

  // Performance Monitoring
  Future<Map<String, dynamic>> getDashboardPerformanceMetrics(String hostelId) async {
    final response = await _dio.get('/reports/dashboard/performance/$hostelId');
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getQueryPerformanceMetrics(String hostelId, {DateTime? from, DateTime? to}) async {
    final queryParams = <String, dynamic>{};
    if (from != null) queryParams['from'] = from.toIso8601String();
    if (to != null) queryParams['to'] = to.toIso8601String();
    
    final response = await _dio.get('/reports/performance/queries/$hostelId', queryParameters: queryParams);
    return List<Map<String, dynamic>>.from(response.data);
  }

  // Data Dictionary
  Future<Map<String, dynamic>> getDataDictionary() async {
    final response = await _dio.get('/reports/data-dictionary');
    return response.data;
  }

  Future<Map<String, dynamic>> getTileDataDictionary(String tileId) async {
    final response = await _dio.get('/reports/data-dictionary/tiles/$tileId');
    return response.data;
  }

  Future<List<Map<String, dynamic>>> getQueryDataDictionary(String queryId) async {
    final response = await _dio.get('/reports/data-dictionary/queries/$queryId');
    return List<Map<String, dynamic>>.from(response.data);
  }
}
