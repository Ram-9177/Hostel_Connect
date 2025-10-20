// lib/core/state/app_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_service.dart';
import '../storage/secure_storage.dart';

// User State
class User {
  final String id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String hostelId;
  final String roomId;

  const User({
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.hostelId,
    required this.roomId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      studentId: json['studentId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'],
      hostelId: json['hostelId'],
      roomId: json['roomId'],
    );
  }

  User copyWith({
    String? id,
    String? studentId,
    String? firstName,
    String? lastName,
    String? email,
    String? role,
    String? hostelId,
    String? roomId,
  }) {
    return User(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      hostelId: hostelId ?? this.hostelId,
      roomId: roomId ?? this.roomId,
    );
  }
}

// App State
class AppState {
  final User? user;
  final String? accessToken;
  final String? refreshToken;
  final bool isLoading;
  final String? error;
  final int currentTabIndex;
  final bool isOnline;

  const AppState({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.isLoading = false,
    this.error,
    this.currentTabIndex = 0,
    this.isOnline = true,
  });

  AppState copyWith({
    User? user,
    String? accessToken,
    String? refreshToken,
    bool? isLoading,
    String? error,
    int? currentTabIndex,
    bool? isOnline,
  }) {
    return AppState(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  bool get isLoggedIn => user != null && accessToken != null;
  bool get isStudent => user?.role == 'STUDENT';
  bool get isWarden => user?.role == 'WARDEN';
  bool get isWardenHead => user?.role == 'WARDEN_HEAD';
  bool get isSuperAdmin => user?.role == 'SUPER_ADMIN';
  bool get isChef => user?.role == 'CHEF';
}

// App State Notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState()) {
    _initializeAuth();
  }

  // Initialize authentication on app start
  Future<void> _initializeAuth() async {
    final isLoggedIn = await SecureTokenStorage.isLoggedIn();
    if (isLoggedIn) {
      await _silentRefresh();
    }
  }

  // Public silent refresh method for external calls
  Future<void> silentRefresh() async {
    await _silentRefresh();
  }

  // Silent refresh for persistent sessions
  Future<void> _silentRefresh() async {
    try {
      final refreshToken = await SecureTokenStorage.getRefreshToken();
      if (refreshToken != null) {
        final response = await ApiService.refreshToken(refreshToken);
        await SecureTokenStorage.updateAccessToken(response['accessToken']);
        
        // Update state with stored user data
        final userData = await SecureTokenStorage.getUserData();
        if (userData != null) {
          final user = User.fromJson(userData);
          state = state.copyWith(
            user: user,
            accessToken: response['accessToken'],
            isLoading: false,
            error: null,
          );
        }
      }
    } catch (e) {
      // If refresh fails, clear storage and show login
      await SecureTokenStorage.clearAll();
      state = state.copyWith(
        user: null,
        accessToken: null,
        refreshToken: null,
        isLoading: false,
        error: null,
      );
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await ApiService.login(email: email, password: password);
      
      final user = User.fromJson(response['user']);
      
      // Store tokens securely for persistent session
      await SecureTokenStorage.storeTokens(
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
        userData: response['user'],
      );
      
      state = state.copyWith(
        user: user,
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
        isLoading: false,
        error: null,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
    } on NetworkException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Network error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  Future<void> register({
    required String studentId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String roomId,
    required String hostelId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await ApiService.register(
        studentId: studentId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        password: password,
        roomId: roomId,
        hostelId: hostelId,
      );
      
      final user = User.fromJson(response['user']);
      
      state = state.copyWith(
        user: user,
        accessToken: response['accessToken'],
        refreshToken: response['refreshToken'],
        isLoading: false,
        error: null,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
    } on NetworkException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Network error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
    }
  }

  Future<void> logout() async {
    // Clear secure storage
    await SecureTokenStorage.clearAll();
    
    // Reset state
    state = const AppState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void setCurrentTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }

  void setOnlineStatus(bool online) {
    state = state.copyWith(isOnline: online);
  }

  Future<void> refreshAccessToken() async {
    if (state.refreshToken == null) return;
    
    try {
      final response = await ApiService.refreshToken(state.refreshToken!);
      state = state.copyWith(accessToken: response['accessToken']);
    } catch (e) {
      // If refresh fails, logout user
      logout();
    }
  }
}

// Providers
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

final userProvider = Provider<User?>((ref) {
  return ref.watch(appStateProvider).user;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isLoading;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(appStateProvider).error;
});

final currentTabProvider = Provider<int>((ref) {
  return ref.watch(appStateProvider).currentTabIndex;
});

final isOnlineProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isOnline;
});
