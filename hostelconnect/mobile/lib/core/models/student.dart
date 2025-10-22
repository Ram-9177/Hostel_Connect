// lib/core/models/student.dart
class Student {
  final String id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? roomId;
  final String? bedNumber;
  final String hostelId;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Student({
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.roomId,
    this.bedNumber,
    required this.hostelId,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      roomId: json['roomId']?.toString(),
      bedNumber: json['bedNumber']?.toString(),
      hostelId: json['hostelId']?.toString() ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'roomId': roomId,
      'bedNumber': bedNumber,
      'hostelId': hostelId,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get fullName => '$firstName $lastName';
}
