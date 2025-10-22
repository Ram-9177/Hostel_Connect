// lib/core/providers/auth_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_service.dart';
import '../api/auth_api_service.dart';
import '../config/environment.dart';
import 'load_state.dart';

// Auth state provider (already exists, but enhanced)
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

// Session provider for current user session
final sessionProvider = Provider<SessionState>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return SessionState(
    isAuthenticated: authState.isAuthenticated,
    user: authState.user,
    isLoading: authState.isLoading,
    error: authState.error,
  );
});

// User profile provider with caching
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, LoadState<User>>((ref) {
  return UserProfileNotifier(ref);
});

// Login state provider
final loginStateProvider = StateNotifierProvider<LoginNotifier, LoadState<LoginResult>>((ref) {
  return LoginNotifier(ref);
});

// Logout state provider
final logoutStateProvider = StateNotifierProvider<LogoutNotifier, LoadState<void>>((ref) {
  return LogoutNotifier(ref);
});

// Token refresh provider
final tokenRefreshProvider = StateNotifierProvider<TokenRefreshNotifier, LoadState<TokenRefreshResult>>((ref) {
  return TokenRefreshNotifier(ref);
});

// Data models
class SessionState {
  final bool isAuthenticated;
  final User? user;
  final bool isLoading;
  final String? error;

  const SessionState({
    required this.isAuthenticated,
    this.user,
    required this.isLoading,
    this.error,
  });
}

class LoginResult {
  final User user;
  final String accessToken;
  final String refreshToken;

  const LoginResult({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}

class TokenRefreshResult {
  final String accessToken;
  final String refreshToken;

  const TokenRefreshResult({
    required this.accessToken,
    required this.refreshToken,
  });
}

// Notifiers
class UserProfileNotifier extends StateNotifier<LoadState<User>> {
  final Ref _ref;
  User? _cachedUser;

  UserProfileNotifier(this._ref) : super(const LoadState.idle()) {
    _initialize();
  }

  void _initialize() {
    final authState = _ref.read(authStateProvider);
    if (authState.isAuthenticated && authState.user != null) {
      _cachedUser = authState.user;
      state = LoadState.success(authState.user!);
    }
  }

  Future<void> loadProfile() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      final authApiService = _ref.read(authApiServiceProvider);
      final response = await authApiService.getProfile();
      
      final user = User.fromJson(response);
      _cachedUser = user;
      state = LoadState.success(user);
    } catch (e) {
      state = LoadState.error('Failed to load profile: ${e.toString()}', previousData: _cachedUser);
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // TODO: Implement profile update API
      await Future.delayed(const Duration(seconds: 1));
      
      final currentUser = state.data;
      if (currentUser != null) {
        final updatedUser = User(
          id: currentUser.id,
          email: updates['email'] ?? currentUser.email,
          role: updates['role'] ?? currentUser.role,
          hostelId: updates['hostelId'] ?? currentUser.hostelId,
          firstName: updates['firstName'] ?? currentUser.firstName,
          lastName: updates['lastName'] ?? currentUser.lastName,
          roomId: updates['roomId'] ?? currentUser.roomId,
          bedNumber: updates['bedNumber'] ?? currentUser.bedNumber,
        );
        
        _cachedUser = updatedUser;
        state = LoadState.success(updatedUser);
      }
    } catch (e) {
      state = LoadState.error('Failed to update profile: ${e.toString()}', previousData: _cachedUser);
    }
  }

  void clearCache() {
    _cachedUser = null;
    state = const LoadState.idle();
  }
}

class LoginNotifier extends StateNotifier<LoadState<LoginResult>> {
  final Ref _ref;

  LoginNotifier(this._ref) : super(const LoadState.idle());

  Future<void> login(String email, String password) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      final authNotifier = _ref.read(authStateProvider.notifier);
      await authNotifier.login(email, password);
      
      final authState = _ref.read(authStateProvider);
      if (authState.isAuthenticated && authState.user != null) {
        final result = LoginResult(
          user: authState.user!,
          accessToken: 'mock_token', // TODO: Get from auth state
          refreshToken: 'mock_refresh_token', // TODO: Get from auth state
        );
        state = LoadState.success(result);
      } else {
        state = LoadState.error(authState.error ?? 'Login failed');
      }
    } catch (e) {
      state = LoadState.error('Login failed: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}

class LogoutNotifier extends StateNotifier<LoadState<void>> {
  final Ref _ref;

  LogoutNotifier(this._ref) : super(const LoadState.idle());

  Future<void> logout() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      final authNotifier = _ref.read(authStateProvider.notifier);
      await authNotifier.logout();
      
      state = const LoadState.success(null);
    } catch (e) {
      state = LoadState.error('Logout failed: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}

class TokenRefreshNotifier extends StateNotifier<LoadState<TokenRefreshResult>> {
  final Ref _ref;

  TokenRefreshNotifier(this._ref) : super(const LoadState.idle());

  Future<void> refreshToken() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      final authNotifier = _ref.read(authStateProvider.notifier);
      await authNotifier.refresh();
      
      // TODO: Get actual tokens from auth state
      final result = TokenRefreshResult(
        accessToken: 'refreshed_token',
        refreshToken: 'refreshed_refresh_token',
      );
      state = LoadState.success(result);
    } catch (e) {
      state = LoadState.error('Token refresh failed: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}
