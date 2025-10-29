import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

class NetworkConfig {
  static const String _apiVersion = '/api/v1';
  
  static String get baseUrl => Platform.isAndroid
      ? 'http://10.0.2.2:3000'
      : 'http://localhost:3000';
  static String get apiUrl => '$baseUrl$_apiVersion';
  
  // Network connectivity
  static final Connectivity _connectivity = Connectivity();
  static final InternetConnection _connectionChecker = InternetConnection();
  
  // Check if device has internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectionChecker.hasInternetAccess;
      return result;
    } catch (e) {
      return false;
    }
  }
  
  // Check network connectivity type
  static Future<List<ConnectivityResult>> getConnectivityType() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return [ConnectivityResult.none];
    }
  }
  
  // Get device info for debugging
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'platform': 'Android',
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'sdkInt': androidInfo.version.sdkInt,
        'brand': androidInfo.brand,
        'device': androidInfo.device,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'platform': 'iOS',
        'model': iosInfo.model,
        'version': iosInfo.systemVersion,
        'name': iosInfo.name,
        'identifierForVendor': iosInfo.identifierForVendor,
      };
    }
    
    return {'platform': 'Unknown'};
  }
  
  // Test API connectivity
  static Future<bool> testApiConnectivity() async {
    try {
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 10);
      
      final request = await client.getUrl(Uri.parse('$apiUrl/health'));
      final response = await request.close();
      
      client.close();
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  
  // Get network diagnostics
  static Future<Map<String, dynamic>> getNetworkDiagnostics() async {
    final hasInternet = await hasInternetConnection();
    final connectivityType = await getConnectivityType();
    final apiConnectivity = await testApiConnectivity();
    final deviceInfo = await getDeviceInfo();
    
    return {
      'hasInternet': hasInternet,
      'connectivityType': connectivityType.toString(),
      'apiConnectivity': apiConnectivity,
      'deviceInfo': deviceInfo,
      'apiUrl': apiUrl,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
