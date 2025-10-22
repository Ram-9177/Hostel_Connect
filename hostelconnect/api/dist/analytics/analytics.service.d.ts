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
export declare class AnalyticsService {
    private readonly logger;
    constructor(logger: AppLoggerService);
    generateComprehensiveAnalytics(): Promise<AnalyticsData>;
    private generateOccupancyAnalytics;
    private generateAttendanceAnalytics;
    private generateMealAnalytics;
    private generateGatePassAnalytics;
    private generatePredictionAnalytics;
    private predictOccupancy;
    private predictAttendance;
    private predictMealConsumption;
    private predictGatePassRequests;
    private identifyRiskStudents;
    private calculateWasteReduction;
    private predictBusyDays;
    private generateTrendData;
    generateInsights(): Promise<any>;
    generateReport(period: 'daily' | 'weekly' | 'monthly'): Promise<any>;
}
