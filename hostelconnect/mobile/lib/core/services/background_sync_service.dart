import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// Temporarily commented out - causing build issues
// import 'package:workmanager/workmanager.dart';

import 'offline_storage_service.dart';
import 'sync_service.dart';

const String _periodicSyncTaskId = 'hostelconnect_periodic_sync';
const String _oneOffSyncTaskId = 'hostelconnect_one_off_sync';

@pragma('vm:entry-point')
void hostelConnectBackgroundDispatcher() {
  // Temporarily disabled - workmanager causing build issues
  // Will re-enable after fixing package compatibility
  /*
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    try {
      await SyncService.backgroundSync();
      return Future.value(true);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Background sync task failed: $error');
        debugPrint(stackTrace.toString());
      }
      return Future.value(false);
    }
  });
  */
}

class BackgroundSyncService {
  static bool _initialized = false;
  static StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  /// Initialize background sync scheduling and listeners.
  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    WidgetsFlutterBinding.ensureInitialized();

    // Temporarily disabled - workmanager causing build issues
    /*
    if (_supportsNativeScheduling) {
      await Workmanager().initialize(
        hostelConnectBackgroundDispatcher,
        isInDebugMode: kDebugMode,
      );
      await _schedulePeriodicTask();
    }
    */

    _listenToConnectivityChanges();
    _initialized = true;
  }

  /// Backwards-compatible entry point used across the app.
  static Future<void> startBackgroundSync() async {
    await initialize();
  }

  /// Cancel scheduled work and listeners.
  static Future<void> stopBackgroundSync() async {
    await _connectivitySubscription?.cancel();
    _connectivitySubscription = null;

    // Temporarily disabled - workmanager causing build issues
    /*
    if (_supportsNativeScheduling) {
      await Workmanager().cancelByUniqueName(_periodicSyncTaskId);
    }
    */

    _initialized = false;
  }

  /// Trigger an immediate sync and queue a native one-off job if supported.
  static Future<void> forceSync() async {
    await SyncService.backgroundSync();

    // Temporarily disabled - workmanager causing build issues
    /*
    if (_supportsNativeScheduling) {
      final uniqueName =
          '${_oneOffSyncTaskId}_${DateTime.now().millisecondsSinceEpoch}';
      try {
        await Workmanager().registerOneOffTask(
          uniqueName,
          _oneOffSyncTaskId,
          constraints: Constraints(
            networkType: NetworkType.connected,
          ),
          backoffPolicy: BackoffPolicy.exponential,
          backoffPolicyDelay: const Duration(minutes: 5),
        );
      } catch (error, stackTrace) {
        if (kDebugMode) {
          debugPrint('Failed to register one-off sync task: $error');
          debugPrint(stackTrace.toString());
        }
      }
    }
    */
  }

  /// Expose whether background sync is configured.
  static bool get isActive => _initialized;

  /// Provide sync status plus scheduling metadata for diagnostics.
  static Future<Map<String, dynamic>> getSyncStatus() async {
    final status = await SyncService.getSyncStatus();
    return {
      ...status,
      'workmanagerEnabled': _supportsNativeScheduling,
    };
  }

  static Future<void> _schedulePeriodicTask() async {
    // Temporarily disabled - workmanager causing build issues
    /*
    try {
      await Workmanager().cancelByUniqueName(_periodicSyncTaskId);
      await Workmanager().registerPeriodicTask(
        _periodicSyncTaskId,
        _periodicSyncTaskId,
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(minutes: 5),
        existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
        ),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 5),
      );
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint('Failed to schedule periodic background sync: $error');
        debugPrint(stackTrace.toString());
      }
    }
    */
  }

  static void _listenToConnectivityChanges() {
    _connectivitySubscription ??=
        OfflineStorageService.connectivityStream.listen((result) async {
      if (result != ConnectivityResult.none) {
        await SyncService.backgroundSync();
      }
    });
  }

  static bool get _supportsNativeScheduling {
    if (kIsWeb) {
      return false;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return true;
      default:
        return false;
    }
  }
}
