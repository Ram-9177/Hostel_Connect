// API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? error;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.error(String error, {int? statusCode}) {
    return ApiResponse(
      success: false,
      error: error,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      message: json['message'],
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }
}

// Pagination wrapper
class PaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int page;
  final int limit;
  final bool hasNext;
  final bool hasPrev;

  const PaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginatedResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return PaginatedResponse(
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      hasNext: json['hasNext'],
      hasPrev: json['hasPrev'],
    );
  }
}
