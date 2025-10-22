// lib/core/network/http_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/environment.dart';
import '../auth/auth_service.dart';
import '../../shared/widgets/ui/toast.dart';

class HttpClient {
  late Dio _dio;
  final Ref _ref;

  HttpClient(this._ref) {
    _dio = Dio();
    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Base configuration
    _dio.options.baseUrl = Environment.baseUrl;
    _dio.options.connectTimeout = Environment.timeout;
    _dio.options.receiveTimeout = Environment.timeout;
    _dio.options.sendTimeout = Environment.timeout;

    // Request interceptor for auth headers
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final authState = _ref.read(AuthService.authStateProvider);
          if (authState.isAuthenticated && authState.token != null) {
            options.headers['Authorization'] = 'Bearer ${authState.token}';
          }
          
          // Add content type
          options.headers['Content-Type'] = 'application/json';
          options.headers['Accept'] = 'application/json';

          if (Environment.enableLogging) {
            print('🚀 REQUEST: ${options.method} ${options.path}');
            print('📤 Headers: ${options.headers}');
            if (options.data != null) {
              print('📤 Data: ${options.data}');
            }
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          if (Environment.enableLogging) {
            print('✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
            print('📥 Data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) async {
          if (Environment.enableLogging) {
            print('❌ ERROR: ${error.response?.statusCode} ${error.requestOptions.path}');
            print('📥 Error: ${error.message}');
          }

          // Handle 401 Unauthorized - try to refresh token
          if (error.response?.statusCode == 401) {
            try {
              final refreshed = await _refreshToken();
              if (refreshed) {
                // Retry the original request
                final options = error.requestOptions;
                final authState = _ref.read(AuthService.authStateProvider);
                if (authState.token != null) {
                  options.headers['Authorization'] = 'Bearer ${authState.token}';
                }
                
                final response = await _dio.fetch(options);
                handler.resolve(response);
                return;
              }
            } catch (refreshError) {
              // Refresh failed, logout user
              await _ref.read(AuthService.authStateProvider.notifier).logout();
              _showErrorToast('Session expired. Please login again.');
            }
          }

          // Handle other errors
          _handleError(error);
          handler.next(error);
        },
      ),
    );

    // Retry interceptor for network errors
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: Environment.enableLogging ? print : null,
        retries: Environment.maxRetries,
        retryDelays: List.generate(
          Environment.maxRetries,
          (index) => Duration(milliseconds: Environment.retryDelayMs * (index + 1)),
        ),
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final authState = _ref.read(AuthService.authStateProvider);
      if (authState.refreshToken == null) return false;

      final response = await _dio.post(
        Environment.authRefresh,
        data: {'refreshToken': authState.refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await _ref.read(AuthService.authStateProvider.notifier).updateTokens(
          data['accessToken'],
          data['refreshToken'],
        );
        return true;
      }
    } catch (e) {
      print('Token refresh failed: $e');
    }
    return false;
  }

  void _handleError(DioException error) {
    String message = 'An error occurred';
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            message = 'Invalid request. Please try again.';
            break;
          case 401:
            message = 'Unauthorized. Please login again.';
            break;
          case 403:
            message = 'Access denied. You don\'t have permission.';
            break;
          case 404:
            message = 'Resource not found.';
            break;
          case 500:
            message = 'Server error. Please try again later.';
            break;
          default:
            message = 'Request failed with status $statusCode';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled';
        break;
      default:
        message = error.message ?? 'Unknown error occurred';
    }

    _showErrorToast(message);
  }

  void _showErrorToast(String message) {
    // This will be implemented with the toast system
    print('Error Toast: $message');
  }

  // HTTP Methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}

// Provider for HttpClient
final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient(ref);
});

// Retry interceptor for handling network failures
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int retries;
  final List<Duration> retryDelays;
  final void Function(String)? logPrint;

  RetryInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryDelays = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 3),
    ],
    this.logPrint,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      
      if (retryCount < retries) {
        final delay = retryDelays[retryCount];
        logPrint?.call('Retrying request in ${delay.inMilliseconds}ms (attempt ${retryCount + 1}/$retries)');
        
        await Future.delayed(delay);
        
        err.requestOptions.extra['retryCount'] = retryCount + 1;
        
        try {
          final response = await dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          // Continue to next retry or fail
        }
      }
    }
    
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError ||
           (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
