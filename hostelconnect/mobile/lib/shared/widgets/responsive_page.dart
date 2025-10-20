// lib/shared/widgets/responsive_page.dart
import 'package:flutter/material.dart';
import '../../core/responsive.dart';

class HPage extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigation;
  final Widget? navigationRail;
  final Widget? appBar;
  final bool showAppBar;

  const HPage({
    super.key,
    required this.body,
    this.bottomNavigation,
    this.navigationRail,
    this.appBar,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      final isWide = r.size.index >= HSize.lg.index;
      final maxContentWidth = r.size == HSize.xl ? 1100.0 : double.infinity;
      
      final nav = isWide ? navigationRail : bottomNavigation;
      final showNav = nav != null;

      return Scaffold(
        appBar: showAppBar && !isWide ? appBar as PreferredSizeWidget? : null,
        body: SafeArea(
          child: Row(
            children: [
              if (isWide && showNav) nav!,
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
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

// Bottom Navigation for phones
class HBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<HNavItem> items;

  const HBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        destinations: items.map((item) => NavigationDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon ?? item.icon),
          label: item.label,
        )).toList(),
      );
    });
  }
}

// Navigation Rail for tablets/desktop
class HNavRail extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<HNavItem> items;

  const HNavRail({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return NavigationRail(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        labelType: r.size == HSize.xl ? NavigationRailLabelType.all : NavigationRailLabelType.selected,
        destinations: items.map((item) => NavigationRailDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon ?? item.icon),
          label: Text(item.label),
        )).toList(),
      );
    });
  }
}

class HNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const HNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}
