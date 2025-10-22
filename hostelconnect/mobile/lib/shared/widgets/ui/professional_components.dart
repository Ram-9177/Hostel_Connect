// Professional UI Components for HostelConnect
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/responsive.dart';
import '../../theme/telugu_theme.dart';

/// Professional Button Component with multiple variants
class HProfessionalButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final HProfessionalButtonVariant variant;
  final HProfessionalButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  const HProfessionalButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = HProfessionalButtonVariant.primary,
    this.size = HProfessionalButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final buttonStyle = _getButtonStyle(variant, size, r);
      final textStyle = _getTextStyle(size, r);
      
      Widget button = ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: isLoading
            ? SizedBox(
                width: _getIconSize(size),
                height: _getIconSize(size),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(variant),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: _getIconSize(size)),
                    SizedBox(width: HTokens.xs),
                  ],
                  Flexible(
                    child: Text(
                      text, 
                      style: textStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
      );

      if (isFullWidth) {
        button = SizedBox(width: double.infinity, child: button);
      }

      return button;
    });
  }

  ButtonStyle _getButtonStyle(HProfessionalButtonVariant variant, HProfessionalButtonSize size, HResponsive r) {
    final colors = _getColors(variant);
    final dimensions = _getDimensions(size, r);
    
    return ElevatedButton.styleFrom(
      backgroundColor: colors.background,
      foregroundColor: colors.foreground,
      elevation: variant == HProfessionalButtonVariant.primary ? 2 : 0,
      shadowColor: colors.background.withOpacity(0.3),
      side: variant == HProfessionalButtonVariant.outline 
          ? BorderSide(color: colors.background, width: 1.5)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dimensions.borderRadius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: dimensions.horizontalPadding,
        vertical: dimensions.verticalPadding,
      ),
      minimumSize: Size(dimensions.minWidth, dimensions.minHeight),
    );
  }

  TextStyle _getTextStyle(HProfessionalButtonSize size, HResponsive r) {
    return TextStyle(
      fontSize: _getFontSize(size, r),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
  }

  _ButtonColors _getColors(HProfessionalButtonVariant variant) {
    switch (variant) {
      case HProfessionalButtonVariant.primary:
        return _ButtonColors(
          background: HTeluguTheme.primary,
          foreground: Colors.white,
        );
      case HProfessionalButtonVariant.secondary:
        return _ButtonColors(
          background: HTeluguTheme.accent,
          foreground: Colors.white,
        );
      case HProfessionalButtonVariant.outline:
        return _ButtonColors(
          background: Colors.transparent,
          foreground: HTeluguTheme.primary,
        );
      case HProfessionalButtonVariant.danger:
        return _ButtonColors(
          background: HTeluguTheme.error,
          foreground: Colors.white,
        );
      case HProfessionalButtonVariant.success:
        return _ButtonColors(
          background: HTeluguTheme.success,
          foreground: Colors.white,
        );
    }
  }

  _ButtonDimensions _getDimensions(HProfessionalButtonSize size, HResponsive r) {
    switch (size) {
      case HProfessionalButtonSize.small:
        return _ButtonDimensions(
          horizontalPadding: HTokens.sm,
          verticalPadding: HTokens.xs,
          minWidth: 80,
          minHeight: r.isXS ? 36 : 40,
          borderRadius: 8,
        );
      case HProfessionalButtonSize.medium:
        return _ButtonDimensions(
          horizontalPadding: HTokens.md,
          verticalPadding: HTokens.sm,
          minWidth: 120,
          minHeight: r.isXS ? 44 : 48,
          borderRadius: 12,
        );
      case HProfessionalButtonSize.large:
        return _ButtonDimensions(
          horizontalPadding: HTokens.lg,
          verticalPadding: HTokens.md,
          minWidth: 160,
          minHeight: r.isXS ? 52 : 56,
          borderRadius: 16,
        );
      case HProfessionalButtonSize.lg:
        return _ButtonDimensions(
          horizontalPadding: HTokens.lg,
          verticalPadding: HTokens.md,
          minWidth: 160,
          minHeight: r.isXS ? 52 : 56,
          borderRadius: 16,
        );
    }
  }

  double _getFontSize(HProfessionalButtonSize size, HResponsive r) {
    switch (size) {
      case HProfessionalButtonSize.small:
        return r.isXS ? 12 : 14;
      case HProfessionalButtonSize.medium:
        return r.isXS ? 14 : 16;
      case HProfessionalButtonSize.large:
        return r.isXS ? 16 : 18;
      case HProfessionalButtonSize.lg:
        return r.isXS ? 16 : 18;
    }
  }

  double _getIconSize(HProfessionalButtonSize size) {
    switch (size) {
      case HProfessionalButtonSize.small:
        return 16;
      case HProfessionalButtonSize.medium:
        return 18;
      case HProfessionalButtonSize.large:
        return 20;
      case HProfessionalButtonSize.lg:
        return 20;
    }
  }

  Color _getTextColor(HProfessionalButtonVariant variant) {
    return _getColors(variant).foreground;
  }
}

/// Professional Input Field Component
class HProfessionalInput extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;

  const HProfessionalInput({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSuffixTap,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<HProfessionalInput> createState() => _HProfessionalInputState();
}

class _HProfessionalInputState extends State<HProfessionalInput> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            widget.label,
            style: TextStyle(
              fontSize: r.isXS ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: HTeluguTheme.textPrimary,
            ),
          ),
          SizedBox(height: HTokens.xs),
          
          // Input Field
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            validator: widget.validator,
            focusNode: _focusNode,
            style: TextStyle(
              fontSize: r.isXS ? 14 : 16,
              color: HTeluguTheme.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: r.isXS ? 14 : 16,
                color: HTeluguTheme.textSecondary,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused 
                          ? HTeluguTheme.primary 
                          : HTeluguTheme.textSecondary,
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      onPressed: widget.onSuffixTap,
                      icon: Icon(
                        widget.suffixIcon,
                        color: _isFocused 
                            ? HTeluguTheme.primary 
                            : HTeluguTheme.textSecondary,
                        size: 20,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: widget.enabled 
                  ? Colors.white 
                  : Colors.white.withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: HTeluguTheme.textSecondary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: HTeluguTheme.textSecondary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: HTeluguTheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: HTeluguTheme.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: HTeluguTheme.error,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: HTeluguTheme.spacingMD,
                vertical: HTeluguTheme.spacingSM,
              ),
            ),
          ),
        ],
      );
    });
  }
}

/// Professional Card Component
class HProfessionalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const HProfessionalCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      Widget card = Container(
        margin: margin ?? EdgeInsets.all(HTeluguTheme.spacingSM),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: elevation ?? 4,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: (elevation ?? 4) * 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.all(HTokens.lg),
          child: child,
        ),
      );

      if (onTap != null) {
        card = Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: card,
          ),
        );
      }

      return card;
    });
  }
}

/// Professional Loading Indicator
class HProfessionalLoading extends StatelessWidget {
  final String? message;
  final double? size;
  final Color? color;

  const HProfessionalLoading({
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
              width: size ?? (r.isXS ? 32 : 40),
              height: size ?? (r.isXS ? 32 : 40),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? HTeluguTheme.primary,
                ),
              ),
            ),
            if (message != null) ...[
              SizedBox(height: HTokens.md),
              Text(
                message!,
                style: TextStyle(
                  fontSize: r.isXS ? 14 : 16,
                  color: HTeluguTheme.textSecondary,
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

/// Professional Error Widget
class HProfessionalError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const HProfessionalError({
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
          padding: EdgeInsets.all(HTokens.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon ?? Icons.error_outline,
                size: r.isXS ? 48 : 64,
                color: HTeluguTheme.error,
              ),
              SizedBox(height: HTokens.lg),
              Text(
                message,
                style: TextStyle(
                  fontSize: r.isXS ? 16 : 18,
                  color: HTeluguTheme.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                SizedBox(height: HTokens.lg),
                HProfessionalButton(
                  text: 'Try Again',
                  onPressed: onRetry,
                  variant: HProfessionalButtonVariant.outline,
                  icon: Icons.refresh,
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}

// Enums and Helper Classes
enum HProfessionalButtonVariant { primary, secondary, outline, danger, success }
enum HProfessionalButtonSize { small, medium, large, lg }

class _ButtonColors {
  final Color background;
  final Color foreground;

  _ButtonColors({required this.background, required this.foreground});
}

class _ButtonDimensions {
  final double horizontalPadding;
  final double verticalPadding;
  final double minWidth;
  final double minHeight;
  final double borderRadius;

  _ButtonDimensions({
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.minWidth,
    required this.minHeight,
    required this.borderRadius,
  });
}
