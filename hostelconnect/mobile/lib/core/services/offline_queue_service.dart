import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hostelconnect/core/models/offline_models.dart';
import 'package:hostelconnect/core/services/storage_service.dart';
import 'package:hostelconnect/core/services/network_service.dart';
import 'package:hostelconnect/core/api/attendance_api_service.dart';
import 'package:hostelconnect/core/api/notice_api_service.dart';
import 'package:hostelconnect/core/api/gatepass_api_service.dart';
import 'package:hostelconnect/core/api/meal_api_service.dart';

/// Offline Queue Service
/// Handles offline operations and queue management
class OfflineQueueService {
  static const String _queueKey = 'offline_queue';
  static const String _statsKey = 'offline_queue_stats';
  static const int _maxRetryCount = 3;
  static const Duration _retryDelay = Duration(minutes: 5);

  final StorageService _storageService;
  final NetworkService _networkService;
  final AttendanceApiService _attendanceApiService;
  final NoticeApiService _noticeApiService;
  final GatePassApiService _gatePassApiService;
  final MealApiService _mealApiService;

  OfflineQueueService({
    required StorageService storageService,
    required NetworkService networkService,
    required AttendanceApiService attendanceApiService,
    required NoticeApiService noticeApiService,
    required GatePassApiService gatePassApiService,
    required MealApiService mealApiService,
  }) : _storageService = storageService,
       _networkService = networkService,
       _attendanceApiService = attendanceApiService,
       _noticeApiService = noticeApiService,
       _gatePassApiService = gatePassApiService,
       _mealApiService = mealApiService;

  /// Add an item to the offline queue
  Future<void> addToQueue(OfflineQueueItem item) async {
    try {
      final queue = await _getQueue();
      queue.add(item);
      await _saveQueue(queue);
      await _updateStats();
      
      debugPrint('Added item to offline queue: ${item.type.displayName}');
    } catch (e) {
      debugPrint('Error adding item to offline queue: $e');
    }
  }

  /// Process all pending items in the queue
  Future<OfflineSyncResult> processQueue() async {
    if (!await _networkService.isConnected()) {
      return OfflineSyncResult(
        totalProcessed: 0,
        successful: 0,
        failed: 0,
        errors: ['No network connection'],
        syncedAt: DateTime.now(),
      );
    }

    final queue = await _getQueue();
    final pendingItems = queue.where((item) => 
      item.status == OfflineQueueStatus.pending ||
      item.status == OfflineQueueStatus.failed
    ).toList();

    int successful = 0;
    int failed = 0;
    final List<String> errors = [];

    for (final item in pendingItems) {
      try {
        await _processItem(item);
        successful++;
      } catch (e) {
        failed++;
        errors.add('${item.type.displayName}: $e');
        
        // Update item status
        final updatedItem = item.copyWith(
          status: OfflineQueueStatus.failed,
          errorMessage: e.toString(),
          retryCount: item.retryCount + 1,
          lastAttemptedAt: DateTime.now(),
        );
        
        final index = queue.indexWhere((q) => q.id == item.id);
        if (index != -1) {
          queue[index] = updatedItem;
        }
      }
    }

    await _saveQueue(queue);
    await _updateStats();

    return OfflineSyncResult(
      totalProcessed: pendingItems.length,
      successful: successful,
      failed: failed,
      errors: errors,
      syncedAt: DateTime.now(),
    );
  }

  /// Process a single queue item
  Future<void> _processItem(OfflineQueueItem item) async {
    switch (item.type) {
      case OfflineOperationType.attendanceScan:
        await _processAttendanceScan(item);
        break;
      case OfflineOperationType.noticeRead:
        await _processNoticeRead(item);
        break;
      case OfflineOperationType.gatePassScan:
        await _processGatePassScan(item);
        break;
      case OfflineOperationType.mealIntent:
        await _processMealIntent(item);
        break;
      case OfflineOperationType.userAction:
        await _processUserAction(item);
        break;
    }

    // Mark item as completed
    await _markItemCompleted(item.id);
  }

  /// Process attendance scan offline data
  Future<void> _processAttendanceScan(OfflineQueueItem item) async {
    final data = AttendanceScanOfflineData.fromJson(item.data);
    
    // Create attendance entry request
    final request = {
      'sessionId': data.sessionId,
      'studentId': data.studentId,
      'scanTime': data.scanTime.toIso8601String(),
      'qrCode': data.qrCode,
      'manualReason': data.manualReason,
      'metadata': data.metadata,
    };

    await _attendanceApiService.createAttendanceEntry(request);
  }

  /// Process notice read offline data
  Future<void> _processNoticeRead(OfflineQueueItem item) async {
    final data = NoticeReadOfflineData.fromJson(item.data);
    
    // Mark notice as read
    await _noticeApiService.markNoticeAsRead(
      data.noticeId,
      data.userId,
      data.readAt,
    );
  }

  /// Process gate pass scan offline data
  Future<void> _processGatePassScan(OfflineQueueItem item) async {
    final data = GatePassScanOfflineData.fromJson(item.data);
    
    // Record gate scan event
    final request = {
      'gatePassId': data.gatePassId,
      'studentId': data.studentId,
      'scanType': data.scanType.name,
      'scanTime': data.scanTime.toIso8601String(),
      'location': data.location,
      'metadata': data.metadata,
    };

    await _gatePassApiService.recordGateScanEvent(request);
  }

  /// Process meal intent offline data
  Future<void> _processMealIntent(OfflineQueueItem item) async {
    final data = MealIntentOfflineData.fromJson(item.data);
    
    // Submit meal intent
    final request = {
      'userId': data.userId,
      'date': data.date.toIso8601String(),
      'mealType': data.mealType.name,
      'intent': data.intent,
      'submittedAt': data.submittedAt.toIso8601String(),
      'metadata': data.metadata,
    };

    await _mealApiService.submitMealIntent(request);
  }

  /// Process user action offline data
  Future<void> _processUserAction(OfflineQueueItem item) async {
    // Generic user action processing
    // This would depend on the specific action type
    debugPrint('Processing user action: ${item.data}');
  }

  /// Mark an item as completed
  Future<void> _markItemCompleted(String itemId) async {
    final queue = await _getQueue();
    final index = queue.indexWhere((item) => item.id == itemId);
    
    if (index != -1) {
      queue[index] = queue[index].copyWith(
        status: OfflineQueueStatus.completed,
        lastAttemptedAt: DateTime.now(),
      );
      await _saveQueue(queue);
    }
  }

  /// Get all items in the queue
  Future<List<OfflineQueueItem>> getQueue() async {
    return await _getQueue();
  }

  /// Get queue statistics
  Future<OfflineQueueStats> getStats() async {
    final queue = await _getQueue();
    final isOnline = await _networkService.isConnected();
    
    return OfflineQueueStats(
      totalItems: queue.length,
      pendingItems: queue.where((item) => item.status == OfflineQueueStatus.pending).length,
      processingItems: queue.where((item) => item.status == OfflineQueueStatus.processing).length,
      completedItems: queue.where((item) => item.status == OfflineQueueStatus.completed).length,
      failedItems: queue.where((item) => item.status == OfflineQueueStatus.failed).length,
      cancelledItems: queue.where((item) => item.status == OfflineQueueStatus.cancelled).length,
      lastSyncAt: DateTime.now(),
      isOnline: isOnline,
    );
  }

  /// Clear completed items from the queue
  Future<void> clearCompletedItems() async {
    final queue = await _getQueue();
    final activeItems = queue.where((item) => 
      item.status != OfflineQueueStatus.completed
    ).toList();
    
    await _saveQueue(activeItems);
    await _updateStats();
  }

  /// Clear all items from the queue
  Future<void> clearQueue() async {
    await _storageService.remove(_queueKey);
    await _updateStats();
  }

  /// Get queue from storage
  Future<List<OfflineQueueItem>> _getQueue() async {
    try {
      final queueJson = await _storageService.getString(_queueKey);
      if (queueJson == null) return [];
      
      final List<dynamic> queueList = jsonDecode(queueJson);
      return queueList.map((json) => 
        OfflineQueueItem.fromJson(json as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      debugPrint('Error loading offline queue: $e');
      return [];
    }
  }

  /// Save queue to storage
  Future<void> _saveQueue(List<OfflineQueueItem> queue) async {
    try {
      final queueJson = jsonEncode(queue.map((item) => item.toJson()).toList());
      await _storageService.setString(_queueKey, queueJson);
    } catch (e) {
      debugPrint('Error saving offline queue: $e');
    }
  }

  /// Update queue statistics
  Future<void> _updateStats() async {
    try {
      final stats = await getStats();
      final statsJson = jsonEncode(stats.toJson());
      await _storageService.setString(_statsKey, statsJson);
    } catch (e) {
      debugPrint('Error updating queue stats: $e');
    }
  }

  /// Generate unique ID for queue items
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// Create attendance scan queue item
  Future<void> queueAttendanceScan({
    required String sessionId,
    required String studentId,
    required DateTime scanTime,
    String? qrCode,
    String? manualReason,
    Map<String, dynamic>? metadata,
  }) async {
    final data = AttendanceScanOfflineData(
      sessionId: sessionId,
      studentId: studentId,
      scanTime: scanTime,
      qrCode: qrCode,
      manualReason: manualReason,
      metadata: metadata,
    );

    final item = OfflineQueueItem(
      id: _generateId(),
      type: OfflineOperationType.attendanceScan,
      data: data.toJson(),
      createdAt: DateTime.now(),
    );

    await addToQueue(item);
  }

  /// Create notice read queue item
  Future<void> queueNoticeRead({
    required String noticeId,
    required String userId,
    required DateTime readAt,
    String? deviceId,
    Map<String, dynamic>? metadata,
  }) async {
    final data = NoticeReadOfflineData(
      noticeId: noticeId,
      userId: userId,
      readAt: readAt,
      deviceId: deviceId,
      metadata: metadata,
    );

    final item = OfflineQueueItem(
      id: _generateId(),
      type: OfflineOperationType.noticeRead,
      data: data.toJson(),
      createdAt: DateTime.now(),
    );

    await addToQueue(item);
  }

  /// Create gate pass scan queue item
  Future<void> queueGatePassScan({
    required String gatePassId,
    required String studentId,
    required GateScanType scanType,
    required DateTime scanTime,
    String? location,
    Map<String, dynamic>? metadata,
  }) async {
    final data = GatePassScanOfflineData(
      gatePassId: gatePassId,
      studentId: studentId,
      scanType: scanType,
      scanTime: scanTime,
      location: location,
      metadata: metadata,
    );

    final item = OfflineQueueItem(
      id: _generateId(),
      type: OfflineOperationType.gatePassScan,
      data: data.toJson(),
      createdAt: DateTime.now(),
    );

    await addToQueue(item);
  }

  /// Create meal intent queue item
  Future<void> queueMealIntent({
    required String userId,
    required DateTime date,
    required MealType mealType,
    required bool intent,
    required DateTime submittedAt,
    Map<String, dynamic>? metadata,
  }) async {
    final data = MealIntentOfflineData(
      userId: userId,
      date: date,
      mealType: mealType,
      intent: intent,
      submittedAt: submittedAt,
      metadata: metadata,
    );

    final item = OfflineQueueItem(
      id: _generateId(),
      type: OfflineOperationType.mealIntent,
      data: data.toJson(),
      createdAt: DateTime.now(),
    );

    await addToQueue(item);
  }
}
