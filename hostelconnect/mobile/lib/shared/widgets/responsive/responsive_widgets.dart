// lib/shared/widgets/responsive/responsive_widgets.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';

/// Responsive wrapper widget
class ResponsiveWrapper extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  
  const ResponsiveWrapper({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.responsive(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

/// Responsive grid widget
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry? padding;
  
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = HTokens.md,
    this.runSpacing = HTokens.md,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final columns = HResponsive.responsiveColumns(context);
    
    return Padding(
      padding: padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: spacing,
          mainAxisSpacing: runSpacing,
          childAspectRatio: 1.2,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

/// Responsive list widget
class ResponsiveList extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  
  const ResponsiveList({
    super.key,
    required this.children,
    this.spacing = HTokens.md,
    this.padding,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context)),
      physics: physics,
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Responsive container widget
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? maxWidth;
  final AlignmentGeometry? alignment;
  
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.maxWidth,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerMaxWidth = maxWidth ?? (HResponsive.isDesktop(context) ? 1200 : screenWidth);
    
    return Container(
      width: double.infinity,
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: containerMaxWidth),
        child: Container(
          padding: padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context)),
          margin: margin,
          child: child,
        ),
      ),
    );
  }
}

/// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final responsiveStyle = baseStyle?.copyWith(
      fontSize: HResponsive.responsiveDouble(
        context,
        mobile: baseStyle?.fontSize ?? 14.0,
        tablet: (baseStyle?.fontSize ?? 14.0) * 1.1,
        desktop: (baseStyle?.fontSize ?? 14.0) * 1.2,
      ),
    );
    
    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive button widget
class ResponsiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  
  const ResponsiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? HResponsive.responsivePadding(
      context,
      mobile: const EdgeInsets.symmetric(horizontal: HTokens.lg, vertical: HTokens.md),
      tablet: const EdgeInsets.symmetric(horizontal: HTokens.xl, vertical: HTokens.lg),
      desktop: const EdgeInsets.symmetric(horizontal: HTokens.xxl, vertical: HTokens.lg),
    );
    
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Padding(
        padding: responsivePadding,
        child: child,
      ),
    );
  }
}

/// Responsive card widget
class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? color;
  
  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context));
    final responsiveMargin = margin ?? EdgeInsets.all(HResponsive.responsiveSpacing(context) * 0.5);
    
    return Card(
      elevation: elevation ?? (HResponsive.isDesktop(context) ? 4.0 : 2.0),
      color: color,
      margin: responsiveMargin,
      child: Padding(
        padding: responsivePadding,
        child: child,
      ),
    );
  }
}

/// Responsive app bar widget
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double? elevation;
  
  const ResponsiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ResponsiveText(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: HResponsive.responsiveDouble(
            context,
            mobile: 18.0,
            tablet: 20.0,
            desktop: 22.0,
          ),
        ),
      ),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      elevation: elevation ?? (HResponsive.isDesktop(context) ? 4.0 : 0.0),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Responsive drawer widget
class ResponsiveDrawer extends StatelessWidget {
  final List<Widget> children;
  final Widget? header;
  final EdgeInsetsGeometry? padding;
  
  const ResponsiveDrawer({
    super.key,
    required this.children,
    this.header,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context));
    
    return Drawer(
      child: Column(
        children: [
          if (header != null) header!,
          Expanded(
            child: Padding(
              padding: responsivePadding,
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive bottom sheet widget
class ResponsiveBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? maxHeight;
  
  const ResponsiveBottomSheet({
    super.key,
    required this.child,
    this.padding,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final responsiveMaxHeight = maxHeight ?? (HResponsive.isDesktop(context) ? screenHeight * 0.6 : screenHeight * 0.8);
    final responsivePadding = padding ?? EdgeInsets.all(HResponsive.responsiveSpacing(context));
    
    return Container(
      constraints: BoxConstraints(maxHeight: responsiveMaxHeight),
      child: Padding(
        padding: responsivePadding,
        child: child,
      ),
    );
  }
}
