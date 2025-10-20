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
exports.RefreshWorker = void 0;
const bull_1 = require("@nestjs/bull");
const dashboards_service_1 = require("./dashboards.service");
let RefreshWorker = class RefreshWorker {
    constructor(dashboardsService) {
        this.dashboardsService = dashboardsService;
    }
    async process(job) {
        const { type } = job.data;
        switch (type) {
            case 'live':
                await this.refreshLiveViews();
                break;
            case 'daily':
                await this.refreshDailyViews();
                break;
            case 'monthly':
                await this.refreshMonthlyViews();
                break;
            default:
                console.log(`Unknown refresh type: ${type}`);
        }
    }
    async refreshLiveViews() {
        try {
            await this.dashboardsService.refreshMaterializedViews();
            console.log('Live views refreshed at:', new Date().toISOString());
        }
        catch (error) {
            console.error('Failed to refresh live views:', error);
        }
    }
    async refreshDailyViews() {
        try {
            await this.dashboardsService.refreshMaterializedViews();
            console.log('Daily views refreshed at:', new Date().toISOString());
        }
        catch (error) {
            console.error('Failed to refresh daily views:', error);
        }
    }
    async refreshMonthlyViews() {
        try {
            await this.dashboardsService.refreshMaterializedViews();
            console.log('Monthly views refreshed at:', new Date().toISOString());
        }
        catch (error) {
            console.error('Failed to refresh monthly views:', error);
        }
    }
};
exports.RefreshWorker = RefreshWorker;
exports.RefreshWorker = RefreshWorker = __decorate([
    (0, bull_1.Processor)('refresh'),
    __metadata("design:paramtypes", [dashboards_service_1.DashboardsService])
], RefreshWorker);
//# sourceMappingURL=refresh.worker.js.map