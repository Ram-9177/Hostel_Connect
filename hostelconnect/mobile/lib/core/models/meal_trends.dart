// lib/core/models/meal_trends.dart

/// Model for meal trend analytics
class MealTrends {
  final String hostelId;
  final DateTime startDate;
  final DateTime endDate;
  final List<MealTrendDataPoint> dataPoints;
  final MealTrendSummary summary;
  final Map<String, int>? mealTypeBreakdown; // Breakfast, Lunch, Dinner
  final Map<String, double>? satisfactionScores;

  const MealTrends({
    required this.hostelId,
    required this.startDate,
    required this.endDate,
    required this.dataPoints,
    required this.summary,
    this.mealTypeBreakdown,
    this.satisfactionScores,
  });

  Map<String, dynamic> toJson() => {
    'hostelId': hostelId,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'dataPoints': dataPoints.map((dp) => dp.toJson()).toList(),
    'summary': summary.toJson(),
    if (mealTypeBreakdown != null) 'mealTypeBreakdown': mealTypeBreakdown,
    if (satisfactionScores != null) 'satisfactionScores': satisfactionScores,
  };

  factory MealTrends.fromJson(Map<String, dynamic> json) {
    return MealTrends(
      hostelId: json['hostelId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((dp) => MealTrendDataPoint.fromJson(dp as Map<String, dynamic>))
          .toList(),
      summary: MealTrendSummary.fromJson(json['summary'] as Map<String, dynamic>),
      mealTypeBreakdown: json['mealTypeBreakdown'] != null
          ? Map<String, int>.from(json['mealTypeBreakdown'] as Map)
          : null,
      satisfactionScores: json['satisfactionScores'] != null
          ? Map<String, double>.from(json['satisfactionScores'] as Map)
          : null,
    );
  }
}

class MealTrendDataPoint {
  final DateTime date;
  final int totalMeals;
  final int consumed;
  final int wasted;
  final double consumptionRate;
  final double averageRating; // 1-5 scale
  final int feedbackCount;

  const MealTrendDataPoint({
    required this.date,
    required this.totalMeals,
    required this.consumed,
    required this.wasted,
    required this.consumptionRate,
    required this.averageRating,
    required this.feedbackCount,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'totalMeals': totalMeals,
    'consumed': consumed,
    'wasted': wasted,
    'consumptionRate': consumptionRate,
    'averageRating': averageRating,
    'feedbackCount': feedbackCount,
  };

  factory MealTrendDataPoint.fromJson(Map<String, dynamic> json) {
    return MealTrendDataPoint(
      date: DateTime.parse(json['date'] as String),
      totalMeals: json['totalMeals'] as int,
      consumed: json['consumed'] as int,
      wasted: json['wasted'] as int,
      consumptionRate: (json['consumptionRate'] as num).toDouble(),
      averageRating: (json['averageRating'] as num).toDouble(),
      feedbackCount: json['feedbackCount'] as int,
    );
  }
}

class MealTrendSummary {
  final int totalMealsServed;
  final double averageConsumptionRate;
  final double averageSatisfactionRating;
  final int totalWaste;
  final String mostPopularMeal;
  final String leastPopularMeal;
  final String trend; // 'IMPROVING', 'DECLINING', 'STABLE'

  const MealTrendSummary({
    required this.totalMealsServed,
    required this.averageConsumptionRate,
    required this.averageSatisfactionRating,
    required this.totalWaste,
    required this.mostPopularMeal,
    required this.leastPopularMeal,
    required this.trend,
  });

  Map<String, dynamic> toJson() => {
    'totalMealsServed': totalMealsServed,
    'averageConsumptionRate': averageConsumptionRate,
    'averageSatisfactionRating': averageSatisfactionRating,
    'totalWaste': totalWaste,
    'mostPopularMeal': mostPopularMeal,
    'leastPopularMeal': leastPopularMeal,
    'trend': trend,
  };

  factory MealTrendSummary.fromJson(Map<String, dynamic> json) {
    return MealTrendSummary(
      totalMealsServed: json['totalMealsServed'] as int,
      averageConsumptionRate: (json['averageConsumptionRate'] as num).toDouble(),
      averageSatisfactionRating: (json['averageSatisfactionRating'] as num).toDouble(),
      totalWaste: json['totalWaste'] as int,
      mostPopularMeal: json['mostPopularMeal'] as String,
      leastPopularMeal: json['leastPopularMeal'] as String,
      trend: json['trend'] as String,
    );
  }
}
