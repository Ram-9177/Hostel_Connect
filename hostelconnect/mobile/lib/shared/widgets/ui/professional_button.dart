// lib/shared/widgets/ui/professional_button.dart
import 'package:flutter/material.dart';
import '../../theme/telugu_theme.dart';

enum HProfessionalButtonVariant {
  primary,
  secondary,
  outline,
  danger,
}

enum HProfessionalButtonSize {
  sm,
  md,
  lg,
  xl,
}

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
    this.size = HProfessionalButtonSize.md,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final dimensions = _getDimensions();
    
    Widget buttonChild = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: dimensions.iconSize,
            height: dimensions.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == HProfessionalButtonVariant.outline 
                  ? HTeluguTheme.primary 
                  : Colors.white,
              ),
            ),
          )
        else if (icon != null)
          Icon(
            icon,
            size: dimensions.iconSize,
            color: colors.iconColor,
          ),
        if ((isLoading || icon != null) && text.isNotEmpty)
          SizedBox(width: dimensions.spacing),
        if (text.isNotEmpty)
          Text(
            text,
            style: TextStyle(
              fontSize: dimensions.fontSize,
              fontWeight: FontWeight.w600,
              color: colors.textColor,
            ),
          ),
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: dimensions.height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.backgroundColor,
          foregroundColor: colors.textColor,
          elevation: variant == HProfessionalButtonVariant.outline ? 0 : 2,
          shadowColor: colors.backgroundColor?.withOpacity(0.3),
          side: variant == HProfessionalButtonVariant.outline
              ? BorderSide(color: HTeluguTheme.primary, width: 1.5)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensions.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: dimensions.horizontalPadding,
            vertical: dimensions.verticalPadding,
          ),
        ),
        child: buttonChild,
      ),
    );
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case HProfessionalButtonVariant.primary:
        return _ButtonColors(
          backgroundColor: HTeluguTheme.primary,
          textColor: Colors.white,
          iconColor: Colors.white,
        );
      case HProfessionalButtonVariant.secondary:
        return _ButtonColors(
          backgroundColor: HTeluguTheme.secondary,
          textColor: Colors.white,
          iconColor: Colors.white,
        );
      case HProfessionalButtonVariant.outline:
        return _ButtonColors(
          backgroundColor: Colors.transparent,
          textColor: HTeluguTheme.primary,
          iconColor: HTeluguTheme.primary,
        );
      case HProfessionalButtonVariant.danger:
        return _ButtonColors(
          backgroundColor: HTeluguTheme.error,
          textColor: Colors.white,
          iconColor: Colors.white,
        );
    }
  }

  _ButtonDimensions _getDimensions() {
    switch (size) {
      case HProfessionalButtonSize.sm:
        return _ButtonDimensions(
          height: 32,
          fontSize: 12,
          iconSize: 16,
          spacing: 6,
          horizontalPadding: 12,
          verticalPadding: 6,
          borderRadius: 6,
        );
      case HProfessionalButtonSize.md:
        return _ButtonDimensions(
          height: 40,
          fontSize: 14,
          iconSize: 18,
          spacing: 8,
          horizontalPadding: 16,
          verticalPadding: 8,
          borderRadius: 8,
        );
      case HProfessionalButtonSize.lg:
        return _ButtonDimensions(
          height: 48,
          fontSize: 16,
          iconSize: 20,
          spacing: 10,
          horizontalPadding: 20,
          verticalPadding: 12,
          borderRadius: 10,
        );
      case HProfessionalButtonSize.xl:
        return _ButtonDimensions(
          height: 56,
          fontSize: 18,
          iconSize: 22,
          spacing: 12,
          horizontalPadding: 24,
          verticalPadding: 16,
          borderRadius: 12,
        );
    }
  }
}

class _ButtonColors {
  final Color? backgroundColor;
  final Color textColor;
  final Color iconColor;

  _ButtonColors({
    this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });
}

class _ButtonDimensions {
  final double height;
  final double fontSize;
  final double iconSize;
  final double spacing;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderRadius;

  _ButtonDimensions({
    required this.height,
    required this.fontSize,
    required this.iconSize,
    required this.spacing,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.borderRadius,
  });
}
