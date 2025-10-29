// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'policy_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HostelPolicyImpl _$$HostelPolicyImplFromJson(Map<String, dynamic> json) =>
    _$HostelPolicyImpl(
      id: json['id'] as String,
      hostelId: json['hostelId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$PolicyTypeEnumMap, json['type']),
      rules: json['rules'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$HostelPolicyImplToJson(_$HostelPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostelId': instance.hostelId,
      'name': instance.name,
      'description': instance.description,
      'type': _$PolicyTypeEnumMap[instance.type]!,
      'rules': instance.rules,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PolicyTypeEnumMap = {
  PolicyType.curfew: 'CURFEW',
  PolicyType.attendance: 'ATTENDANCE',
  PolicyType.meal: 'MEAL',
  PolicyType.room: 'ROOM',
  PolicyType.general: 'GENERAL',
};

_$CurfewPolicyImpl _$$CurfewPolicyImplFromJson(Map<String, dynamic> json) =>
    _$CurfewPolicyImpl(
      id: json['id'] as String,
      hostelId: json['hostelId'] as String,
      curfewTime:
          TimeOfDay.fromJson(json['curfewTime'] as Map<String, dynamic>),
      wakeUpTime:
          TimeOfDay.fromJson(json['wakeUpTime'] as Map<String, dynamic>),
      allowedDays: (json['allowedDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isStrict: json['isStrict'] as bool,
      violationAction: json['violationAction'] as String,
    );

Map<String, dynamic> _$$CurfewPolicyImplToJson(_$CurfewPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostelId': instance.hostelId,
      'curfewTime': instance.curfewTime,
      'wakeUpTime': instance.wakeUpTime,
      'allowedDays': instance.allowedDays,
      'isStrict': instance.isStrict,
      'violationAction': instance.violationAction,
    };

_$AttendancePolicyImpl _$$AttendancePolicyImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendancePolicyImpl(
      id: json['id'] as String,
      hostelId: json['hostelId'] as String,
      minimumAttendance: (json['minimumAttendance'] as num).toDouble(),
      exemptedDays: (json['exemptedDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      violationAction: json['violationAction'] as String,
      allowLateEntry: json['allowLateEntry'] as bool,
      lateEntryGracePeriod:
          Duration(microseconds: (json['lateEntryGracePeriod'] as num).toInt()),
    );

Map<String, dynamic> _$$AttendancePolicyImplToJson(
        _$AttendancePolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostelId': instance.hostelId,
      'minimumAttendance': instance.minimumAttendance,
      'exemptedDays': instance.exemptedDays,
      'violationAction': instance.violationAction,
      'allowLateEntry': instance.allowLateEntry,
      'lateEntryGracePeriod': instance.lateEntryGracePeriod.inMicroseconds,
    };

_$MealPolicyImpl _$$MealPolicyImplFromJson(Map<String, dynamic> json) =>
    _$MealPolicyImpl(
      id: json['id'] as String,
      hostelId: json['hostelId'] as String,
      breakfastTime:
          TimeOfDay.fromJson(json['breakfastTime'] as Map<String, dynamic>),
      lunchTime: TimeOfDay.fromJson(json['lunchTime'] as Map<String, dynamic>),
      dinnerTime:
          TimeOfDay.fromJson(json['dinnerTime'] as Map<String, dynamic>),
      mealWindow: Duration(microseconds: (json['mealWindow'] as num).toInt()),
      allowOptOut: json['allowOptOut'] as bool,
      optOutDeadline: json['optOutDeadline'] as String,
    );

Map<String, dynamic> _$$MealPolicyImplToJson(_$MealPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostelId': instance.hostelId,
      'breakfastTime': instance.breakfastTime,
      'lunchTime': instance.lunchTime,
      'dinnerTime': instance.dinnerTime,
      'mealWindow': instance.mealWindow.inMicroseconds,
      'allowOptOut': instance.allowOptOut,
      'optOutDeadline': instance.optOutDeadline,
    };

_$RoomPolicyImpl _$$RoomPolicyImplFromJson(Map<String, dynamic> json) =>
    _$RoomPolicyImpl(
      id: json['id'] as String,
      hostelId: json['hostelId'] as String,
      allowGuests: json['allowGuests'] as bool,
      maxGuests: (json['maxGuests'] as num).toInt(),
      guestStayLimit:
          Duration(microseconds: (json['guestStayLimit'] as num).toInt()),
      allowRoomChange: json['allowRoomChange'] as bool,
      roomChangeProcess: json['roomChangeProcess'] as String,
    );

Map<String, dynamic> _$$RoomPolicyImplToJson(_$RoomPolicyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostelId': instance.hostelId,
      'allowGuests': instance.allowGuests,
      'maxGuests': instance.maxGuests,
      'guestStayLimit': instance.guestStayLimit.inMicroseconds,
      'allowRoomChange': instance.allowRoomChange,
      'roomChangeProcess': instance.roomChangeProcess,
    };
