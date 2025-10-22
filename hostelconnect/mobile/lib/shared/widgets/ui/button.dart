// lib/shared/widgets/ui/button.dart
import 'package:flutter/material.dart';
import '../../../core/responsive.dart';

enum HButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

enum HButtonSize {
  sm,
  md,
  lg,
}

class HButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final HButtonVariant variant;
  final HButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const HButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = HButtonVariant.primary,
    this.size = HButtonSize.md,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final colors = _getColors();
      final dimensions = _getDimensions(r);
      
      return SizedBox(
        width: fullWidth ? double.infinity : null,
        height: dimensions.height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.backgroundColor,
            foregroundColor: colors.foregroundColor,
            side: colors.border != null ? BorderSide(color: colors.border!) : null,
            elevation: variant == HButtonVariant.primary ? 2 : 0,
            padding: EdgeInsets.symmetric(
              horizontal: dimensions.horizontalPadding,
              vertical: dimensions.verticalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(HTokens.cardRadius),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.foregroundColor),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: dimensions.iconSize),
                      SizedBox(width: HTokens.sm),
                    ],
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: dimensions.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case HButtonVariant.primary:
        return _ButtonColors(
          backgroundColor: HTokens.primary,
          foregroundColor: Colors.white,
        );
      case HButtonVariant.secondary:
        return _ButtonColors(
          backgroundColor: HTokens.secondary,
          foregroundColor: Colors.white,
        );
      case HButtonVariant.outline:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          foregroundColor: HTokens.primary,
          border: HTokens.primary,
        );
      case HButtonVariant.ghost:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          foregroundColor: HTokens.onSurface,
        );
      case HButtonVariant.destructive:
        return _ButtonColors(
          backgroundColor: HTokens.error,
          foregroundColor: Colors.white,
        );
    }
  }

  _ButtonDimensions _getDimensions(HResponsive r) {
    switch (size) {
      case HButtonSize.sm:
        return _ButtonDimensions(
          height: 32,
          horizontalPadding: HTokens.md,
          verticalPadding: HTokens.sm,
          fontSize: r.isXS ? 12 : 14,
          iconSize: 16,
        );
      case HButtonSize.md:
        return _ButtonDimensions(
          height: 40,
          horizontalPadding: HTokens.lg,
          verticalPadding: HTokens.md,
          fontSize: r.isXS ? 14 : 16,
          iconSize: 18,
        );
      case HButtonSize.lg:
        return _ButtonDimensions(
          height: 48,
          horizontalPadding: HTokens.xl,
          verticalPadding: HTokens.lg,
          fontSize: r.isXS ? 16 : 18,
          iconSize: 20,
        );
    }
  }
}

class _ButtonColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? border;

  _ButtonColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.border,
  });
}

class _ButtonDimensions {
  final double height;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double iconSize;

  _ButtonDimensions({
    required this.height,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.fontSize,
    required this.iconSize,
  });
}
