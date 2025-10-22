// lib/core/models/room_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_models.freezed.dart';
part 'room_models.g.dart';

enum RoomType {
  @JsonValue('SINGLE')
  single,
  @JsonValue('DOUBLE')
  double,
  @JsonValue('TRIPLE')
  triple,
  @JsonValue('QUAD')
  quad,
  @JsonValue('DORMITORY')
  dormitory,
}

enum BedType {
  @JsonValue('SINGLE')
  single,
  @JsonValue('BUNK_TOP')
  bunkTop,
  @JsonValue('BUNK_BOTTOM')
  bunkBottom,
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String roomNumber,
    required String blockId,
    required String floorId,
    required RoomType type,
    required int capacity,
    required int currentOccupancy,
    required bool isAvailable,
    required List<Bed> beds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
class Bed with _$Bed {
  const factory Bed({
    required String id,
    required String bedNumber,
    required String roomId,
    required BedType type,
    required bool isOccupied,
    String? studentId,
    DateTime? occupiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Bed;

  factory Bed.fromJson(Map<String, dynamic> json) => _$BedFromJson(json);
}

@freezed
class RoomMapData with _$RoomMapData {
  const factory RoomMapData({
    required String id,
    required String roomNumber,
    required String blockId,
    required String floorId,
    required RoomType type,
    required int capacity,
    required int currentOccupancy,
    required bool isAvailable,
    required List<Bed> beds,
  }) = _RoomMapData;

  factory RoomMapData.fromJson(Map<String, dynamic> json) => _$RoomMapDataFromJson(json);
}

@freezed
class Block with _$Block {
  const factory Block({
    required String id,
    required String name,
    required String hostelId,
    required int totalFloors,
    required int totalRooms,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Block;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
}

@freezed
class Floor with _$Floor {
  const factory Floor({
    required String id,
    required String name,
    required String blockId,
    required int floorNumber,
    required int totalRooms,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Floor;

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);
}