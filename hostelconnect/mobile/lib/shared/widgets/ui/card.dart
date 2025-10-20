// lib/shared/widgets/ui/card.dart
import 'package:flutter/material.dart';
import '../../../core/responsive.dart';

class HCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;

  const HCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final card = Card(
        elevation: elevation ?? 1,
        color: backgroundColor ?? HTokens.surface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(HTokens.cardRadius),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.all(HTokens.lg),
          child: child,
        ),
      );

      if (onTap != null) {
        return GestureDetector(
          onTap: onTap,
          child: card,
        );
      }

      return Container(
        margin: margin,
        child: card,
      );
    });
  }
}

class HCardHeader extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const HCardHeader({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: HTokens.md),
      child: child,
    );
  }
}

class HCardTitle extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const HCardTitle({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Text(
        text,
        style: style ?? TextStyle(
          fontSize: r.isXS ? 16 : 18,
          fontWeight: FontWeight.w600,
          color: HTokens.onSurface,
        ),
      );
    });
  }
}

class HCardDescription extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const HCardDescription({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Text(
        text,
        style: style ?? TextStyle(
          fontSize: r.isXS ? 12 : 14,
          color: HTokens.onSurfaceVariant,
        ),
      );
    });
  }
}

class HCardContent extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const HCardContent({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: child,
    );
  }
}

class HCardFooter extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const HCardFooter({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(top: HTokens.md),
      child: child,
    );
  }
}
