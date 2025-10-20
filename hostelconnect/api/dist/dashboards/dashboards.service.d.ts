import { DataSource } from 'typeorm';
export interface HostelLiveData {
    hostelId: string;
    hostelName: string;
    totalStrength: number;
    outpassNow: number;
    presentDerived: number;
    scanPresent: number;
    manualPresent: number;
    kioskScans: number;
    wardenScans: number;
    updatedAt: Date;
}
export interface AttendanceSessionSummary {
    sessionId: string;
    hostelId: string;
    date: Date;
    slot: string;
    mode: string;
    totalRoster: number;
    scannedCount: number;
    manualCount: number;
    kioskCount: number;
    wardenCount: number;
    attendancePercentage: number;
    updatedAt: Date;
}
export declare class DashboardsService {
    private readonly dataSource;
    constructor(dataSource: DataSource);
    getHostelLive(hostelId?: string): Promise<HostelLiveData[]>;
    getAttendanceSessionSummary(sessionId: string): Promise<AttendanceSessionSummary>;
    getGateFunnel(hostelId?: string, days?: number): Promise<any>;
    getMealForecast(hostelId?: string, days?: number): Promise<any>;
    getMonthlyAnalytics(hostelId?: string, month?: string): Promise<any>;
    getRoomOccupancy(hostelId?: string): Promise<any>;
    refreshMaterializedViews(): Promise<void>;
}
