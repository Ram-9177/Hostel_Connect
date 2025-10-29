// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['id'] as String,
      roomNumber: json['roomNumber'] as String,
      roomType: $enumDecode(_$RoomTypeEnumMap, json['roomType']),
      capacity: (json['capacity'] as num).toInt(),
      currentOccupancy: (json['currentOccupancy'] as num).toInt(),
      status: $enumDecode(_$RoomStatusEnumMap, json['status']),
      description: json['description'] as String?,
      hostelId: json['hostelId'] as String,
      occupants: (json['occupants'] as List<dynamic>)
          .map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'roomNumber': instance.roomNumber,
      'roomType': _$RoomTypeEnumMap[instance.roomType]!,
      'capacity': instance.capacity,
      'currentOccupancy': instance.currentOccupancy,
      'status': _$RoomStatusEnumMap[instance.status]!,
      'description': instance.description,
      'hostelId': instance.hostelId,
      'occupants': instance.occupants,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$RoomTypeEnumMap = {
  RoomType.single: 'SINGLE',
  RoomType.double: 'DOUBLE',
  RoomType.triple: 'TRIPLE',
  RoomType.quad: 'QUAD',
};

const _$RoomStatusEnumMap = {
  RoomStatus.available: 'AVAILABLE',
  RoomStatus.occupied: 'OCCUPIED',
  RoomStatus.maintenance: 'MAINTENANCE',
  RoomStatus.reserved: 'RESERVED',
};
