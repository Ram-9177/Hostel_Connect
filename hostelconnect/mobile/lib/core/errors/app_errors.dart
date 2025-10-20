// Core error handling
class HostelConnectError implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const HostelConnectError(this.message, {this.code, this.details});

  @override
  String toString() => 'HostelConnectError: $message';
}

class NetworkError extends HostelConnectError {
  const NetworkError(super.message, {super.code, super.details});
}

class ValidationError extends HostelConnectError {
  const ValidationError(super.message, {super.code, super.details});
}

class AuthError extends HostelConnectError {
  const AuthError(super.message, {super.code, super.details});
}
