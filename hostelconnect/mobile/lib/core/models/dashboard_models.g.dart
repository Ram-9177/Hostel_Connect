// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardTileImpl _$$DashboardTileImplFromJson(Map<String, dynamic> json) =>
    _$DashboardTileImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$DashboardTileTypeEnumMap, json['type']),
      data: json['data'] as Map<String, dynamic>,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$DashboardTileImplToJson(_$DashboardTileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$DashboardTileTypeEnumMap[instance.type]!,
      'data': instance.data,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'isActive': instance.isActive,
    };

const _$DashboardTileTypeEnumMap = {
  DashboardTileType.attendance: 'attendance',
  DashboardTileType.gatePass: 'gatePass',
  DashboardTileType.meals: 'meals',
  DashboardTileType.complaints: 'complaints',
  DashboardTileType.occupancy: 'occupancy',
  DashboardTileType.maintenance: 'maintenance',
};

_$DrillDownRequestImpl _$$DrillDownRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$DrillDownRequestImpl(
      tileId: json['tileId'] as String,
      type: $enumDecode(_$DrillDownTypeEnumMap, json['type']),
      filters: json['filters'] as Map<String, dynamic>,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$DrillDownRequestImplToJson(
        _$DrillDownRequestImpl instance) =>
    <String, dynamic>{
      'tileId': instance.tileId,
      'type': _$DrillDownTypeEnumMap[instance.type]!,
      'filters': instance.filters,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

const _$DrillDownTypeEnumMap = {
  DrillDownType.byDate: 'byDate',
  DrillDownType.byStudent: 'byStudent',
  DrillDownType.byRoom: 'byRoom',
  DrillDownType.byCategory: 'byCategory',
};

_$DrillDownResultImpl _$$DrillDownResultImplFromJson(
        Map<String, dynamic> json) =>
    _$DrillDownResultImpl(
      id: json['id'] as String,
      tileId: json['tileId'] as String,
      type: $enumDecode(_$DrillDownTypeEnumMap, json['type']),
      data: json['data'] as Map<String, dynamic>,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$DrillDownResultImplToJson(
        _$DrillDownResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tileId': instance.tileId,
      'type': _$DrillDownTypeEnumMap[instance.type]!,
      'data': instance.data,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

_$LiveDashboardTileImpl _$$LiveDashboardTileImplFromJson(
        Map<String, dynamic> json) =>
    _$LiveDashboardTileImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      value: json['value'] as String,
      subtitle: json['subtitle'] as String?,
      icon: json['icon'] as String,
      trend: json['trend'] as String,
      trendValue: (json['trendValue'] as num?)?.toDouble(),
      isAlert: json['isAlert'] as bool? ?? false,
    );

Map<String, dynamic> _$$LiveDashboardTileImplToJson(
        _$LiveDashboardTileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
      'subtitle': instance.subtitle,
      'icon': instance.icon,
      'trend': instance.trend,
      'trendValue': instance.trendValue,
      'isAlert': instance.isAlert,
    };

_$MonthlyAnalyticsImpl _$$MonthlyAnalyticsImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyAnalyticsImpl(
      hostelId: json['hostelId'] as String,
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      attendance: json['attendance'] as Map<String, dynamic>,
      gatePasses: json['gatePasses'] as Map<String, dynamic>,
      meals: json['meals'] as Map<String, dynamic>,
      occupancy: json['occupancy'] as Map<String, dynamic>,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$$MonthlyAnalyticsImplToJson(
        _$MonthlyAnalyticsImpl instance) =>
    <String, dynamic>{
      'hostelId': instance.hostelId,
      'month': instance.month,
      'year': instance.year,
      'attendance': instance.attendance,
      'gatePasses': instance.gatePasses,
      'meals': instance.meals,
      'occupancy': instance.occupancy,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };
