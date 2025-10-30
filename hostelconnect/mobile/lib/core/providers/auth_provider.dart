import 'package:flutter_riverpod/flutter_riverpod.dart';

// Temporary auth provider shim used during cleanup.
final authProvider = Provider<dynamic>((ref) => null);

// For compatibility with code that expects authStateProvider
final authStateProvider = StateProvider<bool>((ref) => false);
