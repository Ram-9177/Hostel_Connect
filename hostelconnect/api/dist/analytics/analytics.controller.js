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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AnalyticsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const analytics_service_1 = require("./analytics.service");
let AnalyticsController = class AnalyticsController {
    constructor(analyticsService) {
        this.analyticsService = analyticsService;
    }
    async getComprehensiveAnalytics() {
        return this.analyticsService.generateComprehensiveAnalytics();
    }
    async getInsights() {
        return this.analyticsService.generateInsights();
    }
    async generateReport(period = 'weekly') {
        return this.analyticsService.generateReport(period);
    }
    async getOccupancyAnalytics() {
        const analytics = await this.analyticsService.generateComprehensiveAnalytics();
        return analytics.occupancy;
    }
    async getAttendanceAnalytics() {
        const analytics = await this.analyticsService.generateComprehensiveAnalytics();
        return analytics.attendance;
    }
    async getMealAnalytics() {
        const analytics = await this.analyticsService.generateComprehensiveAnalytics();
        return analytics.meals;
    }
    async getGatePassAnalytics() {
        const analytics = await this.analyticsService.generateComprehensiveAnalytics();
        return analytics.gatePasses;
    }
    async getPredictions() {
        const analytics = await this.analyticsService.generateComprehensiveAnalytics();
        return analytics.predictions;
    }
};
exports.AnalyticsController = AnalyticsController;
__decorate([
    (0, common_1.Get)('comprehensive'),
    (0, swagger_1.ApiOperation)({ summary: 'Get comprehensive analytics data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Comprehensive analytics retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getComprehensiveAnalytics", null);
__decorate([
    (0, common_1.Get)('insights'),
    (0, swagger_1.ApiOperation)({ summary: 'Get analytics insights and recommendations' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Analytics insights retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getInsights", null);
__decorate([
    (0, common_1.Get)('report'),
    (0, swagger_1.ApiOperation)({ summary: 'Generate analytics report' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Analytics report generated successfully' }),
    __param(0, (0, common_1.Query)('period')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "generateReport", null);
__decorate([
    (0, common_1.Get)('occupancy'),
    (0, swagger_1.ApiOperation)({ summary: 'Get occupancy analytics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Occupancy analytics retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getOccupancyAnalytics", null);
__decorate([
    (0, common_1.Get)('attendance'),
    (0, swagger_1.ApiOperation)({ summary: 'Get attendance analytics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Attendance analytics retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getAttendanceAnalytics", null);
__decorate([
    (0, common_1.Get)('meals'),
    (0, swagger_1.ApiOperation)({ summary: 'Get meal analytics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Meal analytics retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getMealAnalytics", null);
__decorate([
    (0, common_1.Get)('gatepasses'),
    (0, swagger_1.ApiOperation)({ summary: 'Get gate pass analytics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate pass analytics retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getGatePassAnalytics", null);
__decorate([
    (0, common_1.Get)('predictions'),
    (0, swagger_1.ApiOperation)({ summary: 'Get ML predictions' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'ML predictions retrieved successfully' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AnalyticsController.prototype, "getPredictions", null);
exports.AnalyticsController = AnalyticsController = __decorate([
    (0, swagger_1.ApiTags)('Analytics'),
    (0, common_1.Controller)('analytics'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [analytics_service_1.AnalyticsService])
], AnalyticsController);
//# sourceMappingURL=analytics.controller.js.map