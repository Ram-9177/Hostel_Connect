import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/core/error_handling/app_error_handling.dart';
import 'package:hostelconnect/shared/widgets/ui/professional_components.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class PageErrorBoundary extends ConsumerStatefulWidget {
  final Widget child;
  final String pageName;
  final VoidCallback? onRetry;

  const PageErrorBoundary({
    super.key,
    required this.child,
    required this.pageName,
    this.onRetry,
  });

  @override
  ConsumerState<PageErrorBoundary> createState() => _PageErrorBoundaryState();
}

class _PageErrorBoundaryState extends ConsumerState<PageErrorBoundary> {
  bool _hasError = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    return ErrorBoundary(
      onError: (error, stackTrace) {
        setState(() {
          _hasError = true;
          _errorMessage = error.toString();
        });
      },
      child: widget.child,
    );
  }

  Widget _buildErrorWidget() {
    return HResponsive.builder(builder: (ctx, r) {
      return Scaffold(
        appBar: AppBar(
          title: Text(HTeluguTheme.getTeluguEnglishText('error', 'Error')),
          backgroundColor: HTeluguTheme.error,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(r.spacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: r.spacing.xxl * 2,
                  color: HTeluguTheme.error,
                ),
                SizedBox(height: r.spacing.lg),
                Text(
                  HTeluguTheme.getTeluguEnglishText('something_went_wrong', 'Something went wrong'),
                  style: HTeluguTheme.headlineMedium.copyWith(
                    color: HTeluguTheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.spacing.md),
                Text(
                  HTeluguTheme.getTeluguEnglishText('error_in_page', 'There was an error loading ${widget.pageName}'),
                  style: HTeluguTheme.bodyMedium.copyWith(
                    color: HTeluguTheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_errorMessage != null) ...[
                  SizedBox(height: r.spacing.md),
                  Container(
                    padding: EdgeInsets.all(r.spacing.md),
                    decoration: BoxDecoration(
                      color: HTeluguTheme.errorContainer,
                      borderRadius: BorderRadius.circular(r.radius.md),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: HTeluguTheme.bodySmall.copyWith(
                        color: HTeluguTheme.onErrorContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                SizedBox(height: r.spacing.xl),
                HProfessionalButton(
                  text: HTeluguTheme.getTeluguEnglishText('try_again', 'Try Again'),
                  variant: HProfessionalButtonVariant.primary,
                  size: HProfessionalButtonSize.lg,
                  onPressed: () {
                    setState(() {
                      _hasError = false;
                      _errorMessage = null;
                    });
                    widget.onRetry?.call();
                  },
                ),
                SizedBox(height: r.spacing.md),
                HProfessionalButton(
                  text: HTeluguTheme.getTeluguEnglishText('go_back', 'Go Back'),
                  variant: HProfessionalButtonVariant.secondary,
                  size: HProfessionalButtonSize.lg,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PageLoadingBoundary extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? loadingMessage;

  const PageLoadingBoundary({
    super.key,
    required this.child,
    required this.isLoading,
    this.loadingMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return HResponsive.builder(builder: (ctx, r) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const HProfessionalLoading(),
                SizedBox(height: r.spacing.lg),
                Text(
                  loadingMessage ?? HTeluguTheme.getTeluguEnglishText('loading', 'Loading...'),
                  style: HTeluguTheme.bodyLarge.copyWith(
                    color: HTeluguTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }

    return child;
  }
}

class PageWrapper extends StatelessWidget {
  final Widget child;
  final String pageName;
  final bool isLoading;
  final String? loadingMessage;
  final VoidCallback? onRetry;
  final bool showAppBar;
  final String? title;
  final List<Widget>? actions;

  const PageWrapper({
    super.key,
    required this.child,
    required this.pageName,
    this.isLoading = false,
    this.loadingMessage,
    this.onRetry,
    this.showAppBar = true,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return PageErrorBoundary(
      pageName: pageName,
      onRetry: onRetry,
      child: PageLoadingBoundary(
        isLoading: isLoading,
        loadingMessage: loadingMessage,
        child: showAppBar ? Scaffold(
          appBar: AppBar(
            title: Text(title ?? pageName),
            backgroundColor: HTeluguTheme.primary,
            foregroundColor: Colors.white,
            actions: actions,
          ),
          body: child,
        ) : child,
      ),
    );
  }
}
