import { DashboardsService } from './dashboards.service';
export declare class DashboardsController {
    private readonly dashboardsService;
    constructor(dashboardsService: DashboardsService);
    getHostelLive(): Promise<import("./dashboards.service").HostelLiveData[]>;
    getHostelLiveById(hostelId: string): Promise<import("./dashboards.service").HostelLiveData>;
    getAttendanceSessionSummary(sessionId: string): Promise<import("./dashboards.service").AttendanceSessionSummary>;
    getGateFunnel(hostelId?: string, days?: number): Promise<any>;
    getMealForecast(hostelId?: string, days?: number): Promise<any>;
    getMonthlyAnalytics(hostelId?: string, month?: string): Promise<any>;
    getRoomOccupancy(hostelId?: string): Promise<any>;
    refreshViews(): Promise<{
        message: string;
    }>;
}
