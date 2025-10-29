// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_pass_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GatePassImpl _$$GatePassImplFromJson(Map<String, dynamic> json) =>
    _$GatePassImpl(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      reason: json['reason'] as String,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      departureTime: DateTime.parse(json['departureTime'] as String),
      expectedReturnTime: DateTime.parse(json['expectedReturnTime'] as String),
      actualReturnTime: json['actualReturnTime'] == null
          ? null
          : DateTime.parse(json['actualReturnTime'] as String),
      status: $enumDecodeNullable(_$GatePassStatusEnumMap, json['status']) ??
          GatePassStatus.pending,
      approvedBy: json['approvedBy'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      remarks: json['remarks'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      student: json['student'] == null
          ? null
          : Student.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GatePassImplToJson(_$GatePassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'reason': instance.reason,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'departureTime': instance.departureTime.toIso8601String(),
      'expectedReturnTime': instance.expectedReturnTime.toIso8601String(),
      'actualReturnTime': instance.actualReturnTime?.toIso8601String(),
      'status': _$GatePassStatusEnumMap[instance.status]!,
      'approvedBy': instance.approvedBy,
      'rejectedBy': instance.rejectedBy,
      'remarks': instance.remarks,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'student': instance.student,
    };

const _$GatePassStatusEnumMap = {
  GatePassStatus.pending: 'PENDING',
  GatePassStatus.approved: 'APPROVED',
  GatePassStatus.rejected: 'REJECTED',
  GatePassStatus.active: 'ACTIVE',
  GatePassStatus.completed: 'COMPLETED',
  GatePassStatus.overdue: 'OVERDUE',
  GatePassStatus.cancelled: 'CANCELLED',
};

_$GatePassRequestImpl _$$GatePassRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassRequestImpl(
      studentId: json['studentId'] as String,
      reason: json['reason'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      expectedReturnTime: DateTime.parse(json['expectedReturnTime'] as String),
    );

Map<String, dynamic> _$$GatePassRequestImplToJson(
        _$GatePassRequestImpl instance) =>
    <String, dynamic>{
      'studentId': instance.studentId,
      'reason': instance.reason,
      'departureTime': instance.departureTime.toIso8601String(),
      'expectedReturnTime': instance.expectedReturnTime.toIso8601String(),
    };

_$GatePassQRTokenPayloadImpl _$$GatePassQRTokenPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$GatePassQRTokenPayloadImpl(
      gatePassId: json['gatePassId'] as String,
      userId: json['userId'] as String,
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      nonce: json['nonce'] as String,
    );

Map<String, dynamic> _$$GatePassQRTokenPayloadImplToJson(
        _$GatePassQRTokenPayloadImpl instance) =>
    <String, dynamic>{
      'gatePassId': instance.gatePassId,
      'userId': instance.userId,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'nonce': instance.nonce,
    };

_$GateScanResultImpl _$$GateScanResultImplFromJson(Map<String, dynamic> json) =>
    _$GateScanResultImpl(
      ok: json['ok'] as bool,
      direction: $enumDecode(_$GatePassDirectionEnumMap, json['direction']),
      student: Student.fromJson(json['student'] as Map<String, dynamic>),
      gatePass: GatePass.fromJson(json['gatePass'] as Map<String, dynamic>),
      warnings: (json['warnings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$GateScanResultImplToJson(
        _$GateScanResultImpl instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'direction': _$GatePassDirectionEnumMap[instance.direction]!,
      'student': instance.student,
      'gatePass': instance.gatePass,
      'warnings': instance.warnings,
      'message': instance.message,
    };

const _$GatePassDirectionEnumMap = {
  GatePassDirection.out: 'OUT',
  GatePassDirection._in: 'IN',
};

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      rollNumber: json['rollNumber'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      roomId: json['roomId'] as String?,
      bedId: json['bedId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rollNumber': instance.rollNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'roomId': instance.roomId,
      'bedId': instance.bedId,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
