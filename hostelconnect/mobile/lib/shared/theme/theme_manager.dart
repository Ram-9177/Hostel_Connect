// lib/shared/theme/theme_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'telugu_theme.dart';
import 'dark_theme.dart';

/// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// Theme manager
class ThemeManager {
  static ThemeData getLightTheme() => HTeluguTheme.lightTheme;
  static ThemeData getDarkTheme() => DarkTheme.darkTheme;
  
  static ThemeData getTheme(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return getLightTheme();
      case ThemeMode.dark:
        return getDarkTheme();
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark
            ? getDarkTheme()
            : getLightTheme();
    }
  }
}

/// Theme toggle widget
class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    
    return IconButton(
      icon: Icon(
        themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () {
        final newMode = themeMode == ThemeMode.dark 
            ? ThemeMode.light 
            : ThemeMode.dark;
        ref.read(themeModeProvider.notifier).state = newMode;
      },
      tooltip: themeMode == ThemeMode.dark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
    );
  }
}

/// Theme-aware widget
class ThemeAwareWidget extends ConsumerWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;
  
  const ThemeAwareWidget({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final theme = ThemeManager.getTheme(context, themeMode);
    
    return builder(context, theme);
  }
}
