// lib/core/models/dashboard_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

enum DashboardTileType {
  attendance,
  gatePass,
  meals,
  complaints,
  occupancy,
  maintenance,
}

enum DrillDownType {
  byDate,
  byStudent,
  byRoom,
  byCategory,
}

@freezed
class DashboardTile with _$DashboardTile {
  const factory DashboardTile({
    required String id,
    required String title,
    required String description,
    required DashboardTileType type,
    required Map<String, dynamic> data,
    required DateTime lastUpdated,
    @Default(true) bool isActive,
  }) = _DashboardTile;

  factory DashboardTile.fromJson(Map<String, dynamic> json) => _$DashboardTileFromJson(json);
}

@freezed
class DrillDownRequest with _$DrillDownRequest {
  const factory DrillDownRequest({
    required String tileId,
    required DrillDownType type,
    required Map<String, dynamic> filters,
    required DateTime startDate,
    required DateTime endDate,
  }) = _DrillDownRequest;

  factory DrillDownRequest.fromJson(Map<String, dynamic> json) => _$DrillDownRequestFromJson(json);
}

@freezed
class DrillDownResult with _$DrillDownResult {
  const factory DrillDownResult({
    required String id,
    required String tileId,
    required DrillDownType type,
    required Map<String, dynamic> data,
    required DateTime generatedAt,
  }) = _DrillDownResult;

  factory DrillDownResult.fromJson(Map<String, dynamic> json) => _$DrillDownResultFromJson(json);
}