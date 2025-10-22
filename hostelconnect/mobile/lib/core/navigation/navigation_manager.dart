import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostelconnect/core/responsive.dart';
import 'package:hostelconnect/shared/theme/telugu_theme.dart';

class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static NavigatorState get navigator => navigatorKey.currentState!;
  
  static void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, arguments: arguments);
  }
  
  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigator.pushReplacementNamed(routeName, arguments: arguments);
  }
  
  static void pop([dynamic result]) {
    if (navigator.canPop()) {
      navigator.pop(result);
    }
  }
  
  static void popUntil(String routeName) {
    navigator.popUntil(ModalRoute.withName(routeName));
  }
  
  static void popToRoot() {
    navigator.popUntil((route) => route.isFirst);
  }
  
  static bool canPop() {
    return navigator.canPop();
  }
}

class BackButtonHandler extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final String? backButtonLabel;

  const BackButtonHandler({
    super.key,
    required this.child,
    this.onBackPressed,
    this.showBackButton = true,
    this.backButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _handleBackPress(context);
        }
      },
      child: child,
    );
  }

  void _handleBackPress(BuildContext context) {
    if (onBackPressed != null) {
      onBackPressed!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // Handle app exit
      SystemNavigator.pop();
    }
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      backgroundColor: backgroundColor ?? HTeluguTheme.primary,
      foregroundColor: foregroundColor ?? Colors.white,
      elevation: elevation,
      centerTitle: centerTitle,
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    if (!Navigator.of(context).canPop() && onBackPressed == null) {
      return null;
    }

    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      tooltip: 'Go back',
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BreadcrumbNavigation extends StatelessWidget {
  final List<String> breadcrumbs;
  final Function(int)? onBreadcrumbTap;

  const BreadcrumbNavigation({
    super.key,
    required this.breadcrumbs,
    this.onBreadcrumbTap,
  });

  @override
  Widget build(BuildContext context) {
    return HResponsive.builder(builder: (ctx, r) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: HTeluguTheme.surface,
          border: Border(
            bottom: BorderSide(
              color: HTeluguTheme.onSurfaceVariant.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.home,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: breadcrumbs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final breadcrumb = entry.value;
                    final isLast = index == breadcrumbs.length - 1;

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: onBreadcrumbTap != null ? () => onBreadcrumbTap!(index) : null,
                          child: Text(
                            breadcrumb,
                            style: HTeluguTheme.bodySmall.copyWith(
                              color: isLast 
                                ? HTeluguTheme.primary 
                                : HTeluguTheme.onSurfaceVariant,
                              fontWeight: isLast ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (!isLast) ...[
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        ],
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class NavigationDrawer extends StatelessWidget {
  final List<NavigationItem> items;
  final String? headerTitle;
  final Widget? headerWidget;
  final Function(NavigationItem)? onItemTap;

  const NavigationDrawer({
    super.key,
    required this.items,
    this.headerTitle,
    this.headerWidget,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
                  onTap: () {
                    Navigator.of(context).pop();
                    onItemTap?.call(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HTeluguTheme.primary,
            HTeluguTheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: headerWidget ?? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            headerTitle ?? 'HostelConnect',
            style: HTeluguTheme.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Navigation Menu',
            style: HTeluguTheme.bodyMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final String? subtitle;
  final String route;
  final Map<String, dynamic>? arguments;

  const NavigationItem({
    required this.title,
    required this.icon,
    this.subtitle,
    required this.route,
    this.arguments,
  });
}

class FloatingActionButtonWithBack extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final String? tooltip;
  final IconData? icon;

  const FloatingActionButtonWithBack({
    super.key,
    required this.child,
    this.onPressed,
    this.tooltip,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: onPressed,
            tooltip: tooltip,
            child: icon != null ? Icon(icon) : const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
