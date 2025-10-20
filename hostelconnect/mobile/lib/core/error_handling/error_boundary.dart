// lib/core/error_handling/error_boundary.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive_breakpoints.dart';
import '../responsive/responsive_widgets.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallback;
  final Function(Object error, StackTrace stackTrace)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallback,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool _hasError = false;
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.fallback ?? _buildErrorWidget();
    }

    return widget.child;
  }

  Widget _buildErrorWidget() {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Center(
        child: ResponsivePadding(
          padding: EdgeInsets.all(ResponsiveUtils.getResponsivePadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: ResponsiveUtils.getResponsiveIconSize(context),
                color: Colors.red,
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              ResponsiveText(
                'Something went wrong',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: 24),
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context, multiplier: 0.5)),
              ResponsiveText(
                'We apologize for the inconvenience. Please try again or contact support if the problem persists.',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, base: 16),
                  color: Colors.red.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ResponsiveUtils.getResponsiveSpacing(context)),
              ResponsiveButton(
                onPressed: () {
                  setState(() {
                    _hasError = false;
                    _error = null;
                    _stackTrace = null;
                  });
                },
                child: Text('Try Again'),
                variant: ButtonVariant.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    setState(() {
      _hasError = true;
      _error = error;
      _stackTrace = stackTrace;
    });

    // Log error
    debugPrint('Error Boundary caught: $error');
    debugPrint('Stack trace: $stackTrace');

    // Call custom error handler
    widget.onError?.call(error, stackTrace);

    // Haptic feedback
    HapticFeedback.heavyImpact();
  }
}

class ErrorBoundaryWrapper extends StatelessWidget {
  final Widget child;

  const ErrorBoundaryWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      onError: (error, stackTrace) {
        // Log to crash reporting service
        debugPrint('Unhandled error: $error');
        debugPrint('Stack trace: $stackTrace');
      },
      child: child,
    );
  }
}

// Global error handler
void setupGlobalErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    
    // Log to crash reporting service
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // Handle platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Platform Error: $error');
    debugPrint('Stack trace: $stack');
    return true;
  };
}
