// lib/core/models/dashboard_drill_down.dart

/// Model for dashboard drill-down data
class DashboardDrillDown {
  final String category;
  final String subcategory;
  final Map<String, dynamic> filters;
  final List<DashboardDrillDownItem> items;
  final int totalCount;
  final Map<String, dynamic>? aggregations;

  const DashboardDrillDown({
    required this.category,
    required this.subcategory,
    required this.filters,
    required this.items,
    required this.totalCount,
    this.aggregations,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'category': category,
    'subcategory': subcategory,
    'filters': filters,
    'items': items.map((item) => item.toJson()).toList(),
    'totalCount': totalCount,
    if (aggregations != null) 'aggregations': aggregations,
  };

  /// Create from JSON
  factory DashboardDrillDown.fromJson(Map<String, dynamic> json) {
    return DashboardDrillDown(
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      filters: json['filters'] as Map<String, dynamic>,
      items: (json['items'] as List<dynamic>)
          .map((item) => DashboardDrillDownItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      aggregations: json['aggregations'] as Map<String, dynamic>?,
    );
  }
}

/// Individual drill-down item
class DashboardDrillDownItem {
  final String id;
  final String name;
  final Map<String, dynamic> data;
  final String? status;
  final DateTime? timestamp;

  const DashboardDrillDownItem({
    required this.id,
    required this.name,
    required this.data,
    this.status,
    this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'data': data,
    if (status != null) 'status': status,
    if (timestamp != null) 'timestamp': timestamp!.toIso8601String(),
  };

  factory DashboardDrillDownItem.fromJson(Map<String, dynamic> json) {
    return DashboardDrillDownItem(
      id: json['id'] as String,
      name: json['name'] as String,
      data: json['data'] as Map<String, dynamic>,
      status: json['status'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
    );
  }
}
