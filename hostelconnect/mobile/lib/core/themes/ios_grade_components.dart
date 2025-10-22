import 'package:flutter/material.dart';
import 'ios_grade_theme.dart';

/// iOS Grade Components
/// Modern iOS-inspired UI components for HostelConnect

class IOSGradeBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;

  const IOSGradeBackButton({
    super.key,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? IOSGradeTheme.onSurface,
      ),
    );
  }
}

class IOSGradeSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const IOSGradeSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText ?? 'Search...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          borderSide: BorderSide(color: IOSGradeTheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          borderSide: BorderSide(color: IOSGradeTheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          borderSide: BorderSide(color: IOSGradeTheme.primary),
        ),
        filled: true,
        fillColor: IOSGradeTheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: IOSGradeTheme.spacing16,
          vertical: IOSGradeTheme.spacing12,
        ),
      ),
    );
  }
}

class IOSGradeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;

  const IOSGradeTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: IOSGradeTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              borderSide: BorderSide(color: IOSGradeTheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              borderSide: BorderSide(color: IOSGradeTheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              borderSide: BorderSide(color: IOSGradeTheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
              borderSide: BorderSide(color: IOSGradeTheme.error),
            ),
            filled: true,
            fillColor: IOSGradeTheme.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: IOSGradeTheme.spacing16,
              vertical: IOSGradeTheme.spacing12,
            ),
          ),
        ),
      ],
    );
  }
}

class IOSGradeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  const IOSGradeButton({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? IOSGradeTheme.primary,
        foregroundColor: foregroundColor ?? IOSGradeTheme.onPrimary,
        padding: padding ?? const EdgeInsets.symmetric(
          horizontal: IOSGradeTheme.spacing24,
          vertical: IOSGradeTheme.spacing12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        ),
        elevation: 0,
      ),
      child: child,
    );
  }
}

class IOSGradeLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;

  const IOSGradeLoadingIndicator({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 24,
      height: size ?? 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? IOSGradeTheme.primary,
        ),
      ),
    );
  }
}

class IOSGradeErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onRetry;

  const IOSGradeErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: IOSGradeTheme.error,
          ),
          const SizedBox(height: IOSGradeTheme.spacing16),
          Text(
            'Something went wrong',
            style: IOSGradeTheme.headlineSmall.copyWith(
              color: IOSGradeTheme.onSurface,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing8),
          Text(
            error,
            style: IOSGradeTheme.bodyMedium.copyWith(
              color: IOSGradeTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: IOSGradeTheme.spacing24),
            IOSGradeButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
