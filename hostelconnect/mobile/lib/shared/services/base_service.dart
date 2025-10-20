// Base service class for common functionality
import 'package:dio/dio.dart';
import '../core/network/api_config.dart';
import '../core/errors/app_errors.dart';
import '../shared/models/api_response.dart';

abstract class BaseService {
  late final Dio _dio;

  BaseService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
      headers: ApiConfig.headers,
    ));

    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        final token = _getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          // Handle unauthorized
          _handleUnauthorized();
        }
        handler.next(error);
      },
    ));
  }

  String? _getAuthToken() {
    // TODO: Get token from secure storage
    return null;
  }

  void _handleUnauthorized() {
    // TODO: Handle unauthorized access
  }

  // Generic GET request
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  // Generic POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  // Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  // Generic DELETE request
  Future<ApiResponse<T>> delete<T>(
    String path, {
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await _dio.delete(path);
      return ApiResponse.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  ApiResponse<T> _handleDioError<T>(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiResponse.error('Connection timeout. Please check your internet connection.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Server error';
        return ApiResponse.error(message, statusCode: statusCode);
      case DioExceptionType.cancel:
        return ApiResponse.error('Request was cancelled');
      case DioExceptionType.connectionError:
        return ApiResponse.error('No internet connection');
      default:
        return ApiResponse.error('Network error: ${e.message}');
    }
  }
}
