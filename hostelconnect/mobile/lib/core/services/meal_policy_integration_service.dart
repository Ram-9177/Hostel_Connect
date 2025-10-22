// lib/core/services/meal_policy_integration_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_models.dart';
import '../providers/policy_providers.dart';
import '../shared/widgets/ui/toast.dart';

final mealPolicyIntegrationServiceProvider = Provider((ref) => MealPolicyIntegrationService(ref));

class MealPolicyIntegrationService {
  final Ref _ref;

  MealPolicyIntegrationService(this._ref);

  // Get meal cutoff times from policy
  Future<Map<String, TimeOfDay>> getMealCutoffTimes(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        final policy = policyState.data!;
        return {
          'breakfast': policy.breakfastCutoff,
          'lunch': policy.lunchCutoff,
          'dinner': policy.dinnerCutoff,
        };
      } else {
        // Return default cutoff times if policy not available
        return {
          'breakfast': const TimeOfDay(hour: 9, minute: 0),
          'lunch': const TimeOfDay(hour: 14, minute: 0),
          'dinner': const TimeOfDay(hour: 20, minute: 0),
        };
      }
    } catch (e) {
      Toast.showError('Error loading meal cutoff times: $e');
      // Return default cutoff times on error
      return {
        'breakfast': const TimeOfDay(hour: 9, minute: 0),
        'lunch': const TimeOfDay(hour: 14, minute: 0),
        'dinner': const TimeOfDay(hour: 20, minute: 0),
      };
    }
  }

  // Get forecast buffer percentage from policy
  Future<int> getForecastBufferPercentage(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        return policyState.data!.forecastBufferPercentage;
      } else {
        return 10; // Default 10% buffer
      }
    } catch (e) {
      Toast.showError('Error loading forecast buffer: $e');
      return 10; // Default 10% buffer
    }
  }

  // Get advance booking days from policy
  Future<int> getAdvanceBookingDays(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        return policyState.data!.advanceBookingDays;
      } else {
        return 1; // Default 1 day advance booking
      }
    } catch (e) {
      Toast.showError('Error loading advance booking days: $e');
      return 1; // Default 1 day advance booking
    }
  }

  // Check if late booking is allowed
  Future<bool> isLateBookingAllowed(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        return policyState.data!.allowLateBooking;
      } else {
        return false; // Default: late booking not allowed
      }
    } catch (e) {
      Toast.showError('Error loading late booking policy: $e');
      return false; // Default: late booking not allowed
    }
  }

  // Get meal timing information for display
  Future<Map<String, dynamic>> getMealTimingInfo(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        final policy = policyState.data!;
        return {
          'breakfastCutoff': policy.breakfastCutoff.to12HourFormat(),
          'lunchCutoff': policy.lunchCutoff.to12HourFormat(),
          'dinnerCutoff': policy.dinnerCutoff.to12HourFormat(),
          'forecastBuffer': '${policy.forecastBufferPercentage}%',
          'advanceBookingDays': policy.advanceBookingDays,
          'allowLateBooking': policy.allowLateBooking,
          'timezone': 'IST', // Could be made configurable
        };
      } else {
        return {
          'breakfastCutoff': '9:00 AM',
          'lunchCutoff': '2:00 PM',
          'dinnerCutoff': '8:00 PM',
          'forecastBuffer': '10%',
          'advanceBookingDays': 1,
          'allowLateBooking': false,
          'timezone': 'IST',
        };
      }
    } catch (e) {
      Toast.showError('Error loading meal timing info: $e');
      return {
        'breakfastCutoff': '9:00 AM',
        'lunchCutoff': '2:00 PM',
        'dinnerCutoff': '8:00 PM',
        'forecastBuffer': '10%',
        'advanceBookingDays': 1,
        'allowLateBooking': false,
        'timezone': 'IST',
      };
    }
  }

  // Check if current time is past cutoff for a specific meal
  Future<bool> isPastCutoff(String hostelId, String mealType) async {
    try {
      final cutoffTimes = await getMealCutoffTimes(hostelId);
      final cutoffTime = cutoffTimes[mealType.toLowerCase()];
      
      if (cutoffTime != null) {
        final now = DateTime.now();
        final cutoffDateTime = cutoffTime.toDateTimeToday();
        return now.isAfter(cutoffDateTime);
      }
      
      return false;
    } catch (e) {
      Toast.showError('Error checking cutoff time: $e');
      return false;
    }
  }

  // Get time remaining until cutoff
  Future<Duration?> getTimeUntilCutoff(String hostelId, String mealType) async {
    try {
      final cutoffTimes = await getMealCutoffTimes(hostelId);
      final cutoffTime = cutoffTimes[mealType.toLowerCase()];
      
      if (cutoffTime != null) {
        final now = DateTime.now();
        final cutoffDateTime = cutoffTime.toDateTimeToday();
        
        if (now.isBefore(cutoffDateTime)) {
          return cutoffDateTime.difference(now);
        }
      }
      
      return null;
    } catch (e) {
      Toast.showError('Error calculating time until cutoff: $e');
      return null;
    }
  }

  // Format cutoff time for display with timezone
  String formatCutoffTime(TimeOfDay cutoffTime, String timezone) {
    return '${cutoffTime.to12HourFormat()} $timezone';
  }

  // Get policy-based meal forecast calculation
  Future<int> calculateMealForecast(String hostelId, int baseForecast, String mealType) async {
    try {
      final bufferPercentage = await getForecastBufferPercentage(hostelId);
      final bufferAmount = (baseForecast * bufferPercentage / 100).round();
      return baseForecast + bufferAmount;
    } catch (e) {
      Toast.showError('Error calculating meal forecast: $e');
      return baseForecast; // Return base forecast without buffer
    }
  }

  // Validate meal booking against policy
  Future<Map<String, dynamic>> validateMealBooking(String hostelId, String mealType, DateTime bookingTime) async {
    try {
      final cutoffTimes = await getMealCutoffTimes(hostelId);
      final cutoffTime = cutoffTimes[mealType.toLowerCase()];
      final allowLateBooking = await isLateBookingAllowed(hostelId);
      
      if (cutoffTime != null) {
        final cutoffDateTime = cutoffTime.toDateTimeToday();
        final isPastCutoff = bookingTime.isAfter(cutoffDateTime);
        
        return {
          'isValid': !isPastCutoff || allowLateBooking,
          'isPastCutoff': isPastCutoff,
          'cutoffTime': cutoffTime.to12HourFormat(),
          'allowLateBooking': allowLateBooking,
          'message': isPastCutoff && !allowLateBooking 
              ? 'Booking is past cutoff time (${cutoffTime.to12HourFormat()})'
              : 'Booking is valid',
        };
      }
      
      return {
        'isValid': true,
        'isPastCutoff': false,
        'cutoffTime': null,
        'allowLateBooking': allowLateBooking,
        'message': 'Booking is valid',
      };
    } catch (e) {
      Toast.showError('Error validating meal booking: $e');
      return {
        'isValid': false,
        'isPastCutoff': false,
        'cutoffTime': null,
        'allowLateBooking': false,
        'message': 'Error validating booking',
      };
    }
  }

  // Get dietary restrictions from policy
  Future<Map<String, dynamic>> getDietaryRestrictions(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        return policyState.data!.dietaryRestrictions;
      } else {
        return {}; // No restrictions by default
      }
    } catch (e) {
      Toast.showError('Error loading dietary restrictions: $e');
      return {}; // No restrictions on error
    }
  }

  // Get meal timings from policy
  Future<Map<String, dynamic>> getMealTimings(String hostelId) async {
    try {
      final mealPolicyNotifier = _ref.read(mealPolicyProvider(hostelId));
      final policyState = mealPolicyNotifier.state;
      
      if (policyState.state == LoadState.success && policyState.data != null) {
        return policyState.data!.mealTimings;
      } else {
        return {
          'breakfast': {'start': '7:00 AM', 'end': '9:00 AM'},
          'lunch': {'start': '12:00 PM', 'end': '2:00 PM'},
          'dinner': {'start': '7:00 PM', 'end': '9:00 PM'},
        };
      }
    } catch (e) {
      Toast.showError('Error loading meal timings: $e');
      return {
        'breakfast': {'start': '7:00 AM', 'end': '9:00 AM'},
        'lunch': {'start': '12:00 PM', 'end': '2:00 PM'},
        'dinner': {'start': '7:00 PM', 'end': '9:00 PM'},
      };
    }
  }
}
