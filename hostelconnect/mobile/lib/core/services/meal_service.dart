// lib/core/services/meal_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_models.dart';
import '../api/meal_api_service.dart';
import '../state/load_state.dart';

final mealServiceProvider = Provider((ref) => MealService(ref.read(mealApiServiceProvider)));

class MealService {
  final MealApiService _apiService;

  MealService(this._apiService);

  // Meal Intent Management
  Future<LoadStateData<MealIntent>> submitMealIntent(MealIntentRequest request) async {
    try {
      final intent = await _apiService.submitMealIntent(request);
      return LoadStateData(state: LoadState.success, data: intent);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealIntent>> updateMealIntent(String intentId, Map<String, dynamic> updates) async {
    try {
      final intent = await _apiService.updateMealIntent(intentId, updates);
      return LoadStateData(state: LoadState.success, data: intent);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deleteMealIntent(String intentId) async {
    try {
      await _apiService.deleteMealIntent(intentId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> getStudentMealIntents(String studentId, {DateTime? from, DateTime? to}) async {
    try {
      final intents = await _apiService.getStudentMealIntents(studentId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> getHostelMealIntents(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final intents = await _apiService.getHostelMealIntents(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealIntent>> getMealIntent(String intentId) async {
    try {
      final intent = await _apiService.getMealIntent(intentId);
      return LoadStateData(state: LoadState.success, data: intent);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Bulk Meal Intent Operations
  Future<LoadStateData<List<MealIntent>>> submitBulkMealIntents(BulkMealIntentRequest request) async {
    try {
      final intents = await _apiService.submitBulkMealIntents(request);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> submitAllYesIntents(String studentId, String hostelId, DateTime date) async {
    try {
      final intents = await _apiService.submitAllYesIntents(studentId, hostelId, date);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> submitAllNoIntents(String studentId, String hostelId, DateTime date) async {
    try {
      final intents = await _apiService.submitAllNoIntents(studentId, hostelId, date);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> copyYesterdayIntents(String studentId, String hostelId, DateTime date) async {
    try {
      final intents = await _apiService.copyYesterdayIntents(studentId, hostelId, date);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Forecast Management
  Future<LoadStateData<MealForecast>> calculateMealForecast(String hostelId, DateTime date, MealType mealType) async {
    try {
      final forecast = await _apiService.calculateMealForecast(hostelId, date, mealType);
      return LoadStateData(state: LoadState.success, data: forecast);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealForecast>>> calculateAllMealForecasts(String hostelId, DateTime date) async {
    try {
      final forecasts = await _apiService.calculateAllMealForecasts(hostelId, date);
      return LoadStateData(state: LoadState.success, data: forecasts);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealForecast>>> getMealForecasts(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final forecasts = await _apiService.getMealForecasts(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: forecasts);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealForecast>> getMealForecast(String forecastId) async {
    try {
      final forecast = await _apiService.getMealForecast(forecastId);
      return LoadStateData(state: LoadState.success, data: forecast);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Override Management
  Future<LoadStateData<MealOverride>> addMealOverride(MealOverrideRequest request) async {
    try {
      final override = await _apiService.addMealOverride(request);
      return LoadStateData(state: LoadState.success, data: override);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealOverride>> updateMealOverride(String overrideId, Map<String, dynamic> updates) async {
    try {
      final override = await _apiService.updateMealOverride(overrideId, updates);
      return LoadStateData(state: LoadState.success, data: override);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> deleteMealOverride(String overrideId) async {
    try {
      await _apiService.deleteMealOverride(overrideId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealOverride>>> getMealOverrides(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final overrides = await _apiService.getMealOverrides(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: overrides);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealOverride>> getMealOverride(String overrideId) async {
    try {
      final override = await _apiService.getMealOverride(overrideId);
      return LoadStateData(state: LoadState.success, data: override);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Policy Management
  Future<LoadStateData<List<MealPolicy>>> getMealPolicies(String hostelId) async {
    try {
      final policies = await _apiService.getMealPolicies(hostelId);
      return LoadStateData(state: LoadState.success, data: policies);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealPolicy>> updateMealPolicy(String policyId, Map<String, dynamic> updates) async {
    try {
      final policy = await _apiService.updateMealPolicy(policyId, updates);
      return LoadStateData(state: LoadState.success, data: policy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealPolicy>> createMealPolicy(MealPolicy policy) async {
    try {
      final createdPolicy = await _apiService.createMealPolicy(policy);
      return LoadStateData(state: LoadState.success, data: createdPolicy);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Chef Board Management
  Future<LoadStateData<ChefBoard>> createChefBoard(String hostelId, DateTime date) async {
    try {
      final chefBoard = await _apiService.createChefBoard(hostelId, date);
      return LoadStateData(state: LoadState.success, data: chefBoard);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<ChefBoard>> getChefBoard(String hostelId, DateTime date) async {
    try {
      final chefBoard = await _apiService.getChefBoard(hostelId, date);
      return LoadStateData(state: LoadState.success, data: chefBoard);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<ChefBoard>> lockChefBoard(String chefBoardId) async {
    try {
      final chefBoard = await _apiService.lockChefBoard(chefBoardId);
      return LoadStateData(state: LoadState.success, data: chefBoard);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<ChefBoard>> updateChefBoard(String chefBoardId, Map<String, dynamic> updates) async {
    try {
      final chefBoard = await _apiService.updateChefBoard(chefBoardId, updates);
      return LoadStateData(state: LoadState.success, data: chefBoard);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<ChefBoard>>> getChefBoards(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final chefBoards = await _apiService.getChefBoards(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: chefBoards);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Daily Meal Summary
  Future<LoadStateData<DailyMealSummary>> getDailyMealSummary(String hostelId, DateTime date) async {
    try {
      final summary = await _apiService.getDailyMealSummary(hostelId, date);
      return LoadStateData(state: LoadState.success, data: summary);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<DailyMealSummary>>> getDailyMealSummaries(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final summaries = await _apiService.getDailyMealSummaries(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: summaries);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Statistics
  Future<LoadStateData<MealStatistics>> getMealStatistics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final statistics = await _apiService.getMealStatistics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: statistics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealDashboardData>> getMealDashboardData(String hostelId, DateTime date) async {
    try {
      final dashboardData = await _apiService.getMealDashboardData(hostelId, date);
      return LoadStateData(state: LoadState.success, data: dashboardData);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Cutoff Management
  Future<LoadStateData<bool>> checkCutoffStatus(String hostelId, MealType mealType) async {
    try {
      final cutoffPassed = await _apiService.checkCutoffStatus(hostelId, mealType);
      return LoadStateData(state: LoadState.success, data: cutoffPassed);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<MealType, bool>>> checkAllCutoffStatus(String hostelId) async {
    try {
      final cutoffStatus = await _apiService.checkAllCutoffStatus(hostelId);
      return LoadStateData(state: LoadState.success, data: cutoffStatus);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> extendCutoff(String hostelId, MealType mealType, int additionalMinutes) async {
    try {
      await _apiService.extendCutoff(hostelId, mealType, additionalMinutes);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Export/Import
  Future<LoadStateData<String>> exportMealData(MealExportRequest request) async {
    try {
      final exportUrl = await _apiService.exportMealData(request);
      return LoadStateData(state: LoadState.success, data: exportUrl);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> importMealData(String hostelId, List<Map<String, dynamic>> data) async {
    try {
      final intents = await _apiService.importMealData(hostelId, data);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Meal Templates
  Future<LoadStateData<List<MealTemplate>>> getMealTemplates() async {
    try {
      final templates = await _apiService.getMealTemplates();
      return LoadStateData(state: LoadState.success, data: templates);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<MealTemplate>> createMealTemplate(MealTemplate template) async {
    try {
      final createdTemplate = await _apiService.createMealTemplate(template);
      return LoadStateData(state: LoadState.success, data: createdTemplate);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Notifications
  Future<LoadStateData<void>> sendMealReminder(String hostelId, MealType mealType) async {
    try {
      await _apiService.sendMealReminder(hostelId, mealType);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> sendCutoffReminder(String hostelId) async {
    try {
      await _apiService.sendCutoffReminder(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Analytics
  Future<LoadStateData<Map<String, dynamic>>> getMealAnalytics(String hostelId, {DateTime? from, DateTime? to}) async {
    try {
      final analytics = await _apiService.getMealAnalytics(hostelId, from: from, to: to);
      return LoadStateData(state: LoadState.success, data: analytics);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<Map<String, dynamic>>>> getMealTrends(String hostelId, {int days = 30}) async {
    try {
      final trends = await _apiService.getMealTrends(hostelId, days: days);
      return LoadStateData(state: LoadState.success, data: trends);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Validation
  Future<LoadStateData<bool>> validateMealIntent(MealIntentRequest request) async {
    try {
      final isValid = await _apiService.validateMealIntent(request);
      return LoadStateData(state: LoadState.success, data: isValid);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<String, dynamic>>> checkMealEligibility(String studentId, DateTime date) async {
    try {
      final eligibility = await _apiService.checkMealEligibility(studentId, date);
      return LoadStateData(state: LoadState.success, data: eligibility);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Real-time Updates
  Future<LoadStateData<void>> subscribeToMealUpdates(String hostelId) async {
    try {
      await _apiService.subscribeToMealUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> unsubscribeFromMealUpdates(String hostelId) async {
    try {
      await _apiService.unsubscribeFromMealUpdates(hostelId);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Bulk Operations
  Future<LoadStateData<List<MealIntent>>> bulkUpdateIntents(List<String> intentIds, Map<String, dynamic> updates) async {
    try {
      final intents = await _apiService.bulkUpdateIntents(intentIds, updates);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<void>> bulkDeleteIntents(List<String> intentIds) async {
    try {
      await _apiService.bulkDeleteIntents(intentIds);
      return LoadStateData(state: LoadState.success);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // CSV Operations
  Future<LoadStateData<List<int>>> exportToCSV(String hostelId, DateTime date, List<MealType> mealTypes) async {
    try {
      final csvBytes = await _apiService.exportToCSV(hostelId, date, mealTypes);
      return LoadStateData(state: LoadState.success, data: csvBytes);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<List<MealIntent>>> importFromCSV(String hostelId, List<int> csvBytes) async {
    try {
      final intents = await _apiService.importFromCSV(hostelId, csvBytes);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  // Utility Methods
  Future<LoadStateData<List<MealIntent>>> getTodayMealIntents(String studentId, String hostelId) async {
    try {
      final today = DateTime.now();
      final intents = await _apiService.getStudentMealIntents(studentId, from: today, to: today);
      return LoadStateData(state: LoadState.success, data: intents);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<MealType, bool>>> getTodayMealIntentMap(String studentId, String hostelId) async {
    try {
      final result = await getTodayMealIntents(studentId, hostelId);
      if (result.state == LoadState.success && result.data != null) {
        final Map<MealType, bool> intentMap = {};
        for (final intent in result.data!) {
          intentMap[intent.mealType] = intent.willEat;
        }
        return LoadStateData(state: LoadState.success, data: intentMap);
      }
      return LoadStateData(state: LoadState.error, error: result.error);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<bool>> canSubmitIntent(String hostelId, MealType mealType) async {
    try {
      final cutoffResult = await checkCutoffStatus(hostelId, mealType);
      if (cutoffResult.state == LoadState.success) {
        return LoadStateData(state: LoadState.success, data: !cutoffResult.data!);
      }
      return LoadStateData(state: LoadState.error, error: cutoffResult.error);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }

  Future<LoadStateData<Map<MealType, bool>>> canSubmitAllIntents(String hostelId) async {
    try {
      final cutoffResult = await checkAllCutoffStatus(hostelId);
      if (cutoffResult.state == LoadState.success) {
        final Map<MealType, bool> canSubmit = {};
        for (final entry in cutoffResult.data!.entries) {
          canSubmit[entry.key] = !entry.value;
        }
        return LoadStateData(state: LoadState.success, data: canSubmit);
      }
      return LoadStateData(state: LoadState.error, error: cutoffResult.error);
    } catch (e) {
      return LoadStateData(state: LoadState.error, error: e.toString());
    }
  }
}
