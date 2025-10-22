"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnalyticsService = void 0;
const common_1 = require("@nestjs/common");
const app_logger_service_1 = require("../common/services/app-logger.service");
let AnalyticsService = class AnalyticsService {
    constructor(logger) {
        this.logger = logger;
    }
    async generateComprehensiveAnalytics() {
        this.logger.logAnalytics('Generating comprehensive analytics', {});
        const analytics = {
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
    async generateOccupancyAnalytics() {
        const currentOccupancy = 85;
        const occupancyRate = currentOccupancy;
        const dailyTrends = this.generateTrendData(30, 80, 90);
        const weeklyTrends = this.generateTrendData(12, 75, 95);
        const monthlyTrends = this.generateTrendData(6, 70, 100);
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
    async generateAttendanceAnalytics() {
        const overallAttendance = 92.5;
        const dailyTrends = this.generateTrendData(30, 85, 98);
        const weeklyTrends = this.generateTrendData(12, 88, 96);
        const monthlyTrends = this.generateTrendData(6, 90, 95);
        const peakHours = [8, 9, 10, 18, 19, 20];
        const lowHours = [2, 3, 4, 5, 6];
        const dayOfWeekPattern = [95, 92, 90, 88, 85, 80, 75];
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
    async generateMealAnalytics() {
        const consumptionRate = 78.5;
        const preferences = {
            breakfast: 65,
            lunch: 85,
            dinner: 90,
        };
        const dailyTrends = this.generateTrendData(30, 70, 85);
        const weeklyTrends = this.generateTrendData(12, 75, 82);
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
    async generateGatePassAnalytics() {
        const totalRequests = 245;
        const approvalRate = 87.5;
        const averageDuration = 4.5;
        const dailyTrends = this.generateTrendData(30, 5, 15);
        const weeklyTrends = this.generateTrendData(12, 35, 65);
        const peakDays = ['Friday', 'Saturday', 'Sunday'];
        const commonReasons = ['Medical', 'Personal', 'Academic', 'Emergency'];
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
    async generatePredictionAnalytics() {
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
    predictOccupancy(trendData) {
        const n = trendData.length;
        const sumX = (n * (n - 1)) / 2;
        const sumY = trendData.reduce((sum, val) => sum + val, 0);
        const sumXY = trendData.reduce((sum, val, index) => sum + index * val, 0);
        const sumXX = (n * (n - 1) * (2 * n - 1)) / 6;
        const slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
        const intercept = (sumY - slope * sumX) / n;
        const nextValue = slope * n + intercept;
        return Math.max(0, Math.min(100, Math.round(nextValue * 10) / 10));
    }
    predictAttendance(trendData) {
        const weights = [0.1, 0.2, 0.3, 0.4];
        const recentData = trendData.slice(-4);
        const prediction = recentData.reduce((sum, val, index) => {
            return sum + (val * weights[index]);
        }, 0);
        return Math.max(0, Math.min(100, Math.round(prediction * 10) / 10));
    }
    predictMealConsumption(trendData) {
        const alpha = 0.3;
        let prediction = trendData[0];
        for (let i = 1; i < trendData.length; i++) {
            prediction = alpha * trendData[i] + (1 - alpha) * prediction;
        }
        return Math.max(0, Math.min(100, Math.round(prediction * 10) / 10));
    }
    predictGatePassRequests(trendData) {
        const weeklyPattern = [1.2, 1.1, 1.0, 1.3, 1.5, 1.8, 1.6];
        const averageDaily = trendData.reduce((sum, val) => sum + val, 0) / trendData.length;
        const dayOfWeek = new Date().getDay();
        const multiplier = weeklyPattern[dayOfWeek];
        return Math.round(averageDaily * multiplier);
    }
    identifyRiskStudents() {
        return ['STU001', 'STU045', 'STU078', 'STU123', 'STU156'];
    }
    calculateWasteReduction() {
        return 12.5;
    }
    predictBusyDays() {
        return ['Friday', 'Saturday', 'Sunday'];
    }
    generateTrendData(length, min, max) {
        const data = [];
        let current = (min + max) / 2;
        for (let i = 0; i < length; i++) {
            const trend = (Math.random() - 0.5) * 2;
            const random = (Math.random() - 0.5) * 4;
            current += trend + random;
            current = Math.max(min, Math.min(max, current));
            data.push(Math.round(current * 10) / 10);
        }
        return data;
    }
    async generateInsights() {
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
    async generateReport(period) {
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
};
exports.AnalyticsService = AnalyticsService;
exports.AnalyticsService = AnalyticsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [app_logger_service_1.AppLoggerService])
], AnalyticsService);
//# sourceMappingURL=analytics.service.js.map