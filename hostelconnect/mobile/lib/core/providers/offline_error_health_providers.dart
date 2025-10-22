import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/models/offline_models.dart';
import 'package:hostelconnect/core/models/error_models.dart';
import 'package:hostelconnect/core/models/health_models.dart';
import 'package:hostelconnect/core/models/load_state.dart';
import 'package:hostelconnect/core/services/offline_queue_service.dart';
import 'package:hostelconnect/core/services/error_service.dart';
import 'package:hostelconnect/core/services/health_monitoring_service.dart';
import 'package:hostelconnect/core/services/storage_service.dart';
import 'package:hostelconnect/core/services/network_service.dart';
import 'package:hostelconnect/core/api/attendance_api_service.dart';
import 'package:hostelconnect/core/api/notice_api_service.dart';
import 'package:hostelconnect/core/api/gatepass_api_service.dart';
import 'package:hostelconnect/core/api/meal_api_service.dart';

/// Service Providers
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

final attendanceApiServiceProvider = Provider<AttendanceApiService>((ref) {
  return AttendanceApiService();
});

final noticeApiServiceProvider = Provider<NoticeApiService>((ref) {
  return NoticeApiService();
});

final gatePassApiServiceProvider = Provider<GatePassApiService>((ref) {
  return GatePassApiService();
});

final mealApiServiceProvider = Provider<MealApiService>((ref) {
  return MealApiService();
});

final offlineQueueServiceProvider = Provider<OfflineQueueService>((ref) {
  return OfflineQueueService(
    storageService: ref.read(storageServiceProvider),
    networkService: ref.read(networkServiceProvider),
    attendanceApiService: ref.read(attendanceApiServiceProvider),
    noticeApiService: ref.read(noticeApiServiceProvider),
    gatePassApiService: ref.read(gatePassApiServiceProvider),
    mealApiService: ref.read(mealApiServiceProvider),
  );
});

final errorServiceProvider = Provider<ErrorService>((ref) {
  return ErrorService(
    storageService: ref.read(storageServiceProvider),
  );
});

final healthMonitoringServiceProvider = Provider<HealthMonitoringService>((ref) {
  return HealthMonitoringService(
    storageService: ref.read(storageServiceProvider),
    networkService: ref.read(networkServiceProvider),
  );
});

/// Offline Queue Providers
final offlineQueueProvider = FutureProvider<List<OfflineQueueItem>>((ref) async {
  final service = ref.read(offlineQueueServiceProvider);
  return await service.getQueue();
});

final offlineQueueStatsProvider = FutureProvider<OfflineQueueStats>((ref) async {
  final service = ref.read(offlineQueueServiceProvider);
  return await service.getStats();
});

final offlineSyncProvider = FutureProvider.family<OfflineSyncResult, void>((ref, _) async {
  final service = ref.read(offlineQueueServiceProvider);
  return await service.processQueue();
});

/// Offline Queue Notifier
class OfflineQueueNotifier extends StateNotifier<LoadState<List<OfflineQueueItem>>> {
  final OfflineQueueService _service;

  OfflineQueueNotifier(this._service) : super(const LoadState.idle()) {
    loadQueue();
  }

  Future<void> loadQueue() async {
    state = const LoadState.loading();
    try {
      final queue = await _service.getQueue();
      state = LoadState.success(queue);
    } catch (e) {
      state = LoadState.error(e.toString());
    }
  }

  Future<void> addToQueue(OfflineQueueItem item) async {
    await _service.addToQueue(item);
    await loadQueue();
  }

  Future<void> processQueue() async {
    await _service.processQueue();
    await loadQueue();
  }

  Future<void> clearCompletedItems() async {
    await _service.clearCompletedItems();
    await loadQueue();
  }

  Future<void> clearQueue() async {
    await _service.clearQueue();
    await loadQueue();
  }
}

final offlineQueueNotifierProvider = StateNotifierProvider<OfflineQueueNotifier, LoadState<List<OfflineQueueItem>>>((ref) {
  final service = ref.read(offlineQueueServiceProvider);
  return OfflineQueueNotifier(service);
});

/// Error Providers
final errorsProvider = FutureProvider.family<List<AppError>, ErrorFilter?>((ref, filter) async {
  final service = ref.read(errorServiceProvider);
  return await service.getErrors(filter: filter);
});

final errorStatsProvider = FutureProvider<ErrorStats>((ref) async {
  final service = ref.read(errorServiceProvider);
  return await service.getErrorStats();
});

/// Error Notifier
class ErrorNotifier extends StateNotifier<LoadState<List<AppError>>> {
  final ErrorService _service;
  ErrorFilter? _filter;

  ErrorNotifier(this._service) : super(const LoadState.idle()) {
    loadErrors();
  }

  Future<void> loadErrors({ErrorFilter? filter}) async {
    _filter = filter;
    state = const LoadState.loading();
    try {
      final errors = await _service.getErrors(filter: filter);
      state = LoadState.success(errors);
    } catch (e) {
      state = LoadState.error(e.toString());
    }
  }

  Future<void> logError({
    required String message,
    String? stackTrace,
    required ErrorType type,
    required ErrorSeverity severity,
    String? userId,
    String? sessionId,
    Map<String, dynamic>? context,
    bool isRetryable = false,
  }) async {
    await _service.logError(
      message: message,
      stackTrace: stackTrace,
      type: type,
      severity: severity,
      userId: userId,
      sessionId: sessionId,
      context: context,
      isRetryable: isRetryable,
    );
    await loadErrors(filter: _filter);
  }

  Future<bool> retryError(String errorId, {String? userId}) async {
    final result = await _service.retryError(errorId, userId: userId);
    await loadErrors(filter: _filter);
    return result;
  }

  Future<void> markAsResolved(String errorId) async {
    await _service.markAsResolved(errorId);
    await loadErrors(filter: _filter);
  }

  Future<void> markAsIgnored(String errorId) async {
    await _service.markAsIgnored(errorId);
    await loadErrors(filter: _filter);
  }

  Future<void> clearResolvedErrors() async {
    await _service.clearResolvedErrors();
    await loadErrors(filter: _filter);
  }

  Future<void> clearAllErrors() async {
    await _service.clearAllErrors();
    await loadErrors(filter: _filter);
  }
}

final errorNotifierProvider = StateNotifierProvider<ErrorNotifier, LoadState<List<AppError>>>((ref) {
  final service = ref.read(errorServiceProvider);
  return ErrorNotifier(service);
});

/// Health Providers
final systemHealthProvider = FutureProvider<SystemHealth>((ref) async {
  final service = ref.read(healthMonitoringServiceProvider);
  return await service.getSystemHealth();
});

final materializedViewHealthProvider = FutureProvider<List<MaterializedViewHealth>>((ref) async {
  final service = ref.read(healthMonitoringServiceProvider);
  return await service.getMaterializedViewHealth();
});

final healthAlertsProvider = FutureProvider<List<HealthAlert>>((ref) async {
  final service = ref.read(healthMonitoringServiceProvider);
  return await service.getHealthAlerts();
});

final isSystemHealthyProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(healthMonitoringServiceProvider);
  return await service.isSystemHealthy();
});

final areViewsStaleProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(healthMonitoringServiceProvider);
  return await service.areViewsStale();
});

/// Health Notifier
class HealthNotifier extends StateNotifier<LoadState<SystemHealth>> {
  final HealthMonitoringService _service;

  HealthNotifier(this._service) : super(const LoadState.idle()) {
    loadHealth();
  }

  Future<void> loadHealth() async {
    state = const LoadState.loading();
    try {
      final health = await _service.getSystemHealth();
      state = LoadState.success(health);
    } catch (e) {
      state = LoadState.error(e.toString());
    }
  }

  Future<void> startMonitoring() async {
    await _service.startMonitoring();
  }

  Future<void> stopMonitoring() async {
    await _service.stopMonitoring();
  }
}

final healthNotifierProvider = StateNotifierProvider<HealthNotifier, LoadState<SystemHealth>>((ref) {
  final service = ref.read(healthMonitoringServiceProvider);
  return HealthNotifier(service);
});

/// Network Status Provider
final networkStatusProvider = StreamProvider<bool>((ref) async* {
  final service = ref.read(networkServiceProvider);
  await for (final isConnected in service.connectionStream) {
    yield isConnected;
  }
});

/// Offline Status Provider
final offlineStatusProvider = Provider<bool>((ref) {
  final networkStatus = ref.watch(networkStatusProvider);
  return networkStatus.when(
    data: (isConnected) => !isConnected,
    loading: () => false,
    error: (_, __) => true,
  );
});

/// Sync Status Provider
final syncStatusProvider = Provider<bool>((ref) {
  final networkStatus = ref.watch(networkStatusProvider);
  final offlineQueueStats = ref.watch(offlineQueueStatsProvider);
  
  return networkStatus.when(
    data: (isConnected) => isConnected && offlineQueueStats.when(
      data: (stats) => stats.pendingItems == 0,
      loading: () => false,
      error: (_, __) => false,
    ),
    loading: () => false,
    error: (_, __) => false,
  );
});
