// lib/core/models/gatepass_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gatepass_models.freezed.dart';
part 'gatepass_models.g.dart';

/// Gate Pass Request Model
@freezed
class GatePassRequest with _$GatePassRequest {
  const factory GatePassRequest({
    required String studentId,
    required String studentName,
    required String studentRollNumber,
    required String hostelId,
    required String reason,
    required DateTime departureTime,
    required DateTime expectedReturnTime,
    required String destination,
    required String contactNumber,
    String? emergencyContact,
    String? notes,
    required GatePassType type,
    required GatePassPriority priority,
    Map<String, dynamic>? metadata,
  }) = _GatePassRequest;

  factory GatePassRequest.fromJson(Map<String, dynamic> json) => _$GatePassRequestFromJson(json);
}

/// Gate Pass Model
@freezed
class GatePass with _$GatePass {
  const factory GatePass({
    required String id,
    required String studentId,
    required String studentName,
    required String studentRollNumber,
    required String hostelId,
    required String reason,
    required DateTime departureTime,
    required DateTime expectedReturnTime,
    required String destination,
    required String contactNumber,
    String? emergencyContact,
    String? notes,
    required GatePassType type,
    required GatePassPriority priority,
    required GatePassStatus status,
    required DateTime createdAt,
    required String createdBy,
    String? approvedBy,
    DateTime? approvedAt,
    String? rejectedBy,
    DateTime? rejectedAt,
    String? rejectionReason,
    DateTime? actualDepartureTime,
    DateTime? actualReturnTime,
    String? qrCode,
    String? qrNonce,
    DateTime? qrGeneratedAt,
    DateTime? qrExpiresAt,
    bool? adCompleted,
    DateTime? adCompletedAt,
    String? adId,
    Map<String, dynamic>? metadata,
  }) = _GatePass;

  factory GatePass.fromJson(Map<String, dynamic> json) => _$GatePassFromJson(json);
}

/// Gate Scan Event Model
@freezed
class GateScanEvent with _$GateScanEvent {
  const factory GateScanEvent({
    required String id,
    required String gatePassId,
    required String studentId,
    required String studentName,
    required GateScanType scanType,
    required DateTime scanTime,
    required String scannedBy,
    required String scannedByName,
    required String gateLocation,
    String? qrCode,
    String? qrNonce,
    bool? isEmergencyBypass,
    String? emergencyReason,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _GateScanEvent;

  factory GateScanEvent.fromJson(Map<String, dynamic> json) => _$GateScanEventFromJson(json);
}

/// Ad Integration Model
@freezed
class AdIntegration with _$AdIntegration {
  const factory AdIntegration({
    required String adId,
    required String adType,
    required int durationSeconds,
    required bool isCompleted,
    DateTime? startedAt,
    DateTime? completedAt,
    String? adProvider,
    Map<String, dynamic>? adData,
    bool? isEmergencyBypass,
    String? emergencyReason,
    DateTime? emergencyBypassAt,
    String? emergencyBypassBy,
  }) = _AdIntegration;

  factory AdIntegration.fromJson(Map<String, dynamic> json) => _$AdIntegrationFromJson(json);
}

/// QR Code Generation Request
@freezed
class QRGenerationRequest with _$QRGenerationRequest {
  const factory QRGenerationRequest({
    required String gatePassId,
    required String studentId,
    required bool requireAdCompletion,
    String? emergencyReason,
    String? emergencyBypassBy,
  }) = _QRGenerationRequest;

  factory QRGenerationRequest.fromJson(Map<String, dynamic> json) => _$QRGenerationRequestFromJson(json);
}

/// Gate Pass Approval Request
@freezed
class GatePassApprovalRequest with _$GatePassApprovalRequest {
  const factory GatePassApprovalRequest({
    required String gatePassId,
    required bool isApproved,
    String? reason,
    String? approvedBy,
    DateTime? approvedAt,
  }) = _GatePassApprovalRequest;

  factory GatePassApprovalRequest.fromJson(Map<String, dynamic> json) => _$GatePassApprovalRequestFromJson(json);
}

/// Gate Pass Statistics Model
@freezed
class GatePassStatistics with _$GatePassStatistics {
  const factory GatePassStatistics({
    required String period,
    required DateTime startDate,
    required DateTime endDate,
    required int totalRequests,
    required int approvedRequests,
    required int rejectedRequests,
    required int pendingRequests,
    required int activePasses,
    required int completedPasses,
    required int overduePasses,
    required double approvalRate,
    required double completionRate,
    required Map<String, int> requestsByType,
    required Map<String, int> requestsByPriority,
    required Map<String, int> requestsByStatus,
    required List<String> topReasons,
    required List<String> topDestinations,
    Map<String, dynamic>? trends,
  }) = _GatePassStatistics;

  factory GatePassStatistics.fromJson(Map<String, dynamic> json) => _$GatePassStatisticsFromJson(json);
}

/// Gate Pass History Model
@freezed
class GatePassHistory with _$GatePassHistory {
  const factory GatePassHistory({
    required String id,
    required String gatePassId,
    required String action,
    required String performedBy,
    required String performedByName,
    required DateTime timestamp,
    String? reason,
    Map<String, dynamic>? oldValues,
    Map<String, dynamic>? newValues,
    Map<String, dynamic>? metadata,
  }) = _GatePassHistory;

  factory GatePassHistory.fromJson(Map<String, dynamic> json) => _$GatePassHistoryFromJson(json);
}

/// Emergency Bypass Request
@freezed
class EmergencyBypassRequest with _$EmergencyBypassRequest {
  const factory EmergencyBypassRequest({
    required String gatePassId,
    required String reason,
    required String bypassedBy,
    required String bypassedByName,
    required DateTime bypassedAt,
    String? notes,
    Map<String, dynamic>? metadata,
  }) = _EmergencyBypassRequest;

  factory EmergencyBypassRequest.fromJson(Map<String, dynamic> json) => _$EmergencyBypassRequestFromJson(json);
}

/// Gate Pass Dashboard Data
@freezed
class GatePassDashboardData with _$GatePassDashboardData {
  const factory GatePassDashboardData({
    required int pendingApprovals,
    required int activePasses,
    required int overduePasses,
    required int todayDepartures,
    required int todayReturns,
    required int emergencyBypasses,
    required List<GatePass> recentRequests,
    required List<GateScanEvent> recentScans,
    required Map<String, dynamic> hourlyStats,
    required Map<String, dynamic> dailyStats,
  }) = _GatePassDashboardData;

  factory GatePassDashboardData.fromJson(Map<String, dynamic> json) => _$GatePassDashboardDataFromJson(json);
}

/// Enums

enum GatePassType {
  @JsonValue('emergency')
  emergency,
  @JsonValue('medical')
  medical,
  @JsonValue('academic')
  academic,
  @JsonValue('personal')
  personal,
  @JsonValue('family')
  family,
  @JsonValue('other')
  other,
}

enum GatePassPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum GatePassStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('overdue')
  overdue,
  @JsonValue('cancelled')
  cancelled,
}

enum GateScanType {
  @JsonValue('departure')
  departure,
  @JsonValue('return')
  return_,
  @JsonValue('emergency_departure')
  emergencyDeparture,
  @JsonValue('emergency_return')
  emergencyReturn,
}

enum AdType {
  @JsonValue('interstitial')
  interstitial,
  @JsonValue('banner')
  banner,
  @JsonValue('video')
  video,
  @JsonValue('rewarded')
  rewarded,
}

/// Extension methods for convenience
extension GatePassExtension on GatePass {
  bool get isPending => status == GatePassStatus.pending;
  bool get isApproved => status == GatePassStatus.approved;
  bool get isActive => status == GatePassStatus.active;
  bool get isCompleted => status == GatePassStatus.completed;
  bool get isOverdue => status == GatePassStatus.overdue;
  bool get isRejected => status == GatePassStatus.rejected;
  
  bool get hasQRCode => qrCode != null && qrCode!.isNotEmpty;
  bool get isQRExpired {
    if (qrExpiresAt == null) return false;
    return DateTime.now().isAfter(qrExpiresAt!);
  }
  
  bool get isAdRequired => adCompleted != true;
  bool get canGenerateQR => isApproved && !isQRExpired;
  
  Duration? get duration {
    if (actualDepartureTime != null && actualReturnTime != null) {
      return actualReturnTime!.difference(actualDepartureTime!);
    }
    return null;
  }
  
  bool get isOverdueNow {
    if (expectedReturnTime == null) return false;
    return DateTime.now().isAfter(expectedReturnTime) && !isCompleted;
  }
}

extension GateScanEventExtension on GateScanEvent {
  bool get isDeparture => scanType == GateScanType.departure || scanType == GateScanType.emergencyDeparture;
  bool get isReturn => scanType == GateScanType.return_ || scanType == GateScanType.emergencyReturn;
  bool get isEmergency => scanType == GateScanType.emergencyDeparture || scanType == GateScanType.emergencyReturn;
}

extension GatePassTypeExtension on GatePassType {
  String get displayName {
    switch (this) {
      case GatePassType.emergency:
        return 'Emergency';
      case GatePassType.medical:
        return 'Medical';
      case GatePassType.academic:
        return 'Academic';
      case GatePassType.personal:
        return 'Personal';
      case GatePassType.family:
        return 'Family';
      case GatePassType.other:
        return 'Other';
    }
  }
  
  String get description {
    switch (this) {
      case GatePassType.emergency:
        return 'Emergency situations requiring immediate departure';
      case GatePassType.medical:
        return 'Medical appointments or health-related visits';
      case GatePassType.academic:
        return 'Academic activities, exams, or educational visits';
      case GatePassType.personal:
        return 'Personal errands or individual activities';
      case GatePassType.family:
        return 'Family events or family-related visits';
      case GatePassType.other:
        return 'Other reasons not covered above';
    }
  }
}

extension GatePassPriorityExtension on GatePassPriority {
  String get displayName {
    switch (this) {
      case GatePassPriority.low:
        return 'Low';
      case GatePassPriority.medium:
        return 'Medium';
      case GatePassPriority.high:
        return 'High';
      case GatePassPriority.urgent:
        return 'Urgent';
    }
  }
  
  String get description {
    switch (this) {
      case GatePassPriority.low:
        return 'Can be processed during normal hours';
      case GatePassPriority.medium:
        return 'Should be processed within a few hours';
      case GatePassPriority.high:
        return 'Requires immediate attention';
      case GatePassPriority.urgent:
        return 'Critical - process immediately';
    }
  }
}

extension GatePassStatusExtension on GatePassStatus {
  String get displayName {
    switch (this) {
      case GatePassStatus.pending:
        return 'Pending';
      case GatePassStatus.approved:
        return 'Approved';
      case GatePassStatus.rejected:
        return 'Rejected';
      case GatePassStatus.active:
        return 'Active';
      case GatePassStatus.completed:
        return 'Completed';
      case GatePassStatus.overdue:
        return 'Overdue';
      case GatePassStatus.cancelled:
        return 'Cancelled';
    }
  }
  
  String get description {
    switch (this) {
      case GatePassStatus.pending:
        return 'Waiting for approval';
      case GatePassStatus.approved:
        return 'Approved and ready for use';
      case GatePassStatus.rejected:
        return 'Request has been rejected';
      case GatePassStatus.active:
        return 'Currently active and in use';
      case GatePassStatus.completed:
        return 'Successfully completed';
      case GatePassStatus.overdue:
        return 'Past expected return time';
      case GatePassStatus.cancelled:
        return 'Request has been cancelled';
    }
  }
}
