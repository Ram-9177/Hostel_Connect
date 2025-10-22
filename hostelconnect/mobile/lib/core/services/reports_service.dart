// lib/core/services/reports_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_models.dart';
import '../api/reports_api_service.dart';
import '../state/load_state.dart';
import '../models/load_state_data.dart';

final reportsServiceProvider = Provider((ref) => ReportsService(ref.read(reportsApiServiceProvider)));

class ReportsService {
  final ReportsApiService _apiService;

  ReportsService(this._apiService);

  // Live Dashboard Tiles
  Future<LoadStateData<List<LiveDashboardTile>>> getLiveDashboardTiles(String hostelId) async {
    try {
      final tiles = await _apiService.getLiveDashboardTiles(hostelId);
      return LoadStateData(state: LoadState.success, data: tiles);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<LiveDashboardTile>> getLiveDashboardTile(String tileId) async {
    try {
      final tile = await _apiService.getLiveDashboardTile(tileId);
      return LoadStateData(state: LoadState.success, data: tile);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<LiveDashboardTile>>> refreshLiveDashboardTiles(String hostelId, {List<String>? tileIds}) async {
    try {
      final tiles = await _apiService.refreshLiveDashboardTiles(hostelId, tileIds: tileIds);
      return LoadStateData(state: LoadState.success, data: tiles);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Daily Analytics
  Future<LoadStateData<DailyAnalytics>> getDailyAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getDailyAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<DailyAnalytics>>> getDailyAnalyticsRange(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final analytics = await _apiService.getDailyAnalyticsRange(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Monthly Analytics
  Future<LoadStateData<MonthlyAnalytics>> getMonthlyAnalytics(String hostelId, DateTime month) async {
    try {
      final analytics = await _apiService.getMonthlyAnalytics(hostelId, month);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MonthlyAnalytics>>> getMonthlyAnalyticsRange(String hostelId, DateTime startMonth, DateTime endMonth) async {
    try {
      final analytics = await _apiService.getMonthlyAnalyticsRange(hostelId, startMonth, endMonth);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Drill Down Operations
  Future<LoadStateData<List<Map<String, dynamic>>>> executeDrillDown(DrillDownRequest request) async {
    try {
      final results = await _apiService.executeDrillDown(request);
      return LoadStateData(state: LoadState.success, data: results);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<DashboardDrillDown>>> getAvailableDrillDowns(String tileId) async {
    try {
      final drillDowns = await _apiService.getAvailableDrillDowns(tileId);
      return LoadStateData(state: LoadState.success, data: drillDowns);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Attendance Analytics
  Future<LoadStateData<AttendanceAnalytics>> getAttendanceAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getAttendanceAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<AttendanceSessionSummary>>> getAttendanceSessions(String hostelId, DateTime date) async {
    try {
      final sessions = await _apiService.getAttendanceSessions(hostelId, date);
      return LoadStateData(state: LoadState.success, data: sessions);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, int>>> getAttendanceHourlyBreakdown(String hostelId, DateTime date) async {
    try {
      final breakdown = await _apiService.getAttendanceHourlyBreakdown(hostelId, date);
      return LoadStateData(state: LoadState.success, data: breakdown);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Gate Analytics
  Future<LoadStateData<GateAnalytics>> getGateAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getGateAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<GatePassSummary>>> getGatePasses(String hostelId, DateTime date) async {
    try {
      final passes = await _apiService.getGatePasses(hostelId, date);
      return LoadStateData(state: LoadState.success, data: passes);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Duration>> getAverageTAT(String hostelId, DateTime date) async {
    try {
      final tat = await _apiService.getAverageTAT(hostelId, date);
      return LoadStateData(state: LoadState.success, data: tat);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, int>>> getGateHourlyFlow(String hostelId, DateTime date, String flowType) async {
    try {
      final flow = await _apiService.getGateHourlyFlow(hostelId, date, flowType);
      return LoadStateData(state: LoadState.success, data: flow);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Analytics
  Future<LoadStateData<MealAnalytics>> getMealAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getMealAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealVarianceSummary>>> getMealVariances(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final variances = await _apiService.getMealVariances(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: variances);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<MealType, MealTypeAnalytics>>> getMealTypeAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getMealTypeAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Occupancy Analytics
  Future<LoadStateData<OccupancyAnalytics>> getOccupancyAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getOccupancyAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<OccupancySummary>>> getRoomOccupancyDetails(String hostelId, DateTime date) async {
    try {
      final details = await _apiService.getRoomOccupancyDetails(hostelId, date);
      return LoadStateData(state: LoadState.success, data: details);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, int>>> getBlockOccupancy(String hostelId, DateTime date) async {
    try {
      final occupancy = await _apiService.getBlockOccupancy(hostelId, date);
      return LoadStateData(state: LoadState.success, data: occupancy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, int>>> getFloorOccupancy(String hostelId, DateTime date) async {
    try {
      final occupancy = await _apiService.getFloorOccupancy(hostelId, date);
      return LoadStateData(state: LoadState.success, data: occupancy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Integrity Analytics
  Future<LoadStateData<IntegrityAnalytics>> getIntegrityAnalytics(String hostelId, DateTime date) async {
    try {
      final analytics = await _apiService.getIntegrityAnalytics(hostelId, date);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<IntegrityCheck>>> getIntegrityChecks(String hostelId, DateTime date) async {
    try {
      final checks = await _apiService.getIntegrityChecks(hostelId, date);
      return LoadStateData(state: LoadState.success, data: checks);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, int>>> getIntegrityCheckBreakdown(String hostelId, DateTime date) async {
    try {
      final breakdown = await _apiService.getIntegrityCheckBreakdown(hostelId, date);
      return LoadStateData(state: LoadState.success, data: breakdown);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Trend Analytics
  Future<LoadStateData<AttendanceTrends>> getAttendanceTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final trends = await _apiService.getAttendanceTrends(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<GateTrends>> getGateTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final trends = await _apiService.getGateTrends(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealTrends>> getMealTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final trends = await _apiService.getMealTrends(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<OccupancyTrends>> getOccupancyTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final trends = await _apiService.getOccupancyTrends(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<IntegrityTrends>> getIntegrityTrends(String hostelId, DateTime startDate, DateTime endDate) async {
    try {
      final trends = await _apiService.getIntegrityTrends(hostelId, startDate, endDate);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Materialized Views Management
  Future<LoadStateData<void>> refreshMaterializedView(String viewName) async {
    try {
      await _apiService.refreshMaterializedView(viewName);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<String>>> getMaterializedViews() async {
    try {
      final views = await _apiService.getMaterializedViews();
      return LoadStateData(state: LoadState.success, data: views);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getMaterializedViewStatus(String viewName) async {
    try {
      final status = await _apiService.getMaterializedViewStatus(viewName);
      return LoadStateData(state: LoadState.success, data: status);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Export and Reporting
  Future<LoadStateData<String>> exportDashboardData(String hostelId, DashboardPeriod period, String format) async {
    try {
      final exportUrl = await _apiService.exportDashboardData(hostelId, period, format);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<String>> exportAnalyticsData(String hostelId, DateTime startDate, DateTime endDate, String format) async {
    try {
      final exportUrl = await _apiService.exportAnalyticsData(hostelId, startDate, endDate, format);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<int>>> exportToCSV(String hostelId, String reportType, Map<String, dynamic> parameters) async {
    try {
      final csvData = await _apiService.exportToCSV(hostelId, reportType, parameters);
      return LoadStateData(state: LoadState.success, data: csvData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<int>>> exportToExcel(String hostelId, String reportType, Map<String, dynamic> parameters) async {
    try {
      final excelData = await _apiService.exportToExcel(hostelId, reportType, parameters);
      return LoadStateData(state: LoadState.success, data: excelData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Real-time Updates
  Future<LoadStateData<void>> subscribeToDashboardUpdates(String hostelId) async {
    try {
      await _apiService.subscribeToDashboardUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> unsubscribeFromDashboardUpdates(String hostelId) async {
    try {
      await _apiService.unsubscribeFromDashboardUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getDashboardUpdateStatus(String hostelId) async {
    try {
      final status = await _apiService.getDashboardUpdateStatus(hostelId);
      return LoadStateData(state: LoadState.success, data: status);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Custom Reports
  Future<LoadStateData<List<Map<String, dynamic>>>> executeCustomQuery(String query, Map<String, dynamic> parameters) async {
    try {
      final results = await _apiService.executeCustomQuery(query, parameters);
      return LoadStateData(state: LoadState.success, data: results);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<String>>> getAvailableCustomQueries() async {
    try {
      final queries = await _apiService.getAvailableCustomQueries();
      return LoadStateData(state: LoadState.success, data: queries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getCustomQueryDetails(String queryId) async {
    try {
      final details = await _apiService.getCustomQueryDetails(queryId);
      return LoadStateData(state: LoadState.success, data: details);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Dashboard Configuration
  Future<LoadStateData<List<LiveDashboardTile>>> getDashboardConfiguration(String hostelId) async {
    try {
      final config = await _apiService.getDashboardConfiguration(hostelId);
      return LoadStateData(state: LoadState.success, data: config);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> updateDashboardConfiguration(String hostelId, List<LiveDashboardTile> tiles) async {
    try {
      await _apiService.updateDashboardConfiguration(hostelId, tiles);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<DashboardDrillDown>>> getDashboardDrillDowns(String tileId) async {
    try {
      final drillDowns = await _apiService.getDashboardDrillDowns(tileId);
      return LoadStateData(state: LoadState.success, data: drillDowns);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Performance Monitoring
  Future<LoadStateData<Map<String, dynamic>>> getDashboardPerformanceMetrics(String hostelId) async {
    try {
      final metrics = await _apiService.getDashboardPerformanceMetrics(hostelId);
      return LoadStateData(state: LoadState.success, data: metrics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getQueryPerformanceMetrics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final metrics = await _apiService.getQueryPerformanceMetrics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: metrics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Data Dictionary
  Future<LoadStateData<Map<String, dynamic>>> getDataDictionary() async {
    try {
      final dictionary = await _apiService.getDataDictionary();
      return LoadStateData(state: LoadState.success, data: dictionary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getTileDataDictionary(String tileId) async {
    try {
      final dictionary = await _apiService.getTileDataDictionary(tileId);
      return LoadStateData(state: LoadState.success, data: dictionary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getQueryDataDictionary(String queryId) async {
    try {
      final dictionary = await _apiService.getQueryDataDictionary(queryId);
      return LoadStateData(state: LoadState.success, data: dictionary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<LiveDashboardTile>>> getTilesByType(String hostelId, DashboardTileType type) async {
    try {
      final tiles = await _apiService.getLiveDashboardTiles(hostelId);
      final filteredTiles = tiles.where((tile) => tile.type == type).toList();
      return LoadStateData(state: LoadState.success, data: filteredTiles);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<LiveDashboardTile>>> getStaleTiles(String hostelId) async {
    try {
      final tiles = await _apiService.getLiveDashboardTiles(hostelId);
      final staleTiles = tiles.where((tile) => !tile.isFresh).toList();
      return LoadStateData(state: LoadState.success, data: staleTiles);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> getDashboardSummary(String hostelId, DateTime date) async {
    try {
      // Get all analytics for the day
      final attendance = await _apiService.getAttendanceAnalytics(hostelId, date);
      final gate = await _apiService.getGateAnalytics(hostelId, date);
      final meals = await _apiService.getMealAnalytics(hostelId, date);
      final occupancy = await _apiService.getOccupancyAnalytics(hostelId, date);
      final integrity = await _apiService.getIntegrityAnalytics(hostelId, date);

      final summary = {
        'date': date.toIso8601String(),
        'attendance': attendance.toJson(),
        'gate': gate.toJson(),
        'meals': meals.toJson(),
        'occupancy': occupancy.toJson(),
        'integrity': integrity.toJson(),
        'generatedAt': DateTime.now().toIso8601String(),
      };

      return LoadStateData(state: LoadState.success, data: summary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
