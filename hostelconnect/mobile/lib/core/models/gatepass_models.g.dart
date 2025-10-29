// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gatepass_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GatePassRequestImpl _$$GatePassRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassRequestImpl(
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      studentRollNumber: json['studentRollNumber'] as String,
      hostelId: json['hostelId'] as String,
      reason: json['reason'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      expectedReturnTime: DateTime.parse(json['expectedReturnTime'] as String),
      destination: json['destination'] as String,
      contactNumber: json['contactNumber'] as String,
      emergencyContact: json['emergencyContact'] as String?,
      notes: json['notes'] as String?,
      type: $enumDecode(_$GatePassTypeEnumMap, json['type']),
      priority: $enumDecode(_$GatePassPriorityEnumMap, json['priority']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GatePassRequestImplToJson(
        _$GatePassRequestImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'studentRollNumber': instance.studentRollNumber,
      'hostelId': instance.hostelId,
      'reason': instance.reason,
      'departureTime': instance.departureTime.toIso8601String(),
      'expectedReturnTime': instance.expectedReturnTime.toIso8601String(),
      'destination': instance.destination,
      'contactNumber': instance.contactNumber,
      'emergencyContact': instance.emergencyContact,
      'notes': instance.notes,
      'type': _$GatePassTypeEnumMap[instance.type]!,
      'priority': _$GatePassPriorityEnumMap[instance.priority]!,
      'metadata': instance.metadata,
    };

const _$GatePassTypeEnumMap = {
  GatePassType.emergency: 'emergency',
  GatePassType.medical: 'medical',
  GatePassType.academic: 'academic',
  GatePassType.personal: 'personal',
  GatePassType.family: 'family',
  GatePassType.other: 'other',
};

const _$GatePassPriorityEnumMap = {
  GatePassPriority.low: 'low',
  GatePassPriority.medium: 'medium',
  GatePassPriority.high: 'high',
  GatePassPriority.urgent: 'urgent',
};

_$GatePassImpl _$$GatePassImplFromJson(Map<String, dynamic> json) =>
    _$GatePassImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      studentRollNumber: json['studentRollNumber'] as String,
      hostelId: json['hostelId'] as String,
      reason: json['reason'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      expectedReturnTime: DateTime.parse(json['expectedReturnTime'] as String),
      destination: json['destination'] as String,
      contactNumber: json['contactNumber'] as String,
      emergencyContact: json['emergencyContact'] as String?,
      notes: json['notes'] as String?,
      type: $enumDecode(_$GatePassTypeEnumMap, json['type']),
      priority: $enumDecode(_$GatePassPriorityEnumMap, json['priority']),
      status: $enumDecode(_$GatePassStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectedBy: json['rejectedBy'] as String?,
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      actualDepartureTime: json['actualDepartureTime'] == null
          ? null
          : DateTime.parse(json['actualDepartureTime'] as String),
      actualReturnTime: json['actualReturnTime'] == null
          ? null
          : DateTime.parse(json['actualReturnTime'] as String),
      qrCode: json['qrCode'] as String?,
      qrNonce: json['qrNonce'] as String?,
      qrGeneratedAt: json['qrGeneratedAt'] == null
          ? null
          : DateTime.parse(json['qrGeneratedAt'] as String),
      qrExpiresAt: json['qrExpiresAt'] == null
          ? null
          : DateTime.parse(json['qrExpiresAt'] as String),
      adCompleted: json['adCompleted'] as bool?,
      adCompletedAt: json['adCompletedAt'] == null
          ? null
          : DateTime.parse(json['adCompletedAt'] as String),
      adId: json['adId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GatePassImplToJson(_$GatePassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'studentRollNumber': instance.studentRollNumber,
      'hostelId': instance.hostelId,
      'reason': instance.reason,
      'departureTime': instance.departureTime.toIso8601String(),
      'expectedReturnTime': instance.expectedReturnTime.toIso8601String(),
      'destination': instance.destination,
      'contactNumber': instance.contactNumber,
      'emergencyContact': instance.emergencyContact,
      'notes': instance.notes,
      'type': _$GatePassTypeEnumMap[instance.type]!,
      'priority': _$GatePassPriorityEnumMap[instance.priority]!,
      'status': _$GatePassStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectedBy': instance.rejectedBy,
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'actualDepartureTime': instance.actualDepartureTime?.toIso8601String(),
      'actualReturnTime': instance.actualReturnTime?.toIso8601String(),
      'qrCode': instance.qrCode,
      'qrNonce': instance.qrNonce,
      'qrGeneratedAt': instance.qrGeneratedAt?.toIso8601String(),
      'qrExpiresAt': instance.qrExpiresAt?.toIso8601String(),
      'adCompleted': instance.adCompleted,
      'adCompletedAt': instance.adCompletedAt?.toIso8601String(),
      'adId': instance.adId,
      'metadata': instance.metadata,
    };

const _$GatePassStatusEnumMap = {
  GatePassStatus.pending: 'pending',
  GatePassStatus.approved: 'approved',
  GatePassStatus.rejected: 'rejected',
  GatePassStatus.active: 'active',
  GatePassStatus.completed: 'completed',
  GatePassStatus.overdue: 'overdue',
  GatePassStatus.cancelled: 'cancelled',
};

_$GateScanEventImpl _$$GateScanEventImplFromJson(Map<String, dynamic> json) =>
    _$GateScanEventImpl(
      id: json['id'] as String,
      gatePassId: json['gatePassId'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      scanType: $enumDecode(_$GateScanTypeEnumMap, json['scanType']),
      scanTime: DateTime.parse(json['scanTime'] as String),
      scannedBy: json['scannedBy'] as String,
      scannedByName: json['scannedByName'] as String,
      gateLocation: json['gateLocation'] as String,
      qrCode: json['qrCode'] as String?,
      qrNonce: json['qrNonce'] as String?,
      isEmergencyBypass: json['isEmergencyBypass'] as bool?,
      emergencyReason: json['emergencyReason'] as String?,
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GateScanEventImplToJson(_$GateScanEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gatePassId': instance.gatePassId,
      'studentId': instance.studentId,
      'studentName': instance.studentName,
      'scanType': _$GateScanTypeEnumMap[instance.scanType]!,
      'scanTime': instance.scanTime.toIso8601String(),
      'scannedBy': instance.scannedBy,
      'scannedByName': instance.scannedByName,
      'gateLocation': instance.gateLocation,
      'qrCode': instance.qrCode,
      'qrNonce': instance.qrNonce,
      'isEmergencyBypass': instance.isEmergencyBypass,
      'emergencyReason': instance.emergencyReason,
      'notes': instance.notes,
      'metadata': instance.metadata,
    };

const _$GateScanTypeEnumMap = {
  GateScanType.departure: 'departure',
  GateScanType.return_: 'return',
  GateScanType.emergencyDeparture: 'emergency_departure',
  GateScanType.emergencyReturn: 'emergency_return',
};

_$AdIntegrationImpl _$$AdIntegrationImplFromJson(Map<String, dynamic> json) =>
    _$AdIntegrationImpl(
      adId: json['adId'] as String,
      adType: json['adType'] as String,
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      adProvider: json['adProvider'] as String?,
      adData: json['adData'] as Map<String, dynamic>?,
      isEmergencyBypass: json['isEmergencyBypass'] as bool?,
      emergencyReason: json['emergencyReason'] as String?,
      emergencyBypassAt: json['emergencyBypassAt'] == null
          ? null
          : DateTime.parse(json['emergencyBypassAt'] as String),
      emergencyBypassBy: json['emergencyBypassBy'] as String?,
    );

Map<String, dynamic> _$$AdIntegrationImplToJson(_$AdIntegrationImpl instance) =>
    <String, dynamic>{
      'adId': instance.adId,
      'adType': instance.adType,
      'durationSeconds': instance.durationSeconds,
      'isCompleted': instance.isCompleted,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'adProvider': instance.adProvider,
      'adData': instance.adData,
      'isEmergencyBypass': instance.isEmergencyBypass,
      'emergencyReason': instance.emergencyReason,
      'emergencyBypassAt': instance.emergencyBypassAt?.toIso8601String(),
      'emergencyBypassBy': instance.emergencyBypassBy,
    };

_$QRGenerationRequestImpl _$$QRGenerationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$QRGenerationRequestImpl(
      gatePassId: json['gatePassId'] as String,
      studentId: json['studentId'] as String,
      requireAdCompletion: json['requireAdCompletion'] as bool,
      emergencyReason: json['emergencyReason'] as String?,
      emergencyBypassBy: json['emergencyBypassBy'] as String?,
    );

Map<String, dynamic> _$$QRGenerationRequestImplToJson(
        _$QRGenerationRequestImpl instance) =>
    <String, dynamic>{
      'gatePassId': instance.gatePassId,
      'studentId': instance.studentId,
      'requireAdCompletion': instance.requireAdCompletion,
      'emergencyReason': instance.emergencyReason,
      'emergencyBypassBy': instance.emergencyBypassBy,
    };

_$GatePassApprovalRequestImpl _$$GatePassApprovalRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassApprovalRequestImpl(
      gatePassId: json['gatePassId'] as String,
      isApproved: json['isApproved'] as bool,
      reason: json['reason'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
    );

Map<String, dynamic> _$$GatePassApprovalRequestImplToJson(
        _$GatePassApprovalRequestImpl instance) =>
    <String, dynamic>{
      'gatePassId': instance.gatePassId,
      'isApproved': instance.isApproved,
      'reason': instance.reason,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
    };

_$GatePassStatisticsImpl _$$GatePassStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassStatisticsImpl(
      period: json['period'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalRequests: (json['totalRequests'] as num).toInt(),
      approvedRequests: (json['approvedRequests'] as num).toInt(),
      rejectedRequests: (json['rejectedRequests'] as num).toInt(),
      pendingRequests: (json['pendingRequests'] as num).toInt(),
      activePasses: (json['activePasses'] as num).toInt(),
      completedPasses: (json['completedPasses'] as num).toInt(),
      overduePasses: (json['overduePasses'] as num).toInt(),
      approvalRate: (json['approvalRate'] as num).toDouble(),
      completionRate: (json['completionRate'] as num).toDouble(),
      requestsByType: Map<String, int>.from(json['requestsByType'] as Map),
      requestsByPriority:
          Map<String, int>.from(json['requestsByPriority'] as Map),
      requestsByStatus: Map<String, int>.from(json['requestsByStatus'] as Map),
      topReasons: (json['topReasons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      topDestinations: (json['topDestinations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      trends: json['trends'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GatePassStatisticsImplToJson(
        _$GatePassStatisticsImpl instance) =>
    <String, dynamic>{
      'period': instance.period,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'totalRequests': instance.totalRequests,
      'approvedRequests': instance.approvedRequests,
      'rejectedRequests': instance.rejectedRequests,
      'pendingRequests': instance.pendingRequests,
      'activePasses': instance.activePasses,
      'completedPasses': instance.completedPasses,
      'overduePasses': instance.overduePasses,
      'approvalRate': instance.approvalRate,
      'completionRate': instance.completionRate,
      'requestsByType': instance.requestsByType,
      'requestsByPriority': instance.requestsByPriority,
      'requestsByStatus': instance.requestsByStatus,
      'topReasons': instance.topReasons,
      'topDestinations': instance.topDestinations,
      'trends': instance.trends,
    };

_$GatePassHistoryImpl _$$GatePassHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassHistoryImpl(
      id: json['id'] as String,
      gatePassId: json['gatePassId'] as String,
      action: json['action'] as String,
      performedBy: json['performedBy'] as String,
      performedByName: json['performedByName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      reason: json['reason'] as String?,
      oldValues: json['oldValues'] as Map<String, dynamic>?,
      newValues: json['newValues'] as Map<String, dynamic>?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GatePassHistoryImplToJson(
        _$GatePassHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gatePassId': instance.gatePassId,
      'action': instance.action,
      'performedBy': instance.performedBy,
      'performedByName': instance.performedByName,
      'timestamp': instance.timestamp.toIso8601String(),
      'reason': instance.reason,
      'oldValues': instance.oldValues,
      'newValues': instance.newValues,
      'metadata': instance.metadata,
    };

_$EmergencyBypassRequestImpl _$$EmergencyBypassRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$EmergencyBypassRequestImpl(
      gatePassId: json['gatePassId'] as String,
      reason: json['reason'] as String,
      bypassedBy: json['bypassedBy'] as String,
      bypassedByName: json['bypassedByName'] as String,
      bypassedAt: DateTime.parse(json['bypassedAt'] as String),
      notes: json['notes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EmergencyBypassRequestImplToJson(
        _$EmergencyBypassRequestImpl instance) =>
    <String, dynamic>{
      'gatePassId': instance.gatePassId,
      'reason': instance.reason,
      'bypassedBy': instance.bypassedBy,
      'bypassedByName': instance.bypassedByName,
      'bypassedAt': instance.bypassedAt.toIso8601String(),
      'notes': instance.notes,
      'metadata': instance.metadata,
    };

_$GatePassDashboardDataImpl _$$GatePassDashboardDataImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassDashboardDataImpl(
      pendingApprovals: (json['pendingApprovals'] as num).toInt(),
      activePasses: (json['activePasses'] as num).toInt(),
      overduePasses: (json['overduePasses'] as num).toInt(),
      todayDepartures: (json['todayDepartures'] as num).toInt(),
      todayReturns: (json['todayReturns'] as num).toInt(),
      emergencyBypasses: (json['emergencyBypasses'] as num).toInt(),
      recentRequests: (json['recentRequests'] as List<dynamic>)
          .map((e) => GatePass.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentScans: (json['recentScans'] as List<dynamic>)
          .map((e) => GateScanEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      hourlyStats: json['hourlyStats'] as Map<String, dynamic>,
      dailyStats: json['dailyStats'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$GatePassDashboardDataImplToJson(
        _$GatePassDashboardDataImpl instance) =>
    <String, dynamic>{
      'pendingApprovals': instance.pendingApprovals,
      'activePasses': instance.activePasses,
      'overduePasses': instance.overduePasses,
      'todayDepartures': instance.todayDepartures,
      'todayReturns': instance.todayReturns,
      'emergencyBypasses': instance.emergencyBypasses,
      'recentRequests': instance.recentRequests,
      'recentScans': instance.recentScans,
      'hourlyStats': instance.hourlyStats,
      'dailyStats': instance.dailyStats,
    };
