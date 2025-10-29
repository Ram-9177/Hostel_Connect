// Shared data models
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.name,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

enum UserRole {
  STUDENT,
  WARDEN,
  WARDEN_HEAD,
  GATE_SECURITY,
  ADMIN,
  SUPER_ADMIN,
  CHEF,
}

class Student extends User {
  final String rollNumber;
  final String phoneNumber;
  final String? emergencyContact;
  final String? roomId;

  const Student({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.role,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    required this.rollNumber,
    required this.phoneNumber,
    this.emergencyContact,
    this.roomId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      rollNumber: json['rollNumber'],
      phoneNumber: json['phoneNumber'],
      emergencyContact: json['emergencyContact'],
      roomId: json['roomId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'rollNumber': rollNumber,
      'phoneNumber': phoneNumber,
      'emergencyContact': emergencyContact,
      'roomId': roomId,
    };
  }
}
