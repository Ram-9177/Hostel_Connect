// lib/core/models/room_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_models.freezed.dart';
part 'room_models.g.dart';

enum RoomType {
  single,
  double,
  triple,
  quad,
}

enum BedType {
  single,
  bunk,
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String roomNumber,
    required String blockName,
    required RoomType roomType,
    required int totalBeds,
    required int occupiedBeds,
    @Default([]) List<Bed> beds,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
class Bed with _$Bed {
  const factory Bed({
    required String id,
    required String roomId,
    required String bedNumber,
    required BedType bedType,
    String? studentId,
    @Default(true) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Bed;

  factory Bed.fromJson(Map<String, dynamic> json) => _$BedFromJson(json);
}

@freezed
class RoomMapData with _$RoomMapData {
  const factory RoomMapData({
    required String roomId,
    required String roomNumber,
    required String blockName,
    required int totalBeds,
    required int occupiedBeds,
    required double occupancyRate,
  }) = _RoomMapData;

  factory RoomMapData.fromJson(Map<String, dynamic> json) => _$RoomMapDataFromJson(json);
}