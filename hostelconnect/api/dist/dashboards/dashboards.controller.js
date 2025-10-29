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
exports.DashboardsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const passport_1 = require("@nestjs/passport");
const dashboards_service_1 = require("./dashboards.service");
let DashboardsController = class DashboardsController {
    constructor(dashboardsService) {
        this.dashboardsService = dashboardsService;
    }
    async getHostelLive() {
        return this.dashboardsService.getHostelLive();
    }
    async getHostelLiveById(hostelId) {
        const result = await this.dashboardsService.getHostelLive(hostelId);
        return result[0] || null;
    }
    async getAttendanceSessionSummary(sessionId) {
        return this.dashboardsService.getAttendanceSessionSummary(sessionId);
    }
    async getGateFunnel(hostelId, days) {
        return this.dashboardsService.getGateFunnel(hostelId, days ? parseInt(days.toString()) : 7);
    }
    async getMealForecast(hostelId, days) {
        return this.dashboardsService.getMealForecast(hostelId, days ? parseInt(days.toString()) : 7);
    }
    async getMonthlyAnalytics(hostelId, month) {
        return this.dashboardsService.getMonthlyAnalytics(hostelId, month);
    }
    async getRoomOccupancy(hostelId) {
        return this.dashboardsService.getRoomOccupancy(hostelId);
    }
    async refreshViews() {
        await this.dashboardsService.refreshMaterializedViews();
        return { message: 'Materialized views refreshed successfully' };
    }
    async getStudentDashboard(req) {
        return this.dashboardsService.getStudentDashboard(req.user?.id);
    }
    async getStudentDashboardById(id) {
        return this.dashboardsService.getStudentDashboard(id);
    }
    async getWardenDashboard(req) {
        return this.dashboardsService.getWardenDashboard(req.user?.id);
    }
    async getWardenHeadDashboard(req) {
        return this.dashboardsService.getWardenHeadDashboard(req.user?.id);
    }
    async getAdminDashboard(req) {
        return this.dashboardsService.getAdminDashboard(req.user?.id);
    }
    async getChefDashboard(req) {
        return this.dashboardsService.getChefDashboard(req.user?.id);
    }
    async getSecurityDashboard(req) {
        return this.dashboardsService.getSecurityDashboard(req.user?.id);
    }
    async getGlobalStats() {
        return this.dashboardsService.getGlobalStats();
    }
};
exports.DashboardsController = DashboardsController;
__decorate([
    (0, common_1.Get)('hostel-live'),
    (0, swagger_1.ApiOperation)({ summary: 'Get live hostel dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Live dashboard data retrieved' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getHostelLive", null);
__decorate([
    (0, common_1.Get)('hostel-live/:hostelId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get live dashboard data for specific hostel' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Hostel live data retrieved' }),
    __param(0, (0, common_1.Param)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getHostelLiveById", null);
__decorate([
    (0, common_1.Get)('attendance/session/:sessionId'),
    (0, swagger_1.ApiOperation)({ summary: 'Get attendance session summary' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Attendance session summary retrieved' }),
    __param(0, (0, common_1.Param)('sessionId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getAttendanceSessionSummary", null);
__decorate([
    (0, common_1.Get)('gate/funnel'),
    (0, swagger_1.ApiOperation)({ summary: 'Get gate pass funnel data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Gate funnel data retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __param(1, (0, common_1.Query)('days')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Number]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getGateFunnel", null);
__decorate([
    (0, common_1.Get)('meals/forecast'),
    (0, swagger_1.ApiOperation)({ summary: 'Get meal forecast data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Meal forecast data retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __param(1, (0, common_1.Query)('days')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Number]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getMealForecast", null);
__decorate([
    (0, common_1.Get)('monthly'),
    (0, swagger_1.ApiOperation)({ summary: 'Get monthly analytics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Monthly analytics retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __param(1, (0, common_1.Query)('month')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, String]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getMonthlyAnalytics", null);
__decorate([
    (0, common_1.Get)('rooms/occupancy'),
    (0, swagger_1.ApiOperation)({ summary: 'Get room occupancy data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Room occupancy data retrieved' }),
    __param(0, (0, common_1.Query)('hostelId')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getRoomOccupancy", null);
__decorate([
    (0, common_1.Post)('refresh'),
    (0, swagger_1.ApiOperation)({ summary: 'Refresh materialized views' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Materialized views refreshed' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "refreshViews", null);
__decorate([
    (0, common_1.Get)('student'),
    (0, swagger_1.ApiOperation)({ summary: 'Get student dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Student dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getStudentDashboard", null);
__decorate([
    (0, common_1.Get)('student/:id'),
    (0, swagger_1.ApiOperation)({ summary: 'Get student dashboard data by ID' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Student dashboard data retrieved' }),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getStudentDashboardById", null);
__decorate([
    (0, common_1.Get)('warden'),
    (0, swagger_1.ApiOperation)({ summary: 'Get warden dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Warden dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getWardenDashboard", null);
__decorate([
    (0, common_1.Get)('warden-head'),
    (0, swagger_1.ApiOperation)({ summary: 'Get warden-head dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Warden-head dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getWardenHeadDashboard", null);
__decorate([
    (0, common_1.Get)('admin'),
    (0, swagger_1.ApiOperation)({ summary: 'Get admin dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Admin dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getAdminDashboard", null);
__decorate([
    (0, common_1.Get)('chef'),
    (0, swagger_1.ApiOperation)({ summary: 'Get chef dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Chef dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getChefDashboard", null);
__decorate([
    (0, common_1.Get)('security'),
    (0, swagger_1.ApiOperation)({ summary: 'Get security dashboard data' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Security dashboard data retrieved' }),
    __param(0, (0, common_1.Request)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getSecurityDashboard", null);
__decorate([
    (0, common_1.Get)('stats'),
    (0, swagger_1.ApiOperation)({ summary: 'Get global statistics' }),
    (0, swagger_1.ApiResponse)({ status: 200, description: 'Global statistics retrieved' }),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], DashboardsController.prototype, "getGlobalStats", null);
exports.DashboardsController = DashboardsController = __decorate([
    (0, swagger_1.ApiTags)('Dashboards'),
    (0, common_1.Controller)('dash'),
    (0, common_1.UseGuards)((0, passport_1.AuthGuard)('jwt')),
    (0, swagger_1.ApiBearerAuth)(),
    __metadata("design:paramtypes", [dashboards_service_1.DashboardsService])
], DashboardsController);
//# sourceMappingURL=dashboards.controller.js.map