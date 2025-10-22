/// Offline Queue Models
/// Models for handling offline operations and queue management

class OfflineQueueItem {
  final String id;
  final OfflineOperationType type;
  final Map<String, dynamic> data;
  final DateTime createdAt;
  final int retryCount;
  final OfflineQueueStatus status;
  final String? errorMessage;
  final DateTime? lastAttemptedAt;

  const OfflineQueueItem({
    required this.id,
    required this.type,
    required this.data,
    required this.createdAt,
    this.retryCount = 0,
    this.status = OfflineQueueStatus.pending,
    this.errorMessage,
    this.lastAttemptedAt,
  });

  factory OfflineQueueItem.fromJson(Map<String, dynamic> json) {
    return OfflineQueueItem(
      id: json['id'] as String,
      type: OfflineOperationType.values.firstWhere((e) => e.name == json['type']),
      data: json['data'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      retryCount: json['retryCount'] as int? ?? 0,
      status: OfflineQueueStatus.values.firstWhere((e) => e.name == json['status']),
      errorMessage: json['errorMessage'] as String?,
      lastAttemptedAt: json['lastAttemptedAt'] != null 
          ? DateTime.parse(json['lastAttemptedAt'] as String) 
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'retryCount': retryCount,
      'status': status.name,
      'errorMessage': errorMessage,
      'lastAttemptedAt': lastAttemptedAt?.toIso8601String(),
    };
  }

  OfflineQueueItem copyWith({
    String? id,
    OfflineOperationType? type,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    int? retryCount,
    OfflineQueueStatus? status,
    String? errorMessage,
    DateTime? lastAttemptedAt,
  }) {
    return OfflineQueueItem(
      id: id ?? this.id,
      type: type ?? this.type,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
    );
  }
}

enum OfflineOperationType {
  attendanceScan,
  noticeRead,
  gatePassScan,
  mealIntent,
  userAction,
}

enum OfflineQueueStatus {
  pending,
  processing,
  completed,
  failed,
  cancelled,
}

class AttendanceScanOfflineData {
  final String sessionId;
  final String studentId;
  final DateTime scanTime;
  final String? qrCode;
  final String? manualReason;
  final Map<String, dynamic>? metadata;

  const AttendanceScanOfflineData({
    required this.sessionId,
    required this.studentId,
    required this.scanTime,
    this.qrCode,
    this.manualReason,
    this.metadata,
  });

  factory AttendanceScanOfflineData.fromJson(Map<String, dynamic> json) {
    return AttendanceScanOfflineData(
      sessionId: json['sessionId'] as String,
      studentId: json['studentId'] as String,
      scanTime: DateTime.parse(json['scanTime'] as String),
      qrCode: json['qrCode'] as String?,
      manualReason: json['manualReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'studentId': studentId,
      'scanTime': scanTime.toIso8601String(),
      'qrCode': qrCode,
      'manualReason': manualReason,
      'metadata': metadata,
    };
  }
}

class NoticeReadOfflineData {
  final String noticeId;
  final String userId;
  final DateTime readAt;
  final String? deviceId;
  final Map<String, dynamic>? metadata;

  const NoticeReadOfflineData({
    required this.noticeId,
    required this.userId,
    required this.readAt,
    this.deviceId,
    this.metadata,
  });

  factory NoticeReadOfflineData.fromJson(Map<String, dynamic> json) {
    return NoticeReadOfflineData(
      noticeId: json['noticeId'] as String,
      userId: json['userId'] as String,
      readAt: DateTime.parse(json['readAt'] as String),
      deviceId: json['deviceId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'noticeId': noticeId,
      'userId': userId,
      'readAt': readAt.toIso8601String(),
      'deviceId': deviceId,
      'metadata': metadata,
    };
  }
}

class GatePassScanOfflineData {
  final String gatePassId;
  final String studentId;
  final GateScanType scanType;
  final DateTime scanTime;
  final String? location;
  final Map<String, dynamic>? metadata;

  const GatePassScanOfflineData({
    required this.gatePassId,
    required this.studentId,
    required this.scanType,
    required this.scanTime,
    this.location,
    this.metadata,
  });

  factory GatePassScanOfflineData.fromJson(Map<String, dynamic> json) {
    return GatePassScanOfflineData(
      gatePassId: json['gatePassId'] as String,
      studentId: json['studentId'] as String,
      scanType: GateScanType.values.firstWhere((e) => e.name == json['scanType']),
      scanTime: DateTime.parse(json['scanTime'] as String),
      location: json['location'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'gatePassId': gatePassId,
      'studentId': studentId,
      'scanType': scanType.name,
      'scanTime': scanTime.toIso8601String(),
      'location': location,
      'metadata': metadata,
    };
  }
}

enum GateScanType {
  out,
  inScan,
}

class MealIntentOfflineData {
  final String userId;
  final DateTime date;
  final MealType mealType;
  final bool intent;
  final DateTime submittedAt;
  final Map<String, dynamic>? metadata;

  const MealIntentOfflineData({
    required this.userId,
    required this.date,
    required this.mealType,
    required this.intent,
    required this.submittedAt,
    this.metadata,
  });

  factory MealIntentOfflineData.fromJson(Map<String, dynamic> json) {
    return MealIntentOfflineData(
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      mealType: MealType.values.firstWhere((e) => e.name == json['mealType']),
      intent: json['intent'] as bool,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'mealType': mealType.name,
      'intent': intent,
      'submittedAt': submittedAt.toIso8601String(),
      'metadata': metadata,
    };
  }
}

enum MealType {
  breakfast,
  lunch,
  snacks,
  dinner,
}

class OfflineQueueStats {
  final int totalItems;
  final int pendingItems;
  final int processingItems;
  final int completedItems;
  final int failedItems;
  final int cancelledItems;
  final DateTime lastSyncAt;
  final bool isOnline;

  const OfflineQueueStats({
    required this.totalItems,
    required this.pendingItems,
    required this.processingItems,
    required this.completedItems,
    required this.failedItems,
    required this.cancelledItems,
    required this.lastSyncAt,
    required this.isOnline,
  });

  factory OfflineQueueStats.fromJson(Map<String, dynamic> json) {
    return OfflineQueueStats(
      totalItems: json['totalItems'] as int,
      pendingItems: json['pendingItems'] as int,
      processingItems: json['processingItems'] as int,
      completedItems: json['completedItems'] as int,
      failedItems: json['failedItems'] as int,
      cancelledItems: json['cancelledItems'] as int,
      lastSyncAt: DateTime.parse(json['lastSyncAt'] as String),
      isOnline: json['isOnline'] as bool,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalItems': totalItems,
      'pendingItems': pendingItems,
      'processingItems': processingItems,
      'completedItems': completedItems,
      'failedItems': failedItems,
      'cancelledItems': cancelledItems,
      'lastSyncAt': lastSyncAt.toIso8601String(),
      'isOnline': isOnline,
    };
  }
}

class OfflineSyncResult {
  final int totalProcessed;
  final int successful;
  final int failed;
  final List<String> errors;
  final DateTime syncedAt;

  const OfflineSyncResult({
    required this.totalProcessed,
    required this.successful,
    required this.failed,
    required this.errors,
    required this.syncedAt,
  });

  factory OfflineSyncResult.fromJson(Map<String, dynamic> json) {
    return OfflineSyncResult(
      totalProcessed: json['totalProcessed'] as int,
      successful: json['successful'] as int,
      failed: json['failed'] as int,
      errors: (json['errors'] as List).cast<String>(),
      syncedAt: DateTime.parse(json['syncedAt'] as String),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalProcessed': totalProcessed,
      'successful': successful,
      'failed': failed,
      'errors': errors,
      'syncedAt': syncedAt.toIso8601String(),
    };
  }
}

/// Extension methods for OfflineOperationType
extension OfflineOperationTypeExtension on OfflineOperationType {
  String get displayName {
    switch (this) {
      case OfflineOperationType.attendanceScan:
        return 'Attendance Scan';
      case OfflineOperationType.noticeRead:
        return 'Notice Read';
      case OfflineOperationType.gatePassScan:
        return 'Gate Pass Scan';
      case OfflineOperationType.mealIntent:
        return 'Meal Intent';
      case OfflineOperationType.userAction:
        return 'User Action';
    }
  }

  String get description {
    switch (this) {
      case OfflineOperationType.attendanceScan:
        return 'Record attendance scan when offline';
      case OfflineOperationType.noticeRead:
        return 'Mark notice as read when offline';
      case OfflineOperationType.gatePassScan:
        return 'Record gate pass scan when offline';
      case OfflineOperationType.mealIntent:
        return 'Submit meal intent when offline';
      case OfflineOperationType.userAction:
        return 'Record user action when offline';
    }
  }
}

/// Extension methods for OfflineQueueStatus
extension OfflineQueueStatusExtension on OfflineQueueStatus {
  String get displayName {
    switch (this) {
      case OfflineQueueStatus.pending:
        return 'Pending';
      case OfflineQueueStatus.processing:
        return 'Processing';
      case OfflineQueueStatus.completed:
        return 'Completed';
      case OfflineQueueStatus.failed:
        return 'Failed';
      case OfflineQueueStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case OfflineQueueStatus.pending:
        return 'Waiting to be processed';
      case OfflineQueueStatus.processing:
        return 'Currently being processed';
      case OfflineQueueStatus.completed:
        return 'Successfully processed';
      case OfflineQueueStatus.failed:
        return 'Failed to process';
      case OfflineQueueStatus.cancelled:
        return 'Cancelled by user';
    }
  }
}