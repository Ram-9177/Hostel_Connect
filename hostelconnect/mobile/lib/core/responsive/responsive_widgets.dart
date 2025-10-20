// Comprehensive Responsive Widget System
import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';

/// Responsive Container Widget
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? maxWidth;
  final Alignment? alignment;
  final Color? color;
  final Decoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.maxWidth,
    this.alignment,
    this.color,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? ResponsiveUtils.responsiveCardWidth(context),
      ),
      padding: padding ?? ResponsiveUtils.responsivePadding(context),
      margin: margin,
      alignment: alignment,
      color: color,
      decoration: decoration,
      child: child,
    );
  }
}

/// Responsive Grid Widget
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final double? runSpacing;
  final int? maxColumns;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
    this.maxColumns,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final columns = maxColumns ?? ResponsiveUtils.responsiveColumns(context);
    final spacingValue = spacing ?? ResponsiveUtils.responsiveSpacing(context, base: 16.0);
    final runSpacingValue = runSpacing ?? ResponsiveUtils.responsiveSpacing(context, base: 16.0);

    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children.map((child) => Padding(
          padding: EdgeInsets.only(bottom: runSpacingValue),
          child: child,
        )).toList(),
      );
    }

    return Wrap(
      spacing: spacingValue,
      runSpacing: runSpacingValue,
      alignment: WrapAlignment.start,
      children: children.map((child) => SizedBox(
        width: (MediaQuery.of(context).size.width - spacingValue * (columns - 1)) / columns,
        child: child,
      )).toList(),
    );
  }
}

/// Responsive Text Widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = ResponsiveUtils.responsiveFontSize(
      context,
      base: fontSize ?? 16.0,
    );

    return Text(
      text,
      style: style?.copyWith(
        fontSize: responsiveFontSize,
        fontWeight: fontWeight,
        color: color,
      ) ?? TextStyle(
        fontSize: responsiveFontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive Button Widget
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? fontSize;
  final EdgeInsets? padding;

  const ResponsiveButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = ResponsiveUtils.responsiveFontSize(
      context,
      base: fontSize ?? 16.0,
    );

    final responsivePadding = padding ?? EdgeInsets.symmetric(
      horizontal: ResponsiveUtils.responsiveSpacing(context, base: 24.0),
      vertical: ResponsiveUtils.responsiveSpacing(context, base: 12.0),
    );

    Widget button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading
          ? SizedBox(
              width: responsiveFontSize,
              height: responsiveFontSize,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: responsiveFontSize),
                  SizedBox(width: ResponsiveUtils.responsiveSpacing(context, base: 8.0)),
                ],
                Text(
                  text,
                  style: TextStyle(fontSize: responsiveFontSize),
                ),
              ],
            ),
    );

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return Padding(
      padding: responsivePadding,
      child: button,
    );
  }
}

/// Responsive Card Widget
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.responsivePadding(context);
    final responsiveMargin = margin ?? EdgeInsets.all(
      ResponsiveUtils.responsiveSpacing(context, base: 8.0),
    );

    Widget card = Card(
      elevation: elevation ?? 2.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(
          ResponsiveUtils.responsiveSpacing(context, base: 12.0),
        ),
      ),
      child: Padding(
        padding: responsivePadding,
        child: child,
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(
          ResponsiveUtils.responsiveSpacing(context, base: 12.0),
        ),
        child: card,
      );
    }

    return Container(
      margin: responsiveMargin,
      child: card,
    );
  }
}

/// Responsive Input Field Widget
class ResponsiveInput extends StatelessWidget {
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
  final double? fontSize;

  const ResponsiveInput({
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
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize = ResponsiveUtils.responsiveFontSize(
      context,
      base: fontSize ?? 16.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveText(
          label,
          fontSize: responsiveFontSize * 0.9,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: ResponsiveUtils.responsiveSpacing(context, base: 8.0)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          validator: validator,
          style: TextStyle(fontSize: responsiveFontSize),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: responsiveFontSize,
              color: Theme.of(context).hintColor,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: responsiveFontSize)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(suffixIcon, size: responsiveFontSize),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.responsiveSpacing(context, base: 16.0),
              vertical: ResponsiveUtils.responsiveSpacing(context, base: 12.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.responsiveSpacing(context, base: 8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Responsive Dialog Widget
class ResponsiveDialog extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool scrollable;

  const ResponsiveDialog({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final dialogWidth = ResponsiveUtils.responsiveDialogWidth(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    Widget content = child;
    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.responsiveSpacing(context, base: 16.0),
        ),
      ),
      child: Container(
        width: isMobile ? double.infinity : dialogWidth,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Padding(
                padding: ResponsiveUtils.responsivePadding(context),
                child: ResponsiveText(
                  title!,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(height: 1),
            ],
            Flexible(child: content),
            if (actions != null) ...[
              Divider(height: 1),
              Padding(
                padding: ResponsiveUtils.responsivePadding(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
