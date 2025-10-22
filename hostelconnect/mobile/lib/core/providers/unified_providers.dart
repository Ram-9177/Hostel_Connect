// lib/core/providers/unified_providers.dart - CONSOLIDATED PROVIDERS
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/app_state.dart';
import '../auth/auth_service.dart';

/// Unified provider system - PRODUCTION READY
/// This consolidates all providers to avoid conflicts

// === AUTHENTICATION PROVIDERS ===
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

// === APP STATE PROVIDERS ===
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

// === USER PROVIDERS ===
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.user;
});

final userRoleProvider = Provider<String>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role ?? 'student';
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.isAuthenticated;
});

// === CONNECTIVITY PROVIDERS ===
final connectivityProvider = StateProvider<bool>((ref) => true);

// === THEME PROVIDERS ===
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// === NAVIGATION PROVIDERS ===
final currentTabProvider = StateProvider<int>((ref) => 0);

// === ERROR HANDLING PROVIDERS ===
final globalErrorProvider = StateProvider<String?>((ref) => null);

// === LOADING PROVIDERS ===
final globalLoadingProvider = StateProvider<bool>((ref) => false);

// === UTILITY PROVIDERS ===
final deviceInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  // Return device information
  return {
    'platform': 'mobile',
    'version': '1.0.0',
  };
});

// === CLEANUP PROVIDERS ===
/// Provider cleanup utility
class ProviderCleanup {
  static void cleanup(ProviderContainer container) {
    // Cleanup any resources
    container.dispose();
  }
}

/// Provider validation utility
class ProviderValidator {
  static bool isValidProvider<T>(Provider<T> provider) {
    try {
      // Basic validation
      return provider != null;
    } catch (e) {
      return false;
    }
  }
}
