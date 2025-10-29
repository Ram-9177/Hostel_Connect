// lib/core/providers/dio_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_config.dart';

/// Provider for Dio HTTP client instance
/// Used by all API services for making HTTP requests
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add request interceptor for authentication
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // TODO: Add JWT token from auth state
      // final token = ref.read(authStateProvider).token;
      // if (token != null) {
      //   options.headers['Authorization'] = 'Bearer $token';
      // }
      
      print('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      print('❌ ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
      print('❌ MESSAGE: ${e.message}');
      
      // Handle common HTTP errors
      if (e.response?.statusCode == 401) {
        // TODO: Trigger logout or token refresh
        print('🔒 Unauthorized - Please login again');
      } else if (e.response?.statusCode == 500) {
        print('🔥 Server Error - Please try again later');
      }
      
      return handler.next(e);
    },
  ));

  // Add logging interceptor for debugging
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    responseHeader: false,
    error: true,
    logPrint: (obj) => print(obj),
  ));

  return dio;
});
