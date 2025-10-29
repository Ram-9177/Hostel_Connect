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
    getStudentDashboard(req: any): Promise<{
        student: {
            id: string;
            name: string;
            studentId: string;
            email: string;
            hostel: string;
            room: string;
            floor: string;
        };
        attendance: {
            percentage: number;
            present: number;
            total: number;
            lastMarked: string;
            status: string;
        };
        gatePass: {
            active: number;
            pending: number;
            approved: number;
            rejected: number;
        };
        meals: {
            today: {
                breakfast: boolean;
                lunch: boolean;
                dinner: boolean;
            };
            tomorrow: {
                breakfast: boolean;
                lunch: boolean;
                dinner: boolean;
            };
            lockTime: string;
        };
        complaints: {
            pending: number;
            resolved: number;
            total: number;
        };
        notices: {
            unread: number;
            total: number;
        };
    }>;
    getStudentDashboardById(id: string): Promise<{
        student: {
            id: string;
            name: string;
            studentId: string;
            email: string;
            hostel: string;
            room: string;
            floor: string;
        };
        attendance: {
            percentage: number;
            present: number;
            total: number;
            lastMarked: string;
            status: string;
        };
        gatePass: {
            active: number;
            pending: number;
            approved: number;
            rejected: number;
        };
        meals: {
            today: {
                breakfast: boolean;
                lunch: boolean;
                dinner: boolean;
            };
            tomorrow: {
                breakfast: boolean;
                lunch: boolean;
                dinner: boolean;
            };
            lockTime: string;
        };
        complaints: {
            pending: number;
            resolved: number;
            total: number;
        };
        notices: {
            unread: number;
            total: number;
        };
    }>;
    getWardenDashboard(req: any): Promise<{
        hostel: {};
        gatePasses: {
            pending: number;
            approved: number;
            rejected: number;
            activeNow: number;
        };
        complaints: {
            pending: number;
            inProgress: number;
            resolved: number;
        };
        rooms: {
            singleOccupancy: number;
            doubleOccupancy: number;
            tripleOccupancy: number;
            vacant: number;
        };
    }>;
    getWardenHeadDashboard(req: any): Promise<{
        hostels: {
            name: string;
            students: number;
            attendance: number;
            occupancy: number;
        }[];
        globalStats: {
            totalStudents: number;
            totalHostels: number;
            averageAttendance: number;
            averageOccupancy: number;
        };
        gatePasses: {
            pending: number;
            approved: number;
            rejected: number;
            activeNow: number;
        };
    }>;
    getAdminDashboard(req: any): Promise<{
        overview: {
            totalStudents: number;
            totalHostels: number;
            totalWardens: number;
            totalStaff: number;
        };
        hostels: {
            name: string;
            students: number;
            attendance: number;
            occupancy: number;
        }[];
        systemHealth: {
            apiStatus: string;
            databaseStatus: string;
            cacheStatus: string;
            uptime: string;
        };
    }>;
    getChefDashboard(req: any): Promise<{
        tomorrowForecast: {
            date: string;
            isLocked: boolean;
            meals: {
                name: string;
                yes: number;
                buffer: number;
                total: number;
            }[];
        };
        dietarySplit: {
            name: string;
            value: number;
        }[];
        specialRequests: {
            pending: number;
            approved: number;
            total: number;
        };
    }>;
    getSecurityDashboard(req: any): Promise<{
        gateActivity: {
            today: {
                entriesIn: number;
                entriesOut: number;
                activeOut: number;
            };
            lastHour: {
                in: number;
                out: number;
            };
        };
        activePasses: {
            total: number;
            expiringSoon: number;
            overdue: number;
        };
        alerts: {
            total: number;
            high: number;
            medium: number;
            low: number;
        };
    }>;
    getGlobalStats(): Promise<{
        totalStudents: number;
        totalHostels: number;
        totalRooms: number;
        averageAttendance: number;
        averageOccupancy: number;
        activeGatePasses: number;
        pendingComplaints: number;
        lastUpdated: string;
    }>;
}
