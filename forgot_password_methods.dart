// Forgot password methods for API service
// Add these methods to api_service.dart

// Forgot password endpoint
static Future<Map<String, dynamic>> forgotPassword(String email) async {
  const endpoint = '/auth/forgot-password';
  return _makeRequest(
    () => http.post(
      Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
      headers: _defaultHeaders,
      body: jsonEncode({'email': email}),
    ),
    (data) => data,
    endpoint,
  );
}

// Reset password endpoint
static Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
  const endpoint = '/auth/reset-password';
  return _makeRequest(
    () => http.post(
      Uri.parse('${NetworkConfig.apiUrl}$endpoint'),
      headers: _defaultHeaders,
      body: jsonEncode({'token': token, 'newPassword': newPassword}),
    ),
    (data) => data,
    endpoint,
  );
}
