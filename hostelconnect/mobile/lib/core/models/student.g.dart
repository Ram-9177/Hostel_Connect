// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      studentId: json['studentId'] as String,
      hostelId: json['hostelId'] as String,
      roomId: json['roomId'] as String?,
      bedNumber: json['bedNumber'] as String?,
      course: json['course'] as String,
      year: json['year'] as String,
      emergencyContact: json['emergencyContact'] as String?,
      emergencyPhone: json['emergencyPhone'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'studentId': instance.studentId,
      'hostelId': instance.hostelId,
      'roomId': instance.roomId,
      'bedNumber': instance.bedNumber,
      'course': instance.course,
      'year': instance.year,
      'emergencyContact': instance.emergencyContact,
      'emergencyPhone': instance.emergencyPhone,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
