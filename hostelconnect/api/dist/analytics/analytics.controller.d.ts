import { AnalyticsService } from './analytics.service';
export declare class AnalyticsController {
    private readonly analyticsService;
    constructor(analyticsService: AnalyticsService);
    getComprehensiveAnalytics(): Promise<import("./analytics.service").AnalyticsData>;
    getInsights(): Promise<any>;
    generateReport(period?: 'daily' | 'weekly' | 'monthly'): Promise<any>;
    getOccupancyAnalytics(): Promise<import("./analytics.service").OccupancyAnalytics>;
    getAttendanceAnalytics(): Promise<import("./analytics.service").AttendanceAnalytics>;
    getMealAnalytics(): Promise<import("./analytics.service").MealAnalytics>;
    getGatePassAnalytics(): Promise<import("./analytics.service").GatePassAnalytics>;
    getPredictions(): Promise<import("./analytics.service").PredictionAnalytics>;
}
