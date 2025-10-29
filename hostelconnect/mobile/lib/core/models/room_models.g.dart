// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String,
      roomNumber: json['roomNumber'] as String,
      blockId: json['blockId'] as String,
      floorId: json['floorId'] as String,
      type: $enumDecode(_$RoomTypeEnumMap, json['type']),
      capacity: (json['capacity'] as num).toInt(),
      currentOccupancy: (json['currentOccupancy'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
      beds: (json['beds'] as List<dynamic>)
          .map((e) => Bed.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomNumber': instance.roomNumber,
      'blockId': instance.blockId,
      'floorId': instance.floorId,
      'type': _$RoomTypeEnumMap[instance.type]!,
      'capacity': instance.capacity,
      'currentOccupancy': instance.currentOccupancy,
      'isAvailable': instance.isAvailable,
      'beds': instance.beds,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$RoomTypeEnumMap = {
  RoomType.single: 'SINGLE',
  RoomType.double: 'DOUBLE',
  RoomType.triple: 'TRIPLE',
  RoomType.quad: 'QUAD',
  RoomType.dormitory: 'DORMITORY',
};

_$BedImpl _$$BedImplFromJson(Map<String, dynamic> json) => _$BedImpl(
      id: json['id'] as String,
      bedNumber: json['bedNumber'] as String,
      roomId: json['roomId'] as String,
      type: $enumDecode(_$BedTypeEnumMap, json['type']),
      isOccupied: json['isOccupied'] as bool,
      studentId: json['studentId'] as String?,
      occupiedAt: json['occupiedAt'] == null
          ? null
          : DateTime.parse(json['occupiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BedImplToJson(_$BedImpl instance) => <String, dynamic>{
      'id': instance.id,
      'bedNumber': instance.bedNumber,
      'roomId': instance.roomId,
      'type': _$BedTypeEnumMap[instance.type]!,
      'isOccupied': instance.isOccupied,
      'studentId': instance.studentId,
      'occupiedAt': instance.occupiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$BedTypeEnumMap = {
  BedType.single: 'SINGLE',
  BedType.bunkTop: 'BUNK_TOP',
  BedType.bunkBottom: 'BUNK_BOTTOM',
};

_$RoomMapDataImpl _$$RoomMapDataImplFromJson(Map<String, dynamic> json) =>
    _$RoomMapDataImpl(
      id: json['id'] as String,
      roomNumber: json['roomNumber'] as String,
      blockId: json['blockId'] as String,
      floorId: json['floorId'] as String,
      type: $enumDecode(_$RoomTypeEnumMap, json['type']),
      capacity: (json['capacity'] as num).toInt(),
      currentOccupancy: (json['currentOccupancy'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool,
      beds: (json['beds'] as List<dynamic>)
          .map((e) => Bed.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomMapDataImplToJson(_$RoomMapDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomNumber': instance.roomNumber,
      'blockId': instance.blockId,
      'floorId': instance.floorId,
      'type': _$RoomTypeEnumMap[instance.type]!,
      'capacity': instance.capacity,
      'currentOccupancy': instance.currentOccupancy,
      'isAvailable': instance.isAvailable,
      'beds': instance.beds,
    };

_$BlockImpl _$$BlockImplFromJson(Map<String, dynamic> json) => _$BlockImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      hostelId: json['hostelId'] as String,
      totalFloors: (json['totalFloors'] as num).toInt(),
      totalRooms: (json['totalRooms'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$BlockImplToJson(_$BlockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hostelId': instance.hostelId,
      'totalFloors': instance.totalFloors,
      'totalRooms': instance.totalRooms,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$FloorImpl _$$FloorImplFromJson(Map<String, dynamic> json) => _$FloorImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      blockId: json['blockId'] as String,
      floorNumber: (json['floorNumber'] as num).toInt(),
      totalRooms: (json['totalRooms'] as num).toInt(),
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$FloorImplToJson(_$FloorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'blockId': instance.blockId,
      'floorNumber': instance.floorNumber,
      'totalRooms': instance.totalRooms,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
