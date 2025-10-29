// lib/core/models/policy_summary.dart

/// Model for policy summary overview
class PolicySummary {
  final String id;
  final String name;
  final String category;
  final String status; // 'ACTIVE', 'INACTIVE', 'DRAFT'
  final int totalRules;
  final int activeRules;
  final DateTime createdAt;
  final DateTime? lastModified;
  final String createdBy;
  final int affectedStudents;
  final double complianceRate;

  const PolicySummary({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.totalRules,
    required this.activeRules,
    required this.createdAt,
    this.lastModified,
    required this.createdBy,
    required this.affectedStudents,
    required this.complianceRate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'status': status,
    'totalRules': totalRules,
    'activeRules': activeRules,
    'createdAt': createdAt.toIso8601String(),
    if (lastModified != null) 'lastModified': lastModified!.toIso8601String(),
    'createdBy': createdBy,
    'affectedStudents': affectedStudents,
    'complianceRate': complianceRate,
  };

  factory PolicySummary.fromJson(Map<String, dynamic> json) {
    return PolicySummary(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      totalRules: json['totalRules'] as int,
      activeRules: json['activeRules'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'] as String)
          : null,
      createdBy: json['createdBy'] as String,
      affectedStudents: json['affectedStudents'] as int,
      complianceRate: (json['complianceRate'] as num).toDouble(),
    );
  }

  PolicySummary copyWith({
    String? id,
    String? name,
    String? category,
    String? status,
    int? totalRules,
    int? activeRules,
    DateTime? createdAt,
    DateTime? lastModified,
    String? createdBy,
    int? affectedStudents,
    double? complianceRate,
  }) {
    return PolicySummary(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      status: status ?? this.status,
      totalRules: totalRules ?? this.totalRules,
      activeRules: activeRules ?? this.activeRules,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      createdBy: createdBy ?? this.createdBy,
      affectedStudents: affectedStudents ?? this.affectedStudents,
      complianceRate: complianceRate ?? this.complianceRate,
    );
  }
}

enum PolicyStatus {
  active,
  inactive,
  draft,
}
