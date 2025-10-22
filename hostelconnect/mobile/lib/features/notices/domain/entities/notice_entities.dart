// lib/features/notices/domain/entities/notice_entities.dart
class Notice {
  final String id;
  final String title;
  final String content;
  final String type;
  final NoticeTarget target;
  final String? hostelId;
  final String? wingId;
  final String? roomId;
  final String? role;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final bool isActive;
  final int priority;

  const Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.target,
    this.hostelId,
    this.wingId,
    this.roomId,
    this.role,
    required this.createdBy,
    required this.createdAt,
    this.expiresAt,
    required this.isActive,
    required this.priority,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      type: json['type'],
      target: NoticeTarget.fromString(json['target']),
      hostelId: json['hostelId'],
      wingId: json['wingId'],
      roomId: json['roomId'],
      role: json['role'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      isActive: json['isActive'] ?? true,
      priority: json['priority'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'target': target.toString(),
      'hostelId': hostelId,
      'wingId': wingId,
      'roomId': roomId,
      'role': role,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isActive': isActive,
      'priority': priority,
    };
  }

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
  bool get isUrgent => priority >= 3;
}

class NoticeRead {
  final String id;
  final String noticeId;
  final String userId;
  final DateTime readAt;
  final String? deviceId;

  const NoticeRead({
    required this.id,
    required this.noticeId,
    required this.userId,
    required this.readAt,
    this.deviceId,
  });

  factory NoticeRead.fromJson(Map<String, dynamic> json) {
    return NoticeRead(
      id: json['id'],
      noticeId: json['noticeId'],
      userId: json['userId'],
      readAt: DateTime.parse(json['readAt']),
      deviceId: json['deviceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'noticeId': noticeId,
      'userId': userId,
      'readAt': readAt.toIso8601String(),
      'deviceId': deviceId,
    };
  }
}

class DeviceToken {
  final String id;
  final String userId;
  final String token;
  final String platform;
  final String? deviceId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeviceToken({
    required this.id,
    required this.userId,
    required this.token,
    required this.platform,
    this.deviceId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceToken.fromJson(Map<String, dynamic> json) {
    return DeviceToken(
      id: json['id'],
      userId: json['userId'],
      token: json['token'],
      platform: json['platform'],
      deviceId: json['deviceId'],
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'token': token,
      'platform': platform,
      'deviceId': deviceId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

enum NoticeTarget {
  all,
  hostel,
  wing,
  room,
  role;

  static NoticeTarget fromString(String target) {
    switch (target.toLowerCase()) {
      case 'all':
        return NoticeTarget.all;
      case 'hostel':
        return NoticeTarget.hostel;
      case 'wing':
        return NoticeTarget.wing;
      case 'room':
        return NoticeTarget.room;
      case 'role':
        return NoticeTarget.role;
      default:
        return NoticeTarget.all;
    }
  }

  @override
  String toString() {
    switch (this) {
      case NoticeTarget.all:
        return 'all';
      case NoticeTarget.hostel:
        return 'hostel';
      case NoticeTarget.wing:
        return 'wing';
      case NoticeTarget.room:
        return 'room';
      case NoticeTarget.role:
        return 'role';
    }
  }
}

enum NoticeType {
  general,
  urgent,
  maintenance,
  event,
  policy,
  emergency;

  static NoticeType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'general':
        return NoticeType.general;
      case 'urgent':
        return NoticeType.urgent;
      case 'maintenance':
        return NoticeType.maintenance;
      case 'event':
        return NoticeType.event;
      case 'policy':
        return NoticeType.policy;
      case 'emergency':
        return NoticeType.emergency;
      default:
        return NoticeType.general;
    }
  }

  @override
  String toString() {
    switch (this) {
      case NoticeType.general:
        return 'general';
      case NoticeType.urgent:
        return 'urgent';
      case NoticeType.maintenance:
        return 'maintenance';
      case NoticeType.event:
        return 'event';
      case NoticeType.policy:
        return 'policy';
      case NoticeType.emergency:
        return 'emergency';
    }
  }
}
