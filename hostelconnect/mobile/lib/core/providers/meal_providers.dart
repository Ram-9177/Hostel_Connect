// lib/core/providers/meal_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_models.dart';
import '../services/meal_service.dart';
import '../state/load_state.dart';

// Service Provider
final mealServiceProvider = Provider((ref) => MealService(ref.read(mealApiServiceProvider)));

// Meal Intent Providers
final studentMealIntentsProvider = StateNotifierProvider.family<StudentMealIntentsNotifier, LoadStateData<List<MealIntent>>, String>((ref, studentId) {
  return StudentMealIntentsNotifier(ref, studentId);
});

final hostelMealIntentsProvider = StateNotifierProvider.family<HostelMealIntentsNotifier, LoadStateData<List<MealIntent>>, String>((ref, hostelId) {
  return HostelMealIntentsNotifier(ref, hostelId);
});

final todayMealIntentsProvider = StateNotifierProvider.family<TodayMealIntentsNotifier, LoadStateData<List<MealIntent>>, String>((ref, studentId) {
  return TodayMealIntentsNotifier(ref, studentId);
});

final todayMealIntentMapProvider = StateNotifierProvider.family<TodayMealIntentMapNotifier, LoadStateData<Map<MealType, bool>>, String>((ref, studentId) {
  return TodayMealIntentMapNotifier(ref, studentId);
});

// Meal Forecast Providers
final mealForecastsProvider = StateNotifierProvider.family<MealForecastsNotifier, LoadStateData<List<MealForecast>>, String>((ref, hostelId) {
  return MealForecastsNotifier(ref, hostelId);
});

final todayMealForecastsProvider = StateNotifierProvider.family<TodayMealForecastsNotifier, LoadStateData<List<MealForecast>>, String>((ref, hostelId) {
  return TodayMealForecastsNotifier(ref, hostelId);
});

// Meal Override Providers
final mealOverridesProvider = StateNotifierProvider.family<MealOverridesNotifier, LoadStateData<List<MealOverride>>, String>((ref, hostelId) {
  return MealOverridesNotifier(ref, hostelId);
});

final todayMealOverridesProvider = StateNotifierProvider.family<TodayMealOverridesNotifier, LoadStateData<List<MealOverride>>, String>((ref, hostelId) {
  return TodayMealOverridesNotifier(ref, hostelId);
});

// Chef Board Providers
final chefBoardProvider = StateNotifierProvider.family<ChefBoardNotifier, LoadStateData<ChefBoard>, String>((ref, hostelId) {
  return ChefBoardNotifier(ref, hostelId);
});

final chefBoardsProvider = StateNotifierProvider.family<ChefBoardsNotifier, LoadStateData<List<ChefBoard>>, String>((ref, hostelId) {
  return ChefBoardsNotifier(ref, hostelId);
});

// Daily Meal Summary Providers
final dailyMealSummaryProvider = StateNotifierProvider.family<DailyMealSummaryNotifier, LoadStateData<DailyMealSummary>, String>((ref, hostelId) {
  return DailyMealSummaryNotifier(ref, hostelId);
});

final dailyMealSummariesProvider = StateNotifierProvider.family<DailyMealSummariesNotifier, LoadStateData<List<DailyMealSummary>>, String>((ref, hostelId) {
  return DailyMealSummariesNotifier(ref, hostelId);
});

// Meal Policy Providers
final mealPoliciesProvider = StateNotifierProvider.family<MealPoliciesNotifier, LoadStateData<List<MealPolicy>>, String>((ref, hostelId) {
  return MealPoliciesNotifier(ref, hostelId);
});

// Cutoff Status Providers
final cutoffStatusProvider = StateNotifierProvider.family<CutoffStatusNotifier, LoadStateData<Map<MealType, bool>>, String>((ref, hostelId) {
  return CutoffStatusNotifier(ref, hostelId);
});

final canSubmitIntentsProvider = StateNotifierProvider.family<CanSubmitIntentsNotifier, LoadStateData<Map<MealType, bool>>, String>((ref, hostelId) {
  return CanSubmitIntentsNotifier(ref, hostelId);
});

// Meal Statistics Providers
final mealStatisticsProvider = StateNotifierProvider.family<MealStatisticsNotifier, LoadStateData<MealStatistics>, String>((ref, hostelId) {
  return MealStatisticsNotifier(ref, hostelId);
});

final mealDashboardProvider = StateNotifierProvider.family<MealDashboardNotifier, LoadStateData<MealDashboardData>, String>((ref, hostelId) {
  return MealDashboardNotifier(ref, hostelId);
});

// Meal Templates Provider
final mealTemplatesProvider = StateNotifierProvider<MealTemplatesNotifier, LoadStateData<List<MealTemplate>>>((ref) {
  return MealTemplatesNotifier(ref);
});

// Meal Analytics Providers
final mealAnalyticsProvider = StateNotifierProvider.family<MealAnalyticsNotifier, LoadStateData<Map<String, dynamic>>, String>((ref, hostelId) {
  return MealAnalyticsNotifier(ref, hostelId);
});

final mealTrendsProvider = StateNotifierProvider.family<MealTrendsNotifier, LoadStateData<List<Map<String, dynamic>>>, String>((ref, hostelId) {
  return MealTrendsNotifier(ref, hostelId);
});

// Notifier Classes

class StudentMealIntentsNotifier extends StateNotifier<LoadStateData<List<MealIntent>>> {
  final Ref _ref;
  final String studentId;
  List<MealIntent> _cachedIntents = [];

  StudentMealIntentsNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadStudentMealIntents();
  }

  Future<void> loadStudentMealIntents({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getStudentMealIntents(studentId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedIntents = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedIntents);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedIntents);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedIntents);
    }
  }

  Future<void> submitMealIntent(MealIntentRequest request) async {
    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.submitMealIntent(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedIntents.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedIntents);
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> submitBulkIntents(BulkMealIntentRequest request) async {
    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.submitBulkMealIntents(request);

      if (result.state == LoadState.success && result.data != null) {
        // Replace existing intents for the same date
        final newIntents = result.data!;
        _cachedIntents.removeWhere((intent) => 
          intent.date.day == request.date.day &&
          intent.date.month == request.date.month &&
          intent.date.year == request.date.year
        );
        _cachedIntents.addAll(newIntents);
        state = LoadStateData(state: LoadState.success, data: _cachedIntents);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedIntents = [];
    state = LoadStateData();
  }
}

class HostelMealIntentsNotifier extends StateNotifier<LoadStateData<List<MealIntent>>> {
  final Ref _ref;
  final String hostelId;
  List<MealIntent> _cachedIntents = [];

  HostelMealIntentsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadHostelMealIntents();
  }

  Future<void> loadHostelMealIntents({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getHostelMealIntents(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedIntents = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedIntents);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedIntents);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedIntents);
    }
  }

  void clearCache() {
    _cachedIntents = [];
    state = LoadStateData();
  }
}

class TodayMealIntentsNotifier extends StateNotifier<LoadStateData<List<MealIntent>>> {
  final Ref _ref;
  final String studentId;
  List<MealIntent> _cachedIntents = [];

  TodayMealIntentsNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadTodayMealIntents();
  }

  Future<void> loadTodayMealIntents() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getTodayMealIntents(studentId, 'hostel_1'); // TODO: Get hostel from context

      if (result.state == LoadState.success) {
        _cachedIntents = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedIntents);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedIntents);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedIntents);
    }
  }

  void clearCache() {
    _cachedIntents = [];
    state = LoadStateData();
  }
}

class TodayMealIntentMapNotifier extends StateNotifier<LoadStateData<Map<MealType, bool>>> {
  final Ref _ref;
  final String studentId;
  Map<MealType, bool> _cachedIntentMap = {};

  TodayMealIntentMapNotifier(this._ref, this.studentId) : super(LoadStateData()) {
    loadTodayMealIntentMap();
  }

  Future<void> loadTodayMealIntentMap() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getTodayMealIntentMap(studentId, 'hostel_1'); // TODO: Get hostel from context

      if (result.state == LoadState.success) {
        _cachedIntentMap = result.data ?? {};
        state = LoadStateData(state: LoadState.success, data: _cachedIntentMap);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedIntentMap);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedIntentMap);
    }
  }

  void clearCache() {
    _cachedIntentMap = {};
    state = LoadStateData();
  }
}

class MealForecastsNotifier extends StateNotifier<LoadStateData<List<MealForecast>>> {
  final Ref _ref;
  final String hostelId;
  List<MealForecast> _cachedForecasts = [];

  MealForecastsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealForecasts();
  }

  Future<void> loadMealForecasts({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealForecasts(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedForecasts = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedForecasts);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedForecasts);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedForecasts);
    }
  }

  Future<void> calculateAllForecasts(DateTime date) async {
    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.calculateAllMealForecasts(hostelId, date);

      if (result.state == LoadState.success && result.data != null) {
        // Update forecasts for the specific date
        _cachedForecasts.removeWhere((forecast) => 
          forecast.date.day == date.day &&
          forecast.date.month == date.month &&
          forecast.date.year == date.year
        );
        _cachedForecasts.addAll(result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedForecasts);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedForecasts = [];
    state = LoadStateData();
  }
}

class TodayMealForecastsNotifier extends StateNotifier<LoadStateData<List<MealForecast>>> {
  final Ref _ref;
  final String hostelId;
  List<MealForecast> _cachedForecasts = [];

  TodayMealForecastsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadTodayMealForecasts();
  }

  Future<void> loadTodayMealForecasts() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final today = DateTime.now();
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealForecasts(hostelId, from: today, to: today);

      if (result.state == LoadState.success) {
        _cachedForecasts = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedForecasts);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedForecasts);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedForecasts);
    }
  }

  void clearCache() {
    _cachedForecasts = [];
    state = LoadStateData();
  }
}

class MealOverridesNotifier extends StateNotifier<LoadStateData<List<MealOverride>>> {
  final Ref _ref;
  final String hostelId;
  List<MealOverride> _cachedOverrides = [];

  MealOverridesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealOverrides();
  }

  Future<void> loadMealOverrides({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealOverrides(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedOverrides = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedOverrides);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedOverrides);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedOverrides);
    }
  }

  Future<void> addMealOverride(MealOverrideRequest request) async {
    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.addMealOverride(request);

      if (result.state == LoadState.success && result.data != null) {
        _cachedOverrides.insert(0, result.data!);
        state = LoadStateData(state: LoadState.success, data: _cachedOverrides);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedOverrides = [];
    state = LoadStateData();
  }
}

class TodayMealOverridesNotifier extends StateNotifier<LoadStateData<List<MealOverride>>> {
  final Ref _ref;
  final String hostelId;
  List<MealOverride> _cachedOverrides = [];

  TodayMealOverridesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadTodayMealOverrides();
  }

  Future<void> loadTodayMealOverrides() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final today = DateTime.now();
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealOverrides(hostelId, from: today, to: today);

      if (result.state == LoadState.success) {
        _cachedOverrides = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedOverrides);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedOverrides);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedOverrides);
    }
  }

  void clearCache() {
    _cachedOverrides = [];
    state = LoadStateData();
  }
}

class ChefBoardNotifier extends StateNotifier<LoadStateData<ChefBoard>> {
  final Ref _ref;
  final String hostelId;
  ChefBoard? _cachedChefBoard;

  ChefBoardNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadChefBoard();
  }

  Future<void> loadChefBoard({DateTime? date}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final targetDate = date ?? DateTime.now();
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getChefBoard(hostelId, targetDate);

      if (result.state == LoadState.success) {
        _cachedChefBoard = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedChefBoard);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedChefBoard);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedChefBoard);
    }
  }

  Future<void> lockChefBoard() async {
    if (_cachedChefBoard == null) return;

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.lockChefBoard(_cachedChefBoard!.id);

      if (result.state == LoadState.success && result.data != null) {
        _cachedChefBoard = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedChefBoard);
      }
    } catch (e) {
      // Handle error
    }
  }

  void clearCache() {
    _cachedChefBoard = null;
    state = LoadStateData();
  }
}

class ChefBoardsNotifier extends StateNotifier<LoadStateData<List<ChefBoard>>> {
  final Ref _ref;
  final String hostelId;
  List<ChefBoard> _cachedChefBoards = [];

  ChefBoardsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadChefBoards();
  }

  Future<void> loadChefBoards({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getChefBoards(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedChefBoards = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedChefBoards);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedChefBoards);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedChefBoards);
    }
  }

  void clearCache() {
    _cachedChefBoards = [];
    state = LoadStateData();
  }
}

class DailyMealSummaryNotifier extends StateNotifier<LoadStateData<DailyMealSummary>> {
  final Ref _ref;
  final String hostelId;
  DailyMealSummary? _cachedSummary;

  DailyMealSummaryNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadDailyMealSummary();
  }

  Future<void> loadDailyMealSummary({DateTime? date}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final targetDate = date ?? DateTime.now();
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getDailyMealSummary(hostelId, targetDate);

      if (result.state == LoadState.success) {
        _cachedSummary = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedSummary);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSummary);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSummary);
    }
  }

  void clearCache() {
    _cachedSummary = null;
    state = LoadStateData();
  }
}

class DailyMealSummariesNotifier extends StateNotifier<LoadStateData<List<DailyMealSummary>>> {
  final Ref _ref;
  final String hostelId;
  List<DailyMealSummary> _cachedSummaries = [];

  DailyMealSummariesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadDailyMealSummaries();
  }

  Future<void> loadDailyMealSummaries({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getDailyMealSummaries(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedSummaries = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedSummaries);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedSummaries);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedSummaries);
    }
  }

  void clearCache() {
    _cachedSummaries = [];
    state = LoadStateData();
  }
}

class MealPoliciesNotifier extends StateNotifier<LoadStateData<List<MealPolicy>>> {
  final Ref _ref;
  final String hostelId;
  List<MealPolicy> _cachedPolicies = [];

  MealPoliciesNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealPolicies();
  }

  Future<void> loadMealPolicies() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealPolicies(hostelId);

      if (result.state == LoadState.success) {
        _cachedPolicies = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedPolicies);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedPolicies);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedPolicies);
    }
  }

  void clearCache() {
    _cachedPolicies = [];
    state = LoadStateData();
  }
}

class CutoffStatusNotifier extends StateNotifier<LoadStateData<Map<MealType, bool>>> {
  final Ref _ref;
  final String hostelId;
  Map<MealType, bool> _cachedCutoffStatus = {};

  CutoffStatusNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadCutoffStatus();
  }

  Future<void> loadCutoffStatus() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.checkAllCutoffStatus(hostelId);

      if (result.state == LoadState.success) {
        _cachedCutoffStatus = result.data ?? {};
        state = LoadStateData(state: LoadState.success, data: _cachedCutoffStatus);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedCutoffStatus);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedCutoffStatus);
    }
  }

  void clearCache() {
    _cachedCutoffStatus = {};
    state = LoadStateData();
  }
}

class CanSubmitIntentsNotifier extends StateNotifier<LoadStateData<Map<MealType, bool>>> {
  final Ref _ref;
  final String hostelId;
  Map<MealType, bool> _cachedCanSubmit = {};

  CanSubmitIntentsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadCanSubmitIntents();
  }

  Future<void> loadCanSubmitIntents() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.canSubmitAllIntents(hostelId);

      if (result.state == LoadState.success) {
        _cachedCanSubmit = result.data ?? {};
        state = LoadStateData(state: LoadState.success, data: _cachedCanSubmit);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedCanSubmit);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedCanSubmit);
    }
  }

  void clearCache() {
    _cachedCanSubmit = {};
    state = LoadStateData();
  }
}

class MealStatisticsNotifier extends StateNotifier<LoadStateData<MealStatistics>> {
  final Ref _ref;
  final String hostelId;
  MealStatistics? _cachedStatistics;

  MealStatisticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealStatistics();
  }

  Future<void> loadMealStatistics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealStatistics(hostelId, from: from, to: to);

      if (result.state == LoadState.success) {
        _cachedStatistics = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedStatistics);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedStatistics);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedStatistics);
    }
  }

  void clearCache() {
    _cachedStatistics = null;
    state = LoadStateData();
  }
}

class MealDashboardNotifier extends StateNotifier<LoadStateData<MealDashboardData>> {
  final Ref _ref;
  final String hostelId;
  MealDashboardData? _cachedDashboardData;

  MealDashboardNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealDashboardData();
  }

  Future<void> loadMealDashboardData({DateTime? date}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final targetDate = date ?? DateTime.now();
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealDashboardData(hostelId, targetDate);

      if (result.state == LoadState.success) {
        _cachedDashboardData = result.data;
        state = LoadStateData(state: LoadState.success, data: _cachedDashboardData);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedDashboardData);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedDashboardData);
    }
  }

  void clearCache() {
    _cachedDashboardData = null;
    state = LoadStateData();
  }
}

class MealTemplatesNotifier extends StateNotifier<LoadStateData<List<MealTemplate>>> {
  final Ref _ref;
  List<MealTemplate> _cachedTemplates = [];

  MealTemplatesNotifier(this._ref) : super(LoadStateData()) {
    loadMealTemplates();
  }

  Future<void> loadMealTemplates() async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealTemplates();

      if (result.state == LoadState.success) {
        _cachedTemplates = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTemplates);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTemplates);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTemplates);
    }
  }

  void clearCache() {
    _cachedTemplates = [];
    state = LoadStateData();
  }
}

class MealAnalyticsNotifier extends StateNotifier<LoadStateData<Map<String, dynamic>>> {
  final Ref _ref;
  final String hostelId;
  Map<String, dynamic>? _cachedAnalytics;

  MealAnalyticsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealAnalytics();
  }

  Future<void> loadMealAnalytics({DateTime? from, DateTime? to}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealAnalytics(hostelId, from: from, to: to);

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

class MealTrendsNotifier extends StateNotifier<LoadStateData<List<Map<String, dynamic>>>> {
  final Ref _ref;
  final String hostelId;
  List<Map<String, dynamic>> _cachedTrends = [];

  MealTrendsNotifier(this._ref, this.hostelId) : super(LoadStateData()) {
    loadMealTrends();
  }

  Future<void> loadMealTrends({int days = 30}) async {
    if (state.state == LoadState.loading) return;

    state = state.copyWith(state: LoadState.loading);

    try {
      final mealService = _ref.read(mealServiceProvider);
      final result = await mealService.getMealTrends(hostelId, days: days);

      if (result.state == LoadState.success) {
        _cachedTrends = result.data ?? [];
        state = LoadStateData(state: LoadState.success, data: _cachedTrends);
      } else {
        state = LoadStateData(state: LoadState.error, error: result.error, data: _cachedTrends);
      }
    } catch (e) {
      state = LoadStateData(state: LoadState.error, error: e.toString(), data: _cachedTrends);
    }
  }

  void clearCache() {
    _cachedTrends = [];
    state = LoadStateData();
  }
}
