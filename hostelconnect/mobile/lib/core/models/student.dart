// lib/core/models/student.dart
import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String studentId;
  final String hostelId;
  final String? roomId;
  final String? bedNumber;
  final String course;
  final String year;
  final String? emergencyContact;
  final String? emergencyPhone;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.studentId,
    required this.hostelId,
    this.roomId,
    this.bedNumber,
    required this.course,
    required this.year,
    this.emergencyContact,
    this.emergencyPhone,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? studentId,
    String? hostelId,
    String? roomId,
    String? bedNumber,
    String? course,
    String? year,
    String? emergencyContact,
    String? emergencyPhone,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      studentId: studentId ?? this.studentId,
      hostelId: hostelId ?? this.hostelId,
      roomId: roomId ?? this.roomId,
      bedNumber: bedNumber ?? this.bedNumber,
      course: course ?? this.course,
      year: year ?? this.year,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      emergencyPhone: emergencyPhone ?? this.emergencyPhone,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, studentId: $studentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Student && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}