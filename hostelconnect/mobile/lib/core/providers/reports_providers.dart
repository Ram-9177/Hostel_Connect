// lib/core/providers/reports_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dashboard_models.dart';
import '../services/reports_service.dart';
import '../state/load_state.dart';

// Service Provider
final reportsServiceProvider = Provider((ref) => ReportsService(ref.read(reportsApiServiceProvider)));

// Live Dashboard Tiles Providers
final liveDashboardTilesProvider = StateNotifierProvider.family<LiveDashboardTilesNotifier, LoadStateData<List<LiveDashboardTile>>, String>((ref, hostelId) {
  return LiveDashboardTilesNotifier(ref, hostelId);
});

final liveDashboardTileProvider = StateNotifierProvider.family<LiveDashboardTileNotifier, LoadStateData<LiveDashboardTile>, String>((ref, tileId) {
  return LiveDashboardTileNotifier(ref, tileId);
});

// Daily Analytics Providers
final dailyAnalyticsProvider = StateNotifierProvider.family<DailyAnalyticsNotifier, LoadStateData<DailyAnalytics>, (String, DateTime)>((ref, params) {
  return DailyAnalyticsNotifier(ref, params.$1, params.$2);
});

final dailyAnalyticsRangeProvider = StateNotifierProvider.family<DailyAnalyticsRangeNotifier, LoadStateData<List<DailyAnalytics>>, (String, DateTime, DateTime)>((ref, params) {
  return DailyAnalyticsRangeNotifier(ref, params.$1, params.$2, params.$3);
});

// Monthly Analytics Providers
final monthlyAnalyticsProvider = StateNotifierProvider.family<MonthlyAnalyticsNotifier, LoadStateData<MonthlyAnalytics>, (String, DateTime)>((ref, params) {
  return MonthlyAnalyticsNotifier(ref, params.$1, params.$2);
});

final monthlyAnalyticsRangeProvider = StateNotifierProvider.family<MonthlyAnalyticsRangeNotifier, LoadStateData<List<MonthlyAnalytics>>, (String, DateTime, DateTime)>((ref, params) {
  return MonthlyAnalyticsRangeNotifier(ref, params.$1, params.$2, params.$3);
});

// Drill Down Providers
final drillDownResultsProvider = StateNotifierProvider.family<DrillDownResultsNotifier, LoadStateData<List<Map<String, dynamic>>>, DrillDownRequest>((ref, request) {
  return DrillDownResultsNotifier(ref, request);
});

final availableDrillDownsProvider = StateNotifierProvider.family<AvailableDrillDownsNotifier, LoadStateData<List<DashboardDrillDown>>, String>((ref, tileId) {
  return AvailableDrillDownsNotifier(ref, tileId);
});

// Attendance Analytics Providers
final attendanceAnalyticsProvider = StateNotifierProvider.family<AttendanceAnalyticsNotifier, LoadStateData<AttendanceAnalytics>, (String, DateTime)>((ref, params) {
  return AttendanceAnalyticsNotifier(ref, params.$1, params.$2);
});

final attendanceSessionsProvider = StateNotifierProvider.family<AttendanceSessionsNotifier, LoadStateData<List<AttendanceSessionSummary>>, (String, DateTime)>((ref, params) {
  return AttendanceSessionsNotifier(ref, params.$1, params.$2);
});

final attendanceHourlyBreakdownProvider = StateNotifierProvider.family<AttendanceHourlyBreakdownNotifier, LoadStateData<Map<String, int>>, (String, DateTime)>((ref, params) {
  return AttendanceHourlyBreakdownNotifier(ref, params.$1, params.$2);
});

// Gate Analytics Providers
final gateAnalyticsProvider = StateNotifierProvider.family<GateAnalyticsNotifier, LoadStateData<GateAnalytics>, (String, DateTime)>((ref, params) {
  return GateAnalyticsNotifier(ref, params.$1, params.$2);
});

final gatePassesProvider = StateNotifierProvider.family<GatePassesNotifier, LoadStateData<List<GatePassSummary>>, (String, DateTime)>((ref, params) {
  return GatePassesNotifier(ref, params.$1, params.$2);
});

final averageTATProvider = StateNotifierProvider.family<AverageTATNotifier, LoadStateData<Duration>, (String, DateTime)>((ref, params) {
  return AverageTATNotifier(ref, params.$1, params.$2);
});

// Meal Analytics Providers
final mealAnalyticsProvider = StateNotifierProvider.family<MealAnalyticsNotifier, LoadStateData<MealAnalytics>, (String, DateTime)>((ref, params) {
  return MealAnalyticsNotifier(ref, params.$1, params.$2);
});

final mealVariancesProvider = StateNotifierProvider.family<MealVariancesNotifier, LoadStateData<List<MealVarianceSummary>>, (String, DateTime, DateTime)>((ref, params) {
  return MealVariancesNotifier(ref, params.$1, params.$2, params.$3);
});

// Occupancy Analytics Providers
final occupancyAnalyticsProvider = StateNotifierProvider.family<OccupancyAnalyticsNotifier, LoadStateData<OccupancyAnalytics>, (String, DateTime)>((ref, params) {
  return OccupancyAnalyticsNotifier(ref, params.$1, params.$2);
});

final roomOccupancyDetailsProvider = StateNotifierProvider.family<RoomOccupancyDetailsNotifier, LoadStateData<List<OccupancySummary>>, (String, DateTime)>((ref, params) {
  return RoomOccupancyDetailsNotifier(ref, params.$1, params.$2);
});

// Integrity Analytics Providers
final integrityAnalyticsProvider = StateNotifierProvider.family<IntegrityAnalyticsNotifier, LoadStateData<IntegrityAnalytics>, (String, DateTime)>((ref, params) {
  return IntegrityAnalyticsNotifier(ref, params.$1, params.$2);
});

final integrityChecksProvider = StateNotifierProvider.family<IntegrityChecksNotifier, LoadStateData<List<IntegrityCheck>>, (String, DateTime)>((ref, params) {
  return IntegrityChecksNotifier(ref, params.$1, params.$2);
});

// Trend Analytics Providers
final attendanceTrendsProvider = StateNotifierProvider.family<AttendanceTrendsNotifier, LoadStateData<AttendanceTrends>, (String, DateTime, DateTime)>((ref, params) {
  return AttendanceTrendsNotifier(ref, params.$1, params.$2, params.$3);
});

final gateTrendsProvider = StateNotifierProvider.family<GateTrendsNotifier, LoadStateData<GateTrends>, (String, DateTime, DateTime)>((ref, params) {
  return GateTrendsNotifier(ref, params.$1, params.$2, params.$3);
});

final mealTrendsProvider = StateNotifierProvider.family<MealTrendsNotifier, LoadStateData<MealTrends>, (String, DateTime, DateTime)>((ref, params) {
  return MealTrendsNotifier(ref, params.$1, params.$2, params.$3);
});

final occupancyTrendsProvider = StateNotifierProvider.family<OccupancyTrendsNotifier, LoadStateData<OccupancyTrends>, (String, DateTime, DateTime)>((ref, params) {
  return OccupancyTrendsNotifier(ref, params.$1, params.$2, params.$3);
});

final integrityTrendsProvider = StateNotifierProvider.family<IntegrityTrendsNotifier, LoadStateData<IntegrityTrends>, (String, DateTime, DateTime)>((ref, params) {
  return IntegrityTrendsNotifier(ref, params.$1, params.$2, params.$3);
});

// Dashboard Configuration Provider
final dashboardConfigurationProvider = StateNotifierProvider.family<DashboardConfigurationNotifier, LoadStateData<List<LiveDashboardTile>>, String>((ref, hostelId) {
  return DashboardConfigurationNotifier(ref, hostelId);
});

// Notifier Classes

class LiveDashboardTilesNotifier extends StateNotifier<LoadStateData<List<LiveDashboardTile>>> {
  final Ref _ref;
  final String hostelId;
  List<LiveDashboardTile> _cachedTiles = [];

  LiveDashboardTilesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadTiles();
  }

  Future<void> loadTiles() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getLiveDashboardTiles(hostelId);

      if (result.state == LoadState.success) {
        _cachedTiles = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTiles);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTiles);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTiles);
    }
  }

  Future<void> refreshTiles({List<String>? tileIds}) async {
    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.refreshLiveDashboardTiles(hostelId, tileIds: tileIds);

      if (result.state == LoadState.success) {
        _cachedTiles = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTiles);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedTiles = [];
    state = LoadStateData();
  }
}

class LiveDashboardTileNotifier extends StateNotifier<LoadStateData<LiveDashboardTile>> {
  final Ref _ref;
  final String tileId;
  LiveDashboardTile? _cachedTile;

  LiveDashboardTileNotifier(this._ref, this.tileId) : super(LoadStateData()) {
    loadTile();
  }

  Future<void> loadTile() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getLiveDashboardTile(tileId);

      if (result.state == LoadState.success) {
        _cachedTile = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTile);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTile);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTile);
    }
  }

  void clearCache() {
    _cachedTile = null;
    state = LoadStateData();
  }
}

class DailyAnalyticsNotifier extends StateNotifier<LoadStateData<DailyAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  DailyAnalytics? _cachedAnalytics;

  DailyAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getDailyAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class DailyAnalyticsRangeNotifier extends StateNotifier<LoadStateData<List<DailyAnalytics>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  List<DailyAnalytics> _cachedAnalytics = [];

  DailyAnalyticsRangeNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getDailyAnalyticsRange(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = [];
    state = LoadStateData();
  }
}

class MonthlyAnalyticsNotifier extends StateNotifier<LoadStateData<MonthlyAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime month;
  MonthlyAnalytics? _cachedAnalytics;

  MonthlyAnalyticsNotifier(this._ref, this.hostelId, this.month) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getMonthlyAnalytics(hostelId, month);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class MonthlyAnalyticsRangeNotifier extends StateNotifier<LoadStateData<List<MonthlyAnalytics>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startMonth;
  final DateTime endMonth;
  List<MonthlyAnalytics> _cachedAnalytics = [];

  MonthlyAnalyticsRangeNotifier(this._ref, this.hostelId, this.startMonth, this.endMonth) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getMonthlyAnalyticsRange(hostelId, startMonth, endMonth);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = [];
    state = LoadStateData();
  }
}

class DrillDownResultsNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  final DrillDownRequest request;
  List<Map<String, dynamic>> _cachedResults = [];

  DrillDownResultsNotifier(this._ref, this.request) : super(LoadStateData()) {
    executeDrillDown();
  }

  Future<void> executeDrillDown() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.executeDrillDown(request);

      if (result.state == LoadState.success) {
        _cachedResults = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedResults);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedResults);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedResults);
    }
  }

  void clearCache() {
    _cachedResults = [];
    state = LoadStateData();
  }
}

class AvailableDrillDownsNotifier extends StateNotifier<LoadStateData<List<DashboardDrillDown>>> {
  final Ref _ref;
  final String tileId;
  List<DashboardDrillDown> _cachedDrillDowns = [];

  AvailableDrillDownsNotifier(this._ref, this.tileId) : super(LoadStateData()) {
    loadDrillDowns();
  }

  Future<void> loadDrillDowns() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAvailableDrillDowns(tileId);

      if (result.state == LoadState.success) {
        _cachedDrillDowns = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedDrillDowns);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDrillDowns);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDrillDowns);
    }
  }

  void clearCache() {
    _cachedDrillDowns = [];
    state = LoadStateData();
  }
}

// Additional Notifier Classes (Attendance, Gate, Meal, Occupancy, Integrity, Trends)

class AttendanceAnalyticsNotifier extends StateNotifier<LoadStateData<AttendanceAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  AttendanceAnalytics? _cachedAnalytics;

  AttendanceAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAttendanceAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class AttendanceSessionsNotifier extends StateNotifier<LoadStateData<List<AttendanceSessionSummary>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  List<AttendanceSessionSummary> _cachedSessions = [];

  AttendanceSessionsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAttendanceSessions(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedSessions = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedSessions);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSessions);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSessions);
    }
  }

  void clearCache() {
    _cachedSessions = [];
    state = LoadStateData();
  }
}

class AttendanceHourlyBreakdownNotifier extends StateNotifier<LoadStateData<Map<String, int>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  Map<String, int> _cachedBreakdown = {};

  AttendanceHourlyBreakdownNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadBreakdown();
  }

  Future<void> loadBreakdown() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAttendanceHourlyBreakdown(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedBreakdown = result.data ?? {};
        state = LoadStateData(state: LoadState.success, data: _cachedBreakdown);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedBreakdown);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedBreakdown);
    }
  }

  void clearCache() {
    _cachedBreakdown = {};
    state = LoadStateData();
  }
}

// Additional notifier classes for Gate, Meal, Occupancy, Integrity, and Trends
// (Following the same pattern as above)

class GateAnalyticsNotifier extends StateNotifier<LoadStateData<GateAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  GateAnalytics? _cachedAnalytics;

  GateAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getGateAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class GatePassesNotifier extends StateNotifier<LoadStateData<List<GatePassSummary>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  List<GatePassSummary> _cachedPasses = [];

  GatePassesNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadPasses();
  }

  Future<void> loadPasses() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getGatePasses(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedPasses = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPasses);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPasses);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPasses);
    }
  }

  void clearCache() {
    _cachedPasses = [];
    state = LoadStateData();
  }
}

class AverageTATNotifier extends StateNotifier<LoadStateData<Duration>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  Duration? _cachedTAT;

  AverageTATNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadTAT();
  }

  Future<void> loadTAT() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAverageTAT(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedTAT = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTAT);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTAT);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTAT);
    }
  }

  void clearCache() {
    _cachedTAT = null;
    state = LoadStateData();
  }
}

// Additional notifier classes for Meal, Occupancy, Integrity, and Trends
// (Following the same pattern as above)

class MealAnalyticsNotifier extends StateNotifier<LoadStateData<MealAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  MealAnalytics? _cachedAnalytics;

  MealAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getMealAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class MealVariancesNotifier extends StateNotifier<LoadStateData<List<MealVarianceSummary>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  List<MealVarianceSummary> _cachedVariances = [];

  MealVariancesNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadVariances();
  }

  Future<void> loadVariances() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getMealVariances(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedVariances = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedVariances);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedVariances);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedVariances);
    }
  }

  void clearCache() {
    _cachedVariances = [];
    state = LoadStateData();
  }
}

// Additional notifier classes for Occupancy, Integrity, and Trends
// (Following the same pattern as above)

class OccupancyAnalyticsNotifier extends StateNotifier<LoadStateData<OccupancyAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  OccupancyAnalytics? _cachedAnalytics;

  OccupancyAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getOccupancyAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class RoomOccupancyDetailsNotifier extends StateNotifier<LoadStateData<List<OccupancySummary>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  List<OccupancySummary> _cachedDetails = [];

  RoomOccupancyDetailsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadDetails();
  }

  Future<void> loadDetails() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getRoomOccupancyDetails(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedDetails = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedDetails);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDetails);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDetails);
    }
  }

  void clearCache() {
    _cachedDetails = [];
    state = LoadStateData();
  }
}

// Additional notifier classes for Integrity and Trends
// (Following the same pattern as above)

class IntegrityAnalyticsNotifier extends StateNotifier<LoadStateData<IntegrityAnalytics>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  IntegrityAnalytics? _cachedAnalytics;

  IntegrityAnalyticsNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getIntegrityAnalytics(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedAnalytics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedAnalytics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedAnalytics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedAnalytics);
    }
  }

  void clearCache() {
    _cachedAnalytics = null;
    state = LoadStateData();
  }
}

class IntegrityChecksNotifier extends StateNotifier<LoadStateData<List<IntegrityCheck>>> {
  final Ref _ref;
  final String hostelId;
  final DateTime date;
  List<IntegrityCheck> _cachedChecks = [];

  IntegrityChecksNotifier(this._ref, this.hostelId, this.date) : super(LoadStateData()) {
    loadChecks();
  }

  Future<void> loadChecks() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getIntegrityChecks(hostelId, date);

      if (result.state == LoadState.success) {
        _cachedChecks = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedChecks);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedChecks);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedChecks);
    }
  }

  void clearCache() {
    _cachedChecks = [];
    state = LoadStateData();
  }
}

// Additional notifier classes for Trends
// (Following the same pattern as above)

class AttendanceTrendsNotifier extends StateNotifier<LoadStateData<AttendanceTrends>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  AttendanceTrends? _cachedTrends;

  AttendanceTrendsNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getAttendanceTrends(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = null;
    state = LoadStateData();
  }
}

class GateTrendsNotifier extends StateNotifier<LoadStateData<GateTrends>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  GateTrends? _cachedTrends;

  GateTrendsNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getGateTrends(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = null;
    state = LoadStateData();
  }
}

class MealTrendsNotifier extends StateNotifier<LoadStateData<MealTrends>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  MealTrends? _cachedTrends;

  MealTrendsNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getMealTrends(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = null;
    state = LoadStateData();
  }
}

class OccupancyTrendsNotifier extends StateNotifier<LoadStateData<OccupancyTrends>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  OccupancyTrends? _cachedTrends;

  OccupancyTrendsNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getOccupancyTrends(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = null;
    state = LoadStateData();
  }
}

class IntegrityTrendsNotifier extends StateNotifier<LoadStateData<IntegrityTrends>> {
  final Ref _ref;
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  IntegrityTrends? _cachedTrends;

  IntegrityTrendsNotifier(this._ref, this.hostelId, this.startDate, this.endDate) : super(LoadStateData()) {
    loadTrends();
  }

  Future<void> loadTrends() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getIntegrityTrends(hostelId, startDate, endDate);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = null;
    state = LoadStateData();
  }
}

class DashboardConfigurationNotifier extends StateNotifier<LoadStateData<List<LiveDashboardTile>>> {
  final Ref _ref;
  final String hostelId;
  List<LiveDashboardTile> _cachedConfiguration = [];

  DashboardConfigurationNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadConfiguration();
  }

  Future<void> loadConfiguration() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.getDashboardConfiguration(hostelId);

      if (result.state == LoadState.success) {
        _cachedConfiguration = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedConfiguration);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedConfiguration);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedConfiguration);
    }
  }

  Future<void> updateConfiguration(List<LiveDashboardTile> tiles) async {
    try {
      final reportsService = _ref.read(reportsServiceProvider);
      final result = await reportsService.updateDashboardConfiguration(hostelId, tiles);

      if (result.state == LoadState.success) {
        _cachedConfiguration = tiles;
        state = LoadStateData(state: LoadState.success, data: _cachedConfiguration);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedConfiguration = [];
    state = LoadStateData();
  }
}