class PolicyTemplate {
  final String id;
  final String name;
  final String content;
  final String category;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  
  PolicyTemplate({
    required this.id,
    required this.name,
    required this.content,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });
  
  factory PolicyTemplate.fromJson(Map<String, dynamic> json) {
    return PolicyTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'content': content,
    'category': category,
    if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
  };
}
