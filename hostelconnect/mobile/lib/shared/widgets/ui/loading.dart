import 'package:flutter/material.dart';
import '../../../core/responsive.dart';

class HLoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const HLoadingWidget({
    super.key,
    this.message,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: size ?? (r.isXS ? 24 : 32),
              height: size ?? (r.isXS ? 24 : 32),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? HTokens.primary,
                ),
              ),
            ),
            if (message != null) ...[
              SizedBox(height: HTokens.md),
              Text(
                message!,
                style: TextStyle(
                  fontSize: r.isXS ? 14 : 16,
                  color: HTokens.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    });
  }
}

class HLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? loadingMessage;
  final Color? backgroundColor;

  const HLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.loadingMessage,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.3),
            child: HLoadingWidget(message: loadingMessage),
          ),
      ],
    );
  }
}

class HErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const HErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(HTokens.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon ?? Icons.error_outline,
                size: r.isXS ? 48 : 64,
                color: HTokens.error,
              ),
              SizedBox(height: HTokens.md),
              Text(
                message,
                style: TextStyle(
                  fontSize: r.isXS ? 14 : 16,
                  color: HTokens.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                SizedBox(height: HTokens.lg),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(Icons.refresh),
                  label: Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HTokens.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}

class HEmptyStateWidget extends StatelessWidget {
  final String message;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionText;

  const HEmptyStateWidget({
    super.key,
    required this.message,
    this.subtitle,
    this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(HTokens.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon ?? Icons.inbox_outlined,
                size: r.isXS ? 48 : 64,
                color: HTokens.onSurfaceVariant.withOpacity(0.5),
              ),
              SizedBox(height: HTokens.lg),
              Text(
                message,
                style: TextStyle(
                  fontSize: r.isXS ? 16 : 18,
                  fontWeight: FontWeight.w600,
                  color: HTokens.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                SizedBox(height: HTokens.sm),
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: r.isXS ? 12 : 14,
                    color: HTokens.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (onAction != null && actionText != null) ...[
                SizedBox(height: HTokens.lg),
                ElevatedButton.icon(
                  onPressed: onAction,
                  icon: Icon(Icons.add),
                  label: Text(actionText!),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HTokens.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
