// lib/shared/widgets/navigation.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import 'ui/button.dart';

class HNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<HNavItem> items;

  const HNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      if (r.isXS || r.isSM) {
        return _buildBottomNavigation(r);
      } else {
        return _buildNavigationRail(r);
      }
    });
  }

  Widget _buildBottomNavigation(HResponsive r) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: HTokens.surface,
      indicatorColor: HTokens.primary.withOpacity(0.1),
      destinations: items.map((item) => NavigationDestination(
        icon: Icon(item.icon),
        selectedIcon: Icon(item.selectedIcon ?? item.icon),
        label: item.label,
      )).toList(),
    );
  }

  Widget _buildNavigationRail(HResponsive r) {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: HTokens.surface,
      indicatorColor: HTokens.primary.withOpacity(0.1),
      labelType: r.isLG || r.isXL ? NavigationRailLabelType.all : NavigationRailLabelType.selected,
      destinations: items.map((item) => NavigationRailDestination(
        icon: Icon(item.icon),
        selectedIcon: Icon(item.selectedIcon ?? item.icon),
        label: Text(item.label),
      )).toList(),
    );
  }
}

class HNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final String route;

  const HNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    required this.route,
  });
}

class HAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const HAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: r.isXS ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor ?? HTokens.primary,
        foregroundColor: foregroundColor ?? Colors.white,
        centerTitle: centerTitle,
        leading: leading,
        actions: actions,
        elevation: 0,
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class HPage extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigation;
  final Widget? navigationRail;
  final PreferredSizeWidget? appBar;
  final bool showAppBar;
  final EdgeInsets? padding;

  const HPage({
    super.key,
    required this.body,
    this.bottomNavigation,
    this.navigationRail,
    this.appBar,
    this.showAppBar = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final isWide = r.size.index >= HSize.lg.index;
      final maxContentWidth = r.size == HSize.xl ? 1200.0 : double.infinity;
      
      final nav = isWide ? navigationRail : bottomNavigation;
      final showNav = nav != null;

      return Scaffold(
        appBar: showAppBar ? appBar : null,
        body: SafeArea(
          child: Row(
            children: [
              if (isWide && showNav) nav!,
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Padding(
                      padding: padding ?? EdgeInsets.symmetric(
                        horizontal: HSpacing.responsive(r, 
                          xs: HTokens.sm, 
                          sm: HTokens.md, 
                          md: HTokens.lg, 
                          lg: HTokens.xl, 
                          xl: HTokens.xl
                        ),
                        vertical: HTokens.md,
                      ),
                      child: body,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: !isWide && showNav ? nav : null,
      );
    });
  }
}
