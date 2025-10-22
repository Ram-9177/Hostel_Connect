// lib/shared/widgets/ui/ios_grade_card.dart
import 'package:flutter/material.dart';
import '../../theme/ios_grade_theme.dart';

class IOSGradeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isElevated;

  const IOSGradeCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.onTap,
    this.isElevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(IOSGradeTheme.spacing2),
      decoration: BoxDecoration(
        color: backgroundColor ?? IOSGradeTheme.cardBackground,
        borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
        border: Border.all(
          color: IOSGradeTheme.borderLight,
          width: 1,
        ),
        boxShadow: isElevated ? IOSGradeTheme.cardShadow : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(IOSGradeTheme.radiusMedium),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(IOSGradeTheme.spacing4),
            child: child,
          ),
        ),
      ),
    );
  }
}

class QuickAccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final String? teluguTitle;

  const QuickAccessCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
    this.teluguTitle,
  });

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                decoration: BoxDecoration(
                  color: (iconColor ?? IOSGradeTheme.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? IOSGradeTheme.primary,
                  size: 24,
                ),
              ),
              const Spacer(),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: IOSGradeTheme.textSecondary,
                ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          if (teluguTitle != null) ...[
            Text(
              teluguTitle!,
              style: IOSGradeTheme.teluguMedium,
            ),
            const SizedBox(height: IOSGradeTheme.spacing1),
          ],
          Text(
            title,
            style: IOSGradeTheme.headline,
          ),
          const SizedBox(height: IOSGradeTheme.spacing1),
          Text(
            subtitle,
            style: IOSGradeTheme.footnote,
          ),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const StatTile({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
                decoration: BoxDecoration(
                  color: (iconColor ?? IOSGradeTheme.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? IOSGradeTheme.primary,
                  size: 20,
                ),
              ),
              const Spacer(),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: IOSGradeTheme.textSecondary,
                ),
            ],
          ),
          const SizedBox(height: IOSGradeTheme.spacing3),
          Text(
            value,
            style: IOSGradeTheme.title2.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: IOSGradeTheme.spacing1),
          Text(
            title,
            style: IOSGradeTheme.callout.copyWith(
              color: IOSGradeTheme.textSecondary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: IOSGradeTheme.spacing1),
            Text(
              subtitle!,
              style: IOSGradeTheme.caption1,
            ),
          ],
        ],
      ),
    );
  }
}

class TeluguToggleTile extends StatelessWidget {
  final String title;
  final String teluguTitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IconData icon;
  final Color? iconColor;

  const TeluguToggleTile({
    super.key,
    required this.title,
    required this.teluguTitle,
    required this.value,
    this.onChanged,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IOSGradeCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(IOSGradeTheme.spacing2),
            decoration: BoxDecoration(
              color: (iconColor ?? IOSGradeTheme.primary).withOpacity(0.1),
              borderRadius: BorderRadius.circular(IOSGradeTheme.radiusSmall),
            ),
            child: Icon(
              icon,
              color: iconColor ?? IOSGradeTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: IOSGradeTheme.spacing3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teluguTitle,
                  style: IOSGradeTheme.teluguMedium,
                ),
                const SizedBox(height: IOSGradeTheme.spacing1),
                Text(
                  title,
                  style: IOSGradeTheme.callout.copyWith(
                    color: IOSGradeTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: IOSGradeTheme.primary,
          ),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const BackButton({
    super.key,
    this.onPressed,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          // Navigate to role home if no history
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      icon: const Icon(Icons.arrow_back_ios),
      iconSize: 20,
    );
  }
}
