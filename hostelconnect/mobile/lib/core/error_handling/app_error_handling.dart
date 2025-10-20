// Comprehensive Error Handling and Loading System
import 'package:flutter/material.dart';
import '../responsive/responsive_breakpoints.dart';
import '../responsive/responsive_widgets.dart';

/// Error types enumeration
enum ErrorType {
  network,
  server,
  validation,
  authentication,
  permission,
  unknown,
}

/// Error severity levels
enum ErrorSeverity {
  low,
  medium,
  high,
  critical,
}

/// Custom error class
class AppError {
  final String message;
  final ErrorType type;
  final ErrorSeverity severity;
  final String? code;
  final Map<String, dynamic>? details;

  const AppError({
    required this.message,
    required this.type,
    this.severity = ErrorSeverity.medium,
    this.code,
    this.details,
  });

  /// Create network error
  factory AppError.network(String message) {
    return AppError(
      message: message,
      type: ErrorType.network,
      severity: ErrorSeverity.high,
    );
  }

  /// Create server error
  factory AppError.server(String message, {String? code}) {
    return AppError(
      message: message,
      type: ErrorType.server,
      severity: ErrorSeverity.high,
      code: code,
    );
  }

  /// Create validation error
  factory AppError.validation(String message) {
    return AppError(
      message: message,
      type: ErrorType.validation,
      severity: ErrorSeverity.medium,
    );
  }

  /// Create authentication error
  factory AppError.authentication(String message) {
    return AppError(
      message: message,
      type: ErrorType.authentication,
      severity: ErrorSeverity.high,
    );
  }

  /// Create permission error
  factory AppError.permission(String message) {
    return AppError(
      message: message,
      type: ErrorType.permission,
      severity: ErrorSeverity.high,
    );
  }

  /// Get error icon
  IconData get icon {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.error_outline;
      case ErrorType.validation:
        return Icons.warning;
      case ErrorType.authentication:
        return Icons.lock;
      case ErrorType.permission:
        return Icons.block;
      case ErrorType.unknown:
        return Icons.help_outline;
    }
  }

  /// Get error color
  Color getColor(BuildContext context) {
    switch (severity) {
      case ErrorSeverity.low:
        return Colors.orange;
      case ErrorSeverity.medium:
        return Colors.amber;
      case ErrorSeverity.high:
        return Colors.red;
      case ErrorSeverity.critical:
        return Colors.red.shade900;
    }
  }
}

/// Loading states enumeration
enum LoadingState {
  idle,
  loading,
  success,
  error,
}

/// Comprehensive loading widget
class AppLoadingWidget extends StatelessWidget {
  final LoadingState state;
  final String? message;
  final AppError? error;
  final VoidCallback? onRetry;
  final Widget? successWidget;
  final double? size;
  final Color? color;

  const AppLoadingWidget({
    super.key,
    required this.state,
    this.message,
    this.error,
    this.onRetry,
    this.successWidget,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case LoadingState.idle:
        return const SizedBox.shrink();
      
      case LoadingState.loading:
        return _buildLoadingState(context);
      
      case LoadingState.success:
        return successWidget ?? _buildSuccessState(context);
      
      case LoadingState.error:
        return _buildErrorState(context);
    }
  }

  Widget _buildLoadingState(BuildContext context) {
    final responsiveSize = ResponsiveUtils.responsiveSpacing(
      context,
      base: size ?? 40.0,
    );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: responsiveSize,
            height: responsiveSize,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: ResponsiveUtils.responsiveSpacing(context, base: 16.0)),
            ResponsiveText(
              message!,
              fontSize: 16.0,
              color: Theme.of(context).textTheme.bodyMedium?.color,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: ResponsiveUtils.responsiveSpacing(context, base: 48.0),
            color: Colors.green,
          ),
          SizedBox(height: ResponsiveUtils.responsiveSpacing(context, base: 16.0)),
          ResponsiveText(
            message ?? 'Success!',
            fontSize: 16.0,
            color: Colors.green,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final error = this.error ?? const AppError(
      message: 'An unknown error occurred',
      type: ErrorType.unknown,
    );

    return Center(
      child: Padding(
        padding: ResponsiveUtils.responsivePadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              error.icon,
              size: ResponsiveUtils.responsiveSpacing(context, base: 48.0),
              color: error.getColor(context),
            ),
            SizedBox(height: ResponsiveUtils.responsiveSpacing(context, base: 16.0)),
            ResponsiveText(
              error.message,
              fontSize: 16.0,
              color: error.getColor(context),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (onRetry != null) ...[
              SizedBox(height: ResponsiveUtils.responsiveSpacing(context, base: 24.0)),
              ResponsiveButton(
                text: 'Try Again',
                onPressed: onRetry,
                fontSize: 14.0,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error snackbar widget
class ErrorSnackBar extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;

  const ErrorSnackBar({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            error.icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: ResponsiveUtils.responsiveSpacing(context, base: 8.0)),
          Expanded(
            child: Text(
              error.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: error.getColor(context),
      duration: Duration(
        seconds: error.severity == ErrorSeverity.critical ? 10 : 4,
      ),
      action: onRetry != null
          ? SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: onRetry!,
            )
          : null,
    );
  }

  /// Show error snackbar
  static void show(BuildContext context, AppError error, {VoidCallback? onRetry}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ErrorSnackBar(error: error, onRetry: onRetry),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: ResponsiveUtils.responsivePadding(context),
      ),
    );
  }
}

/// Loading overlay widget
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? backgroundColor;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: AppLoadingWidget(
              state: LoadingState.loading,
              message: message,
            ),
          ),
      ],
    );
  }
}

/// Error boundary widget
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(AppError error)? errorBuilder;
  final VoidCallback? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!) ??
          AppLoadingWidget(
            state: LoadingState.error,
            error: _error,
            onRetry: () {
              setState(() {
                _error = null;
              });
            },
          );
    }

    return widget.child;
  }

  void _handleError(AppError error) {
    setState(() {
      _error = error;
    });
    widget.onError?.call();
  }
}

/// Async operation wrapper
class AsyncOperation<T> {
  final Future<T> Function() operation;
  final String? loadingMessage;
  final Widget Function(T data)? successBuilder;
  final Widget Function(AppError error)? errorBuilder;

  const AsyncOperation({
    required this.operation,
    this.loadingMessage,
    this.successBuilder,
    this.errorBuilder,
  });

  Future<void> execute(
    BuildContext context, {
    required Function(LoadingState state) onStateChanged,
    required Function(T data) onSuccess,
    required Function(AppError error) onError,
  }) async {
    try {
      onStateChanged(LoadingState.loading);
      final result = await operation();
      onStateChanged(LoadingState.success);
      onSuccess(result);
    } catch (e) {
      final error = _convertToAppError(e);
      onStateChanged(LoadingState.error);
      onError(error);
    }
  }

  AppError _convertToAppError(dynamic error) {
    if (error is AppError) {
      return error;
    }
    
    final message = error.toString();
    if (message.contains('network') || message.contains('connection')) {
      return AppError.network('Network connection failed');
    }
    if (message.contains('server') || message.contains('500')) {
      return AppError.server('Server error occurred');
    }
    if (message.contains('validation') || message.contains('400')) {
      return AppError.validation('Invalid input provided');
    }
    if (message.contains('auth') || message.contains('401')) {
      return AppError.authentication('Authentication failed');
    }
    if (message.contains('permission') || message.contains('403')) {
      return AppError.permission('Permission denied');
    }
    
    return AppError(
      message: message,
      type: ErrorType.unknown,
    );
  }
}
