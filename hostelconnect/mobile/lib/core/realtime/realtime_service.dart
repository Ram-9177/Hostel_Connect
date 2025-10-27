import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

class RealtimeService {
  static IO.Socket? _socket;
  static bool _isConnected = false;

  static IO.Socket? get socket => _socket;
  static bool get isConnected => _isConnected;

  static Future<void> connect(String token) async {
    try {
      _socket = IO.io('http://localhost:3000/hostelconnect', {
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': token,
        },
      });

      _socket!.onConnect((_) {
        print('✅ Connected to real-time server');
        _isConnected = true;
      });

      _socket!.onDisconnect((_) {
        print('❌ Disconnected from real-time server');
        _isConnected = false;
      });

      _socket!.onConnectError((error) {
        print('❌ Connection error: $error');
        _isConnected = false;
      });

      _socket!.onError((error) {
        print('❌ Socket error: $error');
      });

      _socket!.connect();
    } catch (e) {
      print('❌ Failed to connect to real-time server: $e');
    }
  }

  static void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _isConnected = false;
  }

  // Event listeners
  static void onUserOnline(Function(Map<String, dynamic>) callback) {
    _socket?.on('user_online', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onUserOffline(Function(Map<String, dynamic>) callback) {
    _socket?.on('user_offline', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onNewGatePassRequest(Function(Map<String, dynamic>) callback) {
    _socket?.on('new_gate_pass_request', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onGatePassStatusUpdate(Function(Map<String, dynamic>) callback) {
    _socket?.on('gate_pass_status_update', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onAttendanceSessionStarted(Function(Map<String, dynamic>) callback) {
    _socket?.on('attendance_session_started', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onAttendanceMarked(Function(Map<String, dynamic>) callback) {
    _socket?.on('attendance_marked', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onMealPreferenceUpdated(Function(Map<String, dynamic>) callback) {
    _socket?.on('meal_preference_updated', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onNewNotice(Function(Map<String, dynamic>) callback) {
    _socket?.on('new_notice', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  static void onMessageReceived(Function(Map<String, dynamic>) callback) {
    _socket?.on('message_received', (data) {
      callback(Map<String, dynamic>.from(data));
    });
  }

  // Event emitters
  static void requestGatePass({
    required String studentId,
    required String reason,
    required String startTime,
    required String endTime,
  }) {
    _socket?.emit('gate_pass_request', {
      'studentId': studentId,
      'reason': reason,
      'startTime': startTime,
      'endTime': endTime,
    });
  }

  static void approveGatePass({
    required String studentId,
    required String passId,
    required bool approved,
  }) {
    _socket?.emit('gate_pass_approved', {
      'studentId': studentId,
      'passId': passId,
      'approved': approved,
    });
  }

  static void startAttendanceSession({
    required String sessionId,
    required String sessionName,
    required String qrCode,
  }) {
    _socket?.emit('attendance_session_started', {
      'sessionId': sessionId,
      'sessionName': sessionName,
      'qrCode': qrCode,
    });
  }

  static void markAttendance({
    required String studentId,
    required String sessionId,
    required String status,
  }) {
    _socket?.emit('attendance_marked', {
      'studentId': studentId,
      'sessionId': sessionId,
      'status': status,
    });
  }

  static void updateMealPreference({
    required String studentId,
    required String mealType,
    required String preference,
  }) {
    _socket?.emit('meal_preference_updated', {
      'studentId': studentId,
      'mealType': mealType,
      'preference': preference,
    });
  }

  static void publishNotice({
    required String title,
    required String content,
    required List<String> targetRoles,
  }) {
    _socket?.emit('notice_published', {
      'title': title,
      'content': content,
      'targetRoles': targetRoles,
    });
  }

  static void sendMessage({
    required String roomId,
    required String message,
    required String type,
  }) {
    _socket?.emit('send_message', {
      'roomId': roomId,
      'message': message,
      'type': type,
    });
  }

  static void joinRoom(String roomId) {
    _socket?.emit('join_room', {'roomId': roomId});
  }

  static void leaveRoom(String roomId) {
    _socket?.emit('leave_room', {'roomId': roomId});
  }
}

// Riverpod provider for real-time service
final realtimeServiceProvider = Provider<RealtimeService>((ref) {
  return RealtimeService();
});

// Provider for connection status
final connectionStatusProvider = StateProvider<bool>((ref) {
  return RealtimeService.isConnected;
});
