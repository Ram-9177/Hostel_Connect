// lib/shared/widgets/ui/modern_card.dart
import 'package:flutter/material.dart';
import '../../theme/modern_theme.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool isElevated;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius,
    this.onTap,
    this.isElevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(ModernTheme.spacing8),
      decoration: BoxDecoration(
        color: backgroundColor ?? ModernTheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(ModernTheme.radius16),
        border: Border.all(
          color: ModernTheme.borderLight,
          width: 1,
        ),
        boxShadow: isElevated ? (boxShadow ?? ModernTheme.shadowSmall) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(ModernTheme.radius16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(ModernTheme.spacing16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ModernStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const ModernStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ModernTheme.spacing8),
                decoration: BoxDecoration(
                  color: (iconColor ?? ModernTheme.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ModernTheme.radius8),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? ModernTheme.primary,
                  size: 20,
                ),
              ),
              const Spacer(),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: ModernTheme.textTertiary,
                ),
            ],
          ),
          const SizedBox(height: ModernTheme.spacing12),
          Text(
            value,
            style: ModernTheme.displaySmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: ModernTheme.spacing4),
          Text(
            title,
            style: ModernTheme.bodyMedium.copyWith(
              color: ModernTheme.textSecondary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: ModernTheme.spacing4),
            Text(
              subtitle!,
              style: ModernTheme.bodySmall.copyWith(
                color: ModernTheme.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ModernActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ModernActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.iconColor,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ModernTheme.spacing12),
            decoration: BoxDecoration(
              color: (iconColor ?? ModernTheme.primary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(ModernTheme.radius12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? ModernTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: ModernTheme.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ModernTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: ModernTheme.spacing4),
                Text(
                  description,
                  style: ModernTheme.bodySmall.copyWith(
                    color: ModernTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: ModernTheme.spacing8),
            trailing!,
          ] else if (onTap != null)
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ModernTheme.textTertiary,
            ),
        ],
      ),
    );
  }
}
