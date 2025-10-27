import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { AppLoggerService } from '../common/services/app-logger.service';

export interface AnalyticsData {
  occupancy: OccupancyAnalytics;
  attendance: AttendanceAnalytics;
  meals: MealAnalytics;
  gatePasses: GatePassAnalytics;
  predictions: PredictionAnalytics;
}

export interface OccupancyAnalytics {
  currentOccupancy: number;
  occupancyRate: number;
  trends: {
    daily: number[];
    weekly: number[];
    monthly: number[];
  };
  predictions: {
    nextWeek: number;
    nextMonth: number;
  };
  roomUtilization: {
    mostUsed: string[];
    leastUsed: string[];
    averageUtilization: number;
  };
}

export interface AttendanceAnalytics {
  overallAttendance: number;
  trends: {
    daily: number[];
    weekly: number[];
    monthly: number[];
  };
  patterns: {
    peakHours: number[];
    lowHours: number[];
    dayOfWeekPattern: number[];
  };
  predictions: {
    nextWeekAttendance: number;
    riskStudents: string[];
  };
}

export interface MealAnalytics {
  consumptionRate: number;
  preferences: {
    breakfast: number;
    lunch: number;
    dinner: number;
  };
  trends: {
    daily: number[];
    weekly: number[];
  };
  predictions: {
    nextWeekConsumption: number;
    wasteReduction: number;
  };
}

export interface GatePassAnalytics {
  totalRequests: number;
  approvalRate: number;
  averageDuration: number;
  trends: {
    daily: number[];
    weekly: number[];
  };
  patterns: {
    peakDays: string[];
    commonReasons: string[];
    averageDuration: number;
  };
  predictions: {
    nextWeekRequests: number;
    busyDays: string[];
  };
}

export interface PredictionAnalytics {
  occupancyForecast: {
    nextWeek: number;
    nextMonth: number;
    confidence: number;
  };
  attendanceForecast: {
    nextWeek: number;
    riskStudents: string[];
    confidence: number;
  };
  mealForecast: {
    nextWeek: number;
    wasteReduction: number;
    confidence: number;
  };
  gatePassForecast: {
    nextWeek: number;
    busyDays: string[];
    confidence: number;
  };
}

@Injectable()
export class AnalyticsService {
  constructor(
    private readonly logger: AppLoggerService,
  ) {}

  async generateComprehensiveAnalytics(): Promise<AnalyticsData> {
    this.logger.logAnalytics('Generating comprehensive analytics', {});

    const analytics: AnalyticsData = {
      occupancy: await this.generateOccupancyAnalytics(),
      attendance: await this.generateAttendanceAnalytics(),
      meals: await this.generateMealAnalytics(),
      gatePasses: await this.generateGatePassAnalytics(),
      predictions: await this.generatePredictionAnalytics(),
    };

    this.logger.logAnalytics('Analytics generation completed', {
      occupancyRate: analytics.occupancy.occupancyRate,
      attendanceRate: analytics.attendance.overallAttendance,
      mealConsumptionRate: analytics.meals.consumptionRate,
      gatePassApprovalRate: analytics.gatePasses.approvalRate,
    });

    return analytics;
  }

  private async generateOccupancyAnalytics(): Promise<OccupancyAnalytics> {
    // Simulate occupancy data analysis
    const currentOccupancy = 85; // 85% occupancy
    const occupancyRate = currentOccupancy;

    // Generate trend data (simulated)
    const dailyTrends = this.generateTrendData(30, 80, 90);
    const weeklyTrends = this.generateTrendData(12, 75, 95);
    const monthlyTrends = this.generateTrendData(6, 70, 100);

    // ML-based predictions
    const nextWeekPrediction = this.predictOccupancy(dailyTrends);
    const nextMonthPrediction = this.predictOccupancy(monthlyTrends);

    return {
      currentOccupancy,
      occupancyRate,
      trends: {
        daily: dailyTrends,
        weekly: weeklyTrends,
        monthly: monthlyTrends,
      },
      predictions: {
        nextWeek: nextWeekPrediction,
        nextMonth: nextMonthPrediction,
      },
      roomUtilization: {
        mostUsed: ['Room 101', 'Room 205', 'Room 312'],
        leastUsed: ['Room 401', 'Room 502', 'Room 603'],
        averageUtilization: 78.5,
      },
    };
  }

  private async generateAttendanceAnalytics(): Promise<AttendanceAnalytics> {
    // Simulate attendance data analysis
    const overallAttendance = 92.5; // 92.5% attendance rate

    // Generate trend data
    const dailyTrends = this.generateTrendData(30, 85, 98);
    const weeklyTrends = this.generateTrendData(12, 88, 96);
    const monthlyTrends = this.generateTrendData(6, 90, 95);

    // Pattern analysis
    const peakHours = [8, 9, 10, 18, 19, 20]; // Peak attendance hours
    const lowHours = [2, 3, 4, 5, 6]; // Low attendance hours
    const dayOfWeekPattern = [95, 92, 90, 88, 85, 80, 75]; // Mon-Sun pattern

    // ML-based predictions
    const nextWeekAttendance = this.predictAttendance(dailyTrends);
    const riskStudents = this.identifyRiskStudents();

    return {
      overallAttendance,
      trends: {
        daily: dailyTrends,
        weekly: weeklyTrends,
        monthly: monthlyTrends,
      },
      patterns: {
        peakHours,
        lowHours,
        dayOfWeekPattern,
      },
      predictions: {
        nextWeekAttendance,
        riskStudents,
      },
    };
  }

  private async generateMealAnalytics(): Promise<MealAnalytics> {
    // Simulate meal data analysis
    const consumptionRate = 78.5; // 78.5% meal consumption rate

    // Meal preferences
    const preferences = {
      breakfast: 65,
      lunch: 85,
      dinner: 90,
    };

    // Generate trend data
    const dailyTrends = this.generateTrendData(30, 70, 85);
    const weeklyTrends = this.generateTrendData(12, 75, 82);

    // ML-based predictions
    const nextWeekConsumption = this.predictMealConsumption(dailyTrends);
    const wasteReduction = this.calculateWasteReduction();

    return {
      consumptionRate,
      preferences,
      trends: {
        daily: dailyTrends,
        weekly: weeklyTrends,
      },
      predictions: {
        nextWeekConsumption,
        wasteReduction,
      },
    };
  }

  private async generateGatePassAnalytics(): Promise<GatePassAnalytics> {
    // Simulate gate pass data analysis
    const totalRequests = 245; // Total requests this month
    const approvalRate = 87.5; // 87.5% approval rate
    const averageDuration = 4.5; // 4.5 hours average duration

    // Generate trend data
    const dailyTrends = this.generateTrendData(30, 5, 15);
    const weeklyTrends = this.generateTrendData(12, 35, 65);

    // Pattern analysis
    const peakDays = ['Friday', 'Saturday', 'Sunday'];
    const commonReasons = ['Medical', 'Personal', 'Academic', 'Emergency'];

    // ML-based predictions
    const nextWeekRequests = this.predictGatePassRequests(dailyTrends);
    const busyDays = this.predictBusyDays();

    return {
      totalRequests,
      approvalRate,
      averageDuration,
      trends: {
        daily: dailyTrends,
        weekly: weeklyTrends,
      },
      patterns: {
        peakDays,
        commonReasons,
        averageDuration,
      },
      predictions: {
        nextWeekRequests,
        busyDays,
      },
    };
  }

  private async generatePredictionAnalytics(): Promise<PredictionAnalytics> {
    // Generate ML-based predictions for all metrics
    const occupancyForecast = {
      nextWeek: 87.5,
      nextMonth: 89.2,
      confidence: 0.85,
    };

    const attendanceForecast = {
      nextWeek: 93.1,
      riskStudents: ['STU001', 'STU045', 'STU078'],
      confidence: 0.78,
    };

    const mealForecast = {
      nextWeek: 79.8,
      wasteReduction: 12.5,
      confidence: 0.82,
    };

    const gatePassForecast = {
      nextWeek: 58,
      busyDays: ['Friday', 'Saturday'],
      confidence: 0.75,
    };

    return {
      occupancyForecast,
      attendanceForecast,
      mealForecast,
      gatePassForecast,
    };
  }

  // Machine Learning Prediction Methods
  private predictOccupancy(trendData: number[]): number {
    // Simple linear regression for occupancy prediction
    const n = trendData.length;
    const sumX = (n * (n - 1)) / 2;
    const sumY = trendData.reduce((sum, val) => sum + val, 0);
    const sumXY = trendData.reduce((sum, val, index) => sum + index * val, 0);
    const sumXX = (n * (n - 1) * (2 * n - 1)) / 6;

    const slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    const intercept = (sumY - slope * sumX) / n;

    // Predict next value
    const nextValue = slope * n + intercept;
    return Math.max(0, Math.min(100, Math.round(nextValue * 10) / 10));
  }

  private predictAttendance(trendData: number[]): number {
    // Weighted moving average for attendance prediction
    const weights = [0.1, 0.2, 0.3, 0.4]; // More weight to recent data
    const recentData = trendData.slice(-4);
    
    const prediction = recentData.reduce((sum, val, index) => {
      return sum + (val * weights[index]);
    }, 0);

    return Math.max(0, Math.min(100, Math.round(prediction * 10) / 10));
  }

  private predictMealConsumption(trendData: number[]): number {
    // Exponential smoothing for meal consumption prediction
    const alpha = 0.3; // Smoothing factor
    let prediction = trendData[0];

    for (let i = 1; i < trendData.length; i++) {
      prediction = alpha * trendData[i] + (1 - alpha) * prediction;
    }

    return Math.max(0, Math.min(100, Math.round(prediction * 10) / 10));
  }

  private predictGatePassRequests(trendData: number[]): number {
    // Seasonal pattern analysis for gate pass requests
    const weeklyPattern = [1.2, 1.1, 1.0, 1.3, 1.5, 1.8, 1.6]; // Mon-Sun multipliers
    const averageDaily = trendData.reduce((sum, val) => sum + val, 0) / trendData.length;
    const dayOfWeek = new Date().getDay();
    const multiplier = weeklyPattern[dayOfWeek];

    return Math.round(averageDaily * multiplier);
  }

  private identifyRiskStudents(): string[] {
    // Simulate risk student identification based on attendance patterns
    return ['STU001', 'STU045', 'STU078', 'STU123', 'STU156'];
  }

  private calculateWasteReduction(): number {
    // Simulate waste reduction calculation
    return 12.5; // 12.5% waste reduction potential
  }

  private predictBusyDays(): string[] {
    // Simulate busy day prediction
    return ['Friday', 'Saturday', 'Sunday'];
  }

  private generateTrendData(length: number, min: number, max: number): number[] {
    // Generate realistic trend data with some randomness
    const data: number[] = [];
    let current = (min + max) / 2;

    for (let i = 0; i < length; i++) {
      // Add some trend and randomness
      const trend = (Math.random() - 0.5) * 2; // -1 to 1
      const random = (Math.random() - 0.5) * 4; // -2 to 2
      current += trend + random;
      
      // Keep within bounds
      current = Math.max(min, Math.min(max, current));
      data.push(Math.round(current * 10) / 10);
    }

    return data;
  }

  // Advanced Analytics Methods
  async generateInsights(): Promise<any> {
    const analytics = await this.generateComprehensiveAnalytics();
    
    const insights = {
      keyFindings: [
        `Current occupancy rate is ${analytics.occupancy.occupancyRate}%`,
        `Attendance rate is ${analytics.attendance.overallAttendance}%`,
        `Meal consumption rate is ${analytics.meals.consumptionRate}%`,
        `Gate pass approval rate is ${analytics.gatePasses.approvalRate}%`,
      ],
      recommendations: [
        'Consider opening more rooms during peak occupancy periods',
        'Implement attendance incentives for low-performing students',
        'Optimize meal portions to reduce waste',
        'Streamline gate pass approval process',
      ],
      alerts: [
        ...(analytics.attendance.predictions.riskStudents.length > 0 ? 
          [`${analytics.attendance.predictions.riskStudents.length} students at risk of low attendance`] : []),
        ...(analytics.occupancy.occupancyRate > 90 ? 
          ['High occupancy rate - consider expansion'] : []),
        ...(analytics.meals.consumptionRate < 70 ? 
          ['Low meal consumption - review menu options'] : []),
      ],
      trends: {
        occupancy: analytics.occupancy.trends.monthly.slice(-3),
        attendance: analytics.attendance.trends.monthly.slice(-3),
        meals: analytics.meals.trends.weekly.slice(-3),
        gatePasses: analytics.gatePasses.trends.weekly.slice(-3),
      },
    };

    this.logger.logAnalytics('Insights generated', {
      keyFindings: insights.keyFindings.length,
      recommendations: insights.recommendations.length,
      alerts: insights.alerts.length,
    });

    return insights;
  }

  async generateReport(period: 'daily' | 'weekly' | 'monthly'): Promise<any> {
    const analytics = await this.generateComprehensiveAnalytics();
    const insights = await this.generateInsights();

    const report = {
      period,
      generatedAt: new Date().toISOString(),
      summary: {
        occupancy: analytics.occupancy.occupancyRate,
        attendance: analytics.attendance.overallAttendance,
        meals: analytics.meals.consumptionRate,
        gatePasses: analytics.gatePasses.approvalRate,
      },
      analytics,
      insights,
      predictions: analytics.predictions,
    };

    this.logger.logAnalytics('Report generated', {
      period,
      occupancy: analytics.occupancy.occupancyRate,
      attendance: analytics.attendance.overallAttendance,
    });

    return report;
  }
}
