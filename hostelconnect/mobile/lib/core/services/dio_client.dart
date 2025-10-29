import 'package:dio/dio.dart';
import '../network/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dio Client
/// HTTP client configuration for HostelConnect
class DioClient {
  static Dio? _instance;
  
  static Dio get instance {
    _instance ??= Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    return _instance!;
  }

  // HTTP Methods
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return instance.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return instance.post<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> put<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return instance.put<T>(path, data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> delete<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) {
    return instance.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
  }
}

/// Dio Client Provider for Riverpod
final dioClientProvider = Provider<Dio>((ref) => DioClient.instance);
