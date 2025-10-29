// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bed _$BedFromJson(Map<String, dynamic> json) => Bed(
      id: json['id'] as String,
      bedNumber: json['bedNumber'] as String,
      bedType: $enumDecode(_$BedTypeEnumMap, json['bedType']),
      status: $enumDecode(_$BedStatusEnumMap, json['status']),
      roomId: json['roomId'] as String,
      occupant: json['occupant'] == null
          ? null
          : Student.fromJson(json['occupant'] as Map<String, dynamic>),
      allocatedAt: json['allocatedAt'] == null
          ? null
          : DateTime.parse(json['allocatedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BedToJson(Bed instance) => <String, dynamic>{
      'id': instance.id,
      'bedNumber': instance.bedNumber,
      'bedType': _$BedTypeEnumMap[instance.bedType]!,
      'status': _$BedStatusEnumMap[instance.status]!,
      'roomId': instance.roomId,
      'occupant': instance.occupant,
      'allocatedAt': instance.allocatedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$BedTypeEnumMap = {
  BedType.single: 'SINGLE',
  BedType.bunkTop: 'BUNK_TOP',
  BedType.bunkBottom: 'BUNK_BOTTOM',
};

const _$BedStatusEnumMap = {
  BedStatus.available: 'AVAILABLE',
  BedStatus.occupied: 'OCCUPIED',
  BedStatus.maintenance: 'MAINTENANCE',
  BedStatus.reserved: 'RESERVED',
};
