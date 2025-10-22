// lib/core/api/hostel_api_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/http_client.dart';
import '../config/environment.dart';

class HostelApiService {
  final HttpClient _httpClient;

  HostelApiService(this._httpClient);

  // Hostels
  Future<List<Map<String, dynamic>>> getHostels() async {
    try {
      final response = await _httpClient.get(Environment.hostels);
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch hostels: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch hostels: $e');
    }
  }

  Future<Map<String, dynamic>> getHostel(String id) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/$id');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch hostel: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch hostel: $e');
    }
  }

  Future<Map<String, dynamic>> createHostel(Map<String, dynamic> hostelData) async {
    try {
      final response = await _httpClient.post(
        Environment.hostels,
        data: hostelData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create hostel: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create hostel: $e');
    }
  }

  Future<Map<String, dynamic>> updateHostel(String id, Map<String, dynamic> hostelData) async {
    try {
      final response = await _httpClient.put(
        '${Environment.hostels}/$id',
        data: hostelData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update hostel: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update hostel: $e');
    }
  }

  Future<void> deleteHostel(String id) async {
    try {
      final response = await _httpClient.delete('${Environment.hostels}/$id');
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete hostel: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete hostel: $e');
    }
  }

  // Blocks
  Future<List<Map<String, dynamic>>> getBlocks(String hostelId) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/$hostelId/blocks');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch blocks: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch blocks: $e');
    }
  }

  Future<Map<String, dynamic>> createBlock(String hostelId, Map<String, dynamic> blockData) async {
    try {
      final response = await _httpClient.post(
        '${Environment.hostels}/$hostelId/blocks',
        data: blockData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create block: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create block: $e');
    }
  }

  Future<Map<String, dynamic>> updateBlock(String blockId, Map<String, dynamic> blockData) async {
    try {
      final response = await _httpClient.put(
        '${Environment.hostels}/blocks/$blockId',
        data: blockData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update block: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update block: $e');
    }
  }

  Future<void> deleteBlock(String blockId) async {
    try {
      final response = await _httpClient.delete('${Environment.hostels}/blocks/$blockId');
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete block: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete block: $e');
    }
  }

  // Rooms
  Future<List<Map<String, dynamic>>> getRooms(String hostelId) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/$hostelId/rooms');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch rooms: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch rooms: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRoomsByBlock(String blockId) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/blocks/$blockId/rooms');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to fetch rooms: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch rooms: $e');
    }
  }

  Future<Map<String, dynamic>> createRoom(String blockId, Map<String, dynamic> roomData) async {
    try {
      final response = await _httpClient.post(
        '${Environment.hostels}/blocks/$blockId/rooms',
        data: roomData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create room: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create room: $e');
    }
  }

  Future<Map<String, dynamic>> updateRoom(String roomId, Map<String, dynamic> roomData) async {
    try {
      final response = await _httpClient.put(
        '${Environment.hostels}/rooms/$roomId',
        data: roomData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update room: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update room: $e');
    }
  }

  Future<void> deleteRoom(String roomId) async {
    try {
      final response = await _httpClient.delete('${Environment.hostels}/rooms/$roomId');
      
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete room: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete room: $e');
    }
  }

  // Analytics
  Future<Map<String, dynamic>> getHostelAnalytics(String hostelId) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/$hostelId/analytics');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch analytics: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch analytics: $e');
    }
  }

  // Room Map
  Future<Map<String, dynamic>> getRoomMap(String hostelId) async {
    try {
      final response = await _httpClient.get('${Environment.hostels}/$hostelId/room-map');
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch room map: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch room map: $e');
    }
  }
}

final hostelApiServiceProvider = Provider<HostelApiService>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return HostelApiService(httpClient);
});
