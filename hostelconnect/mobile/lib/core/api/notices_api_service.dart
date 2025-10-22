// lib/core/api/notices_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class NoticesApiService {
  final HttpClient _httpClient;

  NoticesApiService(this._httpClient);

  Future<List<Map<String, dynamic>>> getNotices() async {
    try {
      final response = await _httpClient.get(Environment.notices);
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch notices: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notices: $e');
    }
  }

  Future<Map<String, dynamic>> createNotice(Map<String, dynamic> noticeData) async {
    try {
      final response = await _httpClient.post(
        Environment.notices,
        data: noticeData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create notice: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create notice: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTestNotices() async {
    try {
      final response = await _httpClient.get(Environment.noticesTest);
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch test notices: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch test notices: $e');
    }
  }
}

final noticesApiServiceProvider = Provider<NoticesApiService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return NoticesApiService(httpClient);
});
