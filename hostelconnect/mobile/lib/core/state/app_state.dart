// lib/core/state/app_state.dart - FIXED IMPORTS
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_service.dart';

/// App state model
class AppState {
  final bool isAuthenticated;
  final bool isLoading;
  final bool isOnline;
  final User? user;
  final String? error;
  final int currentTabIndex;

  const AppState({
    required this.isAuthenticated,
    required this.isLoading,
    required this.isOnline,
    this.user,
    this.error,
    this.currentTabIndex = 0,
  });

  factory AppState.initial() {
    return const AppState(
      isAuthenticated: false,
      isLoading: true,
      isOnline: true,
    );
  }

  AppState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    bool? isOnline,
    User? user,
    String? error,
    int? currentTabIndex,
  }) {
    return AppState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      isOnline: isOnline ?? this.isOnline,
      user: user ?? this.user,
      error: error ?? this.error,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.isAuthenticated == isAuthenticated &&
        other.isLoading == isLoading &&
        other.isOnline == isOnline &&
        other.user == user &&
        other.error == error &&
        other.currentTabIndex == currentTabIndex;
  }

  @override
  int get hashCode {
    return Object.hash(
      isAuthenticated,
      isLoading,
      isOnline,
      user,
      error,
      currentTabIndex,
    );
  }
}

/// App state notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState.initial()) {
    _initialize();
  }

  void _initialize() {
    // Initialize app state
    state = state.copyWith(isLoading: false);
  }

  void setUser(User user) {
    state = state.copyWith(
      user: user,
      isAuthenticated: true,
      error: null,
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setOnline(bool online) {
    state = state.copyWith(isOnline: online);
  }

  void setError(String error) {
    state = state.copyWith(error: error);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void logout() {
    state = AppState.initial();
  }

  void setCurrentTab(int index) {
    state = state.copyWith(currentTabIndex: index);
  }
}

/// App state provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

/// User model
class User {
  final String id;
  final String email;
  final String role;
  final String? hostelId;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? roomId;
  final String? bedNumber;

  const User({
    required this.id,
    required this.email,
    required this.role,
    this.hostelId,
    this.firstName,
    this.lastName,
    this.phone,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.roomId,
    this.bedNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'student',
      hostelId: json['hostelId']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      phone: json['phone']?.toString(),
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt'].toString()) : null,
      roomId: json['roomId']?.toString(),
      bedNumber: json['bedNumber']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'hostelId': hostelId,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'roomId': roomId,
      'bedNumber': bedNumber,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.role == role;
  }

  @override
  int get hashCode => Object.hash(id, email, role);
}