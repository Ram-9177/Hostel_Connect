// lib/core/api/student_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class StudentApiService {
  final HttpClient _httpClient;

  StudentApiService(this._httpClient);

  Future<List<Map<String, dynamic>>> getStudents() async {
    try {
      final response = await _httpClient.get(Environment.students);
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch students: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUnassignedStudents() async {
    try {
      final response = await _httpClient.get(Environment.studentsUnassigned);
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch unassigned students: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch unassigned students: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getStudentsByHostel(String hostelId) async {
    try {
      final response = await _httpClient.get('${Environment.studentsByHostel}/$hostelId');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch students by hostel: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch students by hostel: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getStudentsByRoom(String roomId) async {
    try {
      final response = await _httpClient.get('${Environment.studentsByRoom}/$roomId');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch students by room: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch students by room: $e');
    }
  }

  Future<Map<String, dynamic>> getStudent(String id) async {
    try {
      final response = await _httpClient.get('${Environment.students}/$id');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch student: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch student: $e');
    }
  }

  Future<Map<String, dynamic>> updateStudent(String id, Map<String, dynamic> studentData) async {
    try {
      final response = await _httpClient.put(
        '${Environment.students}/$id',
        data: studentData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update student: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update student: $e');
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      final response = await _httpClient.delete('${Environment.students}/$id');
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete student: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete student: $e');
    }
  }
}

final studentApiServiceProvider = Provider<StudentApiService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return StudentApiService(httpClient);
});
