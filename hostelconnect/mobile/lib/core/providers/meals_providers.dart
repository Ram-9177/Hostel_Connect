// lib/core/providers/meals_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'load_state.dart';

// Meals list provider
final mealsProvider = StateNotifierProvider<MealsNotifier, PaginationState<Meal>>((ref) {
  return MealsNotifier(ref);
});

// Single meal provider
final mealProvider = StateNotifierProvider.family<MealNotifier, LoadState<Meal>, String>((ref, mealId) {
  return MealNotifier(ref, mealId);
});

// Meal plan provider
final mealPlanProvider = StateNotifierProvider<MealPlanNotifier, LoadState<MealPlan>>((ref) {
  return MealPlanNotifier(ref);
});

// Meal booking provider
final mealBookingProvider = StateNotifierProvider<MealBookingNotifier, LoadState<MealBooking>>((ref) {
  return MealBookingNotifier(ref);
});

// Meal data model
class Meal {
  final String id;
  final String name;
  final String description;
  final String type; // 'breakfast', 'lunch', 'dinner', 'snacks'
  final DateTime date;
  final DateTime servingTime;
  final List<String> items;
  final String status; // 'planned', 'serving', 'completed', 'cancelled'
  final int totalBookings;
  final int maxCapacity;
  final String? chef;
  final Map<String, dynamic> nutritionInfo;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.date,
    required this.servingTime,
    required this.items,
    required this.status,
    required this.totalBookings,
    required this.maxCapacity,
    this.chef,
    required this.nutritionInfo,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'lunch',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      servingTime: DateTime.tryParse(json['servingTime'] ?? '') ?? DateTime.now(),
      items: List<String>.from(json['items'] ?? []),
      status: json['status'] ?? 'planned',
      totalBookings: json['totalBookings'] ?? 0,
      maxCapacity: json['maxCapacity'] ?? 100,
      chef: json['chef'],
      nutritionInfo: Map<String, dynamic>.from(json['nutritionInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'date': date.toIso8601String(),
      'servingTime': servingTime.toIso8601String(),
      'items': items,
      'status': status,
      'totalBookings': totalBookings,
      'maxCapacity': maxCapacity,
      'chef': chef,
      'nutritionInfo': nutritionInfo,
    };
  }

  Meal copyWith({
    String? id,
    String? name,
    String? description,
    String? type,
    DateTime? date,
    DateTime? servingTime,
    List<String>? items,
    String? status,
    int? totalBookings,
    int? maxCapacity,
    String? chef,
    Map<String, dynamic>? nutritionInfo,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      date: date ?? this.date,
      servingTime: servingTime ?? this.servingTime,
      items: items ?? this.items,
      status: status ?? this.status,
      totalBookings: totalBookings ?? this.totalBookings,
      maxCapacity: maxCapacity ?? this.maxCapacity,
      chef: chef ?? this.chef,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
    );
  }

  bool get isAvailable => status == 'serving' && totalBookings < maxCapacity;
  bool get isFullyBooked => totalBookings >= maxCapacity;
  bool get isServing => status == 'serving';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  
  double get bookingPercentage => maxCapacity > 0 ? (totalBookings / maxCapacity) * 100 : 0;
  int get availableSlots => maxCapacity - totalBookings;
}

// Meal plan data model
class MealPlan {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final List<Meal> meals;
  final Map<String, List<Meal>> mealsByDate;
  final String status; // 'draft', 'published', 'active', 'completed'

  const MealPlan({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.meals,
    required this.mealsByDate,
    required this.status,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    final meals = (json['meals'] as List<dynamic>?)
        ?.map((item) => Meal.fromJson(item))
        .toList() ?? [];
    
    final mealsByDate = <String, List<Meal>>{};
    for (final meal in meals) {
      final dateKey = meal.date.toIso8601String().split('T')[0];
      mealsByDate[dateKey] = [...(mealsByDate[dateKey] ?? []), meal];
    }
    
    return MealPlan(
      id: json['id']?.toString() ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
      meals: meals,
      mealsByDate: mealsByDate,
      status: json['status'] ?? 'draft',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'meals': meals.map((meal) => meal.toJson()).toList(),
      'status': status,
    };
  }

  List<Meal> getMealsForDate(DateTime date) {
    final dateKey = date.toIso8601String().split('T')[0];
    return mealsByDate[dateKey] ?? [];
  }

  List<Meal> getMealsForType(String type) {
    return meals.where((meal) => meal.type == type).toList();
  }
}

// Meal booking data model
class MealBooking {
  final String id;
  final String studentId;
  final String mealId;
  final DateTime bookingDate;
  final String status; // 'booked', 'cancelled', 'completed'
  final DateTime? cancellationTime;
  final String? cancellationReason;

  const MealBooking({
    required this.id,
    required this.studentId,
    required this.mealId,
    required this.bookingDate,
    required this.status,
    this.cancellationTime,
    this.cancellationReason,
  });

  factory MealBooking.fromJson(Map<String, dynamic> json) {
    return MealBooking(
      id: json['id']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      mealId: json['mealId']?.toString() ?? '',
      bookingDate: DateTime.tryParse(json['bookingDate'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 'booked',
      cancellationTime: json['cancellationTime'] != null ? DateTime.tryParse(json['cancellationTime']) : null,
      cancellationReason: json['cancellationReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'mealId': mealId,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
      'cancellationTime': cancellationTime?.toIso8601String(),
      'cancellationReason': cancellationReason,
    };
  }

  bool get isBooked => status == 'booked';
  bool get isCancelled => status == 'cancelled';
  bool get isCompleted => status == 'completed';
}

// Notifiers
class MealsNotifier extends StateNotifier<PaginationState<Meal>> {
  final Ref _ref;
  List<Meal> _cachedMeals = [];

  MealsNotifier(this._ref) : super(const PaginationState()) {
    loadMeals();
  }

  Future<void> loadMeals({bool refresh = false}) async {
    if (state.isLoading && !refresh) return;
    
    if (refresh) {
      state = state.copyWith(
        items: [],
        currentPage: 1,
        loadState: const LoadState.loading(),
      );
    } else {
      state = state.copyWith(loadState: const LoadState.loading());
    }
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final mealsData = [
        {
          'id': '1',
          'name': 'South Indian Breakfast',
          'description': 'Traditional South Indian breakfast with idli, dosa, and sambar',
          'type': 'breakfast',
          'date': DateTime.now().toIso8601String(),
          'servingTime': DateTime.now().add(const Duration(hours: 2)).toIso8601String(),
          'items': ['Idli', 'Dosa', 'Sambar', 'Coconut Chutney'],
          'status': 'serving',
          'totalBookings': 45,
          'maxCapacity': 100,
          'chef': 'Chef Ram',
          'nutritionInfo': {'calories': 350, 'protein': 12, 'carbs': 45},
        },
        {
          'id': '2',
          'name': 'North Indian Lunch',
          'description': 'Hearty North Indian lunch with dal, rice, and vegetables',
          'type': 'lunch',
          'date': DateTime.now().toIso8601String(),
          'servingTime': DateTime.now().add(const Duration(hours: 4)).toIso8601String(),
          'items': ['Dal', 'Rice', 'Mixed Vegetables', 'Roti'],
          'status': 'planned',
          'totalBookings': 0,
          'maxCapacity': 120,
          'chef': 'Chef Sita',
          'nutritionInfo': {'calories': 450, 'protein': 18, 'carbs': 60},
        },
      ];
      
      final meals = mealsData.map((json) => Meal.fromJson(json)).toList();
      
      if (refresh) {
        _cachedMeals = meals;
        state = state.copyWith(
          items: meals,
          loadState: LoadState.success(meals),
          hasMore: meals.length >= state.pageSize,
        );
      } else {
        final updatedItems = [...state.items, ...meals];
        _cachedMeals = updatedItems;
        state = state.copyWith(
          items: updatedItems,
          loadState: LoadState.success(updatedItems),
          hasMore: meals.length >= state.pageSize,
          currentPage: state.currentPage + 1,
        );
      }
    } catch (e) {
      state = state.copyWith(
        loadState: LoadState.error('Failed to load meals: ${e.toString()}', previousData: _cachedMeals),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.canLoadMore) return;
    await loadMeals();
  }

  Future<void> refresh() async {
    await loadMeals(refresh: true);
  }

  void clearCache() {
    _cachedMeals = [];
    state = const PaginationState();
  }
}

class MealNotifier extends StateNotifier<LoadState<Meal>> {
  final Ref _ref;
  final String mealId;
  Meal? _cachedMeal;

  MealNotifier(this._ref, this.mealId) : super(const LoadState.idle()) {
    loadMeal();
  }

  Future<void> loadMeal() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // TODO: Implement single meal API
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock data for now
      final meal = Meal(
        id: mealId,
        name: 'Sample Meal',
        description: 'This is a sample meal description.',
        type: 'lunch',
        date: DateTime.now(),
        servingTime: DateTime.now().add(const Duration(hours: 2)),
        items: ['Item 1', 'Item 2', 'Item 3'],
        status: 'serving',
        totalBookings: 50,
        maxCapacity: 100,
        chef: 'Chef Name',
        nutritionInfo: {'calories': 400, 'protein': 15, 'carbs': 50},
      );
      
      _cachedMeal = meal;
      state = LoadState.success(meal);
    } catch (e) {
      state = LoadState.error('Failed to load meal: ${e.toString()}', previousData: _cachedMeal);
    }
  }

  void clearCache() {
    _cachedMeal = null;
    state = const LoadState.idle();
  }
}

class MealPlanNotifier extends StateNotifier<LoadState<MealPlan>> {
  final Ref _ref;
  MealPlan? _cachedMealPlan;

  MealPlanNotifier(this._ref) : super(const LoadState.idle()) {
    loadMealPlan();
  }

  Future<void> loadMealPlan() async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final mealPlan = MealPlan(
        id: 'current_plan',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 7)),
        meals: [],
        mealsByDate: {},
        status: 'active',
      );
      
      _cachedMealPlan = mealPlan;
      state = LoadState.success(mealPlan);
    } catch (e) {
      state = LoadState.error('Failed to load meal plan: ${e.toString()}', previousData: _cachedMealPlan);
    }
  }

  void clearCache() {
    _cachedMealPlan = null;
    state = const LoadState.idle();
  }
}

class MealBookingNotifier extends StateNotifier<LoadState<MealBooking>> {
  final Ref _ref;

  MealBookingNotifier(this._ref) : super(const LoadState.idle());

  Future<void> bookMeal(String mealId) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final booking = MealBooking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentId: 'current_student', // TODO: Get from auth
        mealId: mealId,
        bookingDate: DateTime.now(),
        status: 'booked',
      );
      
      state = LoadState.success(booking);
    } catch (e) {
      state = LoadState.error('Failed to book meal: ${e.toString()}');
    }
  }

  Future<void> cancelBooking(String bookingId, String reason) async {
    if (state.isLoading) return;
    
    state = state.toLoading();
    
    try {
      // Mock data for now
      await Future.delayed(const Duration(seconds: 1));
      
      final booking = MealBooking(
        id: bookingId,
        studentId: 'current_student', // TODO: Get from auth
        mealId: 'meal_id',
        bookingDate: DateTime.now(),
        status: 'cancelled',
        cancellationTime: DateTime.now(),
        cancellationReason: reason,
      );
      
      state = LoadState.success(booking);
    } catch (e) {
      state = LoadState.error('Failed to cancel booking: ${e.toString()}');
    }
  }

  void clearState() {
    state = const LoadState.idle();
  }
}
