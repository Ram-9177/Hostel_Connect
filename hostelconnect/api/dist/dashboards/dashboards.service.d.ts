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
    getStudentDashboard(studentId: string): Promise<{
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
    getWardenDashboard(wardenId: string): Promise<{
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
    getWardenHeadDashboard(wardenHeadId: string): Promise<{
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
    getAdminDashboard(adminId: string): Promise<{
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
    getChefDashboard(chefId: string): Promise<{
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
    getSecurityDashboard(securityId: string): Promise<{
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
